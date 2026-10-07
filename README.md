# NovaCart E-Commerce Relational Database Project

A comprehensive database design and implementation project for **NovaCart**, a growing online retail platform selling electronics, fashion items, home appliances, books, and accessories. 

This project covers the full database lifecycle: requirement analysis, conceptual design (ERD), logical design (Relational Mapping), database implementation in SQL Server (DDL), mock data population (DML), advanced analytical queries, and design reasoning.

---

## 📁 Repository Structure

The project directory is structured into independent, production-ready files:

*   **`1_ERD.drawio.png`**: The Conceptual Entity-Relationship Diagram designed using Chen's Notation.
*   **`1_Mapping.png`**: The Logical Relational Model showing table structures, Primary Keys, and Foreign Keys.
*   **`Create Tables.sql`**: Data Definition Language (DDL) script containing clean tables schema and constraints.
*   **`NovaCartDB_Insert.sql`**: Data Manipulation Language (DML) script populating at least 10 realistic transactional records into each table.
*   **`NovaCartDB_Opjects.sql`**: Database objects definitions including custom Views for executive reporting.
*   **`Select_Statements.sql`**: SQL Missions queries featuring advanced aggregation, filtering, and table joins.
*   **`Question&Answers.sql`**: Architectural design reasoning questions documented directly as T-SQL inline comments.

---

## 🛠️ Database Schema & Constraints

The system architecture enforces relational and business integrity through **6 foundational entities**:
1.  **Customers**: Manages unique accounts with email validation checks (`LIKE '%@%.%'`) and restricted carrier patterns.
2.  **Products**: Contains catalog records with strictly enforced non-negative stock counts and pricing (`> 0`).
3.  **Orders**: Logs user purchase orders restricted to business-defined statuses: `Pending`, `Shipped`, `Delivered`, `Cancelled`.
4.  **Orders_Details**: An intermediate associative table representing the *Many-to-Many (M:N)* relationship between Orders and Products. Implements a **Composite Primary Key** `(OrderID, ProductID, CustomerID)` to preserve historical pricing integrity (`UnitPrice`).
5.  **Payments**: Models a strict *One-to-One (1:1)* billing context via `UNIQUE (OrderID)`, accepting only `Credit Card`, `PayPal`, or `Cash on Delivery`.
6.  **Reviews**: Implements advanced relational routing directly to `Orders_Details` through a **Composite Foreign Key**, ensuring that **customers can only review products they have actually purchased**.

---

## 📈 Advanced Analytical Features Implemented

The analytical tier (`Select_Statements.sql`) utilizes advanced T-SQL capabilities to generate business-intelligence insights:
*   **Data Aggregation & Grouping**: Calculating revenue per payment method and inventory metrics.
*   **Zero-State Analysis (`LEFT JOIN`)**: Identifying ghost products (never ordered) and dormant users (never checked out).
*   **Subqueries**: Correlating active spending records against dynamic platform averages.
*   **Common Table Expressions (CTEs)**: Partitioning total gross business revenue cleanly by fiscal months.
*   **Window Functions**: Implementing `RANK()` and `DENSE_RANK()` for top-spending consumers, along with financial tracking using `LAG()` and running totals.
*   **Database Views**: Preserving optimized queries (`vw_revenue_by_month`, `vw_best_selling_products`, `vw_customer_summary`) for instant executive dashboard lookups.

---

## 🚀 How to Run the Project

1. Open **Microsoft SQL Server Management Studio (SSMS)**.
2. Create a clean database environment:
   ```sql
   CREATE DATABASE NovaCartDB;
   USE NovaCartDB;
   ```
3. Execute the scripts in the following exact sequence to respect relational hierarchy constraints:
   * Run `Create Tables.sql` to deploy schemas.
   * Run `NovaCartDB_Insert.sql` to safely seed data.
   * Run `NovaCartDB_Opjects.sql` to initialize reporting views.
   * Run `Select_Statements.sql` to observe business intelligence operations.
