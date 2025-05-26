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



ALTER TABLE "borrowings" ADD CONSTRAINT "borrowings_fk1" FOREIGN KEY ("memberID") REFERENCES "members"("memberID");

ALTER TABLE "borrowings" ADD CONSTRAINT "borrowings_fk2" FOREIGN KEY ("bookID") REFERENCES "books"("bookId");
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_fk1" FOREIGN KEY ("memberID") REFERENCES "members"("memberID");

ALTER TABLE "reviews" ADD CONSTRAINT "reviews_fk2" FOREIGN KEY ("bookID") REFERENCES "books"("bookId");
ALTER TABLE "reservations" ADD CONSTRAINT "reservations_fk1" FOREIGN KEY ("memberID") REFERENCES "members"("memberID");

ALTER TABLE "reservations" ADD CONSTRAINT "reservations_fk2" FOREIGN KEY ("bookID") REFERENCES "books"("bookId");
ALTER TABLE "bookCopies" ADD CONSTRAINT "bookCopies_fk1" FOREIGN KEY ("bookID") REFERENCES "books"("bookId");
ALTER TABLE "readingHistory" ADD CONSTRAINT "readingHistory_fk1" FOREIGN KEY ("memberID") REFERENCES "members"("memberID");

ALTER TABLE "readingHistory" ADD CONSTRAINT "readingHistory_fk2" FOREIGN KEY ("bookID") REFERENCES "books"("bookId");