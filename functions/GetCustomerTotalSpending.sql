DELIMITER //

CREATE FUNCTION GetCustomerTotalSpending(customer_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_spending DECIMAL(10,2);
    
    SELECT SUM(total_amount) INTO total_spending
    FROM shop.orders
    WHERE customer_id = customer_id;
    
    RETURN IFNULL(total_spending, 0.00);
END //

DELIMITER ;

SELECT GetCustomerTotalSpending(2);