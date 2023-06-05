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

