insert into Customers ([FullName],[Email],[Phone],[HomeAddress],[JoinDate])values
	('Ahmed Ali', 'ahmed.ali@email.com', '01012345678', '123 Cairo St', '2026-01-10'),
	('Sara Mansour', 'sara.m@email.com', '01123456789', '456 Alex St', '2026-01-15'),
	('Mohamed Omar', 'mohamed.o@email.com', '01234567890', '789 Giza St', '2026-02-01'),
	('Aya Hassan', 'aya.h@email.com', '01545678901', '321 Tanta St', '2026-02-12'),
	('Hany Youssef', 'hany.y@email.com', '01098765432', '654 Mansoura St', '2026-02-20'),
	('Fatma Ibrahim', 'fatma.i@email.com', '01198765432', '987 Luxor St', '2026-03-05'),
	('Mahmoud Said', 'mahmoud.s@email.com', '01298765432', '159 Aswan St', '2026-03-11'),
	('Amira Kamel', 'amira.k@email.com', '01598765432', '753 Zagazig St', '2026-03-18'),
	('Sherif Nour', 'sherif.n@email.com', '01011122233', '852 Port Said St', '2026-03-25'),
	('Nada Waleed', 'nada.w@email.com', '01144455566', '963 Suez St', '2026-03-29');

insert into [dbo].[Products] ([ProductName],[Category],[SellingPrice],[StockQuantity])values
	('iPhone 15', 'Electronics', 5500.00, 20),
	('Wireless Headphones', 'Electronics', 150.00, 50),
	('Running Shoes', 'Fashion', 80.00, 100),
	('Leather Jacket', 'Fashion', 250.00, 30),
	('Coffee Maker', 'Home Appliances', 120.00, 15),
	('Microwave Oven', 'Home Appliances', 300.00, 10),
	('SQL Database Course Book', 'Books', 60.00, 200),
	('Fiction Novel', 'Books', 15.00, 150),
	('Smart Watch', 'Accessories', 180.00, 45),   
	('Leather Wallet', 'Accessories', 40.00, 80);
insert into [dbo].[Orders]([CustomerID],[OrderDate],[OrderStatus])values
	(1, '2026-01-15', 'Delivered'),
	(1, '2026-02-18', 'Shipped'),  
	(2, '2026-01-20', 'Delivered'),
	(3, '2026-02-05', 'Delivered'),
	(4, '2026-02-25', 'Cancelled'),
	(5, '2026-03-01', 'Pending'),  
	(6, '2026-03-10', 'Delivered'),
	(7, '2026-03-15', 'Delivered'),
	(8, '2026-03-22', 'Shipped'),  
	(9, '2026-03-28', 'Delivered');

insert into [dbo].[Orders_Details]([OrderID],[ProductID],CustomerID,[Quantity])values
	(1, 1, 1, 1),
	(1, 2, 1, 2), 
	(2, 3, 1, 1),
	(3, 1, 1, 1),
	(4, 4, 2, 1),
	(5, 5, 3, 1),
	(6, 6, 4, 1),
	(7, 7, 5, 2),
	(8, 8, 6, 3),
	(9, 9, 7, 1),
	(10, 2, 8,1);
insert into Payments([OrderID],[PaymentDate],[PaymentAmount],[Paymentmethod]) values
	(1, '2026-01-15', 5800.00, 'Credit Card'), 
	(2, '2026-02-18', 80.00, 'PayPal'),
	(3, '2026-01-20', 5500.00, 'Credit Card'),
	(4, '2026-02-05', 250.00, 'Cash on Delivery'),
	(5, '2026-02-25', 120.00, 'PayPal'),
	(6, '2026-03-01', 300.00, 'Credit Card'),
	(7, '2026-03-10', 120.00, 'Cash on Delivery'),
	(8, '2026-03-15', 45.00, 'PayPal'),
	(9, '2026-03-22', 180.00, 'Credit Card'),
	(10, '2026-03-28', 150.00, 'Cash on Delivery');
insert into Reviews([OrderID],[ProductID],[CustomerID],[Rating],[Comment],[ReviewDate]) VALUES
	(1, 1, 1, 5, 'Amazing phone, totally worth it!', '2026-01-20'),
	(1, 2, 1, 4, 'Good sound quality.', '2026-01-22'),             
	(2, 3, 1, 5, 'Very comfortable running shoes.', '2026-02-22'),
	(3, 1, 1, 4, 'Great, but delivery was a bit late.', '2026-02-10'),
	(4, 4, 2, 2, 'Material feels cheap.', '2026-03-01'),             
	(5, 5, 3, 1, 'Broke down after one week.', '2026-03-05'),        
	(6, 6, 4, 5, 'Heats up fast, works perfectly.', '2026-03-12'),
	(7, 7, 5, 3, 'Average textbook, some topics are missing.', '2026-03-20'),
	(8, 8, 6, 5, 'Highly recommended novel.', '2026-03-26'),
	(10, 2, 8, 3, 'Decent headphones for the price.', '2026-03-30');
