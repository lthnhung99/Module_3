use quanlydetai;
-- Cho biết họ tên và lương của tất cả các giáo viên.
select giaovien.hoten,giaovien.luong
from giaovien;
-- Cho biết danh sách các giáo viên trong trường
select *
from giaovien;
-- Cho biết các giáo viên nhân viên không thuộc bộ môn HTTT và không có lương lớn hơn 40000
select *
from giaovien
where giaovien.mabm != 'HTTT' and giaovien.LUONG <=4000;
-- Cho biết các giáo viên sinh trong khoảng năm 1955 đến 1960
select *
from giaovien 
where year(ngsinh) between 1955 and 1960;
-- Cho biết tên giáo viên và tên bộ môn mà giáo viên đó làm việc
select giaovien.hoten, bomon.tenbm as tenBm
from giaovien,bomon;
-- Với mỗi bộ môn, cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
select bomon.tenbm, 
				(select count(*) 
                from giaovien 
                where giaovien.mabm=bomon.mabm) as slgvbm
from bomon;
-- Cho biết họ tên và lương của các giáo viên bộ môn HTTT
SELECT Temp.HOTEN, Temp.luong
FROM ( SELECT MAGV, HOTEN, LUONG 
FROM GIAOVIEN
WHERE MABM='HTTT') as Temp;
-- Cho biết những giáo viên có lương lớn hơn lương của giáo viên có MAGV=‘001’
select *
from giaovien
where luong >(select luong from giaovien where MAGV='001');
--  Cho những giáo viên có lương nhỏ nhất
select *, min(luong)
from giaovien;

