CREATE TABLE IF NOT EXISTS "members" (
	"memberID" serial NOT NULL UNIQUE,
	"name" varchar(255) NOT NULL,
	"contactInfo" bigint NOT NULL,
	"joinDate" DATE NOT NULL DEFAULT CURRENT_DATE,
	PRIMARY KEY ("memberID")
);

CREATE TABLE IF NOT EXISTS "books" (
	"title" varchar(255) NOT NULL,
	"authors" varchar(255) NOT NULL,
	"ISBN" varchar(255) NOT NULL UNIQUE,
	"publicationYear" bigint,
	"bookId" serial NOT NULL UNIQUE,
	PRIMARY KEY ("bookId")
);

CREATE TABLE IF NOT EXISTS "borrowings" (
	"borrowingID" serial NOT NULL UNIQUE,
	"memberID" bigint NOT NULL,
	"bookID" bigint NOT NULL,
	"borrowingDate" date NOT NULL,
	"dueDate" date NOT NULL,
	"returnDate" date,
	PRIMARY KEY ("borrowingID")
);

CREATE TABLE IF NOT EXISTS "reviews" (
	"reviewID" serial NOT NULL UNIQUE,
	"memberID" bigint NOT NULL,
	"bookID" bigint NOT NULL,
	"reviewText" varchar(255) NOT NULL,
	"rating" bigint NOT NULL,
	PRIMARY KEY ("reviewID")
);

CREATE TABLE IF NOT EXISTS "reservations" (
	"reservationID" serial NOT NULL UNIQUE,
	"memberID" bigint NOT NULL,
	"bookID" bigint NOT NULL,
	"reservationDate" date NOT NULL,
	"status" varchar(255) NOT NULL,
	PRIMARY KEY ("reservationID")
);

CREATE TABLE IF NOT EXISTS "bookCopies" (
	"copyID" serial NOT NULL UNIQUE,
	"bookID" bigint NOT NULL,
	"copyStatus" varchar(255) NOT NULL,
	PRIMARY KEY ("copyID")
);

CREATE TABLE IF NOT EXISTS "readingHistory" (
	"historyID" serial NOT NULL UNIQUE,
	"memberID" bigint NOT NULL,
	"bookID" bigint NOT NULL,
	"startDate" date NOT NULL,
	"endDate" date,
	PRIMARY KEY ("historyID")
);

-- 4 список для юзерів
CREATE TABLE IF NOT EXISTS "userRoles" (
    id serial PRIMARY KEY,
    username varchar(100) NOT NULL,
    assigned_role varchar(100) NOT NULL,
    description text
);
INSERT INTO "userRoles" (username, assigned_role, description) VALUES
('user', 'readonly', 'User with read-only access to SELECT from all tables'),
('Admin', 'readwrite', 'User with read and write access to all tables');

-- завд №11

-- 1 ROLES
-- роль Read-only
CREATE ROLE readonly;
-- роль Read-write
CREATE ROLE readwrite;

-- 2 USERS
-- юзери
CREATE USER "user" WITH PASSWORD '12345678';
CREATE USER "Admin" WITH PASSWORD '87654321';

-- присвоєння ролей
GRANT readonly TO "user";
GRANT readwrite TO "Admin";

-- 3 PERMISSION
-- select to "readonly"
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
-- full dml to "readwrite"
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite;




-- завд №9
-- DML Postgresql
-- 7 таблиць
-- включно з INSERT, UPDATE, DELETE

-- fix сумісності "ISBN"
TRUNCATE TABLE 
  "members", 
  "books", 
  "bookCopies", 
  "borrowings", 
  "reservations", 
  "reviews", 
  "readingHistory" 
RESTART IDENTITY CASCADE;

-- 1. Members
-- fix - joinDate для Mixed View не працював
ALTER TABLE "members"
DROP COLUMN IF EXISTS "joinDate";

