# 📊 Dashboard
<img width="1522" height="890" alt="image" src="https://github.com/user-attachments/assets/dcd50043-acfd-49b4-a98f-65bfa61fd4df" />
<img width="1543" height="767" alt="image" src="https://github.com/user-attachments/assets/b0b8d1a2-6997-4252-bb05-ed01bd01e732" />
Button to toggle for quantity, sales and return of products
<img width="1546" height="851" alt="image" src="https://github.com/user-attachments/assets/7e58ce69-811f-485b-a63c-4ee1a71ded93" />

## 📌 Introduction/Project Overview  
This project analyzes transactional e-commerce data to identify key revenue drivers, customer purchasing behavior, and product performance. The goal is to generate actionable insights that support sales growth and customer retention strategies.

## Dashboard File  
My final dashboard file is in [dashboard.pbix](dashboard.pbix)

## 🎯 Question to Analyze and why
The analysis focuses on three key areas:  

Revenue Analysis:  
- What is revenue trend overtime?  
- Which Country generate the most revenue?  

Product Analysis:  
- Which products generate the highest sales volume?
- Which products contribute the most revenue?

Customer Analysis:  
- What is the proportion of one-time vs repeat customers?
- How is revenue distributed across customer segments?

Note: Data with null value in customer_id/stock_name and stock_code_category that is non sales related e.g. Manual input, postage, discount and so on is excluded to improve overall data accuracy.

## 🏗️ Data Model  
A star schema was implemented to improve performance and scalability:  

Fact Table:  
- Sales

Dimension Tables:  
- Customer  
- Product  

### ⚙️ Tools & Skills Used

### Python
- Pandas for data preprocessing and standardization before loading into SQL server

### SQL
- Adopt Medalion Architecture (Bronze > Silver > Gold) for Data Architecture
- Data Cleansing & Transformation e.g. CTE, ROW NUMBER, DENSE RANK, to flag out latest reocrd & repeated value.
- Data Standardization
- Data Conversion 
- Data Enrichment e.g. Creating new column after spilting into DIM & FACT table.
- Data validation for accuracy and consistency e.g. Scipts to check for duplication, accuracy and integrity.

### Power BI
- Interactive dashboard development
- Bookmark toggle (Sales / Quantity / Returns)
- DAX measures for KPI calculation
- Visualizations: Bar, Line, Pie, Cards

## 🗂️ Ecommerce Project Dataset
The dataset use for this project is obtained from Kaggle [Ecommmerce_Dataset](https://www.kaggle.com/datasets/luisrenterialezano/retail-sales-dataset?utm_source=chatgpt.com)

## 🔍 Insights
Revenue Analysis  
- Revenue shows a strong upward trend, peaking at 1.12M in November.  
- United Kingdom contributes 82% of total revenue, indicating heavy geographic concentration.  

Customer Analysis  
- 92% of customers are repeat buyers, suggesting strong customer satisfaction and retention.  
- The top 20% of customers generate 74% of total revenue, highlighting a strong Pareto distribution.     

Product Analysis  
- Jumbo Bag is the highest-selling product by volume, peaking at 45k sold and 3rd in terms of revenue $80k.  
- Regency Cakestand 3 Tier generates the highest revenue despite lower sales volume → strong pricing power.  
- Assorted TUTTI FRUIT ROUND BOX has the highest return rate, indicating potential quality or satisfaction issues.  

## 💡 Business Recommendations:  
- Focus retention strategies (e.g., loyalty programs) on high-value customers (top 20%).  
- Expand and promote high-revenue products with strong margins.
- Investigate and resolve quality issues for high-return products.
- Diversify market reach beyond the UK to reduce geographic dependency.  

## ✅ Conclusion
This project demonstrates an end-to-end data analysis workflow, from data cleaning and modeling to insight generation and visualization. It highlights the importance of customer segmentation, product strategy, and geographic performance in driving business growth.
