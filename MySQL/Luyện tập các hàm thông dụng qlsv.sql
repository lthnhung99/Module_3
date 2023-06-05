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