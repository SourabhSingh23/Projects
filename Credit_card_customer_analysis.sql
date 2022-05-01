create database credit_card;
use credit_card;

drop table backchurners;

create table bankchurners(
	CLIENTNUM integer,
    Attrition_Flag varchar(20),
    Customer_Age integer,
    Gender char(5),
    Dependent_count integer,
    Education_Level varchar(20),
    Marital_Status varchar(20),
    Income_Category varchar(20),
    Card_Category varchar(20),
    Months_on_book integer,
    Total_Relationship_Count integer,
    Months_Inactive_12_mon integer,
    Contacts_Count_12_mon integer,
    Credit_Limit integer,
    Total_Revolving_Bal integer,
    Avg_Open_To_Buy integer,
    Total_Amt_Chng_Q4_Q1 double, 
    Total_Trans_Amt integer,
    Total_Trans_Ct integer,
    Total_Ct_Chng_Q4_Q1 double,
    Avg_Utilization_Ratio double
);

select * from bankchurners;

# Distribution of Attributed customers based on age range

SELECT 
    CASE
        WHEN customer_age < 20 THEN '0-20'
        WHEN customer_age BETWEEN 20 AND 30 THEN '20-30'
        WHEN customer_age BETWEEN 30 AND 40 THEN '30-40'
        WHEN customer_age BETWEEN 40 AND 50 THEN '40-50'
        WHEN customer_age BETWEEN 50 AND 60 THEN '50-60'
        WHEN customer_age BETWEEN 60 AND 70 THEN '60-70'
        WHEN customer_age BETWEEN 70 AND 80 THEN '70-80'
        WHEN customer_age > 80 THEN 'Above 80'
    END AS Age_range,
    COUNT(*)
FROM
    bankchurners
WHERE
    Attrition_flag = 'Attrited Customer'
GROUP BY age_range
ORDER BY age_range;


SELECT 
    SUM(IF(gender = 'M', 1, 'NULL')) AS MaleExistingCustomers,
    SUM(IF(Gender = 'F', 1, 'NULL')) AS FemaleExistingCustomers
FROM
    bankchurners
WHERE
    Attrition_flag = 'Existing Customer';

SELECT 
    SUM(IF(gender = 'M', 1, 'NULL')) AS MaleAttritedCustomers,
    SUM(IF(GEnder = 'F', 1, 'NULL')) AS FemaleAttritedCustomers
FROM
    bankchurners
WHERE
    Attrition_flag = 'Attrited Customer';


SELECT 
    Education_level, COUNT(*)
FROM
    bankchurners
WHERE
    Attrition_Flag = 'Existing Customers'
GROUP BY Education_Level
ORDER BY COUNT(*);

SELECT 
    Education_Level, COUNT(*)
FROM
    bankchurners
WHERE
    Attrition_Flag = 'Existing Customer'
GROUP BY Education_level
ORDER BY COUNT(*);



SELECT 
    CASE
        WHEN Months_on_book < 20 THEN '0-20'
        WHEN Months_on_book BETWEEN 20 AND 30 THEN '20-30'
        WHEN Months_on_book BETWEEN 30 AND 40 THEN '30-40'
        WHEN Months_on_book BETWEEN 40 AND 50 THEN '40-50'
        WHEN Months_on_book BETWEEN 50 AND 60 THEN '50-60'
        WHEN Months_on_book > 60 THEN 'Above 60'
    END AS Monthonbook_range,
    COUNT(*)
FROM
    bankchurners
WHERE
    Attrition_flag = 'Attrited Customer'
GROUP BY MOnthonbook_range
ORDER BY Monthonbook_Range;

