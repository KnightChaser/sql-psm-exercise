DELIMITER //

CREATE PROCEDURE GetCustomerOrdersAndTotalSpending(IN customer_name VARCHAR(100))
BEGIN
    DECLARE total_spent DECIMAL(10, 2);

    -- Retrieve all orders for the customer
    SELECT 
        o.order_id, 
        o.order_date, 
        o.total_amount
    FROM shop.customers c
    INNER JOIN shop.orders o ON c.customer_id = o.customer_id
    WHERE c.customer_name = customer_name;

    -- Calculate total spending
    SELECT SUM(o.total_amount) INTO total_spent
    FROM shop.customers c
    INNER JOIN shop.orders o ON c.customer_id = o.customer_id
    WHERE c.customer_name = customer_name;

    -- Return total spent
    SELECT total_spent AS total_spending;
END //

DELIMITER ;

CALL GetCustomerOrdersAndTotalSpending('Alice Johnson');

