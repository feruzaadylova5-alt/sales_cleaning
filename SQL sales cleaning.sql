DROP TABLE IF EXISTS orders_clean;

CREATE TABLE orders_clean AS
SELECT
  *,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UZ', 'UZB', 'UZBEKISTAN') THEN 'Uzbekistan'
    WHEN UPPER(TRIM(country)) IN ('TR', 'TURKEY') THEN 'Turkey'
    WHEN UPPER(TRIM(country)) IN ('KZ', 'KAZAKHSTAN') THEN 'Kazakhstan'
    WHEN UPPER(TRIM(country)) IN ('RUS', 'RUSSIA') THEN 'Russia'
    WHEN UPPER(TRIM(country)) IN ('U.A.E.', 'UAE', 'UNITED ARAB EMIRATES') THEN 'United Arab Emirates'
    ELSE country
  END AS country_clean,
  CASE
    WHEN UPPER(TRIM(category)) = 'ELECTRONICS' THEN 'Electronics'
    WHEN UPPER(TRIM(category)) = 'HOME' THEN 'Home'
    WHEN UPPER(TRIM(category)) = 'SPORTS' THEN 'Sports'
    WHEN UPPER(TRIM(category)) = 'OFFICE' THEN 'Office'
    WHEN UPPER(TRIM(category)) = 'ACCESSORIES' THEN 'Accessories'
    ELSE category
  END AS category_clean,
  CAST(NULLIF(REPLACE(TRIM(unit_price), '$', ''), '') AS DECIMAL(10,2)) AS unit_price_clean,
  COALESCE(CAST(NULLIF(TRIM(discount_percent), '') AS DECIMAL(5,2)), 0) AS discount_clean
FROM orders_raw;

ALTER TABLE orders_clean ADD COLUMN revenue DECIMAL(10,2);

UPDATE orders_clean
SET revenue = CAST(NULLIF(TRIM(quantity), '') AS DECIMAL(10,2)) * unit_price_clean * (1 - discount_clean/100)
WHERE CAST(NULLIF(TRIM(quantity), '') AS DECIMAL(10,2)) > 0;

WITH product_revenue AS (
    SELECT
        category_clean,
        product_name,
        SUM(revenue) AS total_revenue
    FROM orders_clean
    WHERE revenue IS NOT NULL
    GROUP BY category_clean, product_name
),
ranked as (
SELECT
    category_clean,
    product_name,
    total_revenue,
    RANK() OVER (PARTITION BY category_clean ORDER BY total_revenue DESC) AS rnk
FROM product_revenue)

SELECT category_clean, product_name, total_revenue
FROM ranked
WHERE rnk = 1
ORDER BY total_revenue DESC;