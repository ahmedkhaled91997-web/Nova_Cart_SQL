create database NovaCartDB
use NovaCartDB
--Customers Table
create table Customers(
	CustomerID int identity(1,1) primary key,
	FullName varchar(100) not null,
	Email varchar(200) not null unique check (Email like '%@%.%'),
	Phone varchar(11) check (Phone like '010%' or Phone like '011%' or Phone like '012%' or Phone like '015%'),
	HomeAddress varchar (200),
	JoinDate date default getdate()
	)
--Products Table
create table Products(
	ProductID int identity(1,1) primary key,
	ProductName varchar(100) not null,
	Category varchar(100),
	SellingPrice decimal(10,2) check (SellingPrice > 0),
	StockQuantity int check (StockQuantity >=  0)
)
--Orders Table
create table Orders(
	OrderID int identity(1,1) primary key,
	CustomerID int ,
	OrderDate date default getdate(),
	OrderStatus varchar(20) CHECK (OrderStatus IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
	constraint FK_CustomerID_Orders foreign key (CustomerID) references Customers(CustomerID)
)
--Orders Details table M->M
create table Orders_Details(
	OrderID int,
	CustomerID int,
	ProductID int,
	Quantity int check (Quantity > 0) default 1,
	UnitPrice decimal(10,2) check (UnitPrice > 0) ,
	constraint PK_Orders_Details primary key (OrderID, ProductID,CustomerID),
	constraint FK_OrdersDetails_Orders foreign key (OrderID) references Orders(OrderID),
	constraint FK_OrdersDetails_Product foreign key (ProductID) references Products(ProductID),
	constraint FK_OrdersDetails_CustomerID foreign key (CustomerID) references Customers(CustomerID)
)
--Payments  table
create table Payments (
	PaymentID int identity(1,1) primary key,
	OrderID int unique,
	PaymentDate date default getdate(),
	PaymentAmount decimal(10,2) check (PaymentAmount >0),
	Paymentmethod varchar(50) check (Paymentmethod in ('Cash on Delivery','Credit Card','PayPal')),
	constraint FK_OrderID_Payments foreign key (OrderID) references Orders(OrderID)
)
--Reviews Table
create table Reviews(
	ReviewID int identity(1,1) primary key,
	CustomerID int,
	OrderID int ,
	ProductID int,
	Rating int check (Rating between 1 and 5),
	Comment varchar(max),
	ReviewDate date default getdate(),
	constraint FK_Reviews_ foreign key (OrderID,ProductID,CustomerID)
	references Orders_Details(OrderID, ProductID,CustomerID),

)		   
