# Dashboard
<img width="1522" height="890" alt="image" src="https://github.com/user-attachments/assets/dcd50043-acfd-49b4-a98f-65bfa61fd4df" />
<img width="1543" height="767" alt="image" src="https://github.com/user-attachments/assets/b0b8d1a2-6997-4252-bb05-ed01bd01e732" />
Button to toggle for quantity, sales and return of products
<img width="1546" height="851" alt="image" src="https://github.com/user-attachments/assets/7e58ce69-811f-485b-a63c-4ee1a71ded93" />

## Introduction/Project Overview  
This project analyzes transactional e-commerce data to identify key revenue drivers, customer purchasing behavior, and product performance. The goal is to generate actionable insights that support sales growth and customer retention strategies.

## Dashboard File  
My final dashboard file is in [dashboard.pbix](dashboard.pbix)

## Question to Analyze and why
The analysis focuses on three key areas:

Revenue Analysis  
- What is revenue trend overtime?  
- Which Country generate the most revenue?  

Product Analysis  
- Which products generate the highest sales volume?
- Which products contribute the most revenue?

Customer Analysis  
- What is the proportion of one-time vs repeat customers?
- How is revenue distributed across customer segments?

Note: Data with null value in customer_id/stock_name and stock_code_category that is non sales related e.g. Manual input, postage, discount and so on is excluded to improve overall data accuracy.

After analyzing the above questions, stakeholders can act accordingly. E.g. carry out investigation or studies on worst performance product or introduce customer reward scheme for customer retention purposes.

## Data Model  
A star schema was implemented to improve performance and scalability:  

Fact Table:  
- Sales Transactions  

Dimension Tables:  
- Customer  
- Product  

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
- Pie Chart
- Toggle button using view and bookmark panel
- Dax & Power Query

## Construction Project Dataset
The dataset use for this project is obtained from Kaggle [Ecommmerce_Dataset](https://www.kaggle.com/datasets/luisrenterialezano/retail-sales-dataset?utm_source=chatgpt.com)

## Insights
Revenue Analysis  
- Sales throughout 2011 peak at 1.12M on November and bottom out at 0.34M on December, indicating a upwards trend especially from August to November.  
- United Kingdom achieve the highest revenue of 82%, while all other 35 countires contribute 18% of the total revenue.  

Customer Analysis  
- 92% of our customers has repeated orders which suggest customer expectations & satisfactons were met or exceeded.  
- Top 20% of our customer contributed 50% of overall orders and 74% of the total revenue generated throughout the year, this indicate retention of the top 20% customer is crucial to accelerate sales growth for the upcoming year.  

Product Analysis  
- Jumbo Bag is the best selling product, peaking at 45k sold and 3rd in terms of revenue $80k, this suggest excellence in product management & marketing.  
- Regency Cakestand 3 Tier generate the most revenue of $133k throughout year 2011 but is not placed in top 5 best selling products, hence we should adopt strategic approach to amplify it's market presence.  
- Assorted TUTTI FRUIT ROUND BOX has the highest return rate of 24nos, which indicates a significant quality control issue, such as spoilage, damaged packaging, or customer dissatisfaction.  

## Conclusion
As a individual who has interest in data related skillsets/jobs, I embarked on this project to apply what I've learned throughout the months. E.g. validate original dataset, create new column metrics and ensure data standardizaiton/consistency. I hope this project serves as a strong portfolio for my data adventure.  
