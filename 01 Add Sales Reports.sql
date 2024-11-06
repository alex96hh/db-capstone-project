USE littlelemondb;

-- Task 1: Create a View that only displays orders with quantity > 2
CREATE OR REPLACE VIEW OrdersView AS
SELECT OrderID, Quantity, BillAmount AS Cost
FROM Orders
WHERE Quantity > 2;

SELECT *
FROM OrdersView;

-- Task 2: get info on all customers with orders more expensive than $150
SELECT
	c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    o.ORDERID,
    o.BillAmount AS Cost,
    m.MenuName,
    mi.CourseName
FROM Customer AS c
INNER JOIN Orders AS o
INNER JOIN Menu AS m
INNER JOIN MenuItems AS mi
ON c.CustomerID = o.CustomerID
	AND o.MenuID = m.MenuID
    AND m.ItemID = mi.ItemID
WHERE BillAmount > 150
ORDER BY BillAmount ASC;

-- Task 3: Find all menus with a quantity larger 2 in one order
SELECT MenuID, MenuName
FROM Menu
WHERE MenuID = ANY (
	SELECT MenuID
	FROM Orders
	WHERE Quantity > 2
);

-- Task 1: create a stored procedure to find the highest quantity from the ORders table
DROP PROCEDURE IF EXISTS GetMaxQuantity;
CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(quantity) AS "Max Quantity in Order"
FROM Orders;

CALL GetMaxQuantity();

-- Task 2: create a prepared statement to find the Quantity and Cost of all Orders for a specific CustomerID
PREPARE GetOrderDetail FROM
	'SELECT OrderID, Quantity, BillAmount AS Cost
    FROM Orders
    WHERE CustomerID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- Task 3:
DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(orderid INT)
BEGIN
	DELETE FROM Orders
	WHERE OrderID = orderid;
	SELECT CONCAT('Order ', orderid, ' is cancelled') AS Confirmation;
END //
DELIMITER ;

-- need to deactivate safe update mode for the query to work...
SET SQL_SAFE_UPDATES = 0;
CALL CancelOrder(5);
SET SQL_SAFE_UPDATES = 1;

