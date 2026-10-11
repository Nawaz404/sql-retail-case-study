/* =====================================================
   03_advanced_analytics.sql
   Purpose : Advanced T-SQL — conditional logic, string
             functions, window functions, ROLLUP, set
             operators, stored procedures, UDFs and
             transaction control.
   Run     : 3 of 3
   ===================================================== */

USE case_study;
GO

/* ---------- 1. Conditional logic (CASE) ---------- */
-- If total expenses < 60 then profit, else loss
SELECT [Date], Productid, [Total Expenses],
       CASE WHEN [Total Expenses] < 60 THEN 'Profit'
            ELSE 'Loss'
       END AS Result
FROM Fact;

/* ---------- 2. String functions ---------- */
-- Display the ASCII value of the fifth character of the product name
SELECT PRODUCT,
       SUBSTRING(PRODUCT, 5, 1) AS Fifth_Character,
       ASCII(SUBSTRING(PRODUCT, 5, 1)) AS ASCII_Value
FROM PRODUCT;

/* ---------- 3. Window functions ---------- */
-- Rank without any gap, sales wise
SELECT [Date], Productid, Sales,
       DENSE_RANK() OVER (ORDER BY Sales ASC) AS Sales_Rank
FROM Fact;

/* ---------- 4. Hierarchical grouping (ROLLUP) ---------- */
-- Total weekly sales with date and product ID details, in hierarchical order
SELECT DATEPART(WEEK, [Date]) AS Week_No,
       Productid,
       SUM(Sales) AS Total_Sales
FROM Fact
GROUP BY ROLLUP (DATEPART(WEEK, [Date]), Productid);

/* ---------- 5. Set operators ---------- */
-- Intersection: area codes present in BOTH tables
SELECT [Area Code] FROM Fact
INTERSECT
SELECT [Area Code] FROM [LOCATION]
ORDER BY [Area Code];

-- Union: all area codes from both tables, duplicates removed
SELECT [Area Code] FROM Fact
UNION
SELECT [Area Code] FROM [LOCATION]
ORDER BY [Area Code];

/* ---------- 6. Stored procedure ---------- */
GO
CREATE OR ALTER PROCEDURE GetProductsByType
    @ProductType VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Productid, PRODUCT, [Product Type]
    FROM PRODUCT
    WHERE [Product Type] = @ProductType;
END;
GO

EXEC GetProductsByType 'Coffee';

/* ---------- 7. User-defined function ---------- */
GO
CREATE OR ALTER FUNCTION fn_GetProductsByPreference (@ProductType VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT Productid, [Product Type], PRODUCT
    FROM PRODUCT
    WHERE [Product Type] = @ProductType
);
GO

SELECT * FROM dbo.fn_GetProductsByPreference('Tea');

/* ---------- 8. Transaction control & safe DML ---------- */
-- Change product type from coffee to tea where product ID is 1 — then undo it
BEGIN TRANSACTION;
    UPDATE PRODUCT
    SET [Product Type] = 'Tea'
    WHERE Productid = 1;
ROLLBACK TRANSACTION;   -- undo the change (use COMMIT to keep it)

SELECT * FROM PRODUCT WHERE Productid = 1;

-- Delete the records in the Product table for regular type
-- ⚠ DESTRUCTIVE: kept inside a transaction that rolls back by default,
--   so re-running this script never destroys your data.
BEGIN TRANSACTION;
    DELETE FROM PRODUCT WHERE [Type] LIKE 'reg%';
ROLLBACK TRANSACTION;   -- change to COMMIT only if you truly want the delete
