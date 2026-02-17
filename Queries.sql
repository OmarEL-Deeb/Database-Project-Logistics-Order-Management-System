use LogisticsDB
-----------------------------------Basic Queries-----------------------------

--Get all shipments with customer name and vehicle plate
  select s.* ,v.PlateNumber, c.FullName
  from shipments s  inner join vehicles v on s.VehicleId=v.VehicleId
  inner join Customers c on s.CustomerId =c.CustomerId;

  --Get all shipments not delivered
select * 
from Shipments s
where s.Status !='delivered'

--Get drivers without assigned vehicles
select d.* from Drivers d left  join Vehicles v
on  d.DriverId =v.AssignedDriverId
where v.AssignedDriverId is null

--Calculate warehouse capacity usage percentage

SELECT 
    w.Name ,
    w.Capacity,
   IsNull( sum(s.Weight),0) as TotalShipmentWeight ,
    IsNull( sum(s.Weight),0)*100.0 /w.Capacity as CapacityUsagePercent
FROM Warehouses w
LEFT JOIN Shipments s
    ON w.WarehouseId = s.OriginWarehouseId
GROUP BY  w.Name, w.Capacity

--Get customers created in the last 30 days
select * from Customers 
where DATEDIFF(day, CreatedDate , GETDATE()) <=30

----------------------------------Intermediate Queries--------------------------------

--top 5 customers by shipment count
select top 5
c.FullName ,
count(s.ShipmentId) as shipmentcount
from Customers c inner join Shipments s
on c.CustomerId =s.CustomerId
Group by c.FullName
--Monthly revenue grouped by year and month
select year(p.PaidDate) as [Year] , MONTH(p.PaidDate) as [Month] , sum(p.Amount) as TotalRevenue
 from Payments p where p.IsPaid =1 
 group by year(p.PaidDate)  ,MONTH(p.PaidDate)

 ----Average delivery time per warehouse

 select w.Name , avg(s.DeliveryDurationHours) as AverageTime
 from Shipments s  inner join Warehouses w
 on s.OriginWarehouseId =w.WarehouseId
 where s.Status ='Delivered'
 group by w.Name

 ---Drivers with more than 3 delayed shipments
 select d.DriverId ,d.FullName, count (s.ShipmentId) as DelayedShipments
 from Shipments s join Vehicles v
 on s.VehicleId =v.VehicleId
 join Drivers d on d.DriverId = v.AssignedDriverId
 where s.DeliveryDurationHours >48  
 group by d.FullName,d.DriverId
 Having count (s.ShipmentId )>3
 
 --Customers who have shipments but no payments
SELECT DISTINCT
    c.FullName
FROM Customers c
INNER JOIN Shipments s
    ON c.CustomerId = s.CustomerId
LEFT JOIN Payments p
    ON s.ShipmentId = p.ShipmentId
WHERE p.ShipmentId IS NULL;


---Warehouses with no shipments

select w.Name
from Warehouses w left join Shipments s
on w.WarehouseId =s.OriginWarehouseId
where s.OriginWarehouseId Is Null;

---------------------------------Advanced Queries--------------------------------
---