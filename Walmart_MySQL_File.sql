-- Create Database

CREATE DATABASE IF NOT EXISTS walmartsales;

-- Create Table

USE walmartsales;

CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6 , 4 ) NOT NULL,
    total DECIMAL(12 , 4 ) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10 , 2 ) NOT NULL,
    gross_margin_pct FLOAT(11 , 9 ),
    gross_income DECIMAL(12 , 4 ),
    rating FLOAT(2 , 1 )
);

-- Import Data From CSV file 

SELECT * FROM sales;

-- Data Cleaning

-- Add the time_of_day column

SELECT 
    time,
    (CASE
        WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_day
FROM
    sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20) ;

UPDATE sales 
SET 
    time_of_day = (CASE
        WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END);

-- Add day_name Column

SELECT 
    date, DAYNAME(date)
FROM
    sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales 
SET 
    day_name = DAYNAME(date);

-- Add month_name column

SELECT 
    date, MONTHNAME(date)
FROM
    sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales 
SET 
    month_name = MONTHNAME(date);

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------

-- How many unique cities does the data have?
SELECT DISTINCT
    (city)
FROM
    sales;
 
-- In which city is each branch?
SELECT DISTINCT
    (city), branch
FROM
    sales;
 
-- --------------------------------------------------------------------
-- ---------------------------- Product ------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT DISTINCT
    product_line AS Uniques_Product_line
FROM
    sales;
 
-- What is the most common payment method?
SELECT 
    payment AS Payment_Method, COUNT(*) AS No_of_Payments
FROM
    sales
GROUP BY Payment_Method
ORDER BY No_of_Payments DESC
LIMIT 1;
 
-- What is the most selling product line?
SELECT 
    Product_Line, COUNT(*) AS Total_Count
FROM
    sales
GROUP BY Product_Line
ORDER BY Total_Count DESC
LIMIT 1;
 
-- What is the total revenue by month?
SELECT 
    Month_Name, SUM(total) AS Total_Revenue
FROM
    sales
GROUP BY Month_Name
ORDER BY Total_Revenue DESC;
 
-- What month had the largest COGS?
SELECT 
    Month_Name, SUM(cogs) AS No_of_Cogs
FROM
    sales
GROUP BY Month_Name
ORDER BY No_of_Cogs DESC
LIMIT 1;
 
-- What product line had the largest revenue?
SELECT 
    Product_Line, SUM(total) AS Largest_Revenue
FROM
    sales
GROUP BY Product_Line
ORDER BY Largest_Revenue DESC
LIMIT 1;
 
-- What is the city with the largest revenue?
SELECT 
    City, SUM(total) AS Largest_Revenue
FROM
    sales
GROUP BY City
ORDER BY Largest_Revenue DESC
LIMIT 1;
 
-- What product line had the largest VAT?
SELECT 
    Product_Line, ROUND(AVG(tax_pct), 2) AS Largest_VAT
FROM
    sales
GROUP BY Product_Line
ORDER BY Largest_VAT DESC
LIMIT 1;

/*Fetch each product line and add a column to those product line showing "Good", "Bad".
Good if its greater than average sales*/

SELECT 
    ROUND(AVG(total), 2)
FROM
    sales;

SELECT 
    Product_Line,
    CASE
        WHEN ROUND(AVG(total), 2) > 322.50 THEN 'Good'
        ELSE 'Bad'
    END AS Performance
FROM
    sales
GROUP BY Product_Line;

-- Which branch sold more products than average product sold?
SELECT 
    Branch, AVG(quantity) AS Average_Quantity
FROM
    sales
GROUP BY branch
HAVING Average_Quantity > (SELECT 
        AVG(quantity)
    FROM
        sales);
 
-- What is the most common product line by gender?
SELECT 
    Product_Line, Gender, COUNT(*) AS Count
FROM
    sales
GROUP BY Product_Line , Gender
ORDER BY Count DESC
LIMIT 1;
 
-- What is the average rating of each product line?
SELECT 
    Product_Line, ROUND(AVG(Rating), 2) AS Average_Rating
FROM
    sales
GROUP BY Product_Line;
 
-- --------------------------------------------------------------------
-- ---------------------------- Sales ------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday?
SELECT 
    Day_Name, Time_of_day, COUNT(*) AS No_of_Orders
FROM
    sales
WHERE
    Day_Name NOT IN ('Sunday' , 'Saturday')
GROUP BY Time_of_day , Day_Name
ORDER BY COUNT(*) DESC;
 
-- Which of the customer types brings the most revenue?
SELECT 
    Customer_Type, SUM(total) AS Revenue
FROM
    sales
GROUP BY Customer_Type
ORDER BY Revenue DESC;
 
-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT 
    City, ROUND(AVG(tax_pct), 2) AS Largest_VAT
FROM
    sales
GROUP BY City
ORDER BY Largest_VAT DESC
LIMIT 1;
 
-- Which customer type pays the most in VAT?
SELECT 
    Customer_Type, AVG(tax_pct) AS Avg_Vat
FROM
    sales
GROUP BY Customer_Type
ORDER BY Avg_Vat DESC;
 
-- --------------------------------------------------------------------
-- ---------------------------- Customers ------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT DISTINCT
    (Customer_Type)
FROM
    sales;
 
-- How many unique payment methods does the data have?
SELECT DISTINCT
    (Payment)
FROM
    sales;
 
-- What is the most common customer type?
SELECT 
    Customer_Type, COUNT(*) AS No_of_Customers
FROM
    sales
GROUP BY Customer_Type
ORDER BY No_of_Customers;
 
-- Which customer type buys the most?
SELECT 
    Customer_Type, COUNT(*) AS Total_Count
FROM
    sales
GROUP BY Customer_Type
ORDER BY Total_Count DESC;
 
-- What is the gender of most of the customers?
SELECT 
    Gender, COUNT(*) AS Total_Count
FROM
    sales
GROUP BY Gender
ORDER BY Total_Count DESC;
 
-- What is the gender distribution per branch?
SELECT 
    Gender, Branch, COUNT(*) AS Total_Count
FROM
    sales
GROUP BY Gender , Branch
ORDER BY Total_Count DESC;
 
-- Which time of the day do customers give most ratings?
SELECT 
    Time_of_Day,
    COUNT(*) AS Total_Count,
    AVG(Rating) AS AVG_Ravting
FROM
    sales
GROUP BY Time_of_Day
ORDER BY Total_Count DESC
LIMIT 1;
 
-- Which time of the day do customers give most ratings per branch?
SELECT 
    Time_of_Day, AVG(Rating) AS Avg_Rating
FROM
    sales
WHERE
    Branch = 'C'
GROUP BY Time_of_Day
ORDER BY Avg_Rating DESC;
 
-- Which day of the week has the best average ratings?
SELECT 
    Day_Name, ROUND(AVG(Rating), 2) AS Avg_Rating
FROM
    sales
GROUP BY Day_Name
ORDER BY Avg_Rating DESC
LIMIT 1;
 
-- Which day of the week has the best average ratings per branch?
SELECT 
    Day_Name, AVG(Rating) AS Avg_Rating
FROM
    sales
WHERE
    Branch = 'A'
GROUP BY Day_Name
ORDER BY Avg_Rating DESC;