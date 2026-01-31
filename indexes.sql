-- =========================
-- LOADS
-- =========================

CREATE INDEX idx_loads_customer_id ON loads(customer_id);
CREATE INDEX idx_loads_route_id ON loads(route_id);


-- =========================
-- TRIPS
-- =========================

CREATE INDEX idx_trips_load_id ON trips(load_id);
CREATE INDEX idx_trips_driver_id ON trips(driver_id);
CREATE INDEX idx_trips_truck_id ON trips(truck_id);
CREATE INDEX idx_trips_trailer_id ON trips(trailer_id);


-- =========================
-- FUEL PURCHASES
-- =========================

CREATE INDEX idx_fuel_trip_id ON fuel_purchases(trip_id);
CREATE INDEX idx_fuel_driver_id ON fuel_purchases(driver_id);
CREATE INDEX idx_fuel_truck_id ON fuel_purchases(truck_id);


-- =========================
-- MAINTENANCE
-- =========================

CREATE INDEX idx_maintenance_truck_id ON maintenance_records(truck_id);


-- =========================
-- DELIVERY EVENTS
-- =========================

CREATE INDEX idx_delivery_load_id ON delivery_events(load_id);
CREATE INDEX idx_delivery_trip_id ON delivery_events(trip_id);
CREATE INDEX idx_delivery_facility_id ON delivery_events(facility_id);


-- =========================
-- SAFETY INCIDENTS
-- =========================

CREATE INDEX idx_incident_trip_id ON safety_incidents(trip_id);
CREATE INDEX idx_incident_driver_id ON safety_incidents(driver_id);
CREATE INDEX idx_incident_truck_id ON safety_incidents(truck_id);


-- =========================
-- DATE AND TIME
-- =========================

CREATE INDEX idx_trips_dispatch_date ON trips(dispatch_date);
CREATE INDEX idx_loads_load_date ON loads(load_date);
CREATE INDEX idx_fuel_purchase_date ON fuel_purchases(purchase_date);
CREATE INDEX idx_delivery_scheduled_datetime ON delivery_events(scheduled_datetime);
CREATE INDEX idx_delivery_actual_datetime ON delivery_events(actual_datetime);


-- =========================
-- METRICS
-- =========================

CREATE INDEX idx_driver_month ON driver_monthly_metrics(month);
CREATE INDEX idx_truck_month ON truck_utilization_metrics(month);





