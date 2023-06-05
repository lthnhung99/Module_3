create database quanlybanhang;
create table Customer(
cID int auto_increment primary key,
cName varchar(255),
cAge int not null
);


create table `Order`(
oID int auto_increment primary key,
cID int,
oDate datetime not null,
oTotalPrice double not null,
foreign key(cId) references customer(cId)
);
alter table `order` modify column oTotalPrice double;
create table Product(
pID int auto_increment primary key,
pName varchar(255),
pPrice double not null
);

create table OrderDetail(
oID int,
pID int,
odQTY int not null,
foreign key (oID) references `order`(oID),
foreign key (pID) references product(pID)

);
