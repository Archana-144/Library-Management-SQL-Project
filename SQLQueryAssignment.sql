


SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

CREATE DATABASE Library_db;

USE Library_db;


CREATE TABLE mst_Author(
    author_id INT PRIMARY KEY IDENTITY(1,1),
    author_name VARCHAR(100) NOT NULL UNIQUE,

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);


CREATE TABLE mst_Category(
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(100) NOT NULL UNIQUE,

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);


CREATE TABLE mst_Book(
    book_id INT PRIMARY KEY IDENTITY(1,1),

    book_title VARCHAR(150) NOT NULL,

    author_id INT,
    category_id INT,

    published_year INT,

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    FOREIGN KEY(author_id)
    REFERENCES mst_Author(author_id),

    FOREIGN KEY(category_id)
    REFERENCES mst_Category(category_id)
);

CREATE TABLE mst_Librarian(
    librarian_id INT PRIMARY KEY IDENTITY(1,1),

    librarian_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);


CREATE TABLE tbl_Member(
    member_id INT PRIMARY KEY IDENTITY(1,1),

    member_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),

    membership_type VARCHAR(50),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);


CREATE TABLE tbl_BorrowTransaction(
    borrow_id INT PRIMARY KEY IDENTITY(1,1),

    member_id INT,
    book_id INT,
    librarian_id INT,

    borrow_date DATE,
    return_date DATE,

    fine_amount DECIMAL(10,2),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    FOREIGN KEY(member_id)
    REFERENCES tbl_Member(member_id),

    FOREIGN KEY(book_id)
    REFERENCES mst_Book(book_id),

    FOREIGN KEY(librarian_id)
    REFERENCES mst_Librarian(librarian_id)
);

CREATE TABLE tbl_FinePayment(
    payment_id INT PRIMARY KEY IDENTITY(1,1),

    borrow_id INT,
    payment_amount DECIMAL(10,2),

    payment_date DATE,
    payment_status VARCHAR(50),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    FOREIGN KEY(borrow_id)
    REFERENCES tbl_BorrowTransaction(borrow_id)
);


CREATE TABLE tbl_ErrorLog(
    errorlog_id INT PRIMARY KEY IDENTITY(1,1),

    error_message VARCHAR(500),
    error_procedure VARCHAR(100),
    error_line INT,

    error_date DATETIME DEFAULT GETDATE()
);


