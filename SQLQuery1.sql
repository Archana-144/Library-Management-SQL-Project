CREATE DATABASE Digital_Library_DB;
USE Digital_Library_DB;

CREATE TABLE Members_Master(
    member_id INT PRIMARY KEY IDENTITY(1,1),
    member_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    membership_type VARCHAR(50),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);

CREATE TABLE Books_Master(
    book_id INT PRIMARY KEY IDENTITY(1,1),
    book_title VARCHAR(100) NOT NULL,
    author_name VARCHAR(100),
    category VARCHAR(50),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);

CREATE TABLE Librarian_Master(
    librarian_id INT PRIMARY KEY IDENTITY(1,1),
    librarian_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);

CREATE TABLE Borrow_Transactions(
    borrow_id INT PRIMARY KEY IDENTITY(1,1),

    member_id INT,
    book_id INT,
    librarian_id INT,

    book_title VARCHAR(100),

    borrow_date DATE,
    return_date DATE,
    fine_amount DECIMAL(10,2),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    FOREIGN KEY(member_id)
    REFERENCES Members_Master(member_id),

    FOREIGN KEY(book_id)
    REFERENCES Books_Master(book_id),

    FOREIGN KEY(librarian_id)
    REFERENCES Librarian_Master(librarian_id)
);

CREATE TABLE Fine_Payment(
    payment_id INT PRIMARY KEY IDENTITY(1,1),

    borrow_id INT,
    member_id INT,

    payment_amount DECIMAL(10,2),
    payment_date DATE,

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    FOREIGN KEY(borrow_id)
    REFERENCES Borrow_Transactions(borrow_id),

    FOREIGN KEY(member_id)
    REFERENCES Members_Master(member_id)
);

INSERT INTO Members_Master
(member_name,email,phone,membership_type,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Archana','archana@gmail.com','9876543210','Premium',GETDATE(),'admin',GETDATE(),'admin',1),

('Rahul','rahul@gmail.com','9876501234','Standard',GETDATE(),'admin',GETDATE(),'admin',1),

('Ahan','ahan@gmail.com','9123456780','Standard',GETDATE(),'admin',GETDATE(),'admin',1),

('Kavya','kavya@gmail.com','9000011111','Premium',GETDATE(),'admin',GETDATE(),'admin',1),

('Sneha','sneha@gmail.com','9988776655','Student',GETDATE(),'admin',GETDATE(),'admin',1);


INSERT INTO Books_Master
(book_title,author_name,category,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Atomic Habits','James Clear','Self Help',GETDATE(),'admin',GETDATE(),'admin',1),

('Clean Code','Robert Martin','Programming',GETDATE(),'admin',GETDATE(),'admin',1),

('Sapiens','Yuval Noah Harari','History',GETDATE(),'admin',GETDATE(),'admin',1),

('Python Basics','John Zelle','Programming',GETDATE(),'admin',GETDATE(),'admin',1),

('Think Like a Monk','Jay Shetty','Motivation',GETDATE(),'admin',GETDATE(),'admin',1);

INSERT INTO Librarian_Master
(librarian_name,email,phone,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Ramesh','ramesh@gmail.com','9876541111',GETDATE(),'admin',GETDATE(),'admin',1),

('Priya','priya@gmail.com','9988771111',GETDATE(),'admin',GETDATE(),'admin',1),

('Kiran','kiran@gmail.com','9123451111',GETDATE(),'admin',GETDATE(),'admin',1),

('Anita','anita@gmail.com','9000001111',GETDATE(),'admin',GETDATE(),'admin',1),

('Suresh','suresh@gmail.com','9888881111',GETDATE(),'admin',GETDATE(),'admin',1);

INSERT INTO Borrow_Transactions
(member_id,book_id,librarian_id,book_title,borrow_date,return_date,fine_amount,created_on,created_by,updated_on,updated_by,is_active)
VALUES
(1,1,1,'Atomic Habits','2026-05-01','2026-05-10',0,GETDATE(),'admin',GETDATE(),'admin',1),

(2,2,2,'Clean Code','2026-05-03','2026-05-12',20,GETDATE(),'admin',GETDATE(),'admin',1),

(3,3,3,'Sapiens','2026-05-05','2026-05-15',10,GETDATE(),'admin',GETDATE(),'admin',1),

(4,4,4,'Python Basics','2026-05-07','2026-05-18',0,GETDATE(),'admin',GETDATE(),'admin',1),

(5,5,5,'Think Like a Monk','2026-05-09','2026-05-20',15,GETDATE(),'admin',GETDATE(),'admin',1);


INSERT INTO Fine_Payment
(borrow_id,member_id,payment_amount,payment_date,created_on,created_by,updated_on,updated_by,is_active)
VALUES
(1,1,50,'2026-05-15',GETDATE(),'admin',GETDATE(),'admin',1),

(2,2,20,'2026-05-16',GETDATE(),'admin',GETDATE(),'admin',1),

(3,3,10,'2026-05-17',GETDATE(),'admin',GETDATE(),'admin',1),

(4,4,0,'2026-05-18',GETDATE(),'admin',GETDATE(),'admin',1),

(5,5,5,'2026-05-19',GETDATE(),'admin',GETDATE(),'admin',1);

SELECT
m.member_name,
b.book_title,
b.author_name,
l.librarian_name,
bt.borrow_date,
bt.return_date,
bt.fine_amount,
fp.payment_amount

FROM Members_Master m

JOIN Borrow_Transactions bt
ON m.member_id = bt.member_id

JOIN Books_Master b
ON bt.book_id = b.book_id

JOIN Librarian_Master l
ON bt.librarian_id = l.librarian_id

JOIN Fine_Payment fp
ON bt.borrow_id = fp.borrow_id;


SELECT * FROM Members_Master;

SELECT * FROM Books_Master;

SELECT * FROM Librarian_Master;

SELECT * FROM Borrow_Transactions;

SELECT * FROM Fine_Payment;

SELECT * from members_master
where member_id=(select member_id from fine_payment
where payment_amount>20);


select b. book_title,m. member_name
from Members_Master m
join borrow_transactions bt on m.member_id=bt.member_id
JOIN Books_Master b
ON bt.book_id = b.book_id
where member_name='Sneha';


select l.librarian_name ,b.book_title bt  from Borrow_Transactions bt
join Librarian_Master l on bt.librarian_id=l.librarian_id
join Books_Master b on bt.book_id=b.book_id
where borrow_date='2026-05-01';

select * 
from Borrow_Transactions B
join Members_Master M on M.member_id =B.member_id;


CREATE PROCEDURE usp_GetBooksById
    @BookId INT
AS
BEGIN
    Select * from Books_Master WHERE is_active=1 AND book_id=@BookId;
END

EXEC usp_GetBooksById 1;



ALTER PROCEDURE usp_GetmembersBYname
    @member_name VARCHAR(100)
AS
BEGIN
    Select * from Members_Master WHERE is_active=1 and member_name=   @member_name ;
END;

EXEC usp_GetmembersBYname VARCHAR(100) ;
