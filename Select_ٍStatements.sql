--Mission 1 — Customer & Product Overview 
--1. Display all customers
select *
from Customers
--2. Display the product name, category, and current price for every product. 
select ProductName , Category , SellingPrice
from Products
--3. Display products whose current price is greater than 5000. 
select *
from Products
where SellingPrice >= 5000
--4. Display all customers ordered by join date, newest first. 
select * 
from Customers
order by JoinDate desc
--5. Display the total number of customers. 
select count(*) as CountOfCustomers
from Customers
--//////////////////
--Mission 2 — Aggregation & Business Totals 
--1. Calculate the average current product price.
select avg(SellingPrice) as AvgProductPrice
from Products
--2. Display the highest and lowest current product prices. 
select max(SellingPrice) as HighestPrice, min(SellingPrice) as LowestPrice
from Products
--3. Calculate the total available stock quantity. 
select sum(StockQuantity) as TotalStock
from Products
--4. Calculate the total amount recorded in Payments. 
select sum (PaymentAmount)
from Payments
--5. Display the number of orders for each order status. 
select OrderStatus,count(*) as NumberOfStatus
from Orders
group by OrderStatus
--6. Display the total payment amount for each payment method. 
select Paymentmethod , count(*) as NumberOfPaymentMethod
from Payments
group by Paymentmethod
--//////////////////
--Mission 3 — Order & Sales Analysis 
--1. Calculate the total sales amount for each order using quantity multiplied by the historical unit price. 
select OrderID ,sum (Quantity * UnitPrice) as TotalSales
from Orders_Details
group by OrderID
--2.Display only orders whose total sales exceed 5000. 
select OrderID ,sum (Quantity * UnitPrice) as TotalSales
from Orders_Details
group by OrderID
having sum (Quantity * UnitPrice) > 5000
--3. Display each order together with the customer's name, order date, and status.
select OrderID , FullName , OrderDate , OrderStatus
from Orders o join Customers c on o.CustomerID = c.CustomerID 
--4. Display each order with its products,purchased quantities, and historical unit prices. 
select p.ProductID, ProductName , Quantity , UnitPrice
from Orders_Details o join Products p on o.ProductID =p.ProductID
--5. Display the total amount spent by each customer. 
select FullName , sum (Quantity * UnitPrice) TotalAmountSpent
from Customers c join Orders o 
on c.CustomerID = o.CustomerID join Orders_Details od 
on o.OrderID = od.OrderID
group by FullName
--////////////////
--Mission 4 — Reviews & Relationships 
--1. Display the number of reviews received by each product, including products with no reviews.  
select ProductName,sum(Rating) SumRating
from Products p left join Reviews r on r.ProductID = p.ProductID
group by ProductName
--2. Display all reviews together with the customer name and product name.
select FullName , ProductName , Comment
from Customers c left join Reviews r
on r.CustomerID=c.CustomerID left join Products p 
on p.ProductID =r.ProductID
order by FullName
--3. Display customers who have placed at least one order.
select FullName , count(o.CustomerID) CountOfOrders
from Customers c left join Orders o
on c.CustomerID =o.CustomerID
group by FullName
having count(o.CustomerID) >= 1
--4. Display products that have never been ordered. 
select ProductName , o.ProductID
from Products p left join Orders_Details o on o.ProductID =p.ProductID
where o.ProductID is null
--5. Display products that have never received a review. 
select ProductName , r.ProductID
from Products p left join Reviews r on r.ProductID =p.ProductID
where r.ProductID is null
--6. Display all customers and their number of orders, including customers who have never placed an order. 
select FullName , count(o.CustomerID) CountOfOrders
from Customers c left join Orders o
on c.CustomerID =o.CustomerID
group by FullName
--//////////////////
--Mission 5 — Subqueries 
--1. Display customers who placed more orders than the average number of orders among customers who placed at least one order. 
select FullName , c.CustomerID ,count(o.OrderID) CustomerOrderCount
from Customers c join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID , FullName
having count(o.OrderID) >
(select avg(CountOfOrders) as avgOrders 
from (select count(OrderID) as CountOfOrders 
from Orders 
group by CustomerID) as ordercount);

--2. Display products whose current price is above the average current product price. 
select ProductName , productID , SellingPrice
from Products 
where SellingPrice > (select avg(SellingPrice) as CurrentProductPrice
from Products);

--3. Display customers whose total spending exceeds the average among customers who made at least one payment.
select FullName , sum (Quantity * UnitPrice) TotalAmountSpent
from Customers c join Orders o 
on c.CustomerID = o.CustomerID join Orders_Details od 
on o.OrderID = od.OrderID
group by FullName
having sum(Quantity * UnitPrice) >
(select avg(TotalSales) from
(select FullName ,sum (Quantity * UnitPrice) as TotalSales
from Orders_Details od join Orders o 
on od.OrderID =o.OrderID join Customers c
on o.CustomerID = c.CustomerID
group by  FullName) as f);
--///////////////////
--Mission 7 — Window Functions 
--1. Rank customers by total spending using RANK(), highest spending first. 
select FullName ,
sum (Quantity * UnitPrice) TotalAmountSpent,
rank() over(order by sum (Quantity * UnitPrice) desc)

	from Customers c join Orders o 
	on c.CustomerID = o.CustomerID join Orders_Details od 
	on o.OrderID = od.OrderID
	group by FullName;
--2. Rank products by total quantity sold using DENSE_RANK(), highest quantity first. 
select *, dense_rank() over(partition by Quantity order by UnitPrice desc) AS DenseRank
	from Orders_Details;
--3. Display each payment together with the previous payment amount using LAG(), ordered by payment date and payment ID. 
select *,lag(PaymentAmount,1,0)over(ORDER BY PaymentDate, PaymentID) as PrecedentPaymenAmount
from Payments;
--4. Display a running total of payment amounts ordered by payment date and payment ID.
select*,SUM(PaymentAmount) OVER (ORDER BY PaymentDate) TotalPaymentAmounts
from Payments;
--//////////////////////
--Mission 8 — Views 
--1. Create a view named vw_revenue_by_month that displays monthly revenue. 

select * from vw_revenue_by_month

--2. Create a view named vw_best_selling_products that displays product name, total quantity sold, and total revenue. 

select * from vw_best_selling_products
--3. Create a view named vw_customer_summary that displays customer name, number of orders, and total amount spent.

select* from vw_customer_summary

