-- =========================
-- VIEW: Revenue per trip, normalized by mile
-- =========================

CREATE OR REPLACE VIEW vw_trip_revenue AS
SELECT
    t.trip_id,
    t.load_id,
    l.customer_id,
    l.route_id,
    l.revenue + COALESCE(l.fuel_surcharge, 0) + COALESCE(l.accessorial_charges, 0) AS total_revenue,
    t.actual_distance_miles,
    CASE
        WHEN t.actual_distance_miles > 0
        THEN (l.revenue + COALESCE(l.fuel_surcharge, 0) + COALESCE(l.accessorial_charges, 0))
             / t.actual_distance_miles
        ELSE NULL
    END AS revenue_per_mile
FROM trips t JOIN loads l ON t.load_id = l.load_id;


-- =========================
-- VIEW: Costs per trip, normalized by mile
-- =========================

CREATE OR REPLACE VIEW vw_trip_costs AS
SELECT
    t.trip_id,
    t.actual_distance_miles,
    COALESCE(SUM(fp.total_cost), 0) AS fuel_cost,
    COALESCE(SUM(si.vehicle_damage_cost + si.cargo_damage_cost), 0) AS incident_cost,
    CASE
        WHEN t.actual_distance_miles > 0
        THEN COALESCE(SUM(fp.total_cost), 0) / t.actual_distance_miles
        ELSE NULL
    END AS fuel_cost_per_mile
FROM trips t LEFT JOIN fuel_purchases fp ON t.trip_id = fp.trip_id LEFT JOIN safety_incidents si ON t.trip_id = si.trip_id
GROUP BY t.trip_id, t.actual_distance_miles;


-- =========================
-- VIEW: Drivers efficiency and productivity
-- =========================

CREATE OR REPLACE VIEW vw_driver_trip_metrics AS
SELECT
    t.trip_id,
    t.driver_id,
    d.first_name,
    d.last_name,
    t.actual_distance_miles,
    t.actual_duration_hours,
    CASE
        WHEN t.actual_duration_hours > 0
        THEN t.actual_distance_miles / t.actual_duration_hours
        ELSE NULL
    END AS miles_per_hour,
    t.average_mpg,
    t.idle_time_hours,
    de.on_time_flag
FROM trips t JOIN drivers d ON t.driver_id = d.driver_id LEFT JOIN delivery_events de ON t.trip_id = de.trip_id;


-- =========================
-- VIEW: Trucks operating costs
-- =========================


CREATE OR REPLACE VIEW vw_truck_operating_costs AS
SELECT
    t.truck_id,
    tr.make,
    tr.model_year,
    COUNT(DISTINCT t.trip_id) AS trips_count,
    SUM(t.actual_distance_miles) AS total_miles,
    COALESCE(SUM(m.total_cost), 0) AS maintenance_cost,
    COALESCE(SUM(m.downtime_hours), 0) AS downtime_hours,
    CASE
        WHEN SUM(t.actual_distance_miles) > 0
        THEN COALESCE(SUM(m.total_cost), 0) / SUM(t.actual_distance_miles)
        ELSE NULL
    END AS maintenance_cost_per_mile
FROM trips t JOIN trucks tr ON t.truck_id = tr.truck_id LEFT JOIN maintenance_records m ON t.truck_id = m.truck_id
GROUP BY t.truck_id, tr.make, tr.model_year;
