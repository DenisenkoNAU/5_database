/*
З’єднання таблиць із використанням розділу WHERE.
*/
-- Вибирає всі дані з таблиць driver та vehicle, без жодної умови з'єднання. 
-- Повертає декартів добуток (всі можливі комбінації рядків з обох таблиць).
SELECT * from driver, vehicle;

-- Вибирає ім'я, прізвище з таблиці driver та марку автомобіля з таблиці vehicle.
-- Рядки об'єднуються за умови, що id водія у таблиці driver збігається з driver_id у таблиці vehicle.
SELECT first_name, last_name, mark from driver, vehicle
WHERE driver.id = vehicle.driver_id;

-- Використовує псевдоніми d для таблиці driver та v для таблиці vehicle.
-- Вибирає ім'я, прізвище водія, марку та тип автомобіля, з'єднуючи таблиці за умовою відповідності id водія.
SELECT d.first_name, d.last_name, v.mark, v.type from driver d, vehicle v
WHERE d.id = v.driver_id;


/*
З’єднання таблиць із використанням розділу FROM.
*/
-- Вибір всіх записів з таблиці delivery_step та vehicle з використанням явного внутрішнього з'єднання (INNER JOIN)
-- Повертаються лише ті рядки, де ds.vehicle_id відповідає v.id
SELECT *
FROM delivery_step ds
INNER JOIN vehicle v ON ds.vehicle_id = v.id;

-- Вибір всіх записів з таблиці delivery_step, vehicle drier
-- Внутрішнє з'єднання таблиці delivery_step з таблицею vehicle за полем vehicle_id
-- Внутрішнє з'єднання таблиці vehicle з таблицею driver за полем driver_id
SELECT *
FROM delivery_step ds
INNER JOIN vehicle v ON ds.vehicle_id = v.id
INNER JOIN driver d ON v.driver_id = d.id;


/*
Зовнішнє з’єднання (об’єднання) (OUTER JOIN) та його типи: ліве, праве та повне.
*/
-- Ліве з'єднання (LEFT JOIN): вибираються всі записи з таблиці vehicle, навіть якщо немає відповідних записів у таблиці delivery_step
-- Якщо немає відповідних записів у таблиці delivery_step, то її значення будуть NULL
SELECT *
FROM vehicle v
LEFT JOIN delivery_step ds ON v.id = ds.vehicle_id;

-- Праве з'єднання (RIGHT JOIN): вибираються всі записи з таблиці vehicle, навіть якщо немає відповідних записів в таблиці delivery_step
-- Якщо немає відповідних записів у таблиці delivery_step, то її значення будуть NULL
SELECT *
FROM delivery_step ds
RIGHT JOIN vehicle v ON ds.vehicle_id = v.id;

-- Запит повертає всі записи з обох таблиць:
-- Якщо є співпадіння по vehicle_id, то записи будуть об'єднані.
-- Якщо записів у одній з таблиць немає, у відповідних полях буде NULL.
SELECT *
FROM delivery_step ds
FULL JOIN vehicle v ON ds.vehicle_id = v.id;


/*
Перехресні з’єднання
*/
-- Повертає всі можливі комбінації водіїв і транспортних засобів.
SELECT *
FROM driver
CROSS JOIN vehicle;


/*
Об’єднання декількох наборів результатів
*/
-- Повертає унікальні імена та прізвища водіїв та замовників.
SELECT first_name, last_name FROM driver
UNION
SELECT first_name, last_name FROM customer;

-- Повертає всі імена і прізвища, включаючи дублікати.
SELECT first_name, last_name FROM driver
UNION ALL
SELECT first_name, last_name FROM customer;


/*
Групування записів
*/
-- Підраховує кількість транспортних засобів кожного типу.
SELECT v.type, COUNT(*) AS vehicle_count
FROM vehicle v
GROUP BY v.type;

-- Підраховує кількість транспортних засобів кожного типу, але відображає лише ті типи, де кількість більше 5.
SELECT v.type, COUNT(*) AS vehicle_count
FROM vehicle v
GROUP BY v.type
HAVING COUNT(*) > 2;


