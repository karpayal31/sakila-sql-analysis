## Project Overview

-- This project analyzes customer rental behaviour and revenue performance
-- using the DVD Rental (Sakila) database. The objective is to extract
-- business insights from transactional data using SQL.

-- The analysis focuses on customer spending patterns, movie performance,
-- and rental trends to support data-driven business decisions.

## Objectives

-- - Analyze customer purchasing behaviour
-- - Identify high-value customers
-- - Measure revenue trends
-- - Evaluate movie and category performance
-- - Generate actionable business insights

## SQL Techniques Used

-- The analysis uses the following SQL concepts:

-- ### Joins
-- - INNER JOIN used to combine customer, rental, payment,
--   film, and category tables.
-- - Enabled tracking customer activity across the database.

-- ### Aggregations
-- - SUM(), COUNT(), and MAX() used to calculate:
--   - total spending
--   - rental frequency
--   - revenue metrics

-- ### Window Functions
-- - RANK() used to identify top movies within categories.
-- - SUM() OVER() used for cumulative revenue analysis.

-- ### Common Table Expressions (CTEs)
-- - Used to break complex queries into readable steps.

-- ### Grouping
-- - GROUP BY applied to aggregate metrics at customer
--   and movie levels.

## Project Folder Structure

-- dvd_rental_analysis/
-- │
-- ├── docs/
-- │   └── business_questions.md   # Business objectives and analysis goals
-- │
-- ├── sql/
-- │   └── analysis_queries.sql    # All SQL queries used in analysis
-- │
-- ├── images/
-- │   └── erd_diagram.png         # Database ER diagram
-- │
-- └── README.md                   # Project overview and explanation

-- The project structure separates documentation,
-- SQL logic, and visual assets to improve readability
-- and maintainability.



