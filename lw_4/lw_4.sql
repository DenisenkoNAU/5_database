/*
Оператори IN, BETWEEN, LIKE, IS NULL.
*/

-- "DRIVER"
-- Вибирає всі записи з таблиці водіїв
SELECT * FROM driver;

-- Вибирає імена та прізвища водіїв, чиє ім'я є серед 'John', 'Jane', або 'Michael'
SELECT first_name, last_name FROM driver
WHERE first_name IN ('John', 'Jane', 'Michael');

-- Вибирає імена та дати народження водіїв, які народилися між 1980 і 1990 роками
SELECT first_name, birthday FROM driver 
WHERE birthday BETWEEN '1980-01-01' AND '1990-12-31';

-- Вибирає імена та номери телефонів водіїв, чий номер починається на '+1234'
SELECT first_name, phone FROM driver 
WHERE phone LIKE '+1234%';

-- Вибирає імена та email водіїв, у яких поле email не порожнє
SELECT first_name, email FROM driver 
WHERE email IS NOT NULL;

-- Вибирає імена та прізвища водіїв, де ім'я починається на 'J' і прізвище на 'D', або прізвище 'Smith'
SELECT first_name, last_name FROM driver 
WHERE (first_name LIKE 'J%' AND last_name LIKE 'D%') OR last_name = 'Smith';


-- "VECHICLE"
-- Вибирає всі записи з таблиці транспортних засобів
SELECT * FROM vehicle;

-- Вибирає всі транспортні засоби, що доступні (AVAILABLE)
SELECT * FROM vehicle 
WHERE status = 'AVAILABLE';

-- Вибирає транспортні засоби з вантажопідйомністю між 1000 і 2000 кг
SELECT * FROM vehicle 
WHERE capacity BETWEEN 1000 AND 2000;

-- Вибирає транспортні засоби марок 'VOLVO' або 'MAN'
SELECT * FROM vehicle 
WHERE mark IN ('VOLVO', 'MAN');

-- Вибирає доступні транспортні засоби з вантажопідйомністю більше 4000 кг
SELECT * FROM vehicle 
WHERE status = 'AVAILABLE' AND capacity > 4000;


-- "LOCATION"
-- Вибирає всі записи з таблиці місцезнаходжень
SELECT * FROM location;

-- Вибирає всі сортувальні центри
SELECT * FROM location 
WHERE type = 'SORTING_CENTER';

-- Вибирає місцезнаходження, де адреса містить слово 'East'
SELECT * FROM location 
WHERE address LIKE '%East%';

-- Вибирає місцезнаходження з поштовими індексами '10001' або '10002'
SELECT * FROM location 
WHERE postal_code IN ('10001', '10002');

-- Вибирає місцезнаходження в містах 'New York' або 'Los Angeles' і з поштовими індексами '10001' або '10003'
SELECT * FROM location 
WHERE city IN ('New York', 'Los Angeles') AND postal_code IN ('10001', '10003');


-- "CUSTOMER_ORDER"
-- Вибирає всі записи з таблиці замовлень
SELECT * from customer_order;

-- Вибирає всі замовлення зі статусом 'PENDING' або 'IN_PROGRESS'
SELECT * FROM customer_order 
WHERE status IN ('PENDING', 'IN_PROGRESS');

-- Вибирає всі замовлення, зроблені між 1 вересня 2023 і 2 вересня 2023 року
SELECT * FROM customer_order 
WHERE order_date BETWEEN '2023-09-01' AND '2023-09-02';

-- Вибирає всі замовлення, що були зроблені з місцезнаходження 1
SELECT * FROM customer_order 
WHERE from_location_id = 1;

-- Вибирає всі замовлення зі статусом 'IN_PROGRESS' і доставкою до місцезнаходження 5
SELECT * FROM customer_order 
WHERE status = 'IN_PROGRESS' AND to_location_id = 5;


-- "DELIVERY"
-- Вибирає всі записи з таблиці доставок
SELECT * from delivery;

-- Вибирає всі доставки зі статусом 'SCHEDULED' або 'IN_TRANSIT'
SELECT * FROM delivery 
WHERE status IN ('SCHEDULED', 'IN_TRANSIT');

