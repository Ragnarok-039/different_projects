select *
from Products
where ProductName < 'Ikura';

select *
from Orders
where OrderDate < '1996-07-09 00:00:00.000';

select *
from Products
where UnitPrice > 100;

select *
from Customers
where Country = 'Spain';

select *
from Customers
where City like 'W%';

select *
from Customers
where Phone like '%5555%';

select *
from Customers
where Country = 'USA'
  and ContactTitle = 'Marketing Assistant';

select *
from Products
where UnitPrice > 100
   or ProductName = 'Chai';

select *
from Orders
where OrderDate = '1998-02-26 00:00:00.000'
order by Freight;

select *
from Orders
where OrderDate = '1998-02-26 00:00:00.000'
order by EmployeeID, Freight;

select min(UnitPrice), avg(UnitPrice), max(UnitPrice)
from Products
where CategoryID = 3;

select count(distinct ContactTitle)
from Customers
where Country = 'UK';

select sum(UnitPrice)
from Products
where CategoryID = 4
   or CategoryID = 5;

select count(1), City
from Customers
group by City
having count(1) > 4;

select avg(UnitPrice), CategoryID
from Products
group by CategoryID
order by 1 desc;

select OrderDate, count(1)
from Orders
where OrderDate between '1998-03-01' and '1998-03-31'
group by OrderDate
having count(1) = 4;

select OrderID, sum(UnitPrice * Quantity * (1 - Discount))
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity * (1 - Discount)) > 10000;

select count(1)
from Customers
where Region is null
  and ContactTitle like '%Sales%';

select count(1), ContactTitle
from Customers
group by ContactTitle
order by 1 desc;

select CategoryID,
       max(UnitPrice),
       min(UnitPrice),
       max(UnitPrice) - min(UnitPrice) as diff
from Products
group by CategoryID
order by diff desc;

select OrderID, sum(Quantity)
from [Order Details]
group by OrderID
order by 2 desc;

select count(1)
from (select OrderID, sum(Quantity * UnitPrice * Discount) as discount
      from [Order Details]
      group by OrderID) as temp
where temp.discount > 3000;

select count(1)
from Orders
         left join Employees E on Orders.EmployeeID = E.EmployeeID
where E.LastName = 'Fuller';

select round(sum(UnitPrice * Quantity * (1 - Discount)), 0)
from [Order Details]
         left join Orders O on O.OrderID = [Order Details].OrderID
where year(O.OrderDate) = '1997';

select CategoryName, count(1)
from Products
         left join Categories on Products.CategoryID = Categories.CategoryID
group by Categories.CategoryName;

select *
from Employees
         inner join Orders
                    on Employees.EmployeeID = Orders.EmployeeID
         inner join Customers
                    on Orders.CustomerID = Customers.CustomerID
where ContactName like '%Chang%';

select Customers.City
from Customers
         left join Orders on Customers.CustomerID = Orders.CustomerID
where OrderID is null;

select City
from Customers
union
select City
from Employees;

select count(1)
from (select Country, count(1) as num
      from Customers
      group by Country
      having count(1) > 1) as temp_table;

select count(1)
from (select Customers.CustomerID, count(O.CustomerID) as num
      from Customers
               left join Orders as O on Customers.CustomerID = O.CustomerID
      group by Customers.CustomerID
      having count(O.CustomerID) > 10) as temp;

select sum(total_price)
from (select od.UnitPrice * od.Quantity * (1 - od.Discount) as total_price
      from Products
               left join [Order Details] as od
                         on Products.ProductID = od.ProductID
      where Products.CategoryID = 1) as temp;

select *
from [Order Details]
         left join Products as P on [Order Details].ProductID = P.ProductID
where P.ProductName like '%Chocolade%';

select sum(UnitPrice * Quantity * (1 - Discount))
from [Order Details]
where ProductID in (select ProductID
                    from Products
                    where CategoryID in (select Categories.CategoryID
                                         from Categories
                                         where CategoryName like '%Confections%'));

select Categories.CategoryName, sum(od.UnitPrice * od.Quantity * (1 - od.Discount))
from Categories
         left join Products as P on Categories.CategoryID = P.CategoryID
         left join [Order Details] as od on P.ProductID = od.ProductID
group by Categories.CategoryName
order by 2 desc;

select *
from Employees
where EmployeeID in (select Orders.EmployeeID
                     from Orders
                     where CustomerID in (select Customers.CustomerID
                                          from Customers
                                          where ContactName like '%Crowther%')
                       and OrderDate = '1998-04-29');

select count(1)
from (select count(1) as count_orders, ShipCity
      from Orders
      where year(OrderDate) = '1997'
      group by ShipCity
      having count(distinct OrderID) > 5) as temp;

select FirstName,
       LastName,
       City,
       case
           when Region is null then 'not defined'
           else Region
           end as Region
from Employees;

select count(1)
from (select FirstName,
             LastName,
             TitleOfCourtesy,
             case
                 when TitleOfCourtesy in ('Ms.', 'Mrs.') then 'women'
                 when TitleOfCourtesy in ('Mr.', 'Dr.') then 'men'
                 else 'error'
                 end as gender
      from Employees) as temp
