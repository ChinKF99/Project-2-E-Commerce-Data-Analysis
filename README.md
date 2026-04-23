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
-Customer segmentation (High, Medium, Low)

Product Analysis
-Products that sells that most (Quantity) (Jumbo Bag is the best selling product, peaking at 45k sold and 3rd in terms of revenue $80k, this suggest excellence in product managemnent & marketing )
-Products that generate the most revenue (Regency Cakestand 3 Tier generate the most revenue of $133k throughout year 2011 but is not placed in top 5 best selling products, which imply competitive pricing)
-Products that get return the most (Assorted TUTTI FRUIT ROUND BOX has the highest return rate of 24nos, which indicates a significant quality control issue, such as spoilage, damaged packaging, or consistent customer dissatisfaction)

Example of Business Insights
“Over 65% of total revenue is generated from the UK market, indicating high dependency on a single region and potential risk if demand declines.”