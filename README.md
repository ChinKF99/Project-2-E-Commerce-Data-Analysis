SQL Skill:
\-“Use ROW NUMBER function to ensure data standardizaiton, consistency, cleansing and flag out the latest row record to insert into respective dim & fact table.”

\-“Use Dense_RANK function to flag out item with the same stock_code but different stock_unit_price and categorize them into variants.”

\-“Create Data Validation Scipts for checking data accuracy, consistency, and integrity.”

Fix using Python Pandas:

\-“The dataset contained commas within text fields which conflicted with CSV delimiters. Python (pandas) was used to correctly parse and standardize the dataset before loading into SQL Server.”

\-“CustomerID was automatically interpreted as float due to missing values, resulting in .0 suffixes. This was resolved by converting the column to nullable integer type before casting to string.”


PROBLEMS ENCOUNTERED:
-Stock with same code, price but different naming. To ensure consistent naming before adding variant id to related column
