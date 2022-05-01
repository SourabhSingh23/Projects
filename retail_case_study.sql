use retail_case_study;

SELECT 
    *
FROM
    tr_orderdetails;

SELECT 
    *
FROM
    tr_products;
    


SELECT 
    MAX(Quantity), COUNT(*)
FROM
    tr_orderdetails;
    
    
    
SELECT DISTINCT
    ProductID, Quantity
FROM
    tr_orderdetails
WHERE
    Quantity = 3
ORDER BY ProductID ASC;



SELECT DISTINCT
    propertyid
FROM
    tr_orderdetails
ORDER BY 1;



SELECT 
    ProductCAtegory, COUNT(*) AS count
FROM
    tr_products
GROUP BY ProductCAtegory
ORDER BY 2 DESC;



SELECT 
    PropertyState, COUNT(*) AS Count
FROM
    tr_propertyinfo
GROUP BY PropertyState
ORDER BY 2 DESC;



SELECT 
    Productid, SUM(Quantity) AS total_Quantity
FROM
    tr_orderdetails
GROUP BY productid
ORDER BY 2 DESC;



SELECT 
    PropertyID, SUM(Quantity) AS Total_Quantity
FROM
    tr_orderdetails
GROUP BY PropertyID
ORDER BY 2 DESC;



SELECT 
    o.*, p.productname, p.productcategory, p.price
FROM
    tr_orderdetails AS o
        LEFT JOIN
    tr_products AS p ON o.productid = p.productid;
    
    
    

SELECT 
    p.ProductName, SUM(o.Quantity) AS Total_Quantity
FROM
    tr_orderdetails AS o
        LEFT JOIN
    tr_products AS p ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY 2 DESC;



SELECT 
    p.ProductName, SUM(o.Quantity * p.Price) AS Sales
FROM
    tr_orderdetails AS o
        LEFT JOIN
    tr_products AS p ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Sales DESC
LIMIT 5;



SELECT 
    pi.PropertyCity, SUM(o.Quantity * p.Price) AS Sales
FROM
    tr_orderdetails AS o
        LEFT JOIN
    tr_products AS p ON o.ProductID = p.ProductID
        LEFT JOIN
    tr_propertyinfo AS pi ON o.PropertyID = pi.`Prop ID`
GROUP BY pi.PropertyCity
ORDER BY Sales DESC
LIMIT 5;


SELECT 
    pi.PropertyCity,
    p.ProductName,
    SUM(o.Quantity * p.Price) AS Sales
FROM
    tr_orderdetails AS o
        LEFT JOIN
    tr_products AS p ON o.ProductID = p.ProductID
        LEFT JOIN
    tr_propertyinfo AS pi ON o.PropertyID = pi.`Prop ID`
WHERE
    pi.PropertyCity = 'Arlington'
GROUP BY pi.PropertyCity , p.ProductName
ORDER BY Sales DESC
LIMIT 5;
    

