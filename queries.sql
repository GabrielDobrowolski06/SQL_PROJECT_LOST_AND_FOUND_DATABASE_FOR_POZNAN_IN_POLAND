-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database


-- Find all lost items in the location 'Grunwald'
SELECT "thing", "location"
FROM "location_lost"
WHERE "location" = 'Grunwald';

-- Find all matched lost and found items
SELECT *
FROM "matched_items";

-- Find all items found on May 2, 2023
SELECT *
FROM "find"
WHERE "date" = '2023-05-02';

-- Find contact information for the person who found an item in 'Stare Miasto'
SELECT "finders_contact"."phone", "finders_contact"."email"
FROM "finders_contact"
JOIN "find" ON "finders_contact"."find_id" = "find"."id"
WHERE "find"."location" = 'Stare Miasto';

-- Find all items found in 'Jeżyce' within a specific date range
SELECT *
FROM "find"
WHERE "location" = 'Jeżyce' AND "date" BETWEEN '2023-05-01' AND '2023-05-10';

-- Find all currently lost items in the location 'Stare Miasto'
SELECT *
FROM "lost"
WHERE "location" = 'Stare Miasto' AND "still_current" = 0;

-- Find all found items that contain the word 'phone'
SELECT *
FROM "find"
WHERE "thing" LIKE '%phone%';

-- Find the number of lost items in each location
SELECT "location", COUNT(*) AS "lost_count"
FROM "lost"
GROUP BY "location";

-- Find all items found after a specific date
SELECT *
FROM "find"
WHERE "date" > '2023-05-05';

-- Find contact information for the person who found an item in 'Jeżyce' on a specific date
SELECT "finders_contact"."phone", "finders_contact"."email"
FROM "finders_contact"
JOIN "find" ON "finders_contact"."find_id" = "find"."id"
WHERE "find"."location" = 'Jeżyce' AND "find"."date" = '2023-05-04';
