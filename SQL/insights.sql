-- 1. Which UK region has the highest average user salary?

SELECT 
    location, ROUND(AVG(salary), 2) AS average_salary
FROM
    users
GROUP BY location
ORDER BY AVG(salary) DESC;

-- 2. How many users joined per month in the last 12 months?
SELECT 
    YEAR(join_date) AS year,
    MONTH(join_date) AS month,
    COUNT(user_id) AS users_joined
FROM
    users
WHERE
    join_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY YEAR(join_date) , MONTH(join_date)
ORDER BY YEAR(join_date) , MONTH(join_date);

-- 3. What percentage of users have used each feature?
SELECT 
    feature,
    COUNT(DISTINCT user_id) AS users_used_feature,
    ROUND((COUNT(DISTINCT user_id) * 100.0) / (SELECT 
                    COUNT(*)
                FROM
                    users),
            2) AS percentage_of_all_users
FROM
    feature_usage
GROUP BY feature;


-- 4. Which features are most popular among users earning over £60,000?
SELECT 
    COUNT(DISTINCT u.user_id) AS earners_over_60k, f.feature
FROM
    users u
        JOIN
    feature_usage f ON f.user_id = u.user_id
WHERE
    salary > 60000
GROUP BY f.feature;

-- 5. What is the average time (in days) between a user joining and their first feature usage?
SELECT 
    AVG(difference) AS average_time_to_use_a_feature
FROM
    (SELECT 
        u.join_date,
            f.user_id,
            f.first_time_usage,
            DATEDIFF(f.first_time_usage, u.join_date) AS difference
    FROM
        users u
    JOIN (SELECT 
        user_id, MIN(used_at) AS first_time_usage
    FROM
        feature_usage
    GROUP BY user_id) f ON f.user_id = u.user_id) AS time_taken_to_use_a_feature;


-- 6. What are the top 5 merchant types by total transaction amount in the past 30 days?

SELECT 
    merchant_type, ROUND(SUM(amount), 2) AS revenue
FROM
    transactions
WHERE
    transaction_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE()
GROUP BY merchant_type
ORDER BY SUM(amount)
LIMIT 5;


-- 7. Which users spend more than 10% of their salary on average per month?
SELECT 
    u.user_id,
    ROUND((u.salary * 0.1) / 12, 2) AS ten_percent_of_salary,
    t.year,
    t.month,
    t.total_spent
FROM
    users u
        INNER JOIN
    (SELECT 
        user_id,
            YEAR(transaction_date) AS year,
            MONTH(transaction_date) AS month,
            SUM(amount) AS total_spent
    FROM
        transactions
    GROUP BY user_id , YEAR(transaction_date) , MONTH(transaction_date)) t ON u.user_id = t.user_id
WHERE
    t.total_spent > ((u.salary * 0.1) / 12);




-- 8.Which users had more than 1 transaction in a single day
SELECT 
    user_id, transaction_date, COUNT(*) AS daily_repeat_buyers
FROM
    transactions
GROUP BY user_id , transaction_date
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;


-- 9. What is the average resolution time for support tickets by type?
SELECT 
    issue_type,
    AVG(DATEDIFF(resolved_at, created_at)) AS average_amount_of_days_to_resolution
FROM
    support_tickets
WHERE
    resolved_at IS NOT NULL
GROUP BY issue_type;


-- 10. Which 10 users have the most unresolved tickets?
SELECT 
    user_id, COUNT(user_id) AS amount_of_unresolved_tickets
FROM
    support_tickets
WHERE
    resolved_at IS NULL
GROUP BY user_id
ORDER BY COUNT(user_id) DESC
LIMIT 10;

-- 11. Which users used a feature within 7 days of joining and had above-average spend in their first month?

SELECT 
    u.user_id
FROM
    users u
        JOIN
    (SELECT 
        user_id, MIN(used_at) AS first_feature_use
    FROM
        feature_usage
    GROUP BY user_id) f ON u.user_id = f.user_id
        JOIN
    (SELECT 
        t.user_id, SUM(t.amount) AS total_spent_first_month
    FROM
        transactions t
    JOIN users u2 ON u2.user_id = t.user_id
    WHERE
        DATEDIFF(t.transaction_date, u2.join_date) <= 30
    GROUP BY t.user_id) t ON u.user_id = t.user_id
WHERE
    DATEDIFF(f.first_feature_use, u.join_date) <= 7
        AND t.total_spent_first_month > (SELECT 
            AVG(user_total)
        FROM
            (SELECT 
                t.user_id, SUM(t.amount) AS user_total
            FROM
                transactions t
            JOIN users u3 ON u3.user_id = t.user_id
            WHERE
                DATEDIFF(t.transaction_date, u3.join_date) <= 30
            GROUP BY t.user_id) first_month_spend);



-- 12. For each feature, what is the 7-day repeat usage rate?

WITH first_uses AS (
    SELECT
        user_id,
        feature,
        MIN(used_at) AS first_time_used
    FROM
        feature_usage
    GROUP BY
        user_id, feature
),
repeat_uses AS (
    SELECT
        f1.user_id,
        f1.feature,
        COUNT(*) > 0 AS used_again_within_7_days
    FROM
        first_uses f1
    LEFT JOIN feature_usage f2
        ON f1.user_id = f2.user_id
        AND f1.feature = f2.feature
        AND f2.used_at > f1.first_time_used
        AND f2.used_at <= DATE_ADD(f1.first_time_used, INTERVAL 7 DAY)
    GROUP BY
        f1.user_id, f1.feature
),
repeat_rate AS (
    SELECT
        feature,
        COUNT(CASE WHEN used_again_within_7_days THEN 1 END) AS repeat_users,
        COUNT(*) AS total_users
    FROM
        repeat_uses
    GROUP BY feature
)
SELECT
    feature,
    ROUND((repeat_users * 100.0 / total_users), 2) AS repeat_usage_rate_percentage
FROM
    repeat_rate
ORDER BY repeat_usage_rate_percentage DESC;

-- 13. What is the 30-day churn rate among users who joined in the past 6 months?
SELECT 
    ROUND(COUNT(CASE
                WHEN t.user_id IS NULL THEN 1
            END) * 100.0 / COUNT(DISTINCT u.user_id),
            2) AS churn_rate_percentage
FROM
    users u
        LEFT JOIN
    transactions t ON u.user_id = t.user_id
        AND t.transaction_date BETWEEN u.join_date AND DATE_ADD(u.join_date, INTERVAL 30 DAY)
WHERE
    u.join_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
