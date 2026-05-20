use library_db
create table Members_Master(
member_id int primary key identity(1,1),
member_name varchar(100) not null,
email varchar(100) not null unique,
phone varchar(15) not null,
membership_type varchar(50) not null,

created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);

create table Borrow_Transactions(
borrow_id int primary key identity(1,1),
member_id int not null,
book_title varchar(255) not null,
borrow_date datetime not null,
return_date datetime,
fine_amount decimal(10, 2),


created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT


     FOREIGN KEY(member_id)
    REFERENCES Members_Master(member_id)
    );

INSERT INTO Members_Master(
member_name,email,phone,membership_type,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Archana','archana@gmail.com','9876543210','Premium',GETDATE(),'admin',GETDATE(),'admin',1);

INSERT INTO Members_Master(
member_name,email,phone,membership_type,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Rahul','rahul@gmail.com','9876501234','Standard',GETDATE(),'admin',GETDATE(),'admin',1);

INSERT INTO Members_Master(
member_name,email,phone,membership_type,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Ahan','ahan@gmail.com','9123456780','Standard',GETDATE(),'admin',GETDATE(),'admin',1);

INSERT INTO Members_Master(
member_name,email,phone,membership_type,created_on,created_by,updated_on,updated_by,is_active)
VALUES
('Kavya','kavya@gmail.com','9000011111','Premium',GETDATE(),'admin',GETDATE(),'admin',1);

select * from Members_Master;
 


INSERT INTO Borrow_Transactions
(member_id, book_title, borrow_date, return_date, fine_amount, created_on, created_by, updated_on, updated_by, is_active)
VALUES
(1, 'Python Programming', '2026-05-01', '2026-05-10', 0.00, GETDATE(), 'admin', GETDATE(), 'admin', 1);

INSERT INTO Borrow_Transactions
(member_id, book_title, borrow_date, return_date, fine_amount, created_on, created_by, updated_on, updated_by, is_active)
VALUES
( 2,'Database Management Systems', '2026-05-03', '2026-05-12', 20.00, GETDATE(), 'admin', GETDATE(), 'admin', 1);


INSERT INTO Borrow_Transactions
(member_id, book_title, borrow_date, return_date, fine_amount, created_on, created_by, updated_on, updated_by, is_active)
VALUES
(3,'Data Science Basics', '2026-05-05', '2026-05-15', 10.00, GETDATE(), 'admin', GETDATE(), 'admin', 1);


INSERT INTO Borrow_Transactions
(member_id, book_title, borrow_date, return_date, fine_amount, created_on, created_by, updated_on, updated_by, is_active)
VALUES
(4,'Machine Learning Guide', '2026-05-07', '2026-05-18', 0.00, GETDATE(), 'admin', GETDATE(), 'admin', 1);


INSERT INTO Borrow_Transactions
(member_id, book_title, borrow_date, return_date, fine_amount, created_on, created_by, updated_on, updated_by, is_active)
VALUES
(5,'Artificial Intelligence', '2026-05-10', '2026-05-20', 5.00, GETDATE(), 'admin', GETDATE(), 'admin', 1);

 
select * from Borrow_Transactions;
TRUNCATE TABLE Borrow_Transactions;
DBCC CHECKIDENT ('Borrow_Transactions', RESEED, 1);
 
 -- Query to retrieve all borrow transactions with a fine amount greater than 0
SELECT * FROM Borrow_Transactions
WHERE fine_amount > 0 AND is_active=1;


-- Query to retrieve all active members with a premium membership type
SELECT * FROM Members_Master
WHERE membership_type = 'Premium'
AND is_active = 1;

-- Query to retrieve all borrow transactions for a specific member (e.g., member_id = 1)
SELECT * FROM Borrow_Transactions
WHERE fine_amount > 10
OR book_title = 'Python Programming';

-- Query to retrieve all members whose names start with 'K'
SELECT * FROM Members_Master
WHERE member_name LIKE 'K%';

-- Query to retrieve all borrow transactions ordered by fine amount in descending order
SELECT * FROM Borrow_Transactions
ORDER BY fine_amount DESC;


-- Query to update the fine amount for a specific borrow transaction 
UPDATE Borrow_Transactions
SET fine_amount = 50,
updated_on = GETDATE(),
updated_by = 'admin'
WHERE borrow_id = 1;

 -- Query to delete a specific borrow transaction 
DELETE FROM Borrow_Transactions
WHERE borrow_id = 5;

 -- Query to insert a new borrow transaction for a member 
insert into Borrow_Transactions
(member_id, book_title, borrow_date, return_date, fine_amount, created_on, created_by, updated_on, updated_by, is_active)
values
(1, 'Python Programming', '2026-05-01', '2026-05-10', 0.00, GETDATE(), 'admin', GETDATE(), 'admin', 1);



 SELECT * FROM INFORMATION_SCHEMA.TABLES;

 SELECT DB_NAME();

 update Borrow_Transactions
 set book_title  = 'pythonbasics'
 where member_id=3 And
 updated_on =GETDATE() And ;




 insert into Members_Master
 (member_name,email,phone,membership_type,created_on,created_by,updated_on,updated_by,is_active)
 values('kavi','kavi@gmail.com',9731349351,'premium',GETDATE(),'admin',GETDATE(),'admin' ,1);

 delete from Members_Master
 where member_name='manoj';

 delete from Members_Master
 where member_name='kavi';


 update  Members_Master
 set is_active=0
 where member_name='kavi';

 select * from  Members_Master;




