
SELECT a.hotengv, a.luong FROM GiangVien a JOIN Khoa b ON a.makhoa = b.makhoa;
-- Cho biết mã khoa và tên khoa và số giáo viên của khoa đó
SELECT Khoa.makhoa, Khoa.tenkhoa, COUNT(GiangVien.magv) as soGV
FROM KHOA
JOIN GiangVien
ON Khoa.makhoa = GiangVien.makhoa
GROUP BY KHOA.makhoa, Khoa.tenkhoa

-- Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
SELECT Khoa.dienthoai FROM Khoa JOIN SinhVien
ON KHOA.makhoa = SinhVien.makhoa AND SinhVien.hotensv LIKE 'SINHVIEN2'

-- Cho biết mã số và tên của các đề tài do giảng viên ‘GIAOVIEN1’ hướng dẫn
SELECT DETAI.madt , DETAI.tendt 
FROM HuongDan 
INNER JOIN GiangVien ON  HuongDan.magv = GiangVien.magv
INNER JOIN DeTai ON HuongDan.madt = DeTai.madt
WHERE GiangVien.hotengv like 'GIAOVIEN1'

-- Cho biết tên đề tài không có sinh viên nào thực tập
SELECT * FROM DeTai d
WHERE not exists(SELECT madt FROM HuongDan h WHERE h.madt=d.madt)

-- Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
SELECT * FROM Khoa K
WHERE 



 
 






