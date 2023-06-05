use quanlydetai;
-- ***Dùng các hàm gộp 
-- Câu 1: Cho biết số lượng giáo viên của toàn trường
select count(giaovien.magv) as slgv
from giaovien;
-- Câu 2: Cho biết số lượng giáo viên của bộ môn HTTT
select count(giaovien.magv) as slgvbmHttt
from giaovien
where giaovien.mabm = 'HTTT';
-- Câu 3: Tính số lượng giáo viên có người quản lý về mặt chuyên môn
select count(giaovien.MAGV) as slgvcnqlvcm
from giaovien
where giaovien.gvqlcm is not null;
-- Câu 4: Tính số lượng giáo viên làm nhiệm vụ quản lý chuyên môn cho giáo viên khác mà thuộc bộ môn HTTT.
select count(giaovien.MAGV) as gvqlcmHttt
from giaovien
where giaovien.gvqlcm is not null and giaovien.MABM = 'HTTT';
-- Câu 5:  Tính lương trung bình của giáo viên bộ môn Hệ thống thông tin
select avg(giaovien.luong) as luongTBHttt
from giaovien
where giaovien.MABM='HTTT';
-- ***Dùng group by
-- Câu 6: Với mỗi bộ môn cho biết bộ môn (MAMB) và số lượng giáo viên của bộ môn đó.
select giaovien.MABM,count(giaovien.MAGV) as slgvbm
from giaovien
group by giaovien.MABM;
-- Câu 7: Với mỗi giáo viên, cho biết MAGV và số lượng công việc mà giáo viên đó có tham gia.
select magv,count(*) as slcv
from thamgiadt
group by magv;
--
select  distinct giaovien.MAGV, 
        (select sum((select count(congviec.MADT) 
					 from congviec 
					 where thamgiadt.MADT = congviec.MADT)) 
		 from thamgiadt 
		 where thamgiadt.MAGV = giaovien.MAGV) as soluongcv
from giaovien
order by giaovien.MAGV;

-- Câu 8: Với mỗi giáo viên, cho biết MAGV và số lượng đề tài mà giáo viên đó có tham gia.
SELECT MAGV, COUNT( DISTINCT MADT ) AS SLDT 
FROM THAMGIADT 
GROUP BY MAGV;
--
select distinct giaovien.MAGV, 
       (select count(thamgiadt.MaDT) 
		from thamgiadt 
		where thamgiadt.MAGV = giaovien.MAGV) as soluongdt 
from giaovien
order by giaovien.MAGV;
-- Câu 9:  Với mỗi bộ môn, cho biết số đề tài mà giáo viên của bộ môn đó chủ trì
SELECT GV.MABM, COUNT(*) as 'gvbm chủ trì'
FROM DETAI DT, GIAOVIEN GV
WHERE DT.GVCNDT = GV.MAGV
GROUP BY GV.MABM;
-- Câu 10: Với mỗn bộ môn cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
SELECT BM.TENBM, COUNT(*) as slgvbm
FROM GIAOVIEN GV, BOMON BM
WHERE GV.MABM=BM.MABM
GROUP BY BM.MABM, BM.TENBM;
-- ***Dùng GROUP BY + HAVING
-- Câu 11: Cho biết những bộ môn từ 2 giáo viên trở lên.
SELECT MABM
FROM GIAOVIEN
GROUP BY MABM
HAVING COUNT(*) > 2;
-- Câu 12: Cho tên những giáo viên và số lượng đề tài của những GV tham gia từ 3 đề tài trở lên.
SELECT GV.HOTEN, COUNT( DISTINCT TG.MADT) AS SOLUONGDT
FROM GIAOVIEN GV, THAMGIADT TG
WHERE GV.MAGV = TG.MAGV
GROUP BY GV.MAGV, GV.HOTEN
HAVING COUNT( DISTINCT TG.MADT) >= 3;
-- Câu 13: Cho biết số lượng đề tài được thực hiện trong từng năm.
SELECT YEAR(NGAYBD), COUNT(*)
FROM DETAI
GROUP BY YEAR(NGAYBD);
-- ************************************************A
-- Dùng truy vấn con + mệnh đề SELECT
-- Câu A1: Với mỗi bộ môn, cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
SELECT BM.TENBM, (SELECT COUNT(*)
 FROM GIAOVIEN GV
 WHERE GV.MABM = BM.MABM)
