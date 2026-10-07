create trigger TG_UnitPrice
on [dbo].[Orders_Details]
after insert
as 
begin
	 update od 
	 set od.UnitPrice = p.SellingPrice
	 from Orders_Details od join inserted i 
	 on od.OrderID = i.OrderID and od.ProductID = i.ProductID join Products p
	 on i.ProductID = p.ProductID
end;
--//////////////////////
--Mission 6 — Common Table Expressions 
--1. Using a CTE, calculate total revenue by month. 
with CalculateTotalRevenueByMonth as (
	select sum(PaymentAmount) totalsales, datepart(mm,PaymentDate) as SalesMonth
	from Payments
	group by datepart(mm,PaymentDate))

select* from CalculateTotalRevenueByMonth ;
--2. Using a CTE, calculate total spending by customer and return only customers whose spending exceeds 10000. 
with CalculateTotalSpendingByCustomer as(
	select FullName , sum (Quantity * UnitPrice) TotalAmountSpent
	from Customers c join Orders o 
	on c.CustomerID = o.CustomerID join Orders_Details od 
	on o.OrderID = od.OrderID
	group by FullName)

select * from CalculateTotalSpendingByCustomer
where TotalAmountSpent > 5000;
--//////////////////////
--Mission 8 — Views 
--1. Create a view named vw_revenue_by_month that displays monthly revenue. 
create view vw_revenue_by_month as
	select sum(PaymentAmount) totalsales, datepart(mm,PaymentDate) as SalesMonth
	from Payments
	group by datepart(mm,PaymentDate);

--2. Create a view named vw_best_selling_products that displays product name, total quantity sold, and total revenue. 
create view vw_best_selling_products as
	select ProductName,isnull(sum(Quantity),0)as TotalQuantitySold,isnull(sum (Quantity * UnitPrice),0) as Revenue
	from Orders_Details o  right join Products p on o.ProductID = p.ProductID
	group by p.ProductID, ProductName;

--3. Create a view named vw_customer_summary that displays customer name, number of orders, and total amount spent.
create view vw_customer_summary as
	select FullName,count(distinct o.OrderID) as OrderCount,
	isnull(sum(Quantity * UnitPrice),0) as TotalRevenue,c.CustomerID
	from Customers c join Orders o on c.CustomerID=o.CustomerID
	join Orders_Details od on od.OrderID=o.OrderID
	group by FullName , c.CustomerID;
