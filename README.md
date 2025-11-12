# 📚 Online Book Store Data Analysis (SQL Project)

## Project Overview

This repository contains an SQL-based data analysis project focused on an **Online Book Store**. The goal of this project is to model a simplified e-commerce database structure (Books, Customers, and Orders) and then use SQL queries to perform various data analysis tasks. This helps in extracting valuable business insights, such as sales performance, customer behavior, and inventory management.

---

## 💻 Database Schema

The analysis is performed on three relational tables designed to capture the core data of an online book store. The tables are created using the following SQL Data Definition Language (DDL) commands:

### `Books` Table
Stores information about the books available for sale.

| Column Name | Data Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| **Book_ID** | SERIAL | PRIMARY KEY | Unique identifier for each book. |
| **Title** | VARCHAR(100) | | Title of the book. |
| **Author** | VARCHAR(100) | | Author's name. |
| **Genre** | VARCHAR(50) | | Book genre (e.g., Fiction, Fantasy). |
| **Published_Year** | INT | | Year the book was published. |
| **Price** | NUMERIC(10, 2) | | Selling price of the book. |
| **Stock** | INT | | Current inventory count. |

### `Customers` Table
Stores details of the registered customers.

| Column Name | Data Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| **Customer_ID** | SERIAL | PRIMARY KEY | Unique identifier for each customer. |
| **Name** | VARCHAR(100) | | Customer's full name. |
| **Email** | VARCHAR(100) | | Customer's email address. |
| **Phone** | VARCHAR(15) | | Customer's phone number. |
| **City** | VARCHAR(50) | | Customer's city of residence. |
| **Country** | VARCHAR(150) | | Customer's country of residence. |

### `Orders` Table
Records every transaction/purchase made by customers.

| Column Name | Data Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| **Order_ID** | SERIAL | PRIMARY KEY | Unique identifier for the order. |
| **Customer_ID** | INT | FOREIGN KEY (Customers) | The ID of the customer who placed the order. |
| **Book_ID** | INT | FOREIGN KEY (Books) | The ID of the book purchased. |
| **Order_Date** | DATE | | Date the order was placed. |
| **Quantity** | INT | | Number of units of the book ordered. |
| **Total_Amount** | NUMERIC(10, 2) | | Total amount for the specific book in this order. |



---

## 📊 Key Data Analysis Queries

The following are the 20 analytical queries executed on the database, grouped by the type of insight they provide.

### 1. Inventory & Pricing Analysis
Queries focused on understanding the stock and pricing of books.

| Query # | Description | Sample Query Snippet |
| :--- | :--- | :--- |
| **Q5** | Retrieve the **total stock** of all books. | `SELECT SUM(STOCK) FROM Books;` |
| **Q6** | Find details of the **most expensive** book. | `SELECT * FROM Books WHERE price = (SELECT MAX(price) FROM Books);` |
| **Q10** | Find the book with the **lowest stock**. | `SELECT * FROM Books WHERE Stock = (SELECT MIN(STOCK) FROM BOOKS);` |
| **Q13** | Calculate the **average price** of books in a specific genre (e.g., "Fantasy"). | `SELECT AVG(price) FROM Books WHERE genre = 'Fantasy';` |
| **Q16** | Show the **top 3 most expensive books** of a specific genre. | `SELECT * FROM Books WHERE genre = 'Fantasy' ORDER BY price DESC LIMIT 3;` |

### 2. Sales & Revenue Analysis
Queries to track sales performance and revenue generation.

| Query # | Description | Sample Query Snippet |
| :--- | :--- | :--- |
| **Q11** | Calculate the **total revenue** generated from all orders. | `SELECT SUM(total_amount) AS total_revenue FROM Orders;` |
| **Q8** | Retrieve all orders where the **total amount exceeds a value** (e.g., $20). | `SELECT * FROM Orders WHERE total_amount > 20;` |
| **Q12** | Retrieve the total number of books sold **per genre**. | `SELECT Books.genre, SUM(Orders.quantity) FROM Books JOIN Orders... GROUP BY Books.genre;` |
| **Q15** | Find the **most frequently ordered book**. | `SELECT Books.title, COUNT(Orders.order_id) FROM Books JOIN Orders... GROUP BY Books.title ORDER BY COUNT DESC LIMIT 1;` |
| **Q17** | Retrieve the total quantity of books sold **by each author**. | `SELECT Books.author, SUM(Orders.quantity) FROM Books JOIN Orders... GROUP BY Books.author;` |

### 3. Customer & Geographical Analysis
Queries focused on understanding customer behavior and location.

| Query # | Description | Sample Query Snippet |
| :--- | :--- | :--- |
| **Q3** | List all customers from a **specific country** (e.g., 'Canada'). | `SELECT * FROM Customers WHERE country = 'Canada';` |
| **Q7** | Show all customers who ordered **more than 1 quantity** of a book. | (Requires JOIN on Customers and Orders) |
| **Q14** | List customers who have placed **at least 2 orders** (based on quantity). | (Requires JOIN and filtering on `Orders.quantity`) |
| **Q18** | List the cities where customers who spent **over a certain amount** (e.g., $30) are located. | (Requires JOIN on Customers and Orders) |
| **Q19** | Find the customer who **spent the most** on orders. | `SELECT Customers.name, SUM(Orders.total_amount) FROM Customers JOIN Orders... GROUP BY Customers.name ORDER BY total_spent DESC;` |

### 4. Time-based & Filtering Analysis
Queries using specific filtering and date functions.

| Query # | Description | Sample Query Snippet |
| :--- | :--- | :--- |
| **Q1** | Retrieve all books in a **specific genre** (e.g., "Fiction"). | `SELECT * FROM Books WHERE Genre = 'Fiction';` |
| **Q2** | Find books published **after a specific year** (e.g., 1950). | `SELECT * FROM Books WHERE published_year > 1950;` |
| **Q4** | Show orders placed in a **specific month/year** (e.g., November 2023). | `SELECT * FROM Orders WHERE order_date::text LIKE '2023-11%';` |
| **Q9** | List all **distinct genres** available. | `SELECT DISTINCT Genre FROM Books;` |

### 5. Advanced Calculation (Stock Remaining)
An advanced query combining inventory and sales data.

| Query # | Description | Sample Query Snippet |
| :--- | :--- | :--- |
| **Q20** | Calculate the **stock remaining** after fulfilling all orders. | `SELECT Books.title, (Books.stock - SUM(Orders.quantity)) AS remaining_stocks FROM Books JOIN Orders... GROUP BY Books.title, Books.stock;` |

---

## 🛠️ Setup and Usage

To replicate this analysis, you will need a relational database management system (RDBMS) that supports standard SQL (e.g., PostgreSQL, MySQL, SQL Server).

1.  **Clone the Repository:**
    ```bash
    git clone [Your Repository URL]
    ```

2.  **Create the Database and Tables:**
    Execute the DDL script provided in the main file (or a separate `schema.sql` file) to create the `Books`, `Customers`, and `Orders` tables.
    *(The script includes `DROP TABLE IF EXISTS` for easy re-creation).*

3.  **Insert Sample Data:**
    Populate the tables with sample data (INSERT statements are not shown here but would typically be in a `data.sql` file).

4.  **Run Analysis Queries:**
    Execute the 20 analytical queries to perform the data analysis and retrieve the insights.

---
