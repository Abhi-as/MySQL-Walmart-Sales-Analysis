# MySQL-Walmart-Sales-Analysis

## Description
This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized.

## Steps Covered
### 1. Data Wrangling: 
This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
    a. Build a database
    b. Create table and insert the data.
    c. Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.

### 2. Feature Engineering: 
This will help in generate some new columns from existing ones.
    a. Add a new column named `time_of_day` to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
    b. Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
    c. Add a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

### 3. Exploratory Data Analysis (EDA): 
Exploratory data analysis is done to answer the listed questions and aims of this project.

### 4. Conclusion:

## Business Questions To Answer
### Generic
  1. How many unique cities does the data have?
  2. In which city is each branch?
### Product
  1. How many unique product lines does the data have?
  2. What is the most common payment method?
  3. What is the most selling product line?
  4. What is the total revenue by month?
  5. What month had the largest COGS?
  6. What product line had the largest revenue?
  7. What is the city with the largest revenue?
  8. What product line had the largest VAT?
  9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
  10. Which branch sold more products than average product sold?
  11. What is the most common product line by gender?
  12. What is the average rating of each product line?
### Sales
  1. Number of sales made in each time of the day per weekday
  2. Which of the customer types brings the most revenue?
  3. Which city has the largest tax percent/ VAT (Value Added Tax)?
  4. Which customer type pays the most in VAT?
### Customer
  1. How many unique customer types does the data have?
  2. How many unique payment methods does the data have?
  3. What is the most common customer type?
  4. Which customer type buys the most?
  5. What is the gender of most of the customers?
  6. What is the gender distribution per branch?
  7. Which time of the day do customers give most ratings?
  8. Which time of the day do customers give most ratings per branch?
  9. Which day fo the week has the best avg ratings?
  10. Which day of the week has the best average ratings per branch?

### MySQL: Queries, Usage 
  For a more thorough understanding, please check the [MySQLScript.sql](Walmart_MySQL_File.sql) file, which contains additional information and important details 
### PDF: Questions, Queries & Image Results
For a more thorough understanding, please check the [PDF Documentation](Walmart_PDF_File.pdf) file, which contains additional information and important details 

  
  
