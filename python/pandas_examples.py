"""
Pandas Code Examples - Data Manipulation and Analysis
"""

import pandas as pd
import numpy as np

# 1. Creating DataFrames
print("=== Creating DataFrames ===")

# From dictionary
data = {
    'Name': ['Alice', 'Bob', 'Charlie', 'Diana'],
    'Age': [25, 30, 35, 28],
    'City': ['New York', 'London', 'Tokyo', 'Paris'],
    'Salary': [50000, 60000, 70000, 55000]
}
df = pd.DataFrame(data)
print("DataFrame from dictionary:")
print(df)

# From lists
names = ['Alice', 'Bob', 'Charlie']
ages = [25, 30, 35]
df2 = pd.DataFrame({'Name': names, 'Age': ages})
print("\nDataFrame from lists:")
print(df2)

# With custom index
df_indexed = pd.DataFrame(data, index=['A', 'B', 'C', 'D'])
print("\nDataFrame with custom index:")
print(df_indexed)

# 2. Reading Data
print("\n=== Reading Data ===")
# Note: These would read from actual files
# df_csv = pd.read_csv('data.csv')
# df_excel = pd.read_excel('data.xlsx')
# df_json = pd.read_json('data.json')

# Creating sample data for demonstration
sample_data = pd.DataFrame({
    'A': [1, 2, 3, 4, 5],
    'B': [10, 20, 30, 40, 50],
    'C': ['x', 'y', 'z', 'x', 'y']
})
print("Sample data for operations:")
print(sample_data)

# 3. Basic DataFrame Operations
print("\n=== Basic DataFrame Operations ===")
print(f"Shape: {df.shape}")
print(f"Columns: {df.columns.tolist()}")
print(f"Index: {df.index.tolist()}")
print(f"Data types:\n{df.dtypes}")
print(f"Info:\n{df.info()}")
print(f"Describe:\n{df.describe()}")

# 4. Data Selection and Indexing
print("\n=== Data Selection and Indexing ===")

# Selecting columns
print("Single column:")
print(df['Name'])

print("\nMultiple columns:")
print(df[['Name', 'Age']])

# Selecting rows
print("\nFirst 3 rows:")
print(df.head(3))

print("\nLast 2 rows:")
print(df.tail(2))

# Using iloc for position-based indexing
print("\nUsing iloc [0:2, 1:3]:")
print(df.iloc[0:2, 1:3])

# Using loc for label-based indexing
print("\nUsing loc for specific rows:")
print(df.loc[df['Age'] > 27])

# 5. Data Filtering
print("\n=== Data Filtering ===")

# Boolean indexing
high_earners = df[df['Salary'] > 55000]
print("High earners (>55000):")
print(high_earners)

# Multiple conditions
young_high_earners = df[(df['Age'] < 30) & (df['Salary'] > 52000)]
print("\nYoung high earners:")
print(young_high_earners)

# Using isin()
specific_cities = df[df['City'].isin(['New York', 'London'])]
print("\nSpecific cities:")
print(specific_cities)

# 6. Data Manipulation
print("\n=== Data Manipulation ===")

# Adding new columns
df['Salary_Range'] = pd.cut(df['Salary'], bins=3, labels=['Low', 'Medium', 'High'])
print("Added salary range column:")
print(df)

# Applying functions
df['Age_Group'] = df['Age'].apply(lambda x: 'Young' if x < 30 else 'Adult')
print("\nAdded age group column:")
print(df)

# Using map for replacements
city_codes = {'New York': 'NYC', 'London': 'LDN', 'Tokyo': 'TYO', 'Paris': 'PRS'}
df['City_Code'] = df['City'].map(city_codes)
print("\nAdded city codes:")
print(df)

# 7. Grouping and Aggregation
print("\n=== Grouping and Aggregation ===")

# Group by single column
grouped = df.groupby('City_Code')['Salary'].mean()
print("Average salary by city:")
print(grouped)

# Group by multiple columns
df['Department'] = ['IT', 'HR', 'IT', 'Finance']
grouped_multi = df.groupby(['Department', 'Age_Group'])['Salary'].agg(['mean', 'count'])
print("\nSalary stats by department and age group:")
print(grouped_multi)

# Multiple aggregations
agg_stats = df.groupby('City_Code')['Salary'].agg(['mean', 'median', 'std', 'count'])
print("\nDetailed salary statistics by city:")
print(agg_stats)

# 8. Handling Missing Data
print("\n=== Handling Missing Data ===")

# Create DataFrame with missing values
df_missing = pd.DataFrame({
    'A': [1, 2, np.nan, 4, 5],
    'B': [10, np.nan, 30, 40, 50],
    'C': ['x', 'y', np.nan, 'x', 'y']
})
print("DataFrame with missing values:")
print(df_missing)

