use LogisticsDB
GO
---
insert into Countries(Name)
values 
('Egypt'),('Saudi Arabia'),('United Arab Emirates'),('Germany'),('France'),('UK'),('US')
---
insert into Cities(Name,CountryID)
values('Cairo',1),('Alex',1),('Mansoura',1),('Riyadh',2),('Jeddah',2),('Dubai',3),('Berlin',4)
,('Paris',5),('Abu Dhabi',3),('Munich',4),('Lyon',5)
---
INSERT INTO Warehouses (Name, CityId, Capacity, CreatedAt)
VALUES

('WH-Cairo-1',
 (SELECT CityId FROM Cities WHERE Name = 'Cairo'),
 3500,
 '2023-01-15'),

('WH-Alex-1',
 (SELECT CityId FROM Cities WHERE Name = 'Alexandria'),
 3060,
 '2023-03-10'),

('WH-Riyadh-1',
 (SELECT CityId FROM Cities WHERE Name = 'Riyadh'),
 6000,
 '2023-06-05'),

('WH-Dubai-1',
 (SELECT CityId FROM Cities WHERE Name = 'Dubai'),
 8000,
 '2023-09-18'),

('WH-Berlin-1',
 (SELECT CityId FROM Cities WHERE Name = 'Berlin'),
 7000,
 '2024-01-12'),

('WH-Paris-1',
 (SELECT CityId FROM Cities WHERE Name = 'Paris'),
 6500,
 '2024-04-20'),

('WH-Lyon-1',
 (SELECT CityId FROM Cities WHERE Name = 'Lyon'),
 4000,
 '2024-07-08');
--
INSERT INTO Customers 
(FullName, Email, Phone, CreatedDate, IsActive)
VALUES

('Omar Hassan',       'omar.hassan@gmail.com',        '01012345678', '2023-01-10', 1),
('Mohamed Ali',       'm.ali@gmail.com',              '01023456789', '2023-02-05', 1),
('Sara Ahmed',        'sara.ahmed@gmail.com',         '01134567890', '2023-03-12', 1),
('Mahmoud Ibrahim',   'mahmoud.ibrahim@gmail.com',    '01245678901', '2023-04-18', 1),
('Fatma Khaled',      'fatma.khaled@gmail.com',       '01556789012', '2023-06-22', 1),
('Ahmed Mostafa',     'ahmed.mostafa@gmail.com',      '01067890123', '2023-08-30', 1),
('Noha Samir',        'noha.samir@gmail.com',         '01178901234', '2023-10-14', 0),
('Youssef Adel',      'youssef.adel@gmail.com',       '01289012345', '2024-01-09', 1),
('Mona Tarek',        'mona.tarek@gmail.com',         '01590123456', '2024-03-17', 1),
('Karim Nabil',       'karim.nabil@gmail.com',        '01011223344', '2024-05-25', 0);
--------
INSERT INTO Drivers
(FullName, LicenseNumber, Salary, HireDate, IsActive)
VALUES

('Ahmed Salah',     'DL-1001', 8500.00, '2021-03-15', 1),
('Mohamed Fathy',   'DL-1002', 9200.00, '2020-07-10', 1),
('Omar Khaled',     'DL-1003', 7800.00, '2022-01-20', 1),
('Yasser Adel',     'DL-1004', 8800.00, '2019-11-05', 1),
('Karim Samy',      'DL-1005', 9100.00, '2018-06-18', 0),
('Hossam Nabil',    'DL-1006', 7600.00, '2023-04-02', 1),
('Mahmoud Essam',   'DL-1007', 8300.00, '2022-09-14', 1),
('Wael Tarek',      'DL-1008', 8700.00, '2021-12-01', 1),
('Sherif Mostafa',  'DL-1009', 9500.00, '2017-08-23', 1),
('Khaled Ibrahim',  'DL-1010', 7900.00, '2023-02-11', 0);
---
INSERT INTO Vehicles
(PlateNumber, Capacity, AssignedDriverId, IsActive)
VALUES

