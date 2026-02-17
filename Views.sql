Use LogisticsDB
go
--
create View ActiveDrivers
AS  
 select * from Drivers
 where IsActive =1;
 --ShipmentSummary
create View ShipmentSummary
AS  
 select ShipmentId ,CustomerId,CreatedAt ,DeliveredAt,Price,Status,DeliveryDurationHours
 from Shipments 
 --MonthlyRevenue
CREATE VIEW MonthlyRevenue
AS
SELECT 
    YEAR(PaidDate) AS [Year],
    MONTH(PaidDate) AS [Month],
    SUM(p.Amount) AS [Revenue]
FROM Payments p
GROUP BY YEAR(PaidDate), MONTH(PaidDate);
--UnpaidShipments
CREATE VIEW UnpaidShipments
AS
select s.* from Shipments s left join Payments p on p.ShipmentId=s.ShipmentId
where p.IsPaid !=0

