-- Вставка водителей
INSERT INTO driver (first_name, last_name, birthday, phone, email, license_number) 
VALUES 
('John', 'Doe', '1980-04-15', '+1234567890', 'john.doe@example.com', 'A1234567'),
('Jane', 'Smith', '1992-08-10', '+1234567891', 'jane.smith@example.com', 'B9876543'),
('Michael', 'Johnson', '1985-11-22', '+1234567892', 'm.johnson@example.com', 'C3456789'),
('Emily', 'Brown', '1990-01-17', '+1234567893', 'e.brown@example.com', 'D4567890'),
('Chris', 'Davis', '1975-05-25', '+1234567894', 'chris.davis@example.com', 'E5678901');

-- Вставка транспортных средств
INSERT INTO vehicle (driver_id, capacity, vin, license_plate, mark, type, status) 
VALUES 
(1, 5000, '1HGCM82633A123456', 'ABC123', 'Volvo', 'TRUCK', 'AVAILABLE'),
(2, 2000, '1HGCM82633A654321', 'DEF456', 'Mercedes', 'CAR', 'IN_USE'),
(3, 3000, '1HGCM82633A789012', 'GHI789', 'Scania', 'TRUCK', 'AVAILABLE'),
(4, 1500, '1HGCM82633A345678', 'JKL012', 'BMW', 'CAR', 'IN_USE'),
(5, 4000, '1HGCM82633A987654', 'MNO345', 'MAN', 'TRUCK', 'AVAILABLE');

-- Вставка местоположений
INSERT INTO location (name, type, address, city, postal_code) 
VALUES 
('Central Sorting', 'SORTING_CENTER', '123 Main St', 'New York', '10001'),
('East Delivery Point', 'DELIVERY_POINT', '456 East St', 'New York', '10002'),
('West Delivery Point', 'DELIVERY_POINT', '789 West St', 'Los Angeles', '10003'),
('North Sorting Center', 'SORTING_CENTER', '101 North St', 'Chicago', '10004'),
('South Delivery Point', 'DELIVERY_POINT', '202 South St', 'Houston', '10005');

-- Вставка местоположений транспортных средств
INSERT INTO vehicle_location (vehicle_id, location_id)
VALUES 
(1, 2),
(3, 3),
(4, 3);

-- Вставка заказов клиентов
INSERT INTO customer_order (from_location_id, to_location_id, order_date, status)
VALUES 
(2, 1, '2023-09-01 10:00:00', 'PENDING'),
(1, 2, '2023-09-02 12:30:00', 'IN_PROGRESS'),
(4, 3, '2023-09-03 14:00:00', 'COMPLETED'),
(3, 4, '2023-09-04 09:15:00', 'CANCELED'),
(1, 5, '2023-09-05 11:45:00', 'IN_PROGRESS');

-- Вставка доставок
INSERT INTO delivery (order_id, pickup_date, delivery_date, status)
VALUES 
(1, '2023-09-01 11:00:00', NULL, 'SCHEDULED'),
(2, '2023-09-02 12:00:00', NULL, 'IN_TRANSIT'),
(3, '2023-09-03 13:00:00', '2023-09-04 18:00:00', 'DELIVERED'),
(4, '2023-09-04 14:00:00', NULL, 'CANCELED'),
(5, '2023-09-05 09:00:00', NULL, 'IN_TRANSIT');

-- Вставка этапов доставки
INSERT INTO delivery_step (delivery_id, vehicle_id, from_location_id, to_location_id, pickup_date, delivery_date)
VALUES 
(2, 2, 1, 2, '2023-09-02 13:00:00', '2023-09-02 16:00:00'),
(3, 3, 4, 3, '2023-09-03 14:00:00', '2023-09-03 18:00:00'),
(5, 5, 1, 5, '2023-09-04 14:00:00', '2023-09-04 18:00:00');