('Deeb-1234',  5.00,  1, 1),
('Dkhl-5678',  7.50,  2, 1),
('Abnc-9012', 10.00,  3, 1),
('JKLO-3456', 12.00,  4, 1),
('MNO-7890',  8.50,  5, 0),
('PQRS-1122',  6.00,  6, 1),
('STUX-3344', 15.00,  7, 1),
('VWXX-5566',  9.00,  8, 1),
('YZAZ-7788', 20.00,  9, 1),
('BCDZ-9900',  4.00, NULL, 1);
----
INSERT INTO Shipments
(CustomerId, OriginWarehouseId, DestinationWarehouseId,
 VehicleId, Weight, Price, Status, CreatedAt, DeliveredAt)
VALUES

(1,1,4,1, 2.50, 1500.00,'Delivered','2024-01-01','2024-01-03'),
(2,2,5,2, 5.00, 3200.00,'Delivered','2024-01-05','2024-01-08'),
(3,3,1,3, 1.20, 900.00,'Delivered','2024-01-10','2024-01-12'),
(4,4,6,4, 8.75, 5400.00,'Delivered','2024-01-15','2024-01-18'),
(5,5,2,5, 3.40, 2100.00,'Delivered','2024-01-20','2024-01-22'),

(6,6,3,6, 6.00, 4100.00,'InTransit','2024-02-01',NULL),
(7,7,4,7, 9.30, 6200.00,'InTransit','2024-02-03',NULL),
(8,1,5,8, 4.80, 2700.00,'InTransit','2024-02-05',NULL),
(9,2,6,9, 7.25, 5000.00,'InTransit','2024-02-08',NULL),
(10,3,7,10, 2.10, 1300.00,'InTransit','2024-02-10',NULL),

(1,4,2,1, 10.00, 7500.00,'Pending','2024-03-01',NULL),
(2,5,3,2, 12.50, 8900.00,'Pending','2024-03-04',NULL),
(3,6,1,3, 1.75, 950.00,'Pending','2024-03-07',NULL),
(4,7,4,4, 15.00, 12000.00,'Pending','2024-03-10',NULL),
(5,1,6,5, 6.60, 4300.00,'Pending','2024-03-12',NULL),

(6,2,7,6, 3.00, 2000.00,'Cancelled','2024-03-15',NULL),
(7,3,5,7, 5.50, 3600.00,'Cancelled','2024-03-18',NULL),
(8,4,1,8, 2.80, 1700.00,'Cancelled','2024-03-20',NULL),
(9,5,2,9, 11.00, 9800.00,'Cancelled','2024-03-22',NULL),
(10,6,3,10, 4.40, 2900.00,'Cancelled','2024-03-25',NULL);
-----
INSERT INTO Payments
(ShipmentId, Amount, PaymentMethod, IsPaid, PaidDate)
VALUES

-- Delivered Shipments 
(1, 1500.00, 'Card', 1, '2024-01-03'),
(2, 3200.00, 'Transfer', 1, '2024-01-08'),
(3, 900.00,  'Cash', 1, '2024-01-12'),
(4, 5400.00, 'Card', 1, '2024-01-18'),
(5, 2100.00, 'Cash', 1, '2024-01-22'),

-- InTransit 
(6, 4100.00, 'Transfer', 0, NULL),
(7, 6200.00, 'Card', 0, NULL),
(8, 2700.00, 'Cash', 0, NULL),
(9, 5000.00, 'Transfer', 0, NULL),
(10,1300.00, 'Card', 0, NULL),

-- Pending (11–15)
(11,7500.00,'Transfer',0,NULL),
(12,8900.00,'Card',0,NULL),
(13,950.00,'Cash',0,NULL),
(14,12000.00,'Transfer',0,NULL),
(15,4300.00,'Card',0,NULL),

-- Cancelled 
(16,2000.00,'Cash',0,NULL),
(17,3600.00,'Card',0,NULL),
(18,1700.00,'Transfer',0,NULL),
(19,9800.00,'Card',0,NULL),
(20,2900.00,'Cash',0,NULL);
----------
INSERT INTO ShipmentStatusHistory
(ShipmentId, Status, StatusDate)
VALUES
(1,'Pending','2024-01-01'),
(1,'InTransit','2024-01-02'),
(1,'Delivered','2024-01-03'),
(2,'Pending','2024-01-05'),
(2,'InTransit','2024-01-06'),
(2,'Delivered','2024-01-08'),
(6,'Pending','2024-02-01'),
(6,'InTransit','2024-02-02'),
(11,'Pending','2024-03-01'),
(16,'Pending','2024-03-15'),
(16,'Cancelled','2024-03-16');
