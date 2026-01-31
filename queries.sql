-- =========================
-- 1. CUSTOMERS WITH HIGHEST TOTAL REVENUE
-- =========================

SELECT c.customer_id, c.customer_name, SUM(r.total_revenue) AS total_revenue
FROM vw_trip_revenue r JOIN customers c ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;


-- =========================
-- 2. MOST FREQUENTLY USED ROUTES
-- =========================

SELECT r.route_id, r.origin_city, r.destination_city, COUNT(l.load_id) AS load_count
FROM loads l JOIN routes r ON l.route_id = r.route_id
GROUP BY r.route_id, r.origin_city, r.destination_city
ORDER BY load_count DESC;


-- =========================
-- 3. AVERAGE REVENUE PER MILE BY ROUTE
-- =========================

SELECT r.route_id, r.origin_city, r.destination_city, AVG(v.revenue_per_mile) AS avg_revenue_per_mile
FROM vw_trip_revenue v JOIN routes r ON v.route_id = r.route_id
GROUP BY r.route_id, r.origin_city, r.destination_city
ORDER BY avg_revenue_per_mile DESC;


-- =========================
-- 4. DRIVERS WITH HIGHEST ON-TIME DELIVERY RATE
-- =========================

SELECT driver_id, COUNT(*) AS trips_completed, AVG(on_time_flag::int) AS on_time_rate
FROM vw_driver_trip_metrics
GROUP BY driver_id
HAVING COUNT(*) >= 10
ORDER BY on_time_rate DESC;


-- =========================
-- 5. TRUCKS WITH HIGHEST REVENUE PER MILE
-- =========================

SELECT t.truck_id, SUM(r.total_revenue) / SUM(t.actual_distance_miles) AS revenue_per_mile
FROM vw_trip_revenue r JOIN trips t ON r.trip_id = t.trip_id
GROUP BY t.truck_id
ORDER BY revenue_per_mile DESC;


-- =========================
-- 6. ROUTES WITH HIGHEST FUEL COST PER MILE
-- =========================

SELECT r.route_id, r.origin_city, r.destination_city, AVG(c.fuel_cost_per_mile) AS avg_fuel_cost_per_mile
FROM vw_trip_costs c JOIN trips t ON c.trip_id = t.trip_id JOIN loads l ON t.load_id = l.load_id JOIN routes r ON l.route_id = r.route_id
GROUP BY r.route_id, r.origin_city, r.destination_city
ORDER BY avg_fuel_cost_per_mile DESC;


-- =========================
-- 7. MOST PROFITABLE ROUTES PER MILE
-- =========================

SELECT r.route_id, r.origin_city, r.destination_city, AVG(v.revenue_per_mile - c.fuel_cost_per_mile) AS profit_per_mile
FROM vw_trip_revenue v JOIN vw_trip_costs c ON v.trip_id = c.trip_id JOIN routes r ON v.route_id = r.route_id
GROUP BY r.route_id, r.origin_city, r.destination_city
ORDER BY profit_per_mile DESC;


-- =========================
-- 8. CUSTOMER PROFITABILITY ANALYSIS
-- =========================

SELECT c.customer_id, c.customer_name, SUM(v.total_revenue - cst.fuel_cost - cst.incident_cost) AS total_profit
FROM vw_trip_revenue v JOIN vw_trip_costs cst ON v.trip_id = cst.trip_id JOIN customers c ON v.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_profit DESC;


-- =========================
-- 9. PERCENTAGE OF TRIPS OPERATING AT A LOSS
-- =========================

SELECT COUNT(*) FILTER (WHERE (v.total_revenue - c.fuel_cost - c.incident_cost) < 0)::decimal / COUNT(*) * 100 AS loss_trip_percentage
FROM vw_trip_revenue v JOIN vw_trip_costs c ON v.trip_id = c.trip_id;


-- =========================
-- 10. MONTH-OVER-MONTH REVENUE PER MILE TREND
-- =========================

SELECT DATE_TRUNC('month', t.dispatch_date) AS month, AVG(v.revenue_per_mile) AS avg_revenue_per_mile
FROM vw_trip_revenue v JOIN trips t ON v.trip_id = t.trip_id
GROUP BY month
ORDER BY month;


-- =========================
-- 11. DRIVER PERFORMANCE TREND OVER TIME
-- =========================

SELECT driver_id, DATE_TRUNC('month', dispatch_date) AS month, AVG(actual_distance_miles / NULLIF(actual_duration_hours, 0)) AS avg_miles_per_hour
FROM trips
GROUP BY driver_id, month
ORDER BY driver_id, month;


-- =========================
-- 12. DRIVERS / TRUCKS WITH HIGHEST INCIDENT RATE (PER 10000 MILES)
-- =========================

SELECT t.driver_id, COUNT(si.incident_id) * 10000.0 / SUM(t.actual_distance_miles) AS incidents_per_10000_miles
FROM trips t LEFT JOIN safety_incidents si ON t.trip_id = si.trip_id
GROUP BY t.driver_id
HAVING SUM(t.actual_distance_miles) > 0
ORDER BY incidents_per_10000_miles DESC;


-- =========================
-- 13. ARE HIGH-REVENUE ROUTES ALSO HIGH-RISK?
-- =========================

SELECT r.route_id, AVG(v.revenue_per_mile) AS avg_revenue_per_mile, COUNT(si.incident_id) * 10000.0 / SUM(t.actual_distance_miles) AS incidents_per_10000_miles
FROM trips t JOIN vw_trip_revenue v ON t.trip_id = v.trip_id JOIN routes r ON v.route_id = r.route_id LEFT JOIN safety_incidents si ON t.trip_id = si.trip_id
GROUP BY r.route_id
ORDER BY avg_revenue_per_mile DESC;

