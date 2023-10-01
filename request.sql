
WITH AvergeSum AS (SELECT AVG(TotalAmount) FROM Orders)
     TopCustomers AS 
        (SELECT FirstName,LastName FROM Customers
            WHERE CustomerID IN (SELECT CustomerID FROM Orders
                                    GROUP BY CustomerID
                                    HAVING MAX(TotalAmount) > AvergeSum))

SELECT Customers.FirstName,Customers.LastName, Orders.OrderID, Orders.TotalAmount
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.FirstName = TopCustomers.FirstName AND Customers.LastName = TopCustomers.LastName
ORDER BY Orders.TotalAmount DESC;