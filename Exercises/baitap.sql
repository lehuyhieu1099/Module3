-- 1. Danh sách các đối tác của công ty
SELECT * 
FROM NHACUNGCAP
-- 2. Mã hàng, tên hàng và số lượng của các mặt hàng hiện có trong công ty
SELECT M.MAHANG,M.TENHANG,M.SOLUONG
FROM MATHANG M
-- 3. Họ tên, địa chỉ và năm bắt đầu làm việc của các nhân viên trong công ty.
SELECT CONCAT(N.HO,' ',N.TEN)  'NAME ',N.DIACHI,YEAR(N.NGAYLAMVIEC) AS 'YEAR'
FROM NHANVIEN N
-- 4. Địa chỉ và điện thoại của nhà cung cấp có tên giao dịch là VINAMILK là gì?
SELECT N.DIACHI, N.DIENTHOAI 
FROM NHACUNGCAP N
WHERE N.TENGIAODICH LIKE 'VINAMILK'
-- 5. Cho biết mã và tên của các mặt hàng có giá lớn hơn 100000 và số lượng hiện có ít hơn 50
SELECT *
FROM MATHANG M
WHERE M.GIAHANG > 100000 AND M.SoLuong <50
-- 6. Cho biết mỗi mặt hàng trong công ty do ai cung cấp
SELECT M.TENHANG,N.TENCONGTY 
FROM MATHANG M
INNER JOIN NHACUNGCAP N ON M.MACONGTY = N.MACONGTY
-- 7.Công Ty Việt Tiến đã cung cấp những mặt hàng nào
SELECT * FROM MATHANG M
INNER JOIN NHACUNGCAP N ON N.MACONGTY = M.MACONGTY
WHERE N.TENCONGTY LIKE N'Việt Tiến'
-- 8. Loại hàng thực phẩm do những công ty nào cung cấp và địa chỉ của công ty đó là gì?
SELECT N.TENCONGTY,N.DIACHI,L.TenLoaiHang FROM NHACUNGCAP N
INNER JOIN MATHANG M ON  M.MACONGTY= N.MACONGTY
INNER JOIN LOAIHANG L ON L.MALOAIHANG = M.MALOAIHANG
WHERE L.TENLOAIHANG = N'Thực phẩm'
-- 9. Những khách hàng nào đã mua mặt hàng sữa hộp xyz của công ty
SELECT K.TENGIAODICH, l.TenLoaiHang FROM NHACUNGCAP N

