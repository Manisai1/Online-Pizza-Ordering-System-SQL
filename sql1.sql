USE customer;

DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL
);

INSERT INTO Customer (customer_id, first_name, last_name, email, phone_number) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890'),
(2, 'Alice', 'Smith', 'alice.smith@example.com', '987-654-3210'),
(3, 'Bob', 'Johnson', 'bob.johnson@example.com', '456-789-0123'),
(4, 'Emily', 'Davis', 'emily.davis@example.com', '789-012-3456'),
(5, 'Michael', 'Wilson', 'michael.wilson@example.com', '234-567-8901');

SELECT * FROM Customer;
-- -- -- -- -- -- -- -- -- -- -- --
CREATE TABLE pizza (
    Pizza_id INT PRIMARY KEY,
    Pizza VARCHAR(50) NOT NULL,
    Size VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
    
);
INSERT INTO pizza (Pizza_id, Pizza, Size, Price) VALUES
(1, 'African Peri Peri Veg', 'Medium', 350),
(2, 'Barbecue Veg', 'Medium', 300),
(3, 'Barbecue Veg', 'Large', 400),
(4, 'Jamaican Jerk Veg', 'Regular', 250),
(5, 'What-a-pizza Exotic', 'Regular', 200),
(6, 'English Cheddar and Veggies', 'Regular', 175),
(7, 'English Cheddar and Veggies', 'Medium', 375);


CREATE TABLE Crusts (
    crust_id INT PRIMARY KEY,
    Crust VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

INSERT INTO Crusts (crust_id, Crust, Price) VALUES
(1, 'Wheat Thin Crust', 60),
(2, 'Fresh Pan Base', 70),
(3, 'Hand Tossed', 80);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    delivery_charge DECIMAL(10, 2),
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Orders (order_id, customer_id, order_date, delivery_address, delivery_charge, total_amount) VALUES
(1, 1, '2024-03-25', '123 Main St, Cityville', 0.00, 760.00),
(2, 2, '2024-02-24', '456 Elm St, Townsville', 50.00, 420.00),
(3, 3, '2024-02-23', '789 Oak St, Villageton', 100.00, 1480.00),
(4, 1, '2024-04-22', '101 Pine St, Hamletville', 50.00, 380.00),
(5, 2, '2024-04-21', '202 Cedar St, Riverside', 0.00, 740.00),
(6, 3, '2024-03-20', '303 Maple St, Hillside', 100.00, 460.00),
(7, 4, '2024-03-19', '404 Birch St, Parkville', 50.00, 1100.00);


CREATE TABLE OrderItem (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    pizza_id INT,
    crust_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES Pizzas(pizza_id),
    FOREIGN KEY (crust_id) REFERENCES Crusts(crust_id)
);

INSERT INTO OrderItem (order_item_id, order_id, pizza_id, crust_id, quantity, price) VALUES
(1, 1, 1, 2, 2, 760),
(2, 2, 2, 1, 3, 420),
(3, 3, 3, 3, 3, 1480),
(4, 4, 4, 1, 1, 380),
(5, 5, 5, 2, 2, 740),
(6, 6, 6, 3, 1, 460),
(7, 7, 7, 3, 3, 1100);

select distinct C.first_name, C.last_name
from customer C
join orders O on C.customer_id = O.customer_id
join orderitem OI on O.order_id = OI.order_id
join pizza P on O.pizza_id = P.pizza_id where P.size = 'large';


select * from orders where month(order_date) =3;

select delivery_address, count(*) as order_count
from orders
group by delivery_address
having count(*)>3;


SELECT O.order_id, C.first_name, C.last_name, P.Pizza, Cr.Crust, OI.quantity, OI.price 
FROM Orders O
JOIN Customer C ON O.customer_id = C.customer_id
JOIN OrderItem OI ON O.order_id = OI.order_id
JOIN Pizzas P ON OI.pizza_id = P.pizza_id
JOIN Crusts Cr ON OI.crust_id = Cr.crust_id;


SELECT C.customer_id, SUM(O.total_amount) AS total_spent
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_id;


select o.order_id,P.pizza,P.price
from OrderItem OI
join pizza P on OI.pizza_id = P.pizza_id
where P.prize >300;

select distinct C.first_name, C.last_name
from customer C
join Orders O on C.customer_id = O.customer_id
where o.delivery_charge > 50;

select P.pizza , sum(OI.quantity) as Total_Quantity
from orderitem OI
join pizza P on OI.pizza_id = P.pizza_id
group  by P.pizza;

select distinct C.first_name , C.last_name
from customer C
join Orders O on C.customer_id = O.customer_id
join OrderItem OI on O.order_id = OI.pizza_id
JOIN pizza P ON OI.pizza_id = P.pizza_id where P.pizza = 'Barbecue Veg';

select avg(total_orders) as Average from Orders;

select P.pizza , sum(OI.price) as Revenue 
from OrderItem OI
join pizza P on OI.pizza_id = P.pizza_id
group by P.pizza;

select C.first_name, C.last_name, count(O.order_id) as Number_Of_Orders
from Customer C
join Orders O on C.customer_id = O.customer_id
group by C.custromer_id
having count(O.order_id) >1;