/*
INSERT
*/
-- Додає нового клієнта з іменем 'Jonh' та прізвищем 'Smith' до таблиці 'customer'.
INSERT INTO customer (first_name, last_name)
VALUES('Jonh', 'Smith');


/*
UPDATE
*/
-- Оновлює прізвище клієнта з 'NewName' для запису, де 'id' дорівнює 1.
UPDATE customer
SET last_name = 'NewName'
WHERE id = 1;


/*
DELETE
*/
-- Видаляє клієнта з таблиці 'customer', де 'id' дорівнює 4.
DELETE FROM customer
WHERE id = 4;


/*
DROP
*/
-- Видаляє таблицю 'customer' з бази даних.
DROP TABLE customer;


/*
ALTER TABLE
*/
-- Додає новий стовпець 'email' до таблиці 'customer'.
ALTER TABLE customer
ADD email NVARCHAR(100);

-- Видаляє стовпець 'last_name' з таблиці 'customer'.
ALTER TABLE customer
DROP COLUMN last_name;

-- Додає значення за замовчуванням 'Unknown' для стовпця 'first_name'.
ALTER TABLE customer
ADD CONSTRAINT DF_first_name
DEFAULT 'Unknown' FOR first_name;

-- Видаляє значення за замовчуванням для стовпця 'first_name'.
ALTER TABLE customer
DROP CONSTRAINT DF_first_name;

-- Додає первинний ключ до стовпця 'id', якщо він ще не існує.
ALTER TABLE customer
ADD CONSTRAINT PK_Customer PRIMARY KEY (id);

-- Видаляє первинний ключ 'PK_Customer' з таблиці 'customer'.
ALTER TABLE customer
DROP CONSTRAINT PK_Customer;

-- Додає зовнішній ключ, який пов'язує 'id' таблиці 'customer' з полем 'customer_id' таблиці 'orders'.
ALTER TABLE customer
ADD CONSTRAINT FK_Order_Customer FOREIGN KEY (id) REFERENCES orders(customer_id);

-- Видаляє зовнішній ключ 'FK_Order_Customer' з таблиці 'customer'.
ALTER TABLE customer
DROP CONSTRAINT FK_Order_Customer;

-- Додає умову унікальності для стовпця 'email'.
ALTER TABLE customer
ADD CONSTRAINT UQ_CustomerEmail UNIQUE (email);

-- Видаляє умову унікальності для стовпця 'email'.
ALTER TABLE customer
DROP CONSTRAINT UQ_CustomerEmail;

-- Видаляє умову унікальності для стовпця 'email'
ALTER TABLE customer
DROP CONSTRAINT UQ_CustomerEmail;

-- Додає обмеження, яке гарантує, що довжина 'first_name' буде не менше 2 символів.
ALTER TABLE customer
ADD CONSTRAINT CHK_FirstName CHECK (LEN(first_name) >= 2);

-- Видаляє обмеження на значення 'first_name', яке вимагало мінімум 2 символи
ALTER TABLE customer
DROP CONSTRAINT CHK_FirstName;


-- "DRIVER"
-- Вибірка всіх транспортних засобів і їх водіїв за допомогою WHERE-з'єднання
SELECT *
FROM vehicle, driver
WHERE vehicle.driver_id = driver.id;

-- Вибірка імен водіїв та марки їх транспортних засобів за допомогою JOIN
SELECT d.first_name, v.mark
FROM driver d
JOIN vehicle v ON d.id = v.driver_id;

-- Вибірка імен, прізвищ водіїв і марок транспортних засобів типу 'CAR'
SELECT d.first_name, d.last_name, v.mark, v.type
FROM driver d, vehicle v
WHERE d.id = v.driver_id AND v.type = 'CAR';

-- Вибірка імен водіїв, марок їх транспортних засобів, назв і адрес розташування транспортних засобів
SELECT d.first_name, v.mark, l.name, l.address
FROM driver d
JOIN vehicle v ON v.driver_id = d.id
LEFT JOIN vehicle_location vl ON vl.vehicle_id = v.id
LEFT JOIN location l ON l.id = vl.location_id;


