# One Dataset, Three Tools: Retail Sales Analysis

## Project Overview

This project explores how the same retail order dataset can be cleaned, standardized, and analyzed using three different tools: Excel, SQL, and Python.

The goal is to transform inconsistent raw order data into a structured dataset suitable for revenue analysis and product performance comparisons. The project also demonstrates how results can be cross-checked across tools to ensure consistency.

## Tools Used

- **Excel:** Data cleaning, standardization, and spreadsheet-based analysis.
- **SQL (MySQL):** Data transformation, revenue calculations, aggregation, and product ranking.
- **Python:** Data cleaning, analysis, and result validation.

## Dataset

The dataset contains retail order information, including:

- Order ID and order date
- Customer name and email
- Product name and category
- Quantity and unit price
- Discount percentage
- Country

The raw data contains inconsistencies such as different date formats, variations in category capitalization, country abbreviations, currency symbols, missing discount values, and invalid quantities.

## Project Workflow

### 1. Data Cleaning and Standardization

- Standardized country names and product categories.
- Cleaned price and discount fields.
- Handled missing discount values.
- Identified invalid or non-positive quantities for revenue calculations.
- Prepared a consistent structure for further analysis.

### 2. Revenue Analysis

Calculated order revenue using the following formula:

`Revenue = Quantity × Unit Price × (1 − Discount / 100)`

Revenue was calculated only for records with positive quantities.

### 3. Product Performance Ranking

Used SQL aggregation and window functions to:

- Calculate total revenue by product and category.
- Rank products within each category.
- Identify the highest-revenue product or products in each category.

### 4. Cross-Tool Validation

Compared the outputs produced in Excel, SQL, and Python to check whether the cleaning rules and analytical results were consistent across all three tools.

## SQL Concepts Demonstrated

- `CASE WHEN` for standardization
- `TRIM()` and `UPPER()` for text cleaning
- `CAST()` and `NULLIF()` for data type conversion and handling empty values
- `COALESCE()` for missing discount values
- `UPDATE` for calculating revenue
- Common Table Expressions (CTEs)
- Aggregate functions such as `SUM()`
- `RANK()` window function
- `GROUP BY`, `PARTITION BY`, and `ORDER BY`

## Key Takeaways

This project demonstrates a practical data analysis workflow, from preparing inconsistent raw data to calculating revenue and identifying top-performing products. It also highlights the importance of applying consistent business rules and validating results when working across different analytical tools.

## Repository Structure

```text
one-dataset-three-tools/
├── README.md
├── retail_orders_raw.xlsx
├── retail_orders_cleaned.xlsx
├── SQL sales cleaning.sql
└── python_analysis.ipynb
```

*The filenames above illustrate the intended structure. Adjust them to match the files actually included in the repository.*

## Conclusion

By applying the same cleaning and analytical logic in Excel, SQL, and Python, this project demonstrates how different tools can support a consistent and reproducible retail data analysis workflow.
