DELIMITER //

CREATE PROCEDURE GetTopCustomers(IN top_n INT)
BEGIN
    SELECT 
        c.customer_name, 
        SUM(o.total_amount) AS total_spent
    FROM shop.customers c
    INNER JOIN shop.orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
    ORDER BY total_spent DESC
    LIMIT top_n;
END //

DELIMITER ;

CALL GetTopCustomers(5);  -- Get the top 5 customers by spending