INSERT INTO mst_Author
(author_name,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('James Clear',GETDATE(),'admin',GETDATE(),'admin',1),

('Robert Martin',GETDATE(),'admin',GETDATE(),'admin',1),

('Yuval Noah Harari',GETDATE(),'admin',GETDATE(),'admin',1),

('John Zelle',GETDATE(),'admin',GETDATE(),'admin',1),

('Jay Shetty',GETDATE(),'admin',GETDATE(),'admin',1);


INSERT INTO mst_Category
(category_name,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Self Help',GETDATE(),'admin',GETDATE(),'admin',1),

('Programming',GETDATE(),'admin',GETDATE(),'admin',1),

('History',GETDATE(),'admin',GETDATE(),'admin',1),

('Motivation',GETDATE(),'admin',GETDATE(),'admin',1);


INSERT INTO mst_Book
(book_title,author_id,category_id,published_year,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Atomic Habits',1,1,2018,GETDATE(),'admin',GETDATE(),'admin',1),

('Clean Code',2,2,2008,GETDATE(),'admin',GETDATE(),'admin',1),

('Sapiens',3,3,2011,GETDATE(),'admin',GETDATE(),'admin',1),

('Python Basics',4,2,2015,GETDATE(),'admin',GETDATE(),'admin',1),

('Think Like a Monk',5,4,2020,GETDATE(),'admin',GETDATE(),'admin',1);

INSERT INTO mst_Librarian
(librarian_name,email,phone,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Ramesh','ramesh@gmail.com','9876541111',GETDATE(),'admin',GETDATE(),'admin',1),

('Priya','priya@gmail.com','9988771111',GETDATE(),'admin',GETDATE(),'admin',1),

('Kiran','kiran@gmail.com','9123451111',GETDATE(),'admin',GETDATE(),'admin',1),

('Anita','anita@gmail.com','9000001111',GETDATE(),'admin',GETDATE(),'admin',1),

('Suresh','suresh@gmail.com','9888881111',GETDATE(),'admin',GETDATE(),'admin',1);


INSERT INTO tbl_Member
(member_name,email,phone,membership_type,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Archana','archana@gmail.com','9876543210','Premium',GETDATE(),'admin',GETDATE(),'admin',1),

('Rahul','rahul@gmail.com','9876501234','Standard',GETDATE(),'admin',GETDATE(),'admin',1),

('Ahan','ahan@gmail.com','9123456780','Standard',GETDATE(),'admin',GETDATE(),'admin',1),

('Kavya','kavya@gmail.com','9000011111','Premium',GETDATE(),'admin',GETDATE(),'admin',1),

('Sneha','sneha@gmail.com','9988776655','Student',GETDATE(),'admin',GETDATE(),'admin',1);


INSERT INTO tbl_BorrowTransaction
(member_id,book_id,librarian_id,borrow_date,return_date,fine_amount,created_on,created_by,updated_on,updated_by,is_active)
VALUES
(1,1,1,'2026-05-01','2026-05-10',0,GETDATE(),'admin',GETDATE(),'admin',1),

(2,2,2,'2026-05-03','2026-05-12',20,GETDATE(),'admin',GETDATE(),'admin',1),

(3,3,3,'2026-05-05','2026-05-15',10,GETDATE(),'admin',GETDATE(),'admin',1),

(4,4,4,'2026-05-07','2026-05-18',0,GETDATE(),'admin',GETDATE(),'admin',1),

(5,5,5,'2026-05-09','2026-05-20',15,GETDATE(),'admin',GETDATE(),'admin',1);


INSERT INTO tbl_FinePayment
(borrow_id,payment_amount,payment_date,payment_status,created_on,created_by,updated_on,updated_by,is_active)
VALUES
(1,50,'2026-05-15','Paid',GETDATE(),'admin',GETDATE(),'admin',1),

(2,20,'2026-05-16','Paid',GETDATE(),'admin',GETDATE(),'admin',1),

(3,10,'2026-05-17','Pending',GETDATE(),'admin',GETDATE(),'admin',1),

(4,0,'2026-05-18','No Fine',GETDATE(),'admin',GETDATE(),'admin',1),

(5,15,'2026-05-19','Paid',GETDATE(),'admin',GETDATE(),'admin',1);


SELECT
m.member_name,
b.book_title,
a.author_name,
c.category_name,
l.librarian_name,
bt.borrow_date,
bt.return_date

FROM tbl_BorrowTransaction bt

INNER JOIN tbl_Member m
ON bt.member_id = m.member_id

INNER JOIN mst_Book b
ON bt.book_id = b.book_id

INNER JOIN mst_Author a
ON b.author_id = a.author_id

INNER JOIN mst_Category c
ON b.category_id = c.category_id

INNER JOIN mst_Librarian l
ON bt.librarian_id = l.librarian_id;

SELECT
m.member_name,
bt.borrow_date

FROM tbl_Member m

LEFT JOIN tbl_BorrowTransaction bt
ON m.member_id = bt.member_id;


SELECT
m.member_name,
bt.borrow_date

FROM tbl_Member m

RIGHT JOIN tbl_BorrowTransaction bt
ON m.member_id = bt.member_id;


SELECT
m.member_name,
bt.borrow_date

FROM tbl_Member m

FULL JOIN tbl_BorrowTransaction bt
ON m.member_id = bt.member_id;


SELECT
A.librarian_name AS Librarian1,
B.librarian_name AS Librarian2

FROM mst_Librarian A,
mst_Librarian B

WHERE A.librarian_id <> B.librarian_id;

SELECT
m.member_name,
c.category_name

FROM tbl_Member m

CROSS JOIN mst_Category c;


CREATE PROCEDURE usp_GetBorrowDetails
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
    m.member_name,
    b.book_title,
    l.librarian_name,
    bt.borrow_date,
    bt.return_date

    FROM tbl_BorrowTransaction bt

    INNER JOIN tbl_Member m
    ON bt.member_id = m.member_id

    INNER JOIN mst_Book b
    ON bt.book_id = b.book_id

    INNER JOIN mst_Librarian l
    ON bt.librarian_id = l.librarian_id;

END;

EXEC usp_GetBorrowDetails;

CREATE PROCEDURE usp_GetFineDetails
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
    bt.borrow_id,
    fp.payment_amount,
    fp.payment_status

    FROM tbl_FinePayment fp

    INNER JOIN tbl_BorrowTransaction bt
    ON fp.borrow_id = bt.borrow_id;

END;


EXEC usp_GetFineDetails;

CREATE PROCEDURE usp_SearchMember
    @MemberName VARCHAR(100)

AS
BEGIN

    SET NOCOUNT ON;

    SELECT
    member_id,
    member_name,
    email,
    membership_type

    FROM tbl_Member

    WHERE member_name = @MemberName;

END;

EXEC usp_SearchMember 'Sneha';



CREATE TYPE udt_MemberType AS TABLE
(
    member_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    membership_type VARCHAR(50)
);


CREATE PROCEDURE usp_InsertMembers
(
    @MemberData udt_MemberType READONLY
)

AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO tbl_Member
    (
        member_name,
        email,
        phone,
        membership_type,
        created_on,
        created_by,
        updated_on,
        updated_by,
        is_active
    )

    SELECT
        member_name,
        email,
        phone,
        membership_type,
        GETDATE(),
        'admin',
        GETDATE(),
        'admin',
        1

    FROM @MemberData;

END;


SELECT
member_id,
member_name,
email,
membership_type

FROM tbl_Member;


CREATE PROCEDURE usp_InsertBorrowTransaction

    @member_id INT,
    @book_id INT,
    @librarian_id INT,
    @borrow_date DATE,
    @return_date DATE,
    @fine_amount DECIMAL(10,2)

AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO tbl_BorrowTransaction
        (
            member_id,
            book_id,
            librarian_id,
            borrow_date,
            return_date,
            fine_amount,
            created_on,
            created_by,
            updated_on,
            updated_by,
            is_active
        )

        VALUES
        (
            @member_id,
            @book_id,
            @librarian_id,
            @borrow_date,
            @return_date,
            @fine_amount,
            GETDATE(),
            'admin',
            GETDATE(),
            'admin',
            1
        );

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        INSERT INTO tbl_ErrorLog
        (
            error_message,
            error_procedure,
            error_line,
            error_date
        )

        VALUES
        (
            ERROR_MESSAGE(),
            ERROR_PROCEDURE(),
            ERROR_LINE(),
            GETDATE()
        );

    END CATCH

END;



EXEC usp_InsertBorrowTransaction
    1,
    1,
    1,
    '2026-06-01',
    '2026-06-10',
    0;


    SELECT
borrow_id,
member_id,
book_id,
borrow_date

FROM tbl_BorrowTransaction;

SELECT
error_message,
error_procedure,
error_line,
error_date

FROM tbl_ErrorLog;


SELECT
m.member_name,
b.book_title,
a.author_name,
c.category_name,
l.librarian_name,
bt.borrow_date,
bt.return_date,
fp.payment_amount,
fp.payment_status

FROM tbl_BorrowTransaction bt

INNER JOIN tbl_Member m
ON bt.member_id = m.member_id

INNER JOIN mst_Book b
ON bt.book_id = b.book_id

INNER JOIN mst_Author a
ON b.author_id = a.author_id

INNER JOIN mst_Category c
ON b.category_id = c.category_id

INNER JOIN mst_Librarian l
ON bt.librarian_id = l.librarian_id

LEFT JOIN tbl_FinePayment fp
ON bt.borrow_id = fp.borrow_id;