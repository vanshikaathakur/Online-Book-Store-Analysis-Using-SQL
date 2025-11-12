DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

SELECT * FROM Books;

DROP TABLE IF EXISTS customers;

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

SELECT * FROM Customers;

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Orders;




-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books WHERE Genre = 'Fiction' ;


-- 2) Find books published after the year 1950:
SELECT * FROM Books WHERE published_year > 1950 ; 

-- 3) List all customers from the Canada:
SELECT * FROM Customers WHERE country = 'Canada' ;

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders WHERE order_date::text LIKE '2023-11%';

-- 5) Retrieve the total stock of books available:
SELECT SUM(STOCK) FROM Books;

-- 6) Find the details of the most expensive book:
SELECT *
FROM books
WHERE price = (
    
    SELECT MAX(price) FROM books
);

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Cutomers JOIN Orders ON Customers.customer_id = Orders.order_id Where quantity > 1 ;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders WHERE total_amount > 20 ;

-- 9) List all genres available in the Books table:
SELECT DISTINCT Genre FROM Books ;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books WHERE Stock =(
                  SELECT MIN(STOCK) FROM BOOKS
				  )
         

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(price) as total_revenue FROM Orders;


-- 12) Retrieve the total number of books sold for each genre:
SELECT Books.genre, SUM(Orders.quantity) AS total_quantity FROM Books JOIN Orders ON Books.book_id = Orders.book_id GROUP BY Books.genre;

-- 13) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) FROM Books WHERE genre = 'Fantasy' ; 


-- 14) List customers who have placed at least 2 orders:
Select Customers.name , orders.quantity FROM Customers JOIN Orders ON Customers.customer_id = Orders.customer_id WHERE Orders.quantity >= 2;

-- 15) Find the most frequently ordered book:
SELECT Books.book_id,Books.title,count(Orders.order_id) as order_count FROM Books JOIN Orders ON Books.book_id = Orders.book_id GROUP BY Books.book_id,Books.title ORDER BY order_count DESC LIMIT 1;  

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT book_id, title, genre, price
FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;


-- 17) Retrieve the total quantity of books sold by each author:
SELECT Books.author , SUM(Orders.quantity) FROM Books JOIN Orders ON Books.book_id = Orders.book_id GROUP BY Books.author;

-- 18) List the cities where customers who spent over $30 are located:
SELECT Customers.city, Orders.total_amount
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
WHERE Orders.total_amount > 30;

-- 19) Find the customer who spent the most on orders:
SELECT Customers.name, SUM(Orders.total_amount) AS total_spent
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
GROUP BY Customers.name
ORDER BY total_spent DESC;


-- 20) Calculate the stock remaining after fulfilling all orders:
SELECT 
    Books.title,
    Books.stock,
    SUM(Orders.quantity) AS total_ordered,
    (Books.stock - SUM(Orders.quantity)) AS remaining_stocks
FROM Books
JOIN Orders ON Books.book_id = Orders.book_id
GROUP BY Books.title, Books.stock;