# Check for missing values
print("\nMissing values count:")
print(df_missing.isnull().sum())

# Fill missing values
df_filled = df_missing.fillna({'A': df_missing['A'].mean(), 'B': 0, 'C': 'unknown'})
print("\nAfter filling missing values:")
print(df_filled)

# Drop rows with missing values
df_dropped = df_missing.dropna()
print("\nAfter dropping rows with missing values:")
print(df_dropped)

# 9. Data Transformation
print("\n=== Data Transformation ===")

# Pivot tables
pivot_data = pd.DataFrame({
    'Date': ['2023-01-01', '2023-01-01', '2023-01-02', '2023-01-02'],
    'Product': ['A', 'B', 'A', 'B'],
    'Sales': [100, 150, 120, 180]
})
pivot_table = pivot_data.pivot_table(values='Sales', index='Date', columns='Product', aggfunc='sum')
print("Pivot table:")
print(pivot_table)

# Melting (unpivoting)
melted = pivot_table.reset_index().melt(id_vars='Date', var_name='Product', value_name='Sales')
print("\nMelted data:")
print(melted)

# 10. String Operations
print("\n=== String Operations ===")

# String methods
df_string = pd.DataFrame({
    'Name': ['alice smith', 'BOB JOHNSON', 'charlie brown', 'DIANA DAVIS'],
    'Email': ['alice@email.com', 'bob@email.com', 'charlie@email.com', 'diana@email.com']
})

df_string['Name_Title'] = df_string['Name'].str.title()
df_string['Name_Upper'] = df_string['Name'].str.upper()
df_string['Email_Domain'] = df_string['Email'].str.split('@').str[1]

print("String operations:")
print(df_string)

# 11. Data Sorting
print("\n=== Data Sorting ===")

# Sort by single column
df_sorted = df.sort_values('Salary', ascending=False)
print("Sorted by salary (descending):")
print(df_sorted)

# Sort by multiple columns
df_sorted_multi = df.sort_values(['Age', 'Salary'], ascending=[True, False])
print("\nSorted by age (asc) then salary (desc):")
print(df_sorted_multi)

# 12. Data Merging and Joining
print("\n=== Data Merging and Joining ===")

# Create two DataFrames to merge
df1 = pd.DataFrame({
    'ID': [1, 2, 3, 4],
    'Name': ['Alice', 'Bob', 'Charlie', 'Diana'],
    'Department': ['IT', 'HR', 'IT', 'Finance']
})

df2 = pd.DataFrame({
    'ID': [1, 2, 3, 5],
    'Salary': [50000, 60000, 70000, 80000],
    'Experience': [2, 5, 8, 10]
})

# Inner join
inner_join = pd.merge(df1, df2, on='ID', how='inner')
print("Inner join:")
print(inner_join)

# Left join
left_join = pd.merge(df1, df2, on='ID', how='left')
print("\nLeft join:")
print(left_join)

# Outer join
outer_join = pd.merge(df1, df2, on='ID', how='outer')
print("\nOuter join:")
print(outer_join)

# 13. Time Series Operations
print("\n=== Time Series Operations ===")

# Create time series data
dates = pd.date_range('2023-01-01', periods=10, freq='D')
ts_data = pd.DataFrame({
    'Date': dates,
    'Value': np.random.randn(10).cumsum(),
    'Volume': np.random.randint(100, 1000, 10)
})

print("Time series data:")
print(ts_data)

# Set date as index
ts_data.set_index('Date', inplace=True)
print("\nWith date as index:")
print(ts_data.head())

# Resampling (daily to weekly)
weekly_data = ts_data.resample('W').agg({'Value': 'mean', 'Volume': 'sum'})
print("\nWeekly resampled data:")
print(weekly_data)

# 14. Data Export
print("\n=== Data Export ===")
# Note: These would write to actual files
# df.to_csv('output.csv', index=False)
# df.to_excel('output.xlsx', index=False)
# df.to_json('output.json')

print("DataFrame ready for export:")
print(df.head())

# 15. Advanced Operations
print("\n=== Advanced Operations ===")

# Apply custom functions
def categorize_salary(salary):
    if salary < 55000:
        return 'Entry Level'
    elif salary < 65000:
        return 'Mid Level'
    else:
        return 'Senior Level'

df['Salary_Category'] = df['Salary'].apply(categorize_salary)
print("Salary categorization:")
print(df[['Name', 'Salary', 'Salary_Category']])

# Using query method
query_result = df.query('Age > 25 and Salary > 55000')
print("\nQuery result:")
print(query_result)

# Using eval for mathematical expressions
df['Bonus'] = df.eval('Salary * 0.1')
print("\nAdded bonus column (10% of salary):")
print(df[['Name', 'Salary', 'Bonus']])