INNER JOIN MATHANG M ON M.MACONGTY = N.MACONGTY
INNER JOIN LOAIHANG L ON L.MALOAIHANG = M.MALOAIHANG
INNER JOIN CHITIETDATHANG C ON C.MAHANG = M.MAHANG
INNER JOIN DONDATHANG D ON D.SOHOADON = C.SOHOADON
INNER JOIN KHACHHANG K ON K.MAKHACHHANG = D.MAKHACHHANG
WHERE  M.TenHang LIKE N'SỮA HỘP XYZ'
-- 10. Đơn đặt hàng số 1 do ai đặt và do nhân viên nào lập, thời gian và địa điểm giao hàng là ở đâu?
SELECT D.SOHOADON, K.TENGIAODICH,
CONCAT(N.HO,' ',N.TEN)AS 'EMPLOYEE NAME',D.NGAYGIAOHANG,D.NOIGIAOHANG 
FROM DONDATHANG D
INNER JOIN NHANVIEN N ON N.MANHANVIEN = D.MANHANVIEN
INNER JOIN KHACHHANG K ON K.MAKHACHHANG = D.MAKHACHHANG
WHERE D.SOHOADON = 1
-- 11. Hãy cho biết số tiền lương mà công ty phải trả cho mỗi nhân viên là bao nhiêu (lcb +pc)
SELECT N.*,(N.LUONGCOBAN+N.PHUCAP) AS 'LUONG' FROM NHANVIEN N
--2. 12 Trong đơn đặt hàng số 3 đặt mua những mặt hàng nào và số tiền mà khách hàng
--phải trả cho mỗi mặt hàng là bao nhiêu (số tiền phải trả được tính theo công thức
--SOLUONG×GIABAN – SOLUONG×GIABAN×MUCGIAMGIA)
SELECT C.SoHoaDon,M.TenHang,
(C.SoLuong*C.GiaBan -C.SoLuong*C.GiaBan*C.MucGiamGia) AS 'AMOUNT'
FROM DONDATHANG D
INNER JOIN CHITIETDATHANG C ON C.SoHoaDon = D.SoHoaDon
INNER JOIN MATHANG M ON C.MaHang = M.MaHang
WHERE C.SoHoaDon =3
--2. 13 Hãy cho biết có những khách hàng nào lại chính là đối tác cung cấp hàng của
--công ty (tức là có cùng tên giao dịch).
SELECT K.[[TenGiaoDich],N.TenGiaoDich FROM KHACHHANG K
INNER JOIN DONDATHANG D ON K.MaKhachHang = D.MaKhachHang
INNER JOIN CHITIETDATHANG C ON D.SoHoaDon = C.SoHoaDon
INNER JOIN MATHANG M ON C.MaHang = M.MaHang
INNER JOIN NHACUNGCAP N ON N.MaCongTy = M.MaCongTy
WHERE k.[[TenGiaoDich] = n.TenGiaoDich
--2. 14 Trong công ty có những nhân viên nào có cùng ngày sinh
SELECT  A.HO,A.TEN,A.NgaySinh,B.HO,B.TEN  FROM NHANVIEN A
INNER JOIN NHANVIEN B ON A.NgaySinh = B.NGAYSINH
WHERE A.MaNhanVien <> B.MaNhanVien
--2. 15 Những đơn đặt hàng nào yêu cầu giao hàng ngay tại công ty đặt hàng và những
--đơn đó là của công ty nào?(NOIGIAOHANG = TENCONGTY)
SELECT D.NoiGiaoHang,K.TenCongTy FROM DONDATHANG D
INNER JOIN KHACHHANG K ON K.MaKhachHang = D.MaKhachHang
WHERE D.NoiGiaoHang = K.TenCongTy
--2. 16 Cho biết tên công ty, tên giao dịch, địa chỉ và điện thoại của các khách hàng và
--các nhà cung cấp hàng cho công ty.
SELECT K.*,N.* FROM  KHACHHANG K
INNER JOIN DONDATHANG D ON K.MAKHACHHANG = D.MAKHACHHANG
INNER JOIN CHITIETDATHANG C ON C.SOHOADON = D.SOHOADON	
INNER JOIN MATHANG M ON M.MAHANG = C.MAHANG
INNER JOIN NHACUNGCAP N ON N.MACONGTY = M.MACONGTY
--2. 17 Những mặt hàng nào chưa từng được khách hàng đặt mua?
SELECT M.* FROM MATHANG M
LEFT JOIN CHITIETDATHANG C ON C.MAHANG = M.MAHANG
WHERE C.SOHOADON IS NULL
-- 2.18 Những nhân viên nào của công ty chưa từng lập bất kỳ một hoá đơn đặt hàng
--nào?
SELECT N.* FROM NHANVIEN N
LEFT JOIN DONDATHANG D ON D.MANHANVIEN = N.MANHANVIEN
WHERE D.SOHOADON IS NULL
--2. 19 Nhân viên nào của công ty có lương cơ bản cao nhất?
SELECT TOP(1) N.*
FROM NHANVIEN N
ORDER BY LUONGCOBAN DESC
--2. 20 Tổng số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng là bao nhiêu?
SELECT K.[[TENGIAODICH] ,C.SOHOADON,
(C.SOLUONG*C.GIABAN - C.SOLUONG*C.GIABAN*C.MUCGIAMGIA) AS 'AMOUNT'
FROM KHACHHANG K
INNER JOIN DONDATHANG D ON D.MAKHACHHANG = K.MAKHACHHANG
INNER JOIN CHITIETDATHANG C ON C.SOHOADON = D.SOHOADON
--2. 21 Trong năm 2020, những mặt hàng nào chỉ được đặt mua đúng một lần.
SELECT M.MAHANG,M.TENHANG,C.SOHOADON FROM MATHANG M
INNER JOIN CHITIETDATHANG C ON M.MAHANG = M.MAHANG
INNER JOIN DONDATHANG D ON C.SOHOADON = D.SOHOADON
GROUP BY M.MAHANG,M.TENHANG,C.SOHOADON
HAVING COUNT(C.MAHANG) =1
--2. 22 Hãy cho biết mỗi một khách hàng đã phải bỏ ra bao nhiêu tiền để đặt mua hàng
--của công ty?
SELECT K.[[TENGIAODICH] ,
SUM(C.SOLUONG*C.GIABAN - C.SOLUONG*C.GIABAN*C.MUCGIAMGIA) AS 'AMOUNT'
FROM KHACHHANG K
INNER JOIN DONDATHANG D ON D.MAKHACHHANG = K.MAKHACHHANG
INNER JOIN CHITIETDATHANG C ON C.SOHOADON = D.SOHOADON
GROUP BY K.[[TENGIAODICH] 
--2. 23 Mỗi một nhân viên của công ty đã lập bao nhiêu đơn đặt hàng (nếu nhân viên
--chưa hề lập một hoá đơn nào thì cho kết quả là 0)
SELECT N.MANHANVIEN,
COUNT(N.MANHANVIEN) AS 'COUNT'
FROM NHANVIEN N 
LEFT JOIN DONDATHANG D ON D.MANHANVIEN = N.MANHANVIEN
GROUP BY N.MANHANVIEN
--2. 24 Cho biết tổng số tiền hàng mà cửa hàng thu được trong mỗi tháng của năm 2020
--(thời được gian tính theo ngày đặt hàng).
SELECT MONTH(D.NGAYDATHANG) AS 'MONTH',YEAR(D.NGAYDATHANG) AS 'YEAR',
SUM(C.SOLUONG*C.GIABAN - C.SOLUONG*C.GIABAN*C.MUCGIAMGIA) AS 'AMOUNT'
FROM DONDATHANG D
INNER JOIN CHITIETDATHANG C ON C.SOHOADON = D.SOHOADON
GROUP BY MONTH(D.NGAYDATHANG),YEAR(D.NGAYDATHANG)
HAVING YEAR(D.NGAYDATHANG) = 2020
--2. 25 Hãy cho biết tổng số tiền lời mà công ty thu được từ mỗi mặt hàng trong năm
--2020.
SELECT M.TENHANG,M.GIAHANG,C.GIABAN,
(C.GIABAN*C.SOLUONG - C.SOLUONG*M.GIAHANG) AS 'MONEY'
FROM MATHANG M
INNER JOIN CHITIETDATHANG C ON C.MAHANG = M.MAHANG
--2. 26 Hãy cho biết tổng số lượng hàng của mỗi mặt hàng mà công ty đã có (tổng số
--lượng hàng hiện có và đã bán).
SELECT M.TENHANG,
(M.SOLUONG+SUM(C.SOLUONG)) AS 'DA CO'
FROM MATHANG M
INNER JOIN CHITIETDATHANG C ON C.MAHANG = M.MAHANG
GROUP BY M.TENHANG,M.SOLUONG
--2. 27 Nhân viên nào của công ty bán được số lượng hàng nhiều nhất và số lượng hàng
--bán được của những nhân viên này là bao nhiêu?

--2. 28 Đơn đặt hàng nào có số lượng hàng được đặt mua ít nhất?
--2. 29 Số tiền nhiều nhất mà mỗi khách hàng đã từng bỏ ra để đặt hàng trong các đơn
--đặt hàng là bao nhiêu?
--2. 30 Mỗi một đơn đặt hàng đặt mua những mặt hàng nào và tổng số tiền mà mỗi đơn
--đặt hàng phải trả là bao nhiêu?
--2. 31 Hãy cho biết mỗi một loại hàng bao gồm những mặt hàng nào, tổng số lượng
--hàng của mỗi loại và tổng số lượng của tất cả các mặt hàng hiện có trong công ty
--là bao nhiêu?
--2. 32 Thống kê xem trong năm 2003, mỗi một mặt hàng trong mỗi tháng và trong cả
--năm bán được với số lượng bao nhiêu
--Yêu cầu: Kết quả được hiển thị dưới dạng bảng, hai cột cột đầu là mã hàng và
--tên hàng, các cột còn lại tương ứng với các tháng từ 1 đến 12 và cả năm. Như
--vậy mỗi dòng trong kết quả cho biết số lượng hàng bán được mỗi tháng và trong
--cả năm của mỗi mặt hàng.
--Sử dụng câu lệnh UPDATE để thực hiện các yêu cầu sau:
--2. 33 Cập nhật lại giá trị trường NGAYCHUYENHANG của những bản ghi có
--NGAYCHUYENHANG chưa xác định (NULL) trong bảng DONDATHANG
--bằng với giá trị của trường NGAYDATHANG.

--2. 34 Tăng số lượng hàng của những mặt hàng do công ty VINAMILK cung cấp lên gấp
--đôi.
--2. 35 Cập nhật giá trị của trường NOIGIAOHANG trong bảng DONDATHANG bằng địa
--chỉ của khách hàng đối với những đơn đặt hàng chưa xác định được nơi giao hàng
--(giá trị trường NOIGIAOHANG bằng NULL).
--2. 36 Cập nhật lại dữ liệu trong bảng KHACHHANG sao cho nếu tên công ty và tên giao
--dịch của khách hàng trùng với tên công ty và tên giao dịch của một nhà cung cấp
--nào đó thì địa chỉ, điện thoại, fax và e-mail phải giống nhau.
--2. 37 Tăng lương lên gấp rưỡi cho những nhân viên bán được số lượng hàng nhiều hơn
--100 trong năm 2003.
--2. 38 Tăng phụ cấp lên bằng 50% lương cho những nhân viên bán được hàng nhiều nhất.
--2. 39 Giảm 25% lương của những nhân viên trong năm 2003 không lập được bất kỳ đơn
--đặt hàng nào.
--2. 40 Giả sử trong bảng DONDATHANG có thêm trường SOTIEN cho biết số tiền mà
--khách hàng phải trả trong mỗi đơn đặt hàng. Hãy tính giá trị cho trường này.

--Thực hiện các yêu cầu dưới đây bằng câu lệnh DELETE.
--2. 41 Xoá khỏi bảng NHANVIEN những nhân viên đã làm việc trong công ty quá 40 năm.
--2. 42 Xoá những đơn đặt hàng trước năm 2000 ra khỏi cơ sở dữ liệu.
--2. 43 Xoá khỏi bảng LOAIHANG những loại hàng hiện không có mặt hàng.
--2. 44 Xoá khỏi bảng KHACHHANG những khách hàng hiện không có bất kỳ đơn đặt
--hàng nào cho công ty.
--2. 45 Xoá khỏi bảng MATHANG những mặt hàng có số lượng bằng 0 và không được đặt
--mua trong bất kỳ đơn đặt hàng nào.Những nhân viên nào của công ty chưa từng lập bất kỳ một hoá đơn đặt hàng
--nào?










