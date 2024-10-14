-- === 1. Drop Existing Functions ===

DROP FUNCTION IF EXISTS CalculateDiscount;
DROP FUNCTION IF EXISTS GetCustomerOrderCount;
DROP FUNCTION IF EXISTS GetCustomerTotalSpent;
DROP FUNCTION IF EXISTS GetProductCategory;
DROP FUNCTION IF EXISTS GetCustomerEmail;

-- === 2. Create New Functions ===

-- Set the delimiter to handle function creation
DELIMITER //


CREATE FUNCTION GetCustomerOrderCount(
    p_customer_id INT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE order_count INT;

    -- Count the number of orders placed by the customer
    SELECT COUNT(*) INTO order_count
    FROM shop.orders
    WHERE customer_id = p_customer_id;

    RETURN order_count;
END //


CREATE FUNCTION GetCustomerTotalSpent(
    p_customer_id INT
) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_spent DECIMAL(10,2);

    -- Sum the total amount spent by the customer across all orders
    SELECT IFNULL(SUM(total_amount), 0) INTO total_spent
    FROM shop.orders
    WHERE customer_id = p_customer_id;

    RETURN total_spent;
END //


CREATE FUNCTION GetCustomerEmail(
    p_customer_id INT
) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE customer_email VARCHAR(100);

    -- Retrieve the email address of the customer
    SELECT email INTO customer_email
    FROM shop.customers
    WHERE customer_id = p_customer_id
    LIMIT 1;

    RETURN customer_email;
END //

-- Reset the delimiter back to default
DELIMITER ;

-- === 3. SELECT Statement Utilizing the Functions ===

SELECT 
    c.customer_id,
    c.customer_name,
    GetCustomerEmail(c.customer_id) AS email,
    GetCustomerOrderCount(c.customer_id) AS total_orders,
    GetCustomerTotalSpent(c.customer_id) AS total_spent,
    -- Apply a discount based on total_spent
    CASE 
        WHEN GetCustomerTotalSpent(c.customer_id) > 1000 THEN 'VIP Customer'
        ELSE 'Regular Customer'
    END AS customer_status
FROM 
    shop.customers c
ORDER BY 
    total_spent DESC;
