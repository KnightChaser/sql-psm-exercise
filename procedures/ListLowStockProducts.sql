DELIMITER //

CREATE PROCEDURE ListLowStockProducts(IN threshold INT)
BEGIN
    SELECT 
        p.product_name,
        p.category,
        p.stock_quantity
    FROM shop.products p
    WHERE p.stock_quantity < threshold;
END //

DELIMITER ;

CALL ListLowStockProducts(20);  -- List all products with stock less than 20
