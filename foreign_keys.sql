-- =========================
-- FOREIGN KEYS
-- =========================

ALTER TABLE loads
ADD CONSTRAINT fk_loads_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE loads
ADD CONSTRAINT fk_loads_route
FOREIGN KEY (route_id)
REFERENCES routes(route_id);

ALTER TABLE trips
ADD CONSTRAINT fk_trips_load
FOREIGN KEY (load_id)
REFERENCES loads(load_id);

ALTER TABLE trips
ADD CONSTRAINT fk_trips_driver
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);

ALTER TABLE trips
ADD CONSTRAINT fk_trips_truck
FOREIGN KEY (truck_id)
REFERENCES trucks(truck_id);

ALTER TABLE trips
ADD CONSTRAINT fk_trips_trailer
FOREIGN KEY (trailer_id)
REFERENCES trailers(trailer_id);

ALTER TABLE fuel_purchases
ADD CONSTRAINT fk_fuel_trip
FOREIGN KEY (trip_id)
REFERENCES trips(trip_id);

ALTER TABLE fuel_purchases
ADD CONSTRAINT fk_fuel_driver
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);

ALTER TABLE fuel_purchases
ADD CONSTRAINT fk_fuel_truck
FOREIGN KEY (truck_id)
REFERENCES trucks(truck_id);

ALTER TABLE maintenance_records
ADD CONSTRAINT fk_maintenance_truck
FOREIGN KEY (truck_id)
REFERENCES trucks(truck_id);

ALTER TABLE delivery_events
ADD CONSTRAINT fk_delivery_load
FOREIGN KEY (load_id)
REFERENCES loads(load_id);

ALTER TABLE delivery_events
ADD CONSTRAINT fk_delivery_trip
FOREIGN KEY (trip_id)
REFERENCES trips(trip_id);

ALTER TABLE delivery_events
ADD CONSTRAINT fk_delivery_facility
FOREIGN KEY (facility_id)
REFERENCES facilities(facility_id);

ALTER TABLE safety_incidents
ADD CONSTRAINT fk_incident_trip
FOREIGN KEY (trip_id)
REFERENCES trips(trip_id);

ALTER TABLE safety_incidents
ADD CONSTRAINT fk_incident_driver
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);

ALTER TABLE safety_incidents
ADD CONSTRAINT fk_incident_truck
FOREIGN KEY (truck_id)
REFERENCES trucks(truck_id);



-- =========================
-- VALIDATION
-- =========================

SELECT
    conname,
    conrelid::regclass AS table_name
FROM pg_constraint
WHERE contype = 'f'
ORDER BY table_name;


SELECT
    conname,
    convalidated
FROM pg_constraint
WHERE contype = 'f'
ORDER BY conname;



