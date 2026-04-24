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

Revenue Analysis
-What is revenue trend overtime?
-Which Country generate the most revenue?

Product Analysis
-Which product have the most sales?
-Which product generate the most revenue?

Customer Analysis
-One time buyer or repeated buyer?
-Which customer segmentation to focus on to maintain & improve sales?

Note: Data with null value in customer_id/stock_name and stock_code_category that is non sales related e.g. Manual input, postage, discount and so on.

After analyzing the above questions, stakeholders can act accordingly. E.g. carry out investigation or studies on worst performance product or introduce customer reward scheme for customer retention purposes.

## Python
- Pandas, to parse and standardized the dataset before loading into SQL server

## SQL Skill Used
- Adopt Medalion Architecture (Bronze, Silver, Gold) for Data Architecture
- Data Cleansing e.g. CTE, ROW NUMBER, DENSE RANK, to flag out latest reocrd & repeated value.
- Data Standardization
- Data Conversion 
- Data Enrichment e.g. Creating new column after spilting into DIM & FACT table.
- Data Validation e.g. Scipts to check for duplication, accuracy and integrity.

## Power BI Used
- Bar Chart
- line Chart
- Card
- Scatter Chart
- Toggle button using view and bookmark panel





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
