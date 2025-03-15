create database librarydbs
use librarydbs

CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(100),
    address TEXT
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    author_id INT,
    publisher_id INT,
    category_id INT,
    isbn VARCHAR(13) UNIQUE,
    publish_date DATE,
    available_copies INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
    );

CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(15),
    membership_date DATE,
    address TEXT
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(15)
);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
SELECT title, available_copies FROM Books WHERE available_copies > 0;
SELECT B.title, T.borrow_date, T.return_date
FROM Transactions T
JOIN Books B ON T.book_id = B.book_id
WHERE T.member_id = 1;  -- Replace 1 with the actual member_id

SELECT B.title, M.first_name, M.last_name
FROM Transactions T
JOIN Books B ON T.book_id = B.book_id
JOIN Members M ON T.member_id = M.member_id
WHERE T.return_date IS NULL AND T.borrow_date < CURDATE() - INTERVAL 30 DAY;




