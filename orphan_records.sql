-- =========================
-- TRIPS WITHOUT LOADS (0)
-- =========================

SELECT t.trip_id
FROM trips t
LEFT JOIN loads l ON t.load_id = l.load_id
WHERE l.load_id IS NULL;


-- =========================
-- LOADS WITHOUT DELIVERY EVENTS (0)
-- =========================

SELECT l.load_id
FROM loads l
LEFT JOIN delivery_events d ON l.load_id = d.load_id
WHERE d.load_id IS NULL;


-- =========================
-- FUEL PURCHASES WITHOUT TRIPS (0)
-- =========================

SELECT f.fuel_purchase_id
FROM fuel_purchases f
LEFT JOIN trips t ON f.trip_id = t.trip_id
WHERE t.trip_id IS NULL;


-- =========================
-- DELIVERY EVENTS WITH NO FACILITIES (0)
-- =========================

SELECT d.event_id
FROM delivery_events d
LEFT JOIN facilities f ON d.facility_id = f.facility_id
WHERE f.facility_id IS NULL;






