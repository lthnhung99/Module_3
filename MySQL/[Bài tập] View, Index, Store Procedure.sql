-- -- [Bài tập] View, Index, Store Procedure
create database demo;
use demo;
create table Products (
Id int primary key auto_increment,
productCode int,
productName varchar(255),
productPrice float,
productAmount int,
productDescription varchar(255),
productStatus varchar(255)
);
insert into Products 
value (1,1,'Coca','10000','100','ngọt','lạnh'),
(2,2,'Cam ép','12000','200','chua','lạnh'),
(3,3,'Bí đao','15000','300','ngọt','nóng'),
(4,4,'Sữa tươi','20000','500','ngọt','nóng'),
(5,5,'Trà','25000','400','đắng','nóng');
-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
alter table products add index idx_productCode(productCode);
explain select * from Products where productCode = 1;
-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
alter table products add index idx_name(productName,productPrice);
explain select * from Products where productName = 'Coca' or productPrice='10000';
-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view view_product as
select productCode, productName, productPrice, productStatus
from products;
-- Tiến hành sửa đổi view
alter view view_product as
select Id,productCode, productName, productPrice,productAmount, productStatus
from products;
-- Tiến hành xoá view
drop view view_product;
-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure allProducts()
begin
select * from products;
end //
delimiter ;

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
drop procedure if exists addProducts;
create procedure addProducts(
in new_id int,
in new_productCode int,
in new_productName varchar(255),
in new_productPrice float,
in new_productAmount int,
in new_productDescription varchar(255),
in new_productStatus varchar(255)
)
begin
	DECLARE has_error INT DEFAULT 0;
	DECLARE error_message VARCHAR(255) default '' ;
   
    
    if(exists (SELECT * FROM products where id = new_id)) then
		set has_error = 1;
        set error_message = ' Id đã tồn tại';
    end if;
    
    if(exists (SELECT * FROM products where productCode = new_productCode)) then
		set has_error = 1;
        set error_message = concat(error_message, ' Mã sản phẩm không hợp lệ');
    end if;
    
     if(new_productPrice<0 or new_productAmount<0 ) then
		set has_error = 1;
        set error_message = concat(error_message, ' Giá và số lượng lớn hơn không ');
    end if;
    
      if(new_productCode is null or new_productName='' or new_productPrice is null or new_productAmount is null or new_productDescription='' or new_productStatus='' ) then
		set has_error = 1;
        set error_message = concat(error_message, ' Dữ liệu không được rỗng');
    end if;
     if(has_error = 0) then
		insert into products(Id,productCode, productName, productPrice,productAmount, productStatus)
        value (new_id,new_productCode,new_productName,new_productPrice,new_productAmount,new_productStatus);
    end if;
    
    if(has_error=1) then
    select error_message;
    end if;
end //
delimiter ;
-- Tạo store procedure sửa thông tin sản phẩm theo id
use demo;
delimiter //
CREATE PROCEDURE editProducts(
in e_id int,
in e_productCode int,
in e_productName varchar(255),
in e_productPrice float,
in e_productAmount int,
in e_productDescription varchar(255),
in e_productStatus varchar(255)
    )
BEGIN
	DECLARE has_error INT DEFAULT 0;
	DECLARE error_message VARCHAR(255);
	IF has_error = 0 THEN
		SELECT COUNT(*) INTO @count FROM products WHERE id = e_id;
		IF @count = 0  THEN
			SET has_error = 1;
			SET error_message = CONCAT('Id ', e_id, ' k tồn tại. Vui lòng chọn id khác.');
		END IF;
		IF (e_productPrice < 0 or e_productAmount<0) THEN
			SET has_error = 1;
			SET error_message = 'Giá và số lượng phải lớn hơn 0. Vui lòng nhập lại.';
		END IF;
		IF has_error = 0 AND e_productCode IS NOT NULL THEN
			SELECT COUNT(*) INTO @count FROM BOMON WHERE productCode = e_productCode;
			IF @count = 0 THEN
				SET has_error = 1;
				SET error_message = CONCAT('Mã sản phẩm ', e_productCode, ' không tồn tại trong hệ thống. Vui lòng chọn mã khác.');
			END IF;
		END IF;
		IF has_error = 0 THEN
			UPDATE Products
			SET id = e_id, 
            productCode = e_productCode, 
            productName = e_productName, 
            productPrice = e_productPrice, 
            productAmount = e_productAmount, 
            productDescription = e_productDescription, 
            productStatus = e_productStatus
			WHERE id = e_id;
		END IF;
	END IF;
	IF has_error = 1 THEN
		-- Trả về thông tin lỗi
		SELECT has_error AS 'error', error_message AS 'message';
	ELSE
		-- Trả về thông tin chỉnh sửa
		SELECT has_error AS 'error', CONCAT('Đã chỉnh sửa thông tin giáo viên có mã ', e_id, ' thành thông tin mới có mã ', e_id, '.') AS 'message';
	END IF;	
END //
-- Tạo store procedure xoá sản phẩm theo id
delimiter //
CREATE PROCEDURE deleteProduct(id_delete int)
begin
	DECLARE error_message VARCHAR(255);
    if(exists (SELECT * FROM products where id = id_delete)) then
    delete from products where id = id_delete;
    else set error_message= ' Id không tồn tại';
    select error_message;
    end if;
end //
delimiter ;




