-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it


-- Creating the "lost" table
CREATE TABLE "lost" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT, -- Unique identifier for each lost item
    "loster_id" INTEGER NOT NULL, -- ID of the person who lost the item
    "loster_name" TEXT NOT NULL, -- Name of the person who lost the item
    "thing" TEXT NOT NULL, -- Description of the lost item
    "location" TEXT NOT NULL CHECK ("location" IN ('Stare Miasto', 'Nowe Miasto', 'Grunwald', 'Jeżyce', 'Wilda', 'Rataje', 'Winogrady', 'Naramowice', 'Strzeszyn', 'Umultowo')), -- District in Poznań where the item was lost
    "date" DATE NOT NULL, -- Date when the item was lost
    "condition" TEXT, -- Condition of the item (default NULL)
    "additional_informations" TEXT, -- Additional information about the item
    "still_current" INTEGER NOT NULL DEFAULT 0 -- Whether the item is still considered lost (0 if yes, 1 if no)
);

-- Creating the "find" table
CREATE TABLE "find" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT, -- Unique identifier for each found item
    "finder_id" INTEGER NOT NULL, -- ID of the person who found the item
    "finder_name" TEXT NOT NULL, -- Name of the person who found the item
    "thing" TEXT NOT NULL, -- Description of the found item
    "location" TEXT NOT NULL CHECK ("location" IN ('Stare Miasto', 'Nowe Miasto', 'Grunwald', 'Jeżyce', 'Wilda', 'Rataje', 'Winogrady', 'Naramowice', 'Strzeszyn', 'Umultowo')), -- District in Poznań where the item was found
    "date" DATE NOT NULL, -- Date when the item was found
    "condition" TEXT, -- Condition of the item (default NULL)
    "additional_informations" TEXT, -- Additional information about the item
    "still_current" INTEGER NOT NULL DEFAULT 0 -- Whether the item is still available for claiming (0 if yes, 1 if no)
);

-- Creating the "connections" table
CREATE TABLE "connections" (
    "lost_id" INTEGER, -- ID of the lost item
    "find_id" INTEGER, -- ID of the found item
    FOREIGN KEY ("lost_id") REFERENCES "lost" ("id"), -- Foreign key referencing "lost" table
    FOREIGN KEY ("find_id") REFERENCES "find" ("id") -- Foreign key referencing "find" table
);

-- Creating the "losters_contact" table
CREATE TABLE "losters_contact" (
    "lost_id" INTEGER NOT NULL, -- ID of the lost item (foreign key to "lost" table)
    "phone" TEXT, -- Phone number of the person who lost the item
    "email" TEXT, -- Email address of the person who lost the item
    CHECK ("phone" IS NOT NULL OR "email" IS NOT NULL), -- At least one of phone or email must be provided
    FOREIGN KEY ("lost_id") REFERENCES "lost" ("id") -- Foreign key referencing "lost" table
);

-- Creating the "finders_contact" table
CREATE TABLE "finders_contact" (
    "find_id" INTEGER NOT NULL, -- ID of the found item (foreign key to "find" table)
    "phone" TEXT, -- Phone number of the person who found the item
    "email" TEXT, -- Email address of the person who found the item
    CHECK ("phone" IS NOT NULL OR "email" IS NOT NULL), -- At least one of phone or email must be provided
    FOREIGN KEY ("find_id") REFERENCES "find" ("id") -- Foreign key referencing "find" table
);

-- Inserting data into the "lost" table
INSERT INTO "lost" ("id", "loster_name", "thing", "location", "date", "condition", "additional_informations", "still_current") VALUES
(1, 'John Doe', 'Wallet', 'Stare Miasto', '2023-05-01', 'Good', 'Black leather wallet', 1),
(2, 'Jane Smith', 'Keys', 'Nowe Miasto', '2023-05-02', '', 'Set of house keys', 0),
(3, 'Alice Johnson', 'Phone', 'Grunwald', '2023-05-03', 'Slightly scratched', 'iPhone 12', 1),
(4, 'Bob Brown', 'Laptop', 'Jeżyce', '2023-05-04', 'Good', 'Dell XPS 13', 0),
(5, 'Charlie Davis', 'Backpack', 'Wilda', '2023-05-05', 'Worn', 'Red backpack with books', 1),
(6, 'Diana Evans', 'Glasses', 'Rataje', '2023-05-06', '', 'Pair of reading glasses', 0),
(7, 'Eve Ford', 'Umbrella', 'Winogrady', '2023-05-07', 'Good', 'Black umbrella', 0),
(8, 'Frank Green', 'Watch', 'Naramowice', '2023-05-08', 'Good', 'Silver wristwatch', 0),
(9, 'Grace Hill', 'Book', 'Strzeszyn', '2023-05-09', '', 'Copy of "1984" by George Orwell', 0),
(10, 'Hank Ivan', 'Hat', 'Umultowo', '2023-05-10', '', 'Blue baseball cap', 0);

