create database Quanlysinhvien;
use Quanlysinhvien;
create table Class(
ClassID int not null primary key auto_increment,
Classname varchar(60) not null,
StartDate Datetime not null,
`Status` bit
 );
 
 create table Student(
 StudentID int not null primary key auto_increment,
 StudentName varchar(30) not null,
 Address varchar(50),
 Phone varchar(20),
 `Status` bit,
 ClassID int not null,
 foreign key (ClassID) references Class(ClassID)
 );
 
 create table `Subject`(
 SubID int not null primary key auto_increment,
 SubName varchar(30) not null,
 Credit Tinyint not null default 1 check (credit >= 1),
 `Status` bit default 1
 );
 
 create table Mark(
 MarkID int not null primary key auto_increment,
 SubID int not null ,
 StudentID int not null ,
 Mark float default 0 check (mark between 0 and 100),
 ExamTimes Tinyint default 1,
 unique(SubID,StudentId),
 foreign key (SubID) references `Subject`(SubID),
 foreign key (StudentID) references Student(StudentID) 
 );
 use Quanlysinhvien;

INSERT INTO Class
VALUES (1, 'classA1','2008-12-20', 1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (3, 'B3', current_date, 0);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);
       
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);
       USE QuanLySinhVien;
-- Hiển thị danh sách tất cả các học viên
SELECT *
FROM Student;
-- Hiển thị danh sách các học viên đang theo học
-- (true: đang học, fasle: nghỉ học)
SELECT *
FROM Student
WHERE Status = true;
-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ.
SELECT *
FROM Subject
WHERE Credit < 10;
-- Hiển thị danh sách học viên lớp A1
SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S join Class C on S.ClassId = C.ClassID;
SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S join Class C on S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';
-- Hiển thị điểm môn CF của các học viên.
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId;
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';
-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from student as std
where std.StudentName like 'h%';
-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select * from class cls
where month(cls.StartDate)=12;
-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from `Subject` sub
where sub.credit between 3 and 5;
-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update student std set std.classID = 2
where std.studentName = 'hung';
-- Hiển thị các thông tin: StudentName, SubName, Mark
-- Dữ liệu sắp xếp theo điểm thi (mark) giảm dần
-- nếu trùng sắp theo tên tăng dần.
select std.studentName,sub.subName,mark.Mark
from student std
cross join `subject` sub, mark where std.studentID = mark.StudentID
and sub.SubID = mark.SubID
order by Mark desc;

use quanlysinhvien;
-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from `subject`
where subject.Credit = (SELECT MAX(subject.credit) from subject);
-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select * from subject
join mark where subject.SubID = mark.subid and mark.Mark = (SELECT MAX(mark.Mark) from mark);
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, 
-- xếp hạng theo thứ tự điểm giảm dần
select *, (select avg(mark) from student 
join mark on student.StudentID = mark.StudentID 
order by mark.StudentID) as avgStudent from student
where student.StudentID = any (select distinct student.StudentID from student 
join mark on student.StudentID = mark.StudentID)
order by student.StudentID;
-- Hiển thị số lượng sinh viên ở từng nơi
SELECT Address, COUNT(StudentId) AS 'Số lượng học viên'
FROM Student
GROUP BY Address;
-- Tính điểm trung bình các môn học của mỗi học viên
SELECT S.StudentId,S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;
-- Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15
SELECT S.StudentId,S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) > 15;
-- Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);