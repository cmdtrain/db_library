CREATE TABLE IF NOT EXISTS "members" (
	"memberID" serial NOT NULL UNIQUE,
	"name" varchar(255) NOT NULL,
	"contactInfo" bigint NOT NULL,
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





-- завд №9
-- DML Postgresql
-- 7 таблиць
-- включно з INSERT, UPDATE, DELETE


-- 1. Members

INSERT INTO "members" ("memberID", "name", "contactInfo") VALUES
(1, 'Alice Cooper', 9123456789),
(2, 'John Smith', 9998887766),
(3, 'Joe Biden', 9234567890),
(4, 'Donald Trump', 9111222333),
(5, 'Volodymyr Zelensky', 9334445566),
(6, 'Kyrylo Budanov', 9445556677),
(7, 'Emma Watson', 9101112233),
(8, 'Daniel Craig', 9224446688),
(9, 'Grace Park', 9335557799),
(10, 'Liam Neeson', 9556667788);


-- 2. Books

INSERT INTO "books" ("bookId", "title", "authors", "ISBN", "publicationYear") VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925),
(2, 'To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960),
(3, '1984', 'George Orwell', '9780451524935', 1949),
(4, 'The Hobbit', 'J.R.R. Tolkien', '9780547928227', 1937),
(5, 'Pride and Prejudice', 'Jane Austen', '9780141439518', 1813),
(6, 'The Catcher in the Rye', 'J.D. Salinger', '9780316769488', 1951),
(7, 'The Alchemist', 'Paulo Coelho', '9780062315007', 1988),
(8, 'A Brief History of Time', 'Stephen Hawking', '9780553380163', 1988),
(9, 'The Da Vinci Code', 'Dan Brown', '9780307474278', 2003),
(10, 'The Road', 'Cormac McCarthy', '9780307387899', 2006);


-- 3. BookCopies

INSERT INTO "bookCopies" ("copyID", "bookID", "copyStatus") VALUES
(1, 1, 'Available'),
(2, 1, 'Borrowed'),
(3, 2, 'Available'),
(4, 3, 'Available'),
(5, 4, 'Reserved'),
(6, 5, 'Available'),
(7, 6, 'Borrowed'),
(8, 7, 'Available'),
(9, 8, 'Available'),
(10, 9, 'Available');


-- 4. Borrowings

INSERT INTO "borrowings" ("borrowingID", "memberID", "bookID", "borrowingDate", "dueDate", "returnDate") VALUES
(1, 1, 2, '2024-03-01', '2024-03-15', '2024-03-14'),
(2, 3, 5, '2024-03-05', '2024-03-19', NULL),
(3, 4, 1, '2024-03-10', '2024-03-24', '2024-03-23'),
(4, 6, 3, '2024-03-12', '2024-03-26', NULL),
(5, 2, 4, '2024-03-15', '2024-03-29', '2024-03-28'),
(6, 7, 7, '2024-03-17', '2024-03-31', NULL),
(7, 5, 6, '2024-03-20', '2024-04-03', '2024-04-01'),
(8, 9, 8, '2024-03-22', '2024-04-05', NULL),
(9, 10, 9, '2024-03-25', '2024-04-08', NULL),
(10, 8, 10, '2024-03-27', '2024-04-10', '2024-04-09');


-- 5. Reservations

INSERT INTO "reservations" ("reservationID", "memberID", "bookID", "reservationDate", "status") VALUES
(1, 2, 3, '2024-04-01', 'Active'),
(2, 4, 2, '2024-04-02', 'Active'),
(3, 5, 4, '2024-04-03', 'Cancelled'),
(4, 6, 1, '2024-04-04', 'Active'),
(5, 7, 5, '2024-04-05', 'Active'),
(6, 8, 6, '2024-04-06', 'Active'),
(7, 9, 7, '2024-04-07', 'Active'),
(8, 1, 8, '2024-04-08', 'Active'),
(9, 3, 9, '2024-04-09', 'Active'),
(10, 10, 10, '2024-04-10', 'Expired');


-- 6. Reviews

INSERT INTO "reviews" ("reviewID", "memberID", "bookID", "reviewText", "rating") VALUES
(1, 1, 1, 'A classic masterpiece.', 5),
(2, 2, 2, 'Very insightful and emotional.', 4),
(3, 3, 3, 'Still relevant today.', 5),
(4, 4, 4, 'Loved the fantasy elements.', 4),
(5, 5, 5, 'Well-written but not my taste.', 3),
(6, 6, 6, 'A compelling story.', 5),
(7, 7, 7, 'Very motivating.', 4),
(8, 8, 8, 'Challenging but worth it.', 4),
(9, 9, 9, 'A thrilling read!', 5),
(10, 10, 10, 'Dark and gripping.', 4);


-- 7. ReadingHistory

INSERT INTO "readingHistory" ("historyID", "memberID", "bookID", "startDate", "endDate") VALUES
(1, 1, 1, '2024-02-01', '2024-02-15'),
(2, 2, 2, '2024-02-10', '2024-02-20'),
(3, 3, 3, '2024-02-12', '2024-02-25'),
(4, 4, 4, '2024-03-01', '2024-03-10'),
(5, 5, 5, '2024-03-05', '2024-03-15'),
(6, 6, 6, '2024-03-10', '2024-03-20'),
(7, 7, 7, '2024-03-15', NULL),
(8, 8, 8, '2024-03-20', '2024-03-30'),
(9, 9, 9, '2024-03-25', NULL),
(10, 10, 10, '2024-04-01', '2024-04-10');



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
