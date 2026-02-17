use LogisticsDB
go
---join 
SELECT DISTINCT
    c.FullName
FROM Customers c
INNER JOIN Shipments s
    ON c.CustomerId = s.CustomerId
LEFT JOIN Payments p
    ON s.ShipmentId = p.ShipmentId
WHERE p.ShipmentId IS NULL;

---Subquery
SELECT DISTINCT c.FullName
FROM Customers c
WHERE c.CustomerId IN (
    SELECT s.CustomerId
    FROM Shipments s
    WHERE s.ShipmentId NOT IN (
        SELECT p.ShipmentId
        FROM Payments p
        WHERE p.ShipmentId IS NOT NULL
    )
);