-- Вибирає всі доставки, де дата пікапу між 1 і 2 вересня 2023 року
SELECT * FROM delivery 
WHERE pickup_date BETWEEN '2023-09-01' AND '2023-09-02';

-- Вибирає всі доставки, де дата доставки не є порожньою (доставка виконана)
SELECT * FROM delivery 
WHERE delivery_date IS NOT NULL;

-- Вибирає всі доставки для замовлення з ідентифікатором 1
SELECT * FROM delivery 
WHERE order_id = 1;


/*
Оператори IN, BETWEEN, LIKE, IS NULL.
*/

-- "DRIVER"
-- Вибирає всі записи з таблиці водіїв
SELECT * FROM driver;

-- Підрахунок кількості водіїв
SELECT COUNT(*) AS total_drivers FROM driver;

-- Пошук найстаршого водія (за датою народження)
SELECT MIN(birthday) AS oldest_driver FROM driver;

-- Пошук наймолодшого водія (за датою народження)
SELECT MAX(birthday) AS youngest_driver FROM driver;

-- Підрахунок кількості водіїв з різними іменами, відсортованими за спаданням
SELECT first_name, COUNT(*) AS name_count 
FROM driver
GROUP BY first_name
ORDER BY name_count DESC


-- "VECHICLE"
-- Вибирає всі записи з таблиці транспортних засобів
SELECT * FROM vehicle;

-- Підрахунок кількості транспортних засобів
SELECT COUNT(*) AS total_vehicles FROM vehicle;

-- Пошук транспортного засобу з найбільшою вантажопідйомністю
SELECT MAX(capacity) AS max_capacity FROM vehicle;

-- Пошук транспортного засобу з найменшою вантажопідйомністю
SELECT MIN(capacity) AS min_capacity FROM vehicle;

-- Середня вантажопідйомність усіх транспортних засобів
SELECT AVG(capacity) AS avg_capacity FROM vehicle;

-- Сумарна вантажопідйомність транспортних засобів, згрупованих за маркою
SELECT mark, SUM(capacity) AS total_capacity 
FROM vehicle
GROUP BY mark
ORDER BY total_capacity DESC;


-- "LOCATION"
-- Вибирає всі записи з таблиці місцезнаходжень
SELECT * FROM location;

-- Підрахунок кількості місцезнаходжень
SELECT COUNT(*) AS total_locations FROM location;

-- Підрахунок кількості місцезнаходжень у кожному місті
SELECT city, COUNT(*) AS location_count 
FROM location
GROUP BY city
ORDER BY location_count DESC;

-- Підрахунок кількості місцезнаходжень типу "DELIVERY_POINT"
SELECT COUNT(*) AS warehouse_count FROM location WHERE type = 'DELIVERY_POINT';

-- Підрахунок кількості сортувальних центрів у різних містах
SELECT city, COUNT(*) AS sorting_center_count 
FROM location
WHERE type = 'SORTING_CENTER'
GROUP BY city
ORDER BY sorting_center_count DESC;


-- "CUSTOMER_ORDER"
-- Вибирає всі записи з таблиці замовлень
SELECT * from customer_order

-- Підрахунок кількості замовлень
SELECT COUNT(*) AS total_orders FROM customer_order;

-- Підрахунок кількості замовлень на кожній локації
SELECT to_location_id, COUNT(*) AS order_count 
FROM customer_order
GROUP BY to_location_id;

-- Підрахунок кількості замовлень за кожним статусом
SELECT status, COUNT(*) AS order_count 
FROM customer_order
GROUP BY status
ORDER BY order_count DESC;


-- "DELIVERY"
-- Вибирає всі записи з таблиці доставок
SELECT * from delivery;

-- Підрахунок кількості доставок
SELECT COUNT(*) AS total_deliveries FROM delivery;

-- Підрахунок кількості доставок
SELECT COUNT(*) AS total_deliveries FROM delivery WHERE delivery_date IS NULL;

-- Підрахунок кількості доставок за статусом
SELECT status, COUNT(*) AS delivery_count 
FROM delivery
GROUP BY status
ORDER BY delivery_count DESC;
