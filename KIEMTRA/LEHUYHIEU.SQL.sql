-- Thêm dữ liệu vào bảng Mặt hàng
CREATE PROC proc_InsertMatHang(@tenhang nvarchar(50),
								@chitietmathang nvarchar(100),@giaban float,@soluong int)
AS
	INSERT INTO MATHANG
     VALUES
           (@tenhang, 
           @chitietmathang,
           @giaban, 
           @soluong)
  
EXEC proc_InsertMatHang 'Coffee','Trung Nguyen',20000,100
-- Thêm dữ liệu vào bảng Chứng từ
CREATE PROC proc_InsertChungTu(@ngaylap date,@tenkhachhang nvarchar(50),
								@diachikhachhang nvarchar(100),
								@mahang int,@soluong int,@dongia money)															
AS
	INSERT INTO CHUNGTU
     VALUES
           (@NGAYLAP,
           @TENKHACHHANG,
           @DIACHIKHACHHANG, 
           @MAHANG,
           @SOLUONG,
           @DONGIA)
  
EXEC proc_InsertChungTu '2020-8-15','LE HUY HIEU','TP HUE',1,20,20000
-- Thêm dữ liệu vào bảng phiếu thu tiền
CREATE PROC proc_InsertPhieuThuTien(@SOCHUNGTU INT,@NGAYTHUTIEN DATE,@SOTIEN MONEY)
AS
INSERT INTO [dbo].[PHIEUTHUTIEN]
          
     VALUES
           (@SOCHUNGTU,
           @NGAYTHUTIEN,
          @SOTIEN)
EXEC proc_InsertPhieuThuTien 1,'2020-8-17',20000
-- Update Mặt hàng
CREATE PROC proc_updateMatHang(@MAHANG INT,@tenhang nvarchar(50),@chitietmathang nvarchar(100),
								@giaban money,@soluong int )
AS
UPDATE MATHANG
   SET [TENHANG] = @tenhang, 
      [CHITIETMATHANG] = @chitietmathang, 
     [GIABAN] = @giaban, 
      [SOLUONG] = @soluong
 WHERE [MAHANG] = @MAHANG
 -- Update Chứng từ
 CREATE PROC proc_updateChungTu(@sochungtu int,@ngaylap date,@tenkhach nvarchar(50),@diachi nvarchar(100),
								@mahang int, @soluong int,@dongia money)
AS
UPDATE CHUNGTU
   SET [NGAYLAP] = @ngaylap, 
     [TENKHACHHANG] = @tenkhach, 
      [DIACHIKHACHHANG] = @diachi,
      [MAHANG] = @mahang, 
      [SOLUONG] = @soluong, 
      [DONGIA] = @dongia 
 WHERE [SOCHUNGTU] = @sochungtu
 -- Update Phiếu thu tiền
  CREATE PROC proc_updatePhieuThu(@sophieu int,@sochungtu int,@ngaythutien date,@sotien money)
AS
UPDATE PHIEUTHUTIEN
   SET [SOCHUNGTU] = @sochungtu, 
      [NGAYTHUTIEN] = @ngaythutien, 
      [SOTIEN] = @sotien
 WHERE [SOPHIEU] = @sophieu
 -- View của các chứng từ
 CREATE VIEW vw_ChungTu
 AS
 SELECT * FROM CHUNGTU
 -- proc Hiển thị thông tin chi tiết các mặt hàng
 CREATE PROC proc_ShowMatHang
 AS 
 BEGIN 
 SELECT * FROM MATHANG
 END
 EXEC proc_ShowMatHang
 -- PROC trả về thông tin chi tiết của một chứng từ trong CSDL
 ALTER PROC proc_TTCTChungTu (@sochungtu int)
 AS
 BEGIN 
 DECLARE @tableresult TABLE(SOCHUNGTU INT,NGAYLAP DATE,TENKHACHHANG  NVARCHAR(50),DIACHIKHACHHANG NVARCHAR(10),
 MAHANG INT,SOLUONG INT,DONGIA MONEY)
 INSERT INTO  @tableresult
 SELECT  * FROM CHUNGTU C
 WHERE C.SOCHUNGTU = @sochungtu 
 SELECT * FROM @tableresult
 END

 EXEC proc_TTCTChungTu 1
