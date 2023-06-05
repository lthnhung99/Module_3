create database student_management;
create table student_management.student(
`id` int not null primary key ,
`name` varchar(255),
`age` int ,
`country` varchar(255)
);

create table student_management.class(
`id` int,
`name` varchar(255)
);

create table student_management.teacher(
`id` int,
`name` varchar(255),
`age` int,
`country` varchar(255)
);