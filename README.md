# SQL-Data-Warehouse-Project

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective

Develop a modern SQL Server–based data warehouse to consolidate sales data, enabling analytical reporting and better decision-making.

## 🏗️ Data Architecture

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
![Data Architecture](Docs/data_architecture.png)

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

---

#### Specifications

- **Data Sources:** Import CSV data from two source systems (ERP and CRM).
- **Data Quality:** Cleanse the data and resolve quality issues before analysis.
- **Integration:** Combine both sources into a single, user-friendly data model optimized for analytical queries.
- **Scope:** Focus on the latest dataset only; historization is not required.
- **Documentation:** Provide clear documentation of the data model for business stakeholders and the analytics team.

### BI: Analytics & Reporting (Data Analysis)

#### Objective

Develop SQL-based analytics to deliver detailed insights into:

1. **Customer Behavior:** Analyze customer segmentation, retention, and buying patterns across different demographics.
2. **Product Performance:** Identify top-selling products, key revenue drivers by category, and inventory turnover rates.
3. **Sales Performance:** Measure monthly/quarterly sales growth, revenue trends, and regional performance KPIs.
4. **Data Visualization:** Build interactive dashboards (e.g., using Power BI or Tableau) to clearly present key business metrics to executive decision-makers.
