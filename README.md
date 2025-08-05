
# User Behaviour and Feature Adoption

This project provides insights into user behaviour, feature adoption, salary patterns, and customer support resolution performance using SQL queries and Power BI dashboards. It simulates a data environment in a fintech setting to help analysts explore business questions related to product usage and engagement quality.

## Project Structure

```
├── Data
│   └── users.csv
├── PowerBI
│   ├── Executive_summary_user_behaviour.png
│   ├── feature_popularity_user_behaviour.png
│   ├── spending_behaviour_salary_trends.png
│   ├── support_ticket_trends.png
│   └── README.md
├── SQL
│   ├── insights.sql
│   └── README.md
└── README.md (this file)
```

## Key Insights & Goals

- **User Engagement**: Time to first feature use, repeat usage patterns.
- **Transaction Trends**: Monthly volume, revenue by salary band, top merchant categories.
- **Support Tickets**: Resolution time by issue type, open/closed/pending status.
- **Salary Segmentation**: Categorized into salary bands for comparative insights.

## Power BI Dashboards

The dashboard includes:

### 1. Executive Summary
- KPIs: Total users, transactions, average salary, revenue.
- Feature usage rate.
- Average support resolution time.

### 2. Feature Popularity
- Usage rate across features.
- Repeat usage volume (within 7 days).

### 3. Spending Behaviour & Salary Trends
- Merchant types by revenue.
- Transaction revenue segmented by salary bands.
- Monthly transaction volume.

### 4. Support Ticket Trends
- Total tickets and average resolution time.
- Status breakdown (open, resolved, pending).
- Resolution time by issue type.

## DAX Used

```DAX
Resolution Time (Days) = 
DATEDIFF('support_tickets (1)'[created_at], 'support_tickets (1)'[resolved_at].[Date], DAY)

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

## Technologies

- **SQL** (MySQL-style): Used for querying transactional, user, and support datasets.
- **Power BI**: Visualisations and interactive dashboards.
- **GitHub**: Version control and documentation.
