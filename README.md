# Sakila SQL Business Analysis

## Project Overview

This project analyzes a Movie Rental database (Sakila Dataset) to understand business performance, customer behavior, film popularity, and store operations using SQL analytics techniques.
The goal is to transform raw transactional data into meaningful business insights that support decision-making.

---

## Objectives

* Analyze overall revenue performance.
* Identify top customers based on spending.
* Study customer rental behavior.
* Evaluate film and category performance.
* Compare store operations and staff efficiency.
* Apply advanced SQL analytics using window functions.

---

## Business Questions

The analysis aims to answer the following:

1. What is the total revenue generated?
2. Which months generate the highest revenue?
3. Which store performs better?
4. Who are the top customers by spending?
5. Which movies and categories are most popular?
6. Which films generate the highest revenue?
7. What are customer rental patterns?
8. Which staff members handle the most transactions?
9. What are the busiest rental days?
10. Which movie ranks highest within each category?

---

## Dataset

* **Database:** Sakila Movie Rental Database
* **Tables Used:**
  customer, payment, rental, inventory, film, category, film_category, store, staff

---

## SQL Techniques Used

### 1. Joins

* INNER JOIN used to combine multiple tables.
* Connected customers → rentals → payments → films → categories.

### 2. Aggregations

* SUM() – total revenue
* COUNT() – rental frequency
* AVG() – average spending and rental duration
* GROUP BY for summarized analysis.

### 3. Window Functions

* RANK() to identify top customers and movies.
* Running totals using SUM() OVER().
* PARTITION BY for category-wise ranking.

### 4. Common Table Expressions (CTE)

Used to simplify complex queries and improve readability.

---

## Project Folder Structure

```
movie_rental_analysis/
│
├── README.md
├── business_questions.md
├── sql/
│   ├── revenue_analysis.sql
│   ├── customer_analysis.sql
│   ├── film_analysis.sql
│   └── advanced_analysis.sql
│
├── analysis/
│   └── insights.md
│
└── images/
    ├── erd.png
    ├── revenue_chart.png
    └── query_outputs.png
```

---

## Key Analysis Insights

### Revenue Analysis

* Total revenue generated ≈ **67,000**.
* July recorded the highest revenue followed by August.
* February had the lowest revenue.
* Store 2 generated slightly higher revenue than Store 1.

### Customer Behavior

* Top customer: KARL SEAL (221.55 total spending).
* Some customers rent frequently despite lower spending.
* Average spending ranges between 2.9 – 5.7.
* No inactive customers were found.

### Film Performance

* Most rented film: BUCKET BROTHERHOOD.
* Highest revenue films include TELEGRAPH VOYAGE and SATURDAY LAMBS.
* Popular categories: Sports, Animation, Action Sci-Fi, Family.

### Store Operations

* Store 1 has highest rental count.
* Staff ID 1 handles most transactions.
* Tuesday is the busiest rental day.

### Advanced Analysis

* Customers ranked using window functions.
* Top movie identified within each category using RANK().

---

## Entity Relationship Diagram (ERD)

The ERD represents relationships between tables such as customer, rental, payment, and film.

<img width="1466" height="1223" alt="image" src="https://github.com/user-attachments/assets/ee9138ad-b794-4f11-8e89-1e11b6180c19" />


---

## Tools & Technologies

* SQL (MySQL/PostgreSQL)
* Window Functions
* DB Client (MySQL Workbench / DBeaver)
* Markdown Documentation
* Git & Github

---

## How to Run
1. Load Sakila database in MySQL
2. Execute queries from /queries folder
3. Review analysis report in /docs

## Conclusion

The project demonstrates how SQL analytics can extract actionable business insights from transactional data, helping understand customer behavior, product performance, and operational efficiency.

---

## Author

**Payal Kar**
ETL & Data Analytics Project
