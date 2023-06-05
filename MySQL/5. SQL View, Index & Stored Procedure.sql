--  5. SQL View, Index & Stored Procedure
-- [Thực hành] Chỉ mục trong MySql
use classicmodels;
select * from customers where customerName = 'land of toys inc.';
explain select * from customers where customerName = 'land of toys inc.';

alter table customers add index idx_customerName(customerName);
explain select * from customers where customerName = 'land of toys inc.';

alter table customers add index idx_full_name(contactFirstName, contactLastName);
explain select * from customers where contactFirstName = 'Jean' or contactFirstName = 'King';

alter table customers drop index idx_full_name;
-- [Thực hành] Store Procedure : show procedue status(hiện procedure)
delimiter //
create procedure findAllCustomer()
begin
select * from customers;
end //
delimiter ;
call findAllCustomer();

DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`//
CREATE PROCEDURE findAllCustomers()
BEGIN
SELECT * FROM customers where customerNumber = 175;
END //
delimiter ;
call findAllCustomers();
-- [Thực hành] Truyền tham số vào Store Procedure
-- Tham số loại IN
delimiter //
create procedure getCusById(
in cusNum int(11)
)
begin
select * from customers where customerNumber = cusNum;
end //
delimiter ;
call getCusById(175);
-- Tham số loại OUT
delimiter //
 -- drop procedure if exists GetCustomersCountryByCity //
create procedure GetCustomersCountryByCity( in in_city varchar(50),out total int)
begin
select count(customerNumber)
into total
from customers
where city = in_city;
end //
delimiter ;

call GetCustomersCountryByCity('Lyon',@total);
select @total;
-- Tham số loại INOUT
DELIMITER //
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END//
DELIMITER ;
SET @counter = 1;
CALL SetCounter(@counter,1); -- 2
CALL SetCounter(@counter,1); -- 3
CALL SetCounter(@counter,5); -- 8
SELECT @counter; -- 8
-- [Thực hành] View trong MySql
CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM  customers;
select * from customer_views;
-- Cập nhật view customer_views: 
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';
select * from customer_views;
-- Xoá view
DROP VIEW customer_views;