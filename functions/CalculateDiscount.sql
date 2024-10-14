-- Drop the function if it already exists
DROP FUNCTION IF EXISTS CalculateDiscount;

-- Now, recreate the function
DELIMITER //

CREATE FUNCTION CalculateDiscount(p_product_id INT, discount_percentage DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE original_price DECIMAL(10, 2);
    DECLARE discounted_price DECIMAL(10, 2);

    -- Get the original price of the product (LIMIT 1 ensures only one result)
    SELECT price INTO original_price
    FROM shop.products
    WHERE product_id = p_product_id
    LIMIT 1;

    -- Calculate the discounted price
    SET discounted_price = original_price * (1 - discount_percentage / 100);

    RETURN discounted_price;
END //

DELIMITER ;

-- Now, use the function in your SELECT statement
SELECT 
    product_name,
    price AS original_price,
    CASE 
        WHEN stock_quantity < 50 THEN CalculateDiscount(product_id, 20)
        ELSE CalculateDiscount(product_id, 10)
    END AS final_discounted_price
FROM shop.products;
