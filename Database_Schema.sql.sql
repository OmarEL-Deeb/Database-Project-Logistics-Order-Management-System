create database LogisticsDB
use LogisticsDB

 create table Countries (
 CountryId INT Identity Primary Key, 
  Name NVARCHAR(100) Not Null Unique
 )

 create table Cities(

 CityId INT Identity Primary Key,
 Name NVARCHAR(100) Not Null,
  CountryId INT ,
  Constraint FK Foreign Key  (CountryId) References  Countries (CountryId)

 )

 Create table Warehouses(
WarehouseId INT Identity Primary Key,
Name NVARCHAR(150)  Not Null,
CityId INT  ,
Capacity INT Check ( Capacity>0 ),
CreatedAt DATETIME Default GETDATE(),
 Constraint FK1 Foreign Key  (CityId) References  Cities (CityId)
)

create table Customers(
CustomerId INT Identity Primary Key,
FullName NVARCHAR(150)  Not Null ,
Email NVARCHAR(150) Unique Not Null,
Phone NVARCHAR(20) Unique Not Null ,
CreatedDate DATETIME Default GETDATE(),
IsActive BIT Default 1
)

create table Drivers (
DriverId INT Identity Primary Key,
FullName NVARCHAR(150) Not Null,
LicenseNumber NVARCHAR(100) Unique Not Null,
Salary DECIMAL(18,2) Check (Salary> 0),
HireDate DATE,
IsActive BIT Default 1
)

create table Vehicles(
VehicleId INT Identity Primary Key,
PlateNumber NVARCHAR(50) Unique Not Null,
Capacity DECIMAL(10,2) check (Capacity> 0),
AssignedDriverId INT Null  ,
IsActive BIT Default 1,
 Constraint FK2 Foreign Key  (AssignedDriverId) References  Drivers (DriverId)

)

CREATE TABLE Shipments
(
    ShipmentId INT IDENTITY PRIMARY KEY,

    CustomerId INT NOT NULL,
    OriginWarehouseId INT NOT NULL,
    DestinationWarehouseId INT NOT NULL,
    VehicleId INT NOT NULL,

    Weight DECIMAL(10,2) NOT NULL
        CONSTRAINT CK_Shipments_Weight CHECK (Weight > 0),

    Price DECIMAL(18,2) NOT NULL
        CONSTRAINT CK_Shipments_Price CHECK (Price > 0),

    Status NVARCHAR(50) NOT NULL
        CONSTRAINT CK_Shipments_Status CHECK (Status IN ('Pending','InTransit','Delivered','Cancelled')),

    CreatedAt DATETIME DEFAULT GETDATE(),
    DeliveredAt DATETIME NULL,

    DeliveryDurationHours AS DATEDIFF(HOUR, CreatedAt, DeliveredAt),

    CONSTRAINT FK_Shipments_Customers
        FOREIGN KEY (CustomerId)
        REFERENCES Customers(CustomerId)
        ON DELETE CASCADE,

    CONSTRAINT FK_Shipments_OriginWarehouse
        FOREIGN KEY (OriginWarehouseId)
        REFERENCES Warehouses(WarehouseId),

    CONSTRAINT FK_Shipments_DestinationWarehouse
        FOREIGN KEY (DestinationWarehouseId)
        REFERENCES Warehouses(WarehouseId),

    CONSTRAINT FK_Shipments_Vehicles
        FOREIGN KEY (VehicleId)
        REFERENCES Vehicles(VehicleId)
)

create table ShipmentStatusHistory(
ShipmentId int not null ,
hipmentId int not null ,
Status NVARCHAR(50) ,
StatusDate DATETIME Default GETDATE(),
CONSTRAINT PK_ShipmentStatusHistory
        PRIMARY KEY (ShipmentId, StatusDate),
CONSTRAINT FK_ShipmentStatusHistory_Shipments
 FOREIGN KEY (ShipmentId)
 REFERENCES Shipments(ShipmentId)
 )

 create table Payments (
PaymentId INT Identity Primary Key,
ShipmentId INT,
Amount DECIMAL(18,2)Check (Amount> 0),
PaymentMethod NVARCHAR(50) Check (PaymentMethod in ('Cash','Card','Transfer')),
IsPaid BIT Default 0 ,
PaidDate DATETIME Null,
CONSTRAINT FK_Payments_Shipments
 FOREIGN KEY (ShipmentId)
 REFERENCES Shipments(ShipmentId)
)

create table EmployeeRoles(
RoleId INT Identity Primary Key,
RoleName NVARCHAR(100) Unique Not Null
)


create table Employees (
EmployeeId INT Identity Primary Key,
FullName NVARCHAR(150) Not Null,
WarehouseId INT,
RoleId INT, 
Salary DECIMAL(18,2) Check(Salary > 0),
HireDate DATE,
CONSTRAINT FK_Employees_Warehouses
 FOREIGN KEY (WarehouseId)
 REFERENCES Warehouses(WarehouseId),

 CONSTRAINT FK_Employees_EmployeeRoles
 FOREIGN KEY (RoleId)
 REFERENCES EmployeeRoles(RoleId)
)


