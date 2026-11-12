-- Food Delivery App Data Analysis: SQL tasks
-- Runs on MySQL against the `zomato` table loaded from zomatocleaned.csv.
-- Notes on the data:
--   * The same restaurant appears many times (once per listing category and per area it
--     delivers to), so "top N" queries group by name to list each restaurant once.
--   * approx_cost is text such as '1,200', so it is converted to a number before sorting.
--   * A rating of 0 means "not yet rated" (NEW or '-' in the raw data), so averages leave it out.

-- Task 1: For a high-level overview, the top 5 most voted restaurants in the Delivery category.
SELECT name, MAX(votes) AS votes, MAX(rating) AS rating
FROM zomato
WHERE type = 'Delivery'
GROUP BY name
ORDER BY votes DESC
LIMIT 5;

-- Task 2: The top 5 highest-rated Delivery restaurants in Banashankari.
SELECT name, MAX(rating) AS rating, MAX(votes) AS votes
FROM zomato
WHERE type = 'Delivery' AND location = 'Banashankari'
GROUP BY name
ORDER BY rating DESC, votes DESC
LIMIT 5;

-- Task 3: Compare the ratings of the most expensive and the cheapest restaurants in Indiranagar.
SELECT
    (SELECT name FROM zomato
     WHERE location = 'Indiranagar'
     ORDER BY CAST(REPLACE(approx_cost, ',', '') AS UNSIGNED) DESC
     LIMIT 1) AS most_expensive,
    (SELECT rating FROM zomato
     WHERE location = 'Indiranagar'
     ORDER BY CAST(REPLACE(approx_cost, ',', '') AS UNSIGNED) DESC
     LIMIT 1) AS most_expensive_rating,
    (SELECT name FROM zomato
     WHERE location = 'Indiranagar'
     ORDER BY CAST(REPLACE(approx_cost, ',', '') AS UNSIGNED) ASC
     LIMIT 1) AS cheapest,
    (SELECT rating FROM zomato
     WHERE location = 'Indiranagar'
     ORDER BY CAST(REPLACE(approx_cost, ',', '') AS UNSIGNED) ASC
     LIMIT 1) AS cheapest_rating;

-- Task 4: Total votes for restaurants with and without online ordering.
SELECT online_order, SUM(votes) AS total_votes
FROM zomato
GROUP BY online_order;

-- Task 5: For each restaurant type, the number of restaurants, total votes and average rating,
-- most-voted first, leaving out rows with no type.
SELECT type,
       COUNT(name)                 AS restaurants,
       SUM(votes)                  AS total_votes,
       ROUND(AVG(NULLIF(rating, 0)), 2) AS avg_rating
FROM zomato
WHERE type IS NOT NULL AND type <> 'NA'
GROUP BY type
ORDER BY total_votes DESC;

-- Task 6: The most liked dishes of the most-voted restaurant.
SELECT name, dish_liked, rating, votes
FROM zomato
ORDER BY votes DESC
LIMIT 1;

-- Task 7: Expansion targets: the top 15 restaurants with at least 150 votes, a rating above 3,
-- and no online ordering, most-voted first.
SELECT name, MAX(rating) AS rating, MAX(votes) AS votes
FROM zomato
WHERE votes >= 150 AND rating > 3 AND online_order = 'No'
GROUP BY name
ORDER BY votes DESC
LIMIT 15;
