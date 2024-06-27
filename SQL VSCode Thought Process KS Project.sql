-- exploratory analysis (1st Step)
SELECT
    ID,
    name,
    category,
    main_category,
    goal,
    pledged,
    state,
    backers
FROM 
    `majestic-casing-426419-i6.kickstarter.ksprojects`;

-- exploratory analysis (2nd Step)
SELECT
    main_category,
    goal,
    backers,
    pledged
FROM
    `majestic-casing-426419-i6.kickstarter.ksprojects` 
ORDER BY main_category DESC
LIMIT 10;

-- exploratory analysis (3rd Step)
SELECT main_category, goal, backers, pledged, state
FROM `majestic-casing-426419-i6.kickstarter.ksprojects`
WHERE state IN ('failed', 'canceled', 'suspended')
LIMIT 10;

-- exploratory analysis (4th Step)
SELECT main_category, backers, pledged, goal
 FROM `majestic-casing-426419-i6.kickstarter.ksprojects`
WHERE state IN ('failed', 'canceled', 'suspended')
      AND backers >= 100
      AND pledged >= 20000
LIMIT 10;

-- Formulating final query (1st Step)
SELECT main_category, backers, pledged, goal, (pledged/goal) AS pct_pledged
  FROM `majestic-casing-426419-i6.kickstarter.ksprojects`
 WHERE state IN ('failed')
   AND backers >= 100 
   AND pledged >= 20000
 ORDER BY main_category ASC, pct_pledged DESC
 LIMIT 10;

--Formulating final query (2nd Step)
  SELECT main_category, backers, pledged, goal,
         pledged / goal AS pct_pledged,
         
         CASE
            WHEN pledged/goal >=1 THEN "Fully fundend"
            WHEN pledged/goal >0.75 AND pledged/goal <1 THEN "Nearly funded"
            WHEN pledged/goal <0.75 THEN "Not nearly funded"
            END AS funding_status

FROM `majestic-casing-426419-i6.kickstarter.ksprojects`           
WHERE state IN ('failed')
     AND backers >= 100 AND pledged >= 20000
ORDER BY main_category, pct_pledged DESC
LIMIT 10;

-- Final Query (1) -- MOST LIKELY TO FAIL
SELECT main_category, backers, pledged, goal,
         pledged / goal AS pct_pledged,
         
         CASE
            WHEN pledged/goal >=1 THEN "Fully fundend"
            WHEN pledged/goal >0.75 AND pledged/goal <1 THEN "Nearly funded"
            WHEN pledged/goal <0.75 THEN "Not nearly funded"
            END AS funding_status  
FROM `majestic-casing-426419-i6.kickstarter.ksprojects` 
WHERE state IN ('failed')
     AND backers >= 100 AND pledged >= 20000
ORDER BY pct_pledged ASC
LIMIT 1000;

-- Final Query (2) -- MOST LIKELY TO SUCCEED
SELECT main_category, backers, pledged, goal,
         pledged / goal AS pct_pledged,
         
         CASE
            WHEN pledged/goal >=1 THEN "Fully fundend"
            WHEN pledged/goal >0.75 AND pledged/goal <1 THEN "Nearly funded"
            WHEN pledged/goal <0.75 THEN "Not nearly funded"
            END AS funding_status  
FROM `majestic-casing-426419-i6.kickstarter.ksprojects` 
WHERE state IN ('successful')
     AND backers >= 100 AND pledged >= 20000
ORDER BY pct_pledged ASC
LIMIT 1000;

--Success Rate by individual category
SELECT main_category,
       COUNT(*) AS category_count,
       COUNTIF(state = 'failed') AS failed_count,
       COUNTIF(state = 'successful') AS successful_count,
       (COUNTIF(state = 'successful') / COUNT(*)) * 100 AS success_rate
FROM `majestic-casing-426419-i6.kickstarter.ksprojects`
WHERE backers >= 100
  AND pledged >= 20000
GROUP BY main_category
ORDER BY main_category ASC;