where gender = 'women';

select s, count(1)
from (select ProductName,
             UnitPrice,
             case
                 when UnitPrice between 0 and 9.99 then '0-9.99'
                 when UnitPrice between 10 and 29.99 then '10-29.99'
                 when UnitPrice between 30 and 49.99 then '30-49.99'
                 when UnitPrice > 50 then '50+'
                 end as s
      from Products) as temp
group by s;

select round(sum(UnitPrice * Quantity * (1 - Discount)), 0)
from Orders
         left join [Order Details] "[O D]" on Orders.OrderID = "[O D]".OrderID
where year(Orders.OrderDate) = 1996;

select count(1), datepart(quarter, OrderDate)
from Orders
where year(OrderDate) = 1997
group by datepart(quarter, OrderDate);

select max(datediff(day, OrderDate, ShippedDate))
from Orders;

select *
from Customers
where len(Country) > 10;

select *
from Customers
where ContactTitle = 'Owner/Marketing Assistant';

select Shippers.CompanyName, count(1)
from Orders
         left join Shippers on Orders.ShipVia = Shippers.ShipperID
group by Shippers.CompanyName;

select ContactName, count(1)
from Orders
         left join Customers
                   on Orders.CustomerID = Customers.CustomerID
group by ContactName
order by 2 desc;

select *
from Customers
where Country = 'France'
   or City = 'Genève';

select ShipCity
from Orders;

select distinct ContactName
from Customers
         left join Orders O on Customers.CustomerID = O.CustomerID
where Customers.City != O.ShipCity;

select count(OrderID)
from Customers
         left join Orders
                   on Customers.CustomerID = Orders.CustomerID
where Country = 'Spain'
  and ContactName = 'Diego Roel';

select count(1)
from Orders
where ShippedDate is null;

select distinct ShipCity
from Orders
where ShipCountry = 'UK'
  and year(OrderDate) = 1998
  and month(OrderDate) = 2;

select *
from Customers
where ContactName like 'Mari%';

select ContactName, len(ContactName)
from Customers
order by 2 desc;

select OrderID
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity * (1 - Discount)) = 2900;

select datepart(week, OrderDate),
       round(sum(UnitPrice * Quantity * (1 - Discount)), 0)
from [Order Details]
         left join Orders O on O.OrderID = [Order Details].OrderID
where datepart(year, OrderDate) = 1998
group by datepart(week, OrderDate)
order by 2 desc;

select count(1), month(OrderDate)
from Orders
where year(OrderDate) = 1996
  and ShipCountry = 'USA'
group by month(OrderDate)
order by 2 desc;

select count(1), EmployeeID, concat(year(OrderDate), month(OrderDate))
from Orders
group by EmployeeID, concat(year(OrderDate), month(OrderDate))
order by 1 desc;

select count(temp_row)
from (select case
                 when ShippedDate > RequiredDate then 'delay'
                 else 'in time'
                 end as temp_row,
             *
      from Orders
      where year(OrderDate) = 1997) as temp
where temp.temp_row = 'delay';

select temp, count(1)
from (select ContactName,
             case
                 when ContactTitle like '%Marketing%' then 'Marketing'
                 when ContactTitle like '%Sales%' then 'Sales'
                 else 'Other'
                 end as temp
      from Customers) as temp_table
group by temp;

select sum(UnitPrice * Quantity * (1 - Discount)), O.OrderID
from [Order Details]
         left join Orders O on O.OrderID = [Order Details].OrderID
         left join Customers on O.CustomerID = Customers.CustomerID
where Customers.ContactName like '%Pavarotti%'
group by O.OrderID
order by 1;

select E.FirstName, E.LastName
from Orders
         left join Customers on Orders.CustomerID = Customers.CustomerID
         left join Employees E on Orders.EmployeeID = E.EmployeeID
where Customers.ContactName like '%Sommer%';

select E.FirstName, E.LastName, datediff(day, max(Orders.OrderDate), min(OrderDate))
from Orders
         left join Employees E on Orders.EmployeeID = E.EmployeeID
group by E.FirstName, E.LastName
order by 3;

select month(Orders.OrderDate),
       year(Orders.OrderDate),
       sum([Order Details].UnitPrice * [Order Details].Quantity * (1 - [Order Details].Discount))
from Orders
         left join [Order Details] on Orders.OrderID = [Order Details].OrderID
         left join Products on [Order Details].ProductID = Products.ProductID
where Products.ProductName like '%Chef Anton%'
group by month(Orders.OrderDate), year(Orders.OrderDate)
order by 3 desc;

select round(sum(od.Quantity * od.UnitPrice * (1 - od.Discount)), 0)
from Orders
         left join [Order Details] od on Orders.OrderID = od.OrderID
         left join Products P on od.ProductID = P.ProductID
         left join Categories C on P.CategoryID = C.CategoryID
where C.CategoryName = 'Condiments'
  and year(Orders.OrderDate) = 1996;
