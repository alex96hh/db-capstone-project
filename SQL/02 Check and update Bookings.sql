USE littlelemondb;
-- Task 1: create data
-- the Task will be skipped because I already created fake data

-- Task 2: define a stored procedure that checks whether a certain table is already booked at a certain date
DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER //
CREATE PROCEDURE CheckBooking(Date_in DATE, TableNo_in INT)
BEGIN
    DECLARE booking_count INT;

    -- Count the number of bookings for the specified date and table
    SELECT COUNT(*) INTO booking_count -- returns 0 if table empty, i.e. no bookings where found
    FROM Bookings
    WHERE Date = Date_in AND TableNo = TableNo_in;

    -- Check if booking_count is 0 and return appropriate message
    IF booking_count = 0 THEN
        SELECT CONCAT('Table ', TableNo_in, ' is not booked') AS "Booking Status";
    ELSE
        SELECT CONCAT('Table ', TableNo_in, ' is already booked') AS "Booking Status";
    END IF;
END //
DELIMITER ;

CALL CheckBooking('2022-11-12', 3);
CALL CheckBooking('2024-11-03', 3);

-- Task 3: Create a transaction that rejects booking attempts for tables that are already booked
DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(Date_in DATE, TableNo_in INT)
BEGIN
	DECLARE booking_count INT;
	START TRANSACTION;
    
    INSERT INTO Bookings (Date, TableNo)
    VALUES (Date_in, TableNo_in);

    -- Count the number of bookings for the specified date and table
    SELECT COUNT(*) INTO booking_count -- returns 0 if table empty, i.e. no bookings where found
    FROM Bookings
    WHERE Date = Date_in AND TableNo = TableNo_in;
    
    IF booking_count = 0
		THEN COMMIT;
        SELECT CONCAT('Table ', TableNo_in, ' was successfully booked') AS "Booking Status";
	ELSE ROLLBACK;
    SELECT CONCAT('Table ', TableNo_in, ' is already booked - booking cancelled') AS "Booking Status";
    END IF;
END //
DELIMITER ;

CALL AddValidBooking('2024-11-03', 3);

-- Task 1: Create a Procedure that adds a new entry to the Bookings table
DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(BookingID_in INT, CustomerID_in INT, Date_in DATE, TableNo_in INT)
BEGIN
	INSERT INTO Bookings (BookingID, Date, TableNo, CustomerID)
		VALUES (BookingID_in, Date_in, TableNo_in, CustomerID_in);
    SELECT 'New booking added' AS Confirmation;
END //
DELIMITER ;

CALL AddBooking(15, 3, '2022-12-30', 4);

-- Task 2: 
DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(BookingID_in INT, Date_in DATE)
BEGIN
	UPDATE Bookings
		SET Date = Date_in
        WHERE BookingID = BookingID_in;
	SELECT CONCAT('Booking ', BookingID_in, ' updated') AS Confirmation;
END //
DELIMITER ;

CALL UpdateBooking(15, '2022-12-17');

-- Task 3: create a Procedure that cancels/removes a booking
DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking(BookingID_in INT)
BEGIN
	DELETE FROM Bookings
		WHERE BookingID = BookingID_in;
	SELECT CONCAT('Booking ', BookingID_in, ' cancelled') AS Confirmation;
END //
DELIMITER ;

CALL CancelBooking(15);