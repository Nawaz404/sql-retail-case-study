# 📊 Sales & Inventory Case Study (SQL Server)

## 📖 Project Overview
This project involves analyzing a retail dataset containing sales, profit, inventory, and budget metrics across various US markets. The goal was to write complex T-SQL queries to answer specific business questions, optimize data retrieval, and build reusable database objects.

## 🛠️ Tech Stack
- **Database:** SQL Server (T-SQL)
- **Tools:** SSMS / Azure Data Studio
- **Languages:** SQL, Markdown

## 🧠 Key SQL Concepts Demonstrated
- **Advanced Aggregations:** Using `GROUP BY ROLLUP` for hierarchical subtotals.
- **Window Functions:** Using `DENSE_RANK()` to rank sales without gaps.
- **Database Objects:** Creating **Stored Procedures** and **User-Defined Functions (UDFs)** for reusable code.
- **Transaction Control:** Using `BEGIN TRANSACTION` and `ROLLBACK` for safe data manipulation.
- **String Manipulation:** Extracting ASCII values and substrings.
- **Relational Joins:** Combining Fact, Product, and Location tables for market-level insights.

## ❓ Business Questions Answered (Highlights)
1. What is the state-wise profit and sales breakdown?
2. How do actual sales compare to budgeted margins per product?
3. What are the weekly hierarchical sales totals using `ROLLUP`?
4. Which products are generating a profit vs. a loss based on total expenses?

## 🚀 How to Run This Project
1. Clone this repository.
2. Open SQL Server Management Studio (SSMS).
3. Run `scripts/01_database_setup.sql` to create the schema and ingest the CSV data.
4. Run the subsequent scripts to view the analysis and create the stored procedures.