-- Inserting data into the "find" table
INSERT INTO "find" ("id", "finder_name", "thing", "location", "date", "condition", "additional_informations", "still_current") VALUES
(1, 'Liam Jones', 'Wallet', 'Stare Miasto', '2023-05-01', 'Good', 'Black leather wallet', 1),
(2, 'Sophia Adams', 'Watch', 'Naramowice', '2023-05-08', 'Burn', 'Silver wristwatch', 0),
(3, 'Quinn Scott', 'Glasses', 'Rataje', '2023-05-06', '', 'Pair of reading glasses', 0),
(4, 'Noah Lee', 'Phone', 'Grunwald', '2023-05-03', 'Slightly scratched', 'iPhone 12', 1),
(5, 'Ryan Taylor', 'Umbrella', 'Winogrady', '2023-05-07', 'Good', 'Black umbrella', 0),
(6, 'Olivia Kim', 'Laptop', 'Jeżyce', '2023-05-04', 'Good', 'Dell XPS 13', 0),
(7, 'Peter Moore', 'Backpack', 'Wilda', '2023-05-05', 'Worn', 'Red backpack with books', 1),
(8, 'Mia White', 'Keys', 'Nowe Miasto', '2023-05-02', '', 'Set of house keys', 0),
(9, 'Tom Harris', 'Ring', 'Strzeszyn', '2023-05-09', 'Good', 'Gold ring', 0),
(10, 'Uma Nelson', 'Bag', 'Umultowo', '2023-05-10', 'Good', 'Black handbag', 0),
(11, 'Victor Owen', 'Scarf', 'Jeżyce', '2023-05-11', 'Good', 'Red scarf', 0);

-- Inserting data into the "connections" table
INSERT INTO "connections" ("lost_id", "find_id") VALUES
(1, 1),
(3, 4),
(5, 7);

-- Inserting data into the "losters_contact" table
INSERT INTO "losters_contact" ("lost_id", "phone", "email") VALUES
(1, '123-456-7890', 'john.doe@example.com'),
(2, '234-567-8901', NULL),
(3, NULL, 'alice.johnson@example.com'),
(4, '456-789-0123', 'bob.brown@example.com'),
(5, '567-890-1234', NULL),
(6, NULL, 'diana.evans@example.com'),
(7, '789-012-3456', 'eve.ford@example.com'),
(8, '890-123-4567', NULL),
(9, NULL, 'grace.hill@example.com'),
(10, '012-345-6789', 'hank.ivan@example.com');

-- Inserting data into the "finders_contact" table
INSERT INTO "finders_contact" ("find_id", "phone", "email") VALUES
(1, '123-456-7890', 'liam.jones@example.com'),
(2, '234-567-8901', NULL),
(4, NULL, 'noah.lee@example.com'),
(6, '456-789-0123', 'olivia.kim@example.com'),
(7, '567-890-1234', NULL),
(3, NULL, 'quinn.scott@example.com'),
(5, '789-012-3456', 'ryan.taylor@example.com'),
(8, '890-123-4567', NULL),
(9, NULL, 'tom.harris@example.com'),
(10, '012-345-6789', 'uma.nelson@example.com'),
(11, '123-456-7890', NULL);

-- Creating the "location_lost" view
CREATE VIEW "location_lost" AS
SELECT "thing", "location" FROM "lost"
WHERE "still_current" = 0;

-- Creating the "location_find" view
CREATE VIEW "location_find" AS
SELECT "thing", "location" FROM "find"
WHERE "still_current" = 0;

-- Creating the "matched_items" view
CREATE VIEW matched_items AS
SELECT
    lost.id AS lost_id,
    lost.thing AS lost_thing,
    lost.location AS lost_location,
    lost.date AS lost_date,
    find.id AS found_id,
    find.thing AS found_thing,
    find.location AS found_location,
    find.date AS found_date
FROM
    connections
JOIN lost ON connections.lost_id = lost.id
JOIN find ON connections.find_id = find.id;

CREATE INDEX "idx_finders_contact_finder_id" ON "finders_contact" ("find_id");

CREATE INDEX "idx_losters_contact_loster_id" ON "losters_contact" ("lost_id");

CREATE INDEX "idx_find_location_date" ON "find" ("location, date");

CREATE INDEX "idx_lost_location_date" ON "lost" ("location, date");

CREATE INDEX "idx_thing_location_find" ON "find" ("thing", "location");

CREATE INDEX "idx_thing_location_lost" ON "lost" ("thing", "location");

CREATE TRIGGER "lost_trigger"
AFTER INSERT ON "connections"
FOR EACH ROW
BEGIN
    UPDATE "lost" SET "still_current" = 1
    WHERE "id" = NEW.lost_id;
END;

CREATE TRIGGER "find_trigger"
AFTER INSERT ON "connections"
FOR EACH ROW
BEGIN
    UPDATE "find" SET "still_current" = 1
    WHERE "id" = NEW.lost_id;
END;