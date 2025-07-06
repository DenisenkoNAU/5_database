-- Таблица водителей
CREATE TABLE driver (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    birthday DATE NOT NULL,
    phone NVARCHAR(50) NOT NULL,
    email NVARCHAR(50),
    license_number NVARCHAR(50) NOT NULL
);

-- Таблица транспортных средств
CREATE TABLE vehicle (
    id INT IDENTITY(1,1) PRIMARY KEY,
    driver_id INT NOT NULL,
    capacity INT NOT NULL,
    vin NVARCHAR(50) NOT NULL,
    license_plate NVARCHAR(50) NOT NULL,
    mark NVARCHAR(50) NOT NULL,
    type NVARCHAR(50) CHECK (type IN ('TRUCK', 'CAR')) NOT NULL,
    status NVARCHAR(50) CHECK (status IN ('AVAILABLE', 'IN_USE')) NOT NULL,

	-- Связи
    CONSTRAINT fk_vehicle_driver FOREIGN KEY (driver_id) REFERENCES driver (id)
);

-- Таблица местоположений
CREATE TABLE location (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    type NVARCHAR(50) CHECK (type IN ('SORTING_CENTER', 'DELIVERY_POINT')) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    city NVARCHAR(255) NOT NULL,
    postal_code NVARCHAR(20) NOT NULL
);

-- Таблица местоположений транспортных средств
CREATE TABLE vehicle_location (
    vehicle_id INT NOT NULL,
    location_id INT NOT NULL,

	-- Связи
    CONSTRAINT fk_vehicle_location_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicle (id),
    CONSTRAINT fk_vehicle_location_location FOREIGN KEY (location_id) REFERENCES location (id),
	CONSTRAINT pk_vehicle_location PRIMARY KEY (vehicle_id, location_id)
);

-- Таблица заказов (переименованная на customer_order)
CREATE TABLE customer_order (
    id INT IDENTITY(1,1) PRIMARY KEY,
    from_location_id INT NOT NULL,
    to_location_id INT NOT NULL,
    order_date DATETIME2 NOT NULL,
    status NVARCHAR(50) CHECK (status in ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELED')) NOT NULL,

	-- Связи
    CONSTRAINT fk_order_from_location FOREIGN KEY (from_location_id) REFERENCES location (id),
    CONSTRAINT fk_order_to_location FOREIGN KEY (to_location_id) REFERENCES location (id)
);

-- Таблица доставок
CREATE TABLE delivery (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    pickup_date DATETIME2 NOT NULL,
    delivery_date DATETIME2,
    status NVARCHAR(50) CHECK (status in ('SCHEDULED', 'IN_TRANSIT', 'DELIVERED', 'DELAYED', 'CANCELED')) NOT NULL,
    
	-- Связи
	CONSTRAINT fk_delivery_order FOREIGN KEY (order_id) REFERENCES customer_order (id)
);

-- Таблица шагов доставки
CREATE TABLE delivery_step (
    id INT IDENTITY(1,1) PRIMARY KEY,
    delivery_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    from_location_id INT NOT NULL,
    to_location_id INT NOT NULL,
    pickup_date DATETIME2 NOT NULL,
    delivery_date DATETIME2,

	-- Связи
    CONSTRAINT fk_delivery_step_delivery FOREIGN KEY (delivery_id) REFERENCES delivery (id),
    CONSTRAINT fk_delivery_step_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicle (id),
    CONSTRAINT fk_delivery_step_from_location FOREIGN KEY (from_location_id) REFERENCES location (id),
    CONSTRAINT fk_delivery_step_to_location FOREIGN KEY (to_location_id) REFERENCES location (id)
);
