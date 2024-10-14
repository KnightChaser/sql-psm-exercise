DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN customer_name VARCHAR(100))
BEGIN
    SELECT 
        orders.order_id,
        orders.order_date,
        orders.total_amount
    FROM shop.customers
    INNER JOIN shop.orders ON shop.customers.customer_id = shop.orders.customer_id
    WHERE shop.customers.customer_name = customer_name;
END //

DELIMITER ;

CALL GetCustomerOrders('Alice Johnson');