ALTER TABLE "members"
ADD COLUMN "joinDate" DATE NOT NULL DEFAULT CURRENT_DATE;
INSERT INTO "members" ("name", "contactInfo", "joinDate") VALUES
('Alice Cooper', 9123456789, '2012-08-02'),
('John Smith', 9998887766, '2001-01-14'),
('Joe Biden', 9234567890, '2016-09-07'),
('Donald Trump', 9111222333, '1999-10-30'),
('Volodymyr Zelensky', 9334445566, '2020-03-22'),
('Kyrylo Budanov', 9445556677, '2024-11-10'),
('Emma Watson', 9101112233, '2002-12-01'),
('Daniel Craig', 9224446688, '1997-04-27'),
('Grace Park', 9335557799, '2009-07-03'),
('Liam Neeson', 9556667788, '2019-08-08');


-- 2. Books

INSERT INTO "books" ("title", "authors", "ISBN", "publicationYear") VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925),
('To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960),
('1984', 'George Orwell', '9780451524935', 1949),
('The Hobbit', 'J.R.R. Tolkien', '9780547928227', 1937),
('Pride and Prejudice', 'Jane Austen', '9780141439518', 1813),
('The Catcher in the Rye', 'J.D. Salinger', '9780316769488', 1951),
('The Alchemist', 'Paulo Coelho', '9780062315007', 1988),
('A Brief History of Time', 'Stephen Hawking', '9780553380163', 1988),
('The Da Vinci Code', 'Dan Brown', '9780307474278', 2003),
('The Road', 'Cormac McCarthy', '9780307387899', 2006);


-- 3. BookCopies

INSERT INTO "bookCopies" ("bookID", "copyStatus") VALUES
(1, 'Available'),
(1, 'Borrowed'),
(2, 'Available'),
(3, 'Available'),
(4, 'Reserved'),
(5, 'Available'),
(6, 'Borrowed'),
(7, 'Available'),
(8, 'Available'),
(9, 'Available');


-- 4. Borrowings

INSERT INTO "borrowings" ("memberID", "bookID", "borrowingDate", "dueDate", "returnDate") VALUES
(1, 2, '2024-03-01', '2024-03-15', '2024-03-14'),
(3, 5, '2024-03-05', '2024-03-19', NULL),
(4, 1, '2024-03-10', '2024-03-24', '2024-03-23'),
(6, 3, '2024-03-12', '2024-03-26', NULL),
(2, 4, '2024-03-15', '2024-03-29', '2024-03-28'),
(7, 7, '2024-03-17', '2024-03-31', NULL),
(5, 6, '2024-03-20', '2024-04-03', '2024-04-01'),
(9, 8, '2024-03-22', '2024-04-05', NULL),
(10, 9, '2024-03-25', '2024-04-08', NULL),
(8, 10, '2024-03-27', '2024-04-10', '2024-04-09');


-- 5. Reservations

INSERT INTO "reservations" ("memberID", "bookID", "reservationDate", "status") VALUES
(2, 3, '2024-04-01', 'Active'),
(4, 2, '2024-04-02', 'Active'),
(5, 4, '2024-04-03', 'Cancelled'),
(6, 1, '2024-04-04', 'Active'),
(7, 5, '2024-04-05', 'Active'),
(8, 6, '2024-04-06', 'Active'),
(9, 7, '2024-04-07', 'Active'),
(1, 8, '2024-04-08', 'Active'),
(3, 9, '2024-04-09', 'Active'),
(10, 10, '2024-04-10', 'Expired');


-- 6. Reviews

INSERT INTO "reviews" ("memberID", "bookID", "reviewText", "rating") VALUES
(1, 1, 'A classic masterpiece.', 5),
(2, 2, 'Very insightful and emotional.', 4),
(3, 3, 'Still relevant today.', 5),
(4, 4, 'Loved the fantasy elements.', 4),
(5, 5, 'Well-written but not my taste.', 3),
(6, 6, 'A compelling story.', 5),
(7, 7, 'Very motivating.', 4),
(8, 8, 'Challenging but worth it.', 4),
(9, 9, 'A thrilling read!', 5),
(10, 10, 'Dark and gripping.', 4);


-- 7. ReadingHistory

INSERT INTO "readingHistory" ("memberID", "bookID", "startDate", "endDate") VALUES
(1, 1, '2024-02-01', '2024-02-15'),
(2, 2, '2024-02-10', '2024-02-20'),
(3, 3, '2024-02-12', '2024-02-25'),
(4, 4, '2024-03-01', '2024-03-10'),
(5, 5, '2024-03-05', '2024-03-15'),
(6, 6, '2024-03-10', '2024-03-20'),
(7, 7, '2024-03-15', NULL),
(8, 8, '2024-03-20', '2024-03-30'),
(9, 9, '2024-03-25', NULL),
(10, 10, '2024-04-01', '2024-04-10');



-- UPDATE
UPDATE "members"
SET "contactInfo" = 9991234567
WHERE "memberID" = 2;


-- DELETE
DELETE FROM "reservations"
WHERE "reservationID" = 10;

-- пояснення:
-- без DELETE для табличок: 1-Members, 2-Books, 6-Reviews, 4-Borrowings, 7-ReadingHistory - для збереження цілісності бази даних
-- без UPDATE для табличок: 2-Books, 4-Borrowings, 7-ReadingHistory - апдейт може поламати бд




--завд №10
--views

-- 1 Horizontal
CREATE OR REPLACE VIEW view_book_titles_authors AS
SELECT "title", "authors"
FROM "books";

-- 2 Vertical
CREATE OR REPLACE VIEW view_overdue_borrowings AS
SELECT *
FROM "borrowings"
WHERE "returnDate" IS NULL AND "dueDate" < CURRENT_DATE;

-- 3 Mixed
CREATE OR REPLACE VIEW view_active_members_contact AS
SELECT "memberID", "name", "contactInfo"
FROM "members"
WHERE "joinDate" >= CURRENT_DATE - INTERVAL '3 months';


-- 4 JOIN
CREATE OR REPLACE VIEW view_members_borrowed_books AS
SELECT 
    m."memberID",
    m."name" AS member_name,
    b."title" AS book_title,
    br."borrowingDate",
    br."dueDate",
    br."returnDate"
FROM "members" m
JOIN "borrowings" br ON m."memberID" = br."memberID"
JOIN "books" b ON b."bookId" = br."bookID";


-- 5 Subquery
CREATE OR REPLACE VIEW view_top_rated_books AS
SELECT b."bookId", b."title", b."authors", avg_ratings.avg_rating
FROM "books" b
JOIN (
    SELECT "bookID", AVG("rating") AS avg_rating
    FROM "reviews"
    GROUP BY "bookID"
) avg_ratings ON b."bookId" = avg_ratings."bookID"
WHERE avg_ratings.avg_rating > 4;


-- 6 UNION
CREATE OR REPLACE VIEW view_all_reservations_union AS
SELECT "reservationID", "memberID", "bookID", "reservationDate", "status"
FROM "reservations"
WHERE "status" IN ('Pending', 'Reserved')
UNION
SELECT "reservationID", "memberID", "bookID", "reservationDate", "status"
FROM "reservations"
WHERE "status" = 'Expired';

-- 7 View from another view
CREATE OR REPLACE VIEW view_names_overdue_borrowers AS
SELECT DISTINCT m."name"
FROM view_overdue_borrowings ob
JOIN "members" m ON ob."memberID" = m."memberID";

-- 8 CHECK OPTION
CREATE OR REPLACE VIEW view_available_books WITH (security_barrier) AS
SELECT * FROM "bookCopies"
WHERE "copyStatus" = 'Available'
WITH CHECK OPTION;


