# Dashboard
<img width="1522" height="890" alt="image" src="https://github.com/user-attachments/assets/dcd50043-acfd-49b4-a98f-65bfa61fd4df" />
<img width="1543" height="767" alt="image" src="https://github.com/user-attachments/assets/b0b8d1a2-6997-4252-bb05-ed01bd01e732" />
Button to toggle for quantity, sales and return of products
<img width="1546" height="851" alt="image" src="https://github.com/user-attachments/assets/7e58ce69-811f-485b-a63c-4ee1a71ded93" />

## Introduction  
This e-commerce dashboard analyzes top-performing products, sales trends, and customer contributions to drive actionable insights.

## Dashboard File  
My final dashboard file is in [dashboard.pbix](dashboard.pbix)

## Question to Analyze and why
To deepen my understanding of our products, customer base, and sales trend,  I ask the following:


### Delay Cost Analysis
1. Does delayed project cost more?

### Contractor Analysis
1. Which Contractor has the highest Cost Overrun
2. Which Contractor has most delay
3. Which Contractor perform best overall

### Project Category Analysis
1. Which category has the most delay
2. Which category has the worst cost control (Average/Total cost overrun)




SQL Skill:
-“Use ROW NUMBER function to ensure data standardizaiton, consistency, cleansing and flag out the latest row record to insert into respective dim \& fact table.”



\-“Use DENSE\_RANK function to flag out item with the same stock\_code but different stock\_unit\_price and categorize them into variants.”



\-“Create Data Validation Scipts for checking data accuracy, consistency, and integrity.”



\-“Use multiple CTE to cleanse \& transform data before loading it into silver layer table to reduce SQL coding complexity by improving readability and eliminating redundancy ”



\-“Carry out data enrichment after loading into respective silver layer table. E.g. Sales amount derived from stock quantity x stock price.”



Fix using Python Pandas:

\-“The dataset contained commas within text fields which conflicted with CSV delimiters. Python (pandas) was used to correctly parse and standardize the dataset before loading into SQL Server.”



\-“CustomerID was automatically interpreted as float due to missing values, resulting in .0 suffixes. This was resolved by converting the column to nullable integer type before casting to string.”

Business Questions:

Revenue Analysis
-Monthly Revenue trend overtime (Sales throughout 2011 peak at 1.12M on November and bottom out at 0.34M on December, indicating a upwards trend from Jan to November)
-Which Country generate the most revenue (United Kingdom achieve the highest revenue of 82%, while all other 36 countires contribute 18% of the total revenue.)

Customer Analysis
-How many customer are one time buyer or repeated buyer (92% of our customers has repeated orders whic suggest customer expectations & satisfactons were met or exceeded.)
-Customer segmentation (Top 20% of our customer contributed 50% of overall orders and 74% of the total revenue generated throughout the year, this indicate retention of the top 20% customer is crucial to accelerate sales growth for the upcoming year)

Product Analysis
-Products that sells that most (Quantity) (Jumbo Bag is the best selling product, peaking at 45k sold and 3rd in terms of revenue $80k, this suggest excellence in product managemnent & marketing )
-Products that generate the most revenue (Regency Cakestand 3 Tier generate the most revenue of $133k throughout year 2011 but is not placed in top 5 best selling products, which imply competitive pricing)
-Products that get return the most (Assorted TUTTI FRUIT ROUND BOX has the highest return rate of 24nos, which indicates a significant quality control issue, such as spoilage, damaged packaging, or consistent customer dissatisfaction)

Example of Business Insights
“Over 65% of total revenue is generated from the UK market, indicating high dependency on a single region and potential risk if demand declines.”
