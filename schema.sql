-- =========================
-- LOGISTICS ANALYTICS SCHEMA
-- =========================

-- DRIVERS
CREATE TABLE drivers (
    driver_id TEXT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    hire_date DATE,
    termination_date DATE,
    license_number TEXT,
    license_state TEXT,
    date_of_birth DATE,
    home_terminal TEXT,
    employment_status TEXT,
    cdl_class TEXT,
    years_experience INT
);
    

-- TRUCKS
CREATE TABLE trucks (
    truck_id TEXT PRIMARY KEY,
    unit_number INT,
    make TEXT,
    model_year INT,
    vin TEXT,
    acquisition_date DATE,
    acquisition_mileage INT,
    fuel_type TEXT,
    tank_capacity_gallons INT,
    status TEXT,
    home_terminal TEXT
);

-- TRAILERS
CREATE TABLE trailers (
    trailer_id TEXT PRIMARY KEY,
    trailer_number INT,
    trailer_type TEXT,
    length_feet INT,
    model_year INT,
    vin TEXT,
    acquisition_date DATE,
    status TEXT,
    current_location TEXT
);

-- CUSTOMERS
CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    customer_name TEXT,
    customer_type TEXT, 
    credit_terms_days INT,     
    primary_freight_type TEXT, 
    account_status TEXT,           
    contract_start_date DATE,
    annual_revenue_potential INT
);

-- FACILITIES
CREATE TABLE facilities (
    facility_id TEXT PRIMARY KEY,
    facility_name TEXT, 
    facility_type TEXT,
    city TEXT,
    state TEXT,
    latitude DOUBLE precision,
    longitude DOUBLE precision,
    dock_doors INT,
    operating_hours TEXT
);

-- ROUTES
CREATE TABLE routes (
    route_id TEXT PRIMARY KEY,
    origin_city TEXT,
    origin_state TEXT,
    destination_city TEXT, 
    destination_state TEXT,
    typical_distance_miles INT,
    base_rate_per_mile NUMERIC(12,2),
    fuel_surcharge_rate NUMERIC(12,2),
    typical_transit_days INT
);

-- LOADS
CREATE TABLE loads (
    load_id TEXT PRIMARY KEY,
    customer_id TEXT,
    route_id TEXT, 
    load_date DATE,
    load_type TEXT, 
    weight_lbs INT,
    pieces INT,
    revenue NUMERIC(12,2),
    fuel_surcharge NUMERIC(12,2),
    accessorial_charges INT, 
    load_status TEXT,
    booking_type TEXT
);

-- TRIPS
CREATE TABLE trips (
    trip_id TEXT PRIMARY KEY,
    load_id TEXT, 
    driver_id TEXT,
    truck_id TEXT,
    trailer_id TEXT,
    dispatch_date DATE,
    actual_distance_miles INT,  
    actual_duration_hours DOUBLE precision,
    fuel_gallons_used DOUBLE precision,
    average_mpg DOUBLE precision,
    idle_time_hours DOUBLE precision,
    trip_status TEXT
);

-- FUEL PURCHASES
CREATE TABLE fuel_purchases (
    fuel_purchase_id TEXT PRIMARY KEY,
    trip_id TEXT,
    truck_id TEXT, 
    driver_id TEXT,
    purchase_date TIMESTAMP,
    location_city TEXT,
    location_state TEXT,
    gallons DOUBLE precision,
    price_per_gallon NUMERIC(12,2),
    total_cost NUMERIC(12,2),
    fuel_card_number TEXT
);

-- MAINTENANCE RECORDS
CREATE TABLE maintenance_records (
    maintenance_id TEXT PRIMARY KEY,
    truck_id TEXT,
    maintenance_date DATE,
    maintenance_type TEXT, 
    odometer_reading INT,  
    labor_hours DOUBLE precision,
    labor_cost NUMERIC(12,2),
    parts_cost NUMERIC(12,2),
    total_cost NUMERIC(12,2),
    facility_location TEXT,
    downtime_hours DOUBLE precision,
    service_description TEXT
);

-- DELIVERY EVENTS
CREATE TABLE delivery_events (
    event_id TEXT PRIMARY KEY,
    load_id TEXT,
    trip_id TEXT,
    event_type TEXT,
    facility_id TEXT,
    scheduled_datetime TIMESTAMP,
    actual_datetime TIMESTAMP,
    detention_minutes INT, 
    on_time_flag BOOLEAN, 
    location_city TEXT,
    location_state TEXT
);

-- SAFETY INCIDENTS
CREATE TABLE safety_incidents (
    incident_id TEXT PRIMARY KEY,
    trip_id TEXT,
    truck_id TEXT,
    driver_id TEXT, 
    incident_date TIMESTAMP, 
    incident_type TEXT,
    location_city TEXT,
    location_state TEXT,
    at_fault_flag BOOLEAN, 
    injury_flag BOOLEAN,  
    vehicle_damage_cost NUMERIC(12,2),
    cargo_damage_cost NUMERIC(12,2),
    claim_amount NUMERIC(12,2),
    preventable_flag BOOLEAN,
    description TEXT
);

-- DRIVER_MONTHLY_METRICS
CREATE TABLE driver_monthly_metrics (
	driver_id TEXT,
    month DATE, 
    trips_completed INT, 
    total_miles INT, 
    total_revenue NUMERIC(12,2),
    average_mpg DOUBLE precision,
    total_fuel_gallons DOUBLE precision,
    on_time_delivery_rate DOUBLE precision,
    average_idle_hours DOUBLE precision,
    PRIMARY KEY (driver_id, month)
);

-- TRUCK_UTILIZATION_METRICS
CREATE TABLE truck_utilization_metrics (
	truck_id TEXT,
    month DATE,
    trips_completed INT, 
    total_miles INT,
    total_revenue NUMERIC(12,2),
    average_mpg DOUBLE precision,
    maintenance_events INT, 
    maintenance_cost NUMERIC(12,2),
    downtime_hours DOUBLE precision,
    utilization_rate DOUBLE precision,
    PRIMARY KEY (truck_id, month)
);

