-- Drop the function if it already exists
DROP FUNCTION IF EXISTS CheckProductStock;

-- Now, recreate the function
DELIMITER //

CREATE FUNCTION CheckProductStock(product_id INT, reorder_threshold INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE stock_level INT;
    DECLARE message VARCHAR(100);
    
    -- Get current stock level (LIMIT 1 ensures only one result)
    SELECT stock_quantity INTO stock_level
    FROM shop.products
    WHERE product_id = product_id
    LIMIT 1;
    
    -- Check if stock is below threshold
    IF stock_level < reorder_threshold THEN
        SET message = CONCAT('Reorder needed. Current stock: ', stock_level);
    ELSE
        SET message = CONCAT('Stock is sufficient. Current stock: ', stock_level);
    END IF;
    
    RETURN message;
END //

DELIMITER ;


SELECT CheckProductStock(2, 5000);