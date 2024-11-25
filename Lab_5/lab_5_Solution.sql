create database lab_5;

use lab_5;

CREATE TABLE PUBLISHER (
    Name VARCHAR(100) PRIMARY KEY,
    Address VARCHAR(200),
    Phone VARCHAR(15)
);

CREATE TABLE BOOK (
    BookId VARCHAR(20) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    PublisherName VARCHAR(100) NOT NULL,
    FOREIGN KEY (PublisherName) REFERENCES PUBLISHER(Name)
);

CREATE TABLE BOOK_AUTHORS (
    BookId VARCHAR(20),
    AuthorName VARCHAR(100) NOT NULL,
    PRIMARY KEY (BookId, AuthorName),
    FOREIGN KEY (BookId) REFERENCES BOOK(BookId)
);

CREATE TABLE LIBRARY_BRANCH (
    BranchId VARCHAR(20) PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

CREATE TABLE BOOK_COPIES (
    BookId VARCHAR(20),
    BranchId VARCHAR(20),
    No_Of_Copies INT NOT NULL,
    PRIMARY KEY (BookId, BranchId),
    FOREIGN KEY (BookId) REFERENCES BOOK(BookId),
    FOREIGN KEY (BranchId) REFERENCES LIBRARY_BRANCH(BranchId)
);

CREATE TABLE BORROWER (
    CardNo VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200),
    Phone VARCHAR(15)
);

CREATE TABLE BOOK_LOAN (
    BookId VARCHAR(20),
    BranchId VARCHAR(20),
    CardNo VARCHAR(20),
    DateOut DATE NOT NULL,
    DueDate DATE NOT NULL,
    PRIMARY KEY (BookId, BranchId, CardNo),
    FOREIGN KEY (BookId) REFERENCES BOOK(BookId),
    FOREIGN KEY (BranchId) REFERENCES LIBRARY_BRANCH(BranchId),
    FOREIGN KEY (CardNo) REFERENCES BORROWER(CardNo)
);

INSERT INTO PUBLISHER (Name, Address, Phone) VALUES
('PHI', '20 Delhi Super Market', '01715-454678'),
('Tata', 'North Kolkata', '0156-2345445'),
('Galgotia', 'Mumbai', '0192-203490');


INSERT INTO BOOK (BookId, Title, PublisherName) VALUES
('100.001cn', 'Computer Network', 'PHI'),
('100.002dsc', 'Database System', 'Tata'),
('100.003ds', 'Digital System', 'PHI'),
('100.004db', 'DBMS', 'PHI'),
('100.005ora', 'Oracle 2000', 'Galgotia');

INSERT INTO BOOK_AUTHORS (BookId, AuthorName) VALUES
('100.001cn', 'A S Tanenbaum'),
('100.002dsc', 'Silberschatz'),
('100.003ds', 'Ronald J Tocci'),
('100.004db', 'Ivan BayRoss'),
('100.005ora', 'Ivan BayRoss');

INSERT INTO LIBRARY_BRANCH (BranchId, BranchName, Address) VALUES
(1001, 'CSE Seminar Library', 'Rajshahi'),
(1002, 'RU Central Library', 'Rajshahi'),
(1003, 'DU Central Library', 'Dhaka');

INSERT INTO BOOK_COPIES (BookId, BranchId, No_Of_Copies) VALUES
('100.001cn', 1001, 2),
('100.001cn', 1002, 5),
('100.002dsc', 1001, 3),
('100.002dsc', 1002, 4),
('100.003ds', 1001, 3),
('100.003ds', 1003, 5),
('100.004db', 1001, 2),
('100.004db', 1002, 5),
('100.005ora', 1001, 2),
('100.005ora', 1002, 7);

INSERT INTO BORROWER (CardNo, Name, Address, Phone) VALUES
(10001, 'Saidur', 'CSE', '01714-400567'),
(10002, 'Rafiq', 'PHYSICS', '0194-300456'),
(10003, 'Masud', 'CSE', '0156-345678'),
(10004, 'Nobir', 'ICT', '01199-203456');

INSERT INTO BOOK_LOAN (BookId, BranchId, CardNo, DateOut, DueDate) VALUES
('100.001cn', 1001, 10001, '2015-01-15', '2015-02-15'),
('100.001cn', 1002, 10002, '2015-01-25', '2015-02-25'),
('100.002dsc', 1001, 10003, '2015-02-20', '2015-03-20'),
('100.002dsc', 1002, 10004, '2015-03-15', '2015-04-15'),
('100.003ds', 1001, 10001, '2015-06-07', '2015-07-07'),
('100.003ds', 1003, 10002, '2015-10-15', '2015-11-15'),
('100.004db', 1001, 10003, '2015-10-25', '2015-11-25'),
('100.004db', 1002, 10004, '2015-11-15', '2015-12-15'),
('100.005ora', 1001, 10003, '2015-12-22', '2016-01-22'),
('100.005ora', 1002, 10001, '2015-12-25', '2016-01-25');

-- How many copies of the book titled DBMS are owned by the library branch named "CSE Seminar Library"?
select sum(bc.no_of_copies)
from book_copies as bc
natural join book as b
natural join library_branch as lb
where lb.branchname = 'cse Seminar Library' and b.title = 'DBMS';

-- How many copies of the book titled DBMS are owned by each library branch?
select lb.branchname,bc.no_of_copies
from book_copies as bc
natural join book as b
natural join library_branch as lb
where b.title = 'dbms';

-- How many copies of the book titled DBMS are owned by each library branch?(alternative)
SELECT lb.BranchName, SUM(bc.No_Of_Copies)
FROM BOOK b
JOIN BOOK_COPIES bc ON b.BookId = bc.BookId
JOIN LIBRARY_BRANCH lb ON bc.BranchId = lb.BranchId
WHERE b.Title = 'DBMS'
GROUP BY lb.BranchName;

-- Retrieve the names of all borrowers who do not have any books checked out.
SELECT br.Name
FROM BORROWER br
LEFT JOIN BOOK_LOAN bl ON br.CardNo = bl.CardNo
WHERE bl.CardNo IS NULL;

-- alternative
select name
from borrower
where cardno not in (
	select cardno
    from book_loan
);

-- For each book loaned out from the CSE Seminar Library branch and due today, retrieve the book title, borrower's name, and address.
SELECT b.Title, br.Name, br.Address
FROM BOOK_LOAN bl
JOIN BOOK b ON bl.BookId = b.BookId
JOIN BORROWER br ON bl.CardNo = br.CardNo
JOIN LIBRARY_BRANCH lb ON bl.BranchId = lb.BranchId
WHERE lb.BranchName = 'CSE Seminar Library' AND bl.DueDate = '2015-02-15';

-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
select lb.branchname,sum(bc.no_of_copies)
from library_branch as lb
natural join book_copies as bc
group by lb.branchName;

-- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than two books checked out.
select br.name,br.address,br.phone
from borrower as br 
natural join book_loan as bl
group by bl.cardno
having count(bl.cardno)>2;
 
--  For each book authored by Ivan BayRoss, retrieve the title and the number of copies owned by the "RU Central Library" branch.
SELECT b.Title, SUM(bc.No_Of_Copies)
FROM BOOK b
JOIN BOOK_AUTHORS ba ON b.BookId = ba.BookId
JOIN BOOK_COPIES bc ON b.BookId = bc.BookId
JOIN LIBRARY_BRANCH lb ON bc.BranchId = lb.BranchId
WHERE ba.AuthorName = 'Ivan BayRoss' AND lb.BranchName = 'RU Central Library'
GROUP BY b.Title;
