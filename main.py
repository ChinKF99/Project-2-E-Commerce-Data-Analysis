import pandas as pd

df = pd.read_csv('data.csv', encoding='latin1')

# Clean Description
df["Description"] = df["Description"].str.replace(',', '', regex=False).str.strip()

# Fix CustomerID properly
df['CustomerID'] = (
    df['CustomerID']
    .astype('Int64')
    .astype(str)
    .str.replace('<NA>', '')
)

# Save cleaned file
df.to_csv('cleaned_data.csv', index=False)