-- "VEHICLE"
-- Вибірка марок транспортних засобів і імен водіїв, використовуючи WHERE для з’єднання таблиць.
SELECT v.mark, d.first_name, d.last_name
FROM vehicle v, driver d
WHERE v.driver_id = d.id;

-- Вибірка транспортних засобів і відповідних водіїв із використанням JOIN в розділі FROM.
SELECT v.mark, d.first_name, d.last_name
FROM vehicle v
JOIN driver d ON v.driver_id = d.id;

-- Об’єднання наборів результатів двох запитів: усіх водіїв з транспортними засобами і всіх транспортних засобів з водіями.
SELECT d.first_name, v.mark
FROM driver d
JOIN vehicle v ON d.id = v.driver_id
UNION
SELECT d.first_name, v.mark
FROM vehicle v
JOIN driver d ON v.driver_id = d.id;

-- Підрахунок кількості транспортних засобів кожного типу з групуванням по типу.
SELECT v.type, COUNT(*) AS vehicle_count
FROM vehicle v
GROUP BY v.type;


-- "LOCATION"
-- Вибірка локацій та замовлень, де замовлення має певну локацію відправлення.
SELECT l.name, co.id, co.status
FROM location l, customer_order co
WHERE l.id = co.from_location_id;

-- Вибірка локацій та кроків доставки, використовуючи JOIN для з'єднання по місцю відправлення.
SELECT l.name, ds.pickup_date, ds.delivery_date
FROM location l
JOIN delivery_step ds ON l.id = ds.from_location_id;

-- Вибірка всіх локацій і відповідних кроків доставки, включаючи ті локації, які ще не використовуються в доставках.
SELECT l.name, ds.pickup_date, ds.delivery_date
FROM location l
LEFT JOIN delivery_step ds ON l.id = ds.from_location_id;

-- Підрахунок кількості замовлень з кожної локації.
SELECT l.name, COUNT(co.id) AS order_count
FROM location l
JOIN customer_order co ON l.id = co.from_location_id
GROUP BY l.name;


-- "CUSTOMER_ORDER"
-- Вибірка замовлень і відповідних доставок за допомогою WHERE.
SELECT co.id, co.status, d.status AS delivery_status
FROM customer_order co, delivery d
WHERE co.id = d.order_id;

-- Вибірка замовлень і відповідних місць доставки за допомогою JOIN.
SELECT co.id, co.status, l.name AS delivery_location
FROM customer_order co
JOIN location l ON co.to_location_id = l.id;

-- Вибірка всіх замовлень та відповідних доставок, включаючи ті замовлення, які ще не мають доставки.
SELECT co.id, co.status, d.pickup_date, d.delivery_date
FROM customer_order co
LEFT JOIN delivery d ON co.id = d.order_id;

-- Підрахунок кількості замовлень за їх статусом.
SELECT status, COUNT(*) AS order_count
FROM customer_order
GROUP BY status;


-- "DELIVERY"
-- Вибірка замовлень та їх доставок з використанням WHERE.
SELECT d.id, d.status, co.id AS order_id
FROM delivery d, customer_order co
WHERE d.order_id = co.id;

-- Вибірка замовлень та їх доставок з використанням JOIN.
SELECT d.id, d.status, co.id AS order_id
FROM delivery d
JOIN customer_order co ON  d.order_id = co.id;

-- Вибірка всіх доставок і відповідних замовлень, включаючи ті доставки, які ще не мають відповідних замовлень.
SELECT d.id, d.status, co.status AS order_status
FROM delivery d
RIGHT JOIN customer_order co ON d.order_id = co.id;

-- Підрахунок кількості доставок за їх статусом.
SELECT status, COUNT(*) AS delivery_count
FROM delivery
GROUP BY status;


-- "DELIVERY_STEP"
-- Вибірка кроків доставки і транспортних засобів з використанням WHERE.
SELECT ds.id, ds.pickup_date, v.mark
FROM delivery_step ds, vehicle v
WHERE ds.vehicle_id = v.id;

-- Вибірка кроків доставки та відповідних замовлень за допомогою JOIN.
SELECT ds.id, ds.pickup_date, co.status AS order_status
FROM delivery_step ds
JOIN delivery d ON ds.delivery_id = d.id
JOIN customer_order co ON d.order_id = co.id;

