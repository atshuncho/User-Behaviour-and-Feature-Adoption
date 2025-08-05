
# SQL Analysis for User Behaviour and Feature Insights

This repository contains 12 SQL queries designed to showcase a range of data analysis skills using a banking-style dataset. These queries span user demographics, feature usage, transactional behavior, and support interactions.

## Queries Overview

### 1. Average Salary by Region
Identifies which UK region has the highest average salary among users.

### 2. Monthly User Sign-Ups (Last 12 Months)
Counts how many users joined in each of the last 12 months.

### 3. Feature Usage Rate
Calculates the percentage of all users that have used each product feature.

### 4. Feature Popularity Among High Earners
Ranks features based on usage by users earning over £60,000.

### 5. Average Time to First Feature Use
Calculates how long it takes users (in days) to use a feature after joining.

### 6. Top 5 Merchant Types (Past 30 Days)
Finds the 5 merchant types with the highest total transaction amounts over the last 30 days.

### 7. Users Spending >10% of Salary Per Month
Identifies users who spend more than 10% of their monthly salary on average.

### 8. Repeat Transactions in One Day
Detects users who transacted more than once in a single day.

### 9. Support Ticket Resolution Time
Shows the average time taken to resolve support tickets, grouped by issue type.

### 10. Users with Most Unresolved Tickets
Lists the top 10 users with the highest number of unresolved support tickets.

### 11. Power Users: Early Adoption + High Spend
Finds users who used a feature within 7 days of joining **and** spent above the average in their first month.

### 12. 7-Day Repeat Feature Usage
Calculates the percentage of users who reused the same feature within 7 days of first use.

### 13. 30-day churn rate among users who joined in the past 6 months
Calculates the percentage of users with no transaction activity 30 days after joining.

---

## Tables Used
- `users`: user profile data (join date, salary, location)
- `feature_usage`: logs of user-feature interactions with timestamps
- `transactions`: user transactions (amount, date, merchant type)
- `support_tickets`: support tickets and resolution status

## Tools
- SQL (MySQL syntax)
---

## Purpose
This project was designed to simulate real-world product analytics tasks (like those at Monzo) and to demonstrate strong SQL capabilities including:
- Aggregations
- Date filtering
- Subqueries
- CTEs
- Joins
- Conditional filtering

---
