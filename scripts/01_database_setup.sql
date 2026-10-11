/* =====================================================
   01_database_setup.sql
   Purpose : Create the case_study database, define the
             schema, and load the raw CSV files.
   Run     : 1 of 3
   Note    : CSV paths assume the files sit in the SQL
             Server data folder (/var/opt/mssql/data/).
   ===================================================== */

CREATE DATABASE case_study;
GO

USE case_study;
GO

/* ---------- Schema ---------- */
CREATE TABLE dbo.LOCATION (
    [Area Code]   INT,
    [State]       VARCHAR(100),
    [Market]      VARCHAR(100),
    [Market Size] VARCHAR(100)
);

CREATE TABLE dbo.PRODUCT (
    Productid      INT,
    [Product Type] VARCHAR(50),
    PRODUCT        VARCHAR(100),
    [Type]         VARCHAR(50)
);

CREATE TABLE dbo.Fact (
    [Date]           DATE,
    Productid        INT,
    Profit           INT,
    Sales            INT,
    Margin           INT,
    COGS             INT,
    [Total Expenses] INT,
    Marketing        INT,
    Inventory        INT,
    [Budget Profit]  INT,
    [Budget COGS]    INT,
    [Budget Margin]  INT,
    [Budget Sales]   INT,
    [Area Code]      INT
);
GO

/* ---------- Data ingestion ---------- */
BULK INSERT dbo.LOCATION
FROM '/var/opt/mssql/data/Location.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2);

BULK INSERT dbo.PRODUCT
FROM '/var/opt/mssql/data/product.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2);

BULK INSERT dbo.Fact
FROM '/var/opt/mssql/data/fact.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '''', TABLOCK);
GO

/* ---------- Verify the load ---------- */
SELECT TOP 10 * FROM dbo.LOCATION;
SELECT TOP 10 * FROM dbo.PRODUCT;
SELECT TOP 10 * FROM dbo.Fact;