-- Вибірка всіх кроків доставки та відповідних транспортних засобів, включаючи кроки доставки без транспортних засобів.
SELECT ds.id, ds.pickup_date, v.mark
FROM delivery_step ds
LEFT JOIN vehicle v ON ds.vehicle_id = v.id;

-- Підрахунок кількості кроків доставки по кожному типу транспортного засобу.
SELECT v.type, COUNT(ds.id) AS step_count
FROM delivery_step ds
JOIN vehicle v ON ds.vehicle_id = v.id
GROUP BY v.type;


-- "DRIVER"
SELECT * FROM driver;

-- Додаємо нового водія в таблицю driver.
INSERT INTO driver (first_name, last_name, birthday, phone, license_number)
VALUES ('John', 'Doe', '1980-04-21', '+123456789', 'XYZ123456');
SELECT * FROM driver;

-- Оновлюємо номер телефону водія з license_number = 'XYZ123456'.
UPDATE driver
SET phone = '+987654321'
WHERE license_number = 'XYZ123456';
SELECT * FROM driver;

-- Видаляємо водія з license_number = 'XYZ123456'.
DELETE FROM driver
WHERE license_number = 'XYZ123456';
SELECT * FROM driver;


-- "VEHICLE"
SELECT * FROM vehicle;

-- Додаємо новий транспортний засіб в таблицю vehicle.
INSERT INTO vehicle (driver_id, capacity, vin, license_plate, mark, type, status) 
VALUES (1, 1000, '1HGCM82633A123482', 'ABC1234', 'Toyota', 'CAR', 'AVAILABLE');
SELECT * FROM vehicle;

-- Оновлюємо номерний знак транспортного засобу.
UPDATE vehicle
SET license_plate = 'DEF456'
WHERE license_plate = 'ABC1234';
SELECT * FROM vehicle;

-- Додаємо стовпець "color" для зберігання кольору транспортного засобу.
ALTER TABLE vehicle
ADD color VARCHAR(50);
SELECT * FROM vehicle;


-- "LOCATION"
SELECT * FROM location;

-- Додаємо нову локацію в таблицю location.
INSERT INTO location (name, type, address, city, postal_code)
VALUES ('Warehouse 1', 'DELIVERY_POINT', '123 Street Name', 'Chicago', '10006');
SELECT * FROM location;

-- Оновлюємо адресу локації.
UPDATE location
SET address = '456 New Street'
WHERE id = 6;
SELECT * FROM location;

-- Додаємо стовпець "notes".
ALTER TABLE location
ADD notes NVARCHAR(50);
SELECT * FROM location;

-- Видаляємо стовпець "notes".
ALTER TABLE location
DROP COLUMN notes;
SELECT * FROM location;


-- "CUSTOMER_ORDER"
SELECT * FROM customer_order;

-- Додаємо нове замовлення в таблицю customer_order.
INSERT INTO customer_order (from_location_id, to_location_id, order_date, status)
VALUES (2, 1, '2023-09-01 10:00:00', 'PENDING');
SELECT * FROM customer_order;

-- Оновлюємо статус замовлення.
UPDATE customer_order
SET status = 'COMPLETED'
WHERE id = 6;
SELECT * FROM customer_order;

-- Видаляємо замовлення з таблиці.
DELETE FROM customer_order
WHERE id = 6;
SELECT * FROM customer_order


-- "DELIVERY"
SELECT * FROM delivery;

-- Додаємо нове замовлення на доставку.
INSERT INTO delivery (order_id, pickup_date, status)
VALUES (5, '2023-09-03 13:00:00', 'SCHEDULED');
SELECT * FROM delivery;

-- Додаємо нову колонку "driver_name".
ALTER TABLE delivery
ADD driver_name NVARCHAR(100);
SELECT * FROM delivery;

-- Видаляємо колонку "driver_name".
ALTER TABLE delivery
DROP COLUMN driver_name;
SELECT * FROM delivery;

-- Оновлюємо запис у таблиці delivery.
UPDATE delivery
SET order_id = 4
WHERE id = 6;
SELECT * FROM delivery;