FROM BOMON BM;
-- Dùng truy vấn con + mệnh đề FROM
-- Câu A2: Cho biết họ tên và lương của các giáo viên bộ môn HTTT
SELECT T.HOTEN, T.LNG
FROM ( SELECT MAGV, HOTEN, LUONG as LNG
FROM GIAOVIEN
WHERE MABM= 'HTTT') as T;
-- Dùng truy vấn con + mệnh đề WHERE
-- Câu A3: Cho biết những giáo viên có lương lớn hơn lương của giáo viên có MAGV=‘001’
SELECT *
FROM GIAOVIEN
WHERE LUONG > (SELECT LUONG
FROM GIAOVIEN
WHERE MAGV= '001');
-- Câu A4: Cho biết họ tên những giáo viên mà không có một người thân nào
select hoten
from giaovien
where magv not in (select magv from nguoithan);
-- Câu A5: Cho những giáo viên có tham gia đề tài
select *
from giaovien
where MAGV in (select magv from thamgiadt);
-- Câu A6: Cho những giáo viên có lương nhỏ nhất
SELECT *
FROM GIAOVIEN
WHERE LUONG <= ALL (SELECT LUONG FROM GIAOVIEN);
--
select *
from giaovien
where luong<= (select min(luong) from giaovien);
-- Câu A7: Cho những giáo viên có lương cao hơn tất cả các giáo viên của bộ môn HTTT
SELECT *
FROM GIAOVIEN
WHERE LUONG >=ALL(SELECT LUONG
					FROM GIAOVIEN
					WHERE MABM= 'HTTT');
--
SELECT *
FROM GIAOVIEN
where luong>= (select max(luong) from giaovien where MABM='HTTT');
-- Câu A8: Cho biết bộ môn (MABM) có đông giáo viên nhất
select mabm, count(*) 'slgv nhiều nhất'
from giaovien
group by mabm
having count(*) >= all (select count(*)
						from giaovien
						group by mabm);
-- Câu A9: Cho biết họ tên những giáo viên mà không có một người thân nào. (Sử dụng ALL thay vì NOT IN)
select magv,hoten
from giaovien
where magv != all(select magv from nguoithan);
-- Câu A10: Cho biết họ tên những giáo viên có tham gia đề tài. (Sử dụng = ANY thay vì IN)
select magv,hoten
from giaovien
where magv = any(select magv from thamgiadt);
-- Câu A11: Cho biết các giáo viên có tham gia đề tài.
select *
from giaovien
where magv = any(select magv from thamgiadt);
-- Câu A12: Cho biết các giáo viên không có người thân
SELECT HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS ( SELECT *
FROM NGUOITHAN NT
WHERE NT.MAGV = GV.MAGV);

-- Câu A14: Cho biết những giáo viên có lương lớn hơn lương trung bình của bộ môn mà giáo viên đó làm việc.
 SELECT * 
