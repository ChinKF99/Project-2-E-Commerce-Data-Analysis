SQL Skill:
-“Use ROW NUMBER function to ensure data standardizaiton, consistency, cleansing and flag out the latest row record to insert into respective dim \& fact table.”



\-“Use DENSE\_RANK function to flag out item with the same stock\_code but different stock\_unit\_price and categorize them into variants.”



\-“Create Data Validation Scipts for checking data accuracy, consistency, and integrity.”



\-“Use multiple CTE to cleanse \& transform data before loading it into silver layer table to reduce SQL coding complexity by improving readability and eliminating redundancy ”



\-“Carry out data enrichment after loading into respective silver layer table. E.g. Sales amount derived from stock quantity x stock price.”



Fix using Python Pandas:

\-“The dataset contained commas within text fields which conflicted with CSV delimiters. Python (pandas) was used to correctly parse and standardize the dataset before loading into SQL Server.”



\-“CustomerID was automatically interpreted as float due to missing values, resulting in .0 suffixes. This was resolved by converting the column to nullable integer type before casting to string.”

