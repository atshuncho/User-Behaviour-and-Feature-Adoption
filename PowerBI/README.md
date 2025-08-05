
# User Behaviour & Engagement Power BI Dashboard

This Power BI report analyses user behaviour, feature adoption, transaction activity, and support ticket trends to provide insights into user engagement and operational performance.

## Pages Overview

### 1. Executive Summary
- **Volume of Users**
- **Volume of Transactions**
- **Average Salary**
- **Total Revenue**
- **Feature Usage Rate (Pie Chart)**
- **Daily Resolution Time Trend (Line Chart)**
- **Top Merchant Types by Spend (Table)**

### 2. Feature Popularity
- **Amount of Features Available**
- **Feature Usage Rate by % (Pie Chart)**
- **Volume of Repeat Users (7-Day Window, Stacked Bar Chart)**

### 3. Spending Behaviour & Salary Trends
- **Merchant Types by Revenue (Bar Chart)**
- **Transaction Revenue by Salary Band (Bar Chart)**
- **Monthly Transaction Volume (Line Chart)**
- **User Transaction Table with Salary & Age**
- **Average Salary KPI Card**

### 4. Support Ticket Trends
- **Ticket Volume Over Time**
- **Status of Tickets (Pie Chart)**
- **Average Ticket Resolution Time (KPI)**
- **Resolution Time by Issue Type (Bar Chart)**
- **Detailed Table of Tickets**
- **Dynamic Filtering by Ticket Status and User**

---

## Key Business Questions Answered
- What is the average salary of our user base?
- Which features are most used and how often do users repeat usage within a week?
- What are the top-spending merchant categories?
- How does salary correlate with transaction volume?
- What’s the resolution time for support issues by type?
- Are support tickets trending up or down over time?

---

## DAX Measures Used

### 🕒 Resolution Time (Days)
Calculates the number of days between a ticket’s creation and resolution.
```DAX
Resolution Time (Days) = 
DATEDIFF(
    'support_tickets (1)'[created_at],
    'support_tickets (1)'[resolved_at].[Date],
    DAY
)
```

### Salary Band Order
Categorises users into salary bands for grouped analysis in visualisations.
```DAX
Salary Band Order = 
SWITCH(
    TRUE(),
    Users[salary] < 20000, 1,
    Users[salary] < 40000, 2,
    Users[salary] < 60000, 3,
    Users[salary] < 80000, 4,
    Users[salary] >= 80000, 5
)
```

---


## Tools & Tech
- **Power BI Desktop**
- **DAX for custom calculations**
- **SQL-based pre-processing**

---

## Notes
- All charts are fully interactive with slicers and drill-through capabilities.
- Salary banding is custom built using DAX logic.
- Repeat usage calculated using pre-aggregated SQL queries and visualised in stacked bar chart format.

---