FROM giaovien gv
where gv.LUONG > (select avg(gv1.LUONG) from giaovien gv1 where gv.MABM = gv1.MABM);
-- cách 2:
SELECT * 
FROM giaovien gv join (
	SELECT MABM, avg(LUONG) as ltb
	FROM giaovien
	group by MABM
) as tb_luong on gv.MABM = tb_luong.MABM
where gv.LUONG > tb_luong.ltb;
-- Câu A15: Cho biết những giáo viên có lương lớn nhất
select magv,hoten,luong as luonglonnhat
from giaovien
where luong = (select max(giaovien.luong) from giaovien);
-- Câu A16: Cho biết những đề tài mà giáo viên ‘001’ không tham gia.
select madt,tendt
from detai
where madt not in (select madt from thamgiadt where magv = '001');
-- Câu A17: Cho biết họ tên những giáo viên có vai trò quản lý về mặt chuyên môn với các giáo viên khác
select magv,hoten
from giaovien
where magv in (select gvqlcm from giaovien where gvqlcm is not null);
-- Câu A18: Cho biết những giáo viên có lương lớn nhất.
select MAGV,hoten,luong from giaovien
where giaovien.LUONG >= all(SELECT LUONG from giaovien);
-- Câu A19: Cho biết những bộ môn (MABM) có đông giáo viên nhất
SELECT MABM,count(*) as slgv
FROM GIAOVIEN
GROUP BY MABM
HAVING COUNT(*) >= ALL ( SELECT COUNT(*)
FROM GIAOVIEN GV
GROUP BY GV.MABM);
-- 
select bomon.MABM, count(giaovien.MABM) as soluonggiaovien
from giaovien
join bomon on bomon.MABM = giaovien.MABM
group by giaovien.MABM
having soluonggiaovien = (SELECT MAX(count) 
							FROM (SELECT COUNT(giaovien.MABM) as count 
                            FROM giaovien GROUP BY giaovien.MABM) as counts);













-- Câu A20: Cho biết những tên bộ môn, họ tên của trưởng bộ môn và số lượng giáo viên của bộ môn có đông giáo viên nhất
select bm.TENBM, gv2.HOTEN, count(gv1.MABM) as soluonggiaovienmax
from bomon bm
join giaovien gv2 on bm.TRUONGBM = gv2.MAGV
join giaovien gv1 on bm.MABM = gv1.MABM
group by gv1.MABM
having soluonggiaovienmax = (SELECT MAX(count) FROM (SELECT COUNT(gv1.MABM) as count FROM giaovien gv1 GROUP BY gv1.MABM) as counts);
-- Câu A21: Cho biết những giáo viên có lương lớn hơn mức lương trung bình của giáo viên bộ môn Hệ thống thông tin mà không trực thuộc bộ môn hệ thống thông tin
-- Câu A22: Cho tên biết đề tài có đông giáo viên tham gia nhất viên bộ môn Hệ thống thông tin mà không trực thuộc bộ môn hệ thống thông tin
-- ************************************************B
-- Câu B2: Tìm các giáo viên không tham gia đề tài nào
-- Câu B3: Tìm các giáo viên vừa tham gia đề tài vừa là trưởng bộ môn.
-- Câu B4: Liệt kê những giáo viên có tham gia đề tài và những giáo viên là trưởng bộ môn.
SELECT distinct giaovien.MAGV 
FROM giaovien 
cross join bomon, thamgiadt where giaovien.MAGV = bomon.TRUONGBM or giaovien.MAGV = thamgiadt.MAGV
ORDER BY giaovien.MAGV;
-- Câu B5: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài
-- Câu B6: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài (Dùng NOT EXISTS)
select gv.magv from giaovien gv
where not exists (select tgdt.magv from thamgiadt tgdt where gv.magv not in (select thamgiadt.MAGV from thamgiadt))
order by gv.magv;
-- Câu B7: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài (Dùng NOT EXISTS)
-- Câu B9: Tìm tên các giáo viên ‘HTTT’ mà tham gia tất cả các đề tài thuộc chủ đề ‘QLGD
​
​
-- ADVANCED
-- Cho biết tên giáo viên và tên của giáo viên có nhiều người thân nhất
-- Cho biết tên của giáo viên lớn tuổi nhất của bộ môn hệ thống thông tin
-- Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia
-- Cho biết tên của giáo viên chủ nhiệm nhiều đề tài nhất.
-- Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất
-- Cho biết tên đề tài nào mà được tất cả giáo viên của bộ môn hóa hữu cơ tham gia
