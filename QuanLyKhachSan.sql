create database QLKS
go
use QLKS
go

-- Tạo bảng khách sạn
CREATE TABLE khachsan (
  id VARCHAR(5) PRIMARY KEY,
  ten NVARCHAR(50) NOT NULL,
  dia_chi VARCHAR(100) NOT NULL
);

-- Tạo bảng người dùng
CREATE TABLE nhanvien (
  id_nhanvien VARCHAR(5) PRIMARY KEY,
  ten_nhanvien NVARCHAR(100) NOT NULL,
  ngay_sinh DATE NOT NULL,
  sdt VARCHAR(10) NOT NULL,
  gioi_tinh NVARCHAR(6) NOT NULL,
  email VARCHAR(50) NOT NULL,
  hinh_anh VARCHAR(100) DEFAULT '',
);
GO

CREATE TABLE taikhoan (
	id_taikhoan INT IDENTITY(1,1) PRIMARY KEY,
	id_nhanvien VARCHAR(5),
	ten_dang_nhap VARCHAR(100) NOT NULL,
	mat_khau VARCHAR(100) DEFAULT '123',
	hoat_dong INT,
	quyen NVARCHAR(20) DEFAULT 'staff',
	FOREIGN KEY (id_nhanvien) REFERENCES nhanvien(id_nhanvien),
);
GO

-- Tạo bảng loại phòng
CREATE TABLE loaiphong (
	id_loaiphong INT PRIMARY KEY,
	ten_loai NVARCHAR(50) NOT NULL,
	so_luong_nguoi INT NOT NULL,
	mota NVARCHAR(500)
);
GO

CREATE TABLE tang(
	id_tang INT PRIMARY KEY,
	ten_tang NVARCHAR(20)
);
GO

-- Tạo bảng phòng
CREATE TABLE phong (
	id_phong VARCHAR(5) PRIMARY KEY,
	id_loaiphong INT NOT NULL,
	id_tang INT NOT NULL,
	ten NVARCHAR(50) NOT NULL,
	--so_luong_nguoi INT NOT NULL,
	trang_thai NVARCHAR(30) DEFAULT N'Còn trống',
	gia INT NOT NULL
	CONSTRAINT fk_loaiphong FOREIGN KEY (id_loaiphong) REFERENCES loaiphong(id_loaiphong),
	CONSTRAINT fk_tang FOREIGN KEY (id_tang) REFERENCES tang(id_tang)
);
GO

-- Tạo bảng hình cho phòng
CREATE TABLE imgphong (
	id_loaiphong INT,
	id_hinh VARCHAR(150),
	CONSTRAINT pk_imgphong PRIMARY KEY(id_loaiphong, id_hinh),
	CONSTRAINT fk_loaiphong_imgphong FOREIGN KEY (id_loaiphong) REFERENCES loaiphong(id_loaiphong)
);
GO

-- Tạo bảng dịch vụ
CREATE TABLE dichvu (
	id_dichvu VARCHAR(5) PRIMARY KEY,
	ten_dichvu NVARCHAR(50) NOT NULL,
	gia INT NOT NULL
);

-- Tạo bảng dịch vụ
CREATE TABLE thietbi (
	id_thietbi VARCHAR(5) PRIMARY KEY,
	ten_thietbi NVARCHAR(50) NOT NULL,
	gia INT NOT NULL
);
GO

-- Tạo bảng khách hàng
CREATE TABLE khachhang (
	id_khachhang VARCHAR(5) PRIMARY KEY,
	ten_khachhang NVARCHAR(50) NOT NULL,
	ngay_sinh DATE NOT NULL,
	dia_chi NVARCHAR(300) NOT NULL,
	sdt VARCHAR(15) NOT NULL,
	cmnd VARCHAR(15) NOT NULL,
	gioi_tinh NVARCHAR(6) NOT NULL,
);
GO

-- Tạo bảng đặt phòng
CREATE TABLE datphong (
	id_datphong VARCHAR(5) PRIMARY KEY,
	id_nhanvien VARCHAR(5) NOT NULL,
	id_khachhang VARCHAR(5) NOT NULL,
	id_phong VARCHAR(5) NOT NULL,
	check_in datetime NOT NULL,
	check_out datetime,
	dat_coc FLOAT,
	tien_phong FLOAT DEFAULT 0,
	phu_thu_checkin FLOAT,
	phu_thu_checkout FLOAT,
	tong_tien_dv FLOAT DEFAULT 0,
	tong_tien_tb FLOAT DEFAULT 0,
	tong_tien_hoa_don FLOAT DEFAULT 0,
	tong_tien FLOAT,
	so_nguoi_o int,
	loai NVARCHAR(20),
	trang_thai NVARCHAR(40) DEFAULT N'Chưa thanh toán'
	CONSTRAINT fk_nhanvien FOREIGN KEY (id_nhanvien) REFERENCES nhanvien(id_nhanvien),
	CONSTRAINT fk_phong FOREIGN KEY (id_phong) REFERENCES phong(id_phong),
	CONSTRAINT fk_khachhang FOREIGN KEY (id_khachhang) REFERENCES khachhang(id_khachhang),
);
GO

CREATE TABLE datphongonline (
	id_datphong INT IDENTITY(1, 1) PRIMARY KEY,
	id_phong VARCHAR(5) NOT NULL,
	check_in datetime NOT NULL,
	check_out datetime NOT NULL,
	tong_tien FLOAT NOT NULL,
	so_nguoi_o int NOT NULL,
	trang_thai NVARCHAR(40) DEFAULT N'Chưa thanh toán',
	ten_khachhang NVARCHAR(50) NOT NULL,
	ngay_sinh DATE NOT NULL,
	dia_chi NVARCHAR(300) NOT NULL,
	sdt VARCHAR(15) NOT NULL,
	cmnd VARCHAR(15) NOT NULL,
	gioi_tinh NVARCHAR(6) NOT NULL,
	CONSTRAINT fk_phong_online FOREIGN KEY (id_phong) REFERENCES phong(id_phong)
);

GO

CREATE TABLE chitietsudungdv(
	id_datphong VARCHAR(5) NOT NULL,
	id_dichvu VARCHAR(5) NOT NULL,
	ngay_thue DATE,
	so_luong INT,
	tong_tien_dv FLOAT,
	CONSTRAINT fk_datphong_ctsddv FOREIGN KEY (id_datphong) REFERENCES datphong(id_datphong),
	CONSTRAINT fk_dichvu_ctsddv FOREIGN KEY (id_dichvu) REFERENCES dichvu(id_dichvu),
	PRIMARY KEY(id_datphong, id_dichvu)
);
GO

CREATE TABLE chitietsudungtb(
	id_datphong VARCHAR(5) NOT NULL,
	id_thietbi VARCHAR(5) NOT NULL,
	ngay_thue DATE,
	so_luong INT,
	tong_tien_tb FLOAT,
	CONSTRAINT fk_datphong_ctsdtb FOREIGN KEY (id_datphong) REFERENCES datphong(id_datphong),
	CONSTRAINT fk_dichvu_ctsdtb FOREIGN KEY (id_thietbi) REFERENCES thietbi(id_thietbi),
	PRIMARY KEY(id_datphong, id_thietbi)
);
GO


select * from phong
select * from loaiphong

insert into tang values(1, N'Tầng 1')
insert into tang values(2, N'Tầng 2')
insert into tang values(3, N'Tầng 3')
go

insert into loaiphong values(1, N'Phòng đơn loại 1', 1, N'Phòng đơn loại 1 tại GreenInn là sự hoàn hảo của sự tinh tế và tiện nghi. Với kiến ​​trúc độc đáo kết hợp giữa vẻ cổ điển và thiết kế hiện đại, mỗi phòng đều là một không gian ấm áp và thoải mái. Nội thất sang trọng và cao cấp được chăm chút tỉ mỉ.')
insert into loaiphong values(2, N'Phòng đơn loại 2', 1, N'Phòng đơn loại 2 không chỉ là một nơi nghỉ ngơi, mà còn là điểm đến của sự sang trọng và tiện nghi. Tận hưởng không gian riêng tư của bạn trong không gian ấm cúng và đẳng cấp tại GreenInn, nơi mà mọi yêu cầu của bạn đều được chăm sóc với tận tâm và chất lượng.')
insert into loaiphong values(3, N'Phòng đôi loại 1', 2, N'Phòng đôi loại 1 của chúng tôi không chỉ là một nơi nghỉ ngơi, mà còn là điểm đến của sự sang trọng và tiện nghi. Tận hưởng không gian riêng tư của bạn trong không gian ấm cúng và đẳng cấp tại GreenInn.')
insert into loaiphong values(4, N'Phòng đôi loại 2', 2, N'Phòng đôi loại 2 được thiết kế để mang đến trải nghiệm lưu trú đặc biệt, với không gian rộng rãi, trang thiết bị hiện đại và dịch vụ chăm sóc khách hàng hàng đầu.')
insert into loaiphong values(5, N'Phòng VIP đơn Standard', 1, N'Phòng VIP đơn loại Standard tại chỗ nghỉ của chúng tôi là sự kết hợp tuyệt vời giữa tiện nghi cao cấp và không gian thoải mái. Nơi đây được thiết kế đặc biệt để đáp ứng mọi nhu cầu của khách hàng VIP, mang đến trải nghiệm lưu trú đẳng cấp và sang trọng.')
insert into loaiphong values(6, N'Phòng VIP đôi Standard', 2, N'Phòng VIP đôi loại Standard tại chỗ nghỉ của chúng tôi là sự kết hợp hoàn hảo giữa tiện nghi cao cấp và không gian sang trọng. Đây là nơi lưu trú lý tưởng cho các cặp đôi hoặc những người muốn trải nghiệm không gian sang trọng và đẳng cấp cùng nhau.')
go

insert into imgphong values(1, 'loai1_img1.jpg')
insert into imgphong values(1, 'loai1_img2.jpg')
insert into imgphong values(1, 'loai1_img3.jpg')
insert into imgphong values(1, 'loai1_img4.jpg')--#Loai 1
insert into imgphong values(2, 'loai2_img1.jpg')
insert into imgphong values(2, 'loai2_img2.jpg')
insert into imgphong values(2, 'loai2_img3.jpg')
insert into imgphong values(2, 'loai2_img4.jpg')--#Loai 2
insert into imgphong values(3, 'loai3_img1.jpg')
insert into imgphong values(3, 'loai3_img2.jpg')
insert into imgphong values(3, 'loai3_img3.jpg')
insert into imgphong values(3, 'loai3_img4.jpg')--#Loai 3
insert into imgphong values(4, 'loai4_img1.jpg')
insert into imgphong values(4, 'loai4_img2.jpg')
insert into imgphong values(4, 'loai4_img3.jpg')
insert into imgphong values(4, 'loai4_img4.jpg')--#Loai 4
insert into imgphong values(5, 'loai5_img1.jpg')
insert into imgphong values(5, 'loai5_img2.jpg')
insert into imgphong values(5, 'loai5_img3.jpg')
insert into imgphong values(5, 'loai5_img4.jpg')--#Loai 5
insert into imgphong values(6, 'loai6_img1.jpg')
insert into imgphong values(6, 'loai6_img2.jpg')
insert into imgphong values(6, 'loai6_img3.jpg')
insert into imgphong values(6, 'loai6_img4.jpg')--#Loai 6
go

insert into phong values('P001', 1, 1, N'Phòng 101', N'Còn trống', 250000)
insert into phong values('P002', 1, 1, N'Phòng 102', N'Còn trống', 250000)
insert into phong values('P003', 1, 1, N'Phòng 103', N'Còn trống', 250000)
insert into phong values('P004', 2, 1, N'Phòng 104', N'Còn trống', 350000)
insert into phong values('P005', 2, 1, N'Phòng 105', N'Còn trống', 350000)
insert into phong values('P006', 2, 1, N'Phòng 106', N'Còn trống', 350000)
insert into phong values('P007', 3, 2, N'Phòng 107', N'Còn trống', 650000)
insert into phong values('P008', 3, 2, N'Phòng 108', N'Còn trống', 650000)
insert into phong values('P009', 3, 2, N'Phòng 109', N'Còn trống', 650000)
insert into phong values('P010', 4, 2, N'Phòng 110', N'Còn trống', 850000)
insert into phong values('P011', 4, 2, N'Phòng 111', N'Còn trống', 850000)
insert into phong values('P012', 4, 2, N'Phòng 112', N'Còn trống', 850000)
insert into phong values('P013', 5, 3, N'Phòng 113', N'Còn trống', 810000)
insert into phong values('P014', 5, 3, N'Phòng 114', N'Còn trống', 810000)
insert into phong values('P015', 5, 3, N'Phòng 115', N'Còn trống', 810000)
insert into phong values('P016', 6, 3, N'Phòng 116', N'Còn trống', 950000)
insert into phong values('P017', 6, 3, N'Phòng 117', N'Còn trống', 950000)
insert into phong values('P018', 6, 3, N'Phòng 118', N'Đang sử dụng', 950000)
go

insert into thietbi values('TB001', N'Dép (1 đôi)', 100000)
insert into thietbi values('TB002', N'Nước suối (1 chai)', 10000)
insert into thietbi values('TB003', N'Dầu gội (1 chai nhỏ)', 15000)
insert into thietbi values('TB004', N'Sữa tắm (1 chai nhỏ)', 15000)
insert into thietbi values('TB005', N'Kem đánh răng (1 tuýp nhỏ)', 15000)
insert into thietbi values('TB006', N'Bàn chải (1 cây)', 5000)
insert into thietbi values('TB007', N'Khăn tắm (1 cái)', 100000)
insert into thietbi values('TB008', N'Máy sấy tóc (1 cái)', 300000)
insert into thietbi values('TB009', N'Cà phê (1 gói)', 5000)
go

insert into dichvu values('DV001', N'Giặt ủi', 200000)
insert into dichvu values('DV002', N'Quầy bar', 300000)
insert into dichvu values('DV003', N'Dịch vụ spa', 250000)
insert into dichvu values('DV004', N'Fitness', 350000)
insert into dichvu values('DV005', N'Buổi ăn phụ', 200000)
insert into dichvu values('DV006', N'Sử dụng hồ bơi', 150000)
insert into dichvu values('DV007', N'Karaoke', 250000)
go

set dateformat dmy insert into nhanvien values('NV001', N'Phạm Lê Tuấn Anh', '05-12-2002', '0123456789', N'Nam', 'ta@gmail.com', 'picture3.png')
set dateformat dmy insert into nhanvien values('NV002', N'Lư Gia Hoàng', '31-08-2002', '0123456789', N'Nam', 'hoang@gmail.com', 'picture2.png')
set dateformat dmy insert into nhanvien values('NV003', N'Trần Đỗ Anh Hào', '27-03-2002', '0123456789', N'Nam', 'hao@gmail.com', 'picture1.png')
go


--Thêm nhân viên, tự động thêm mã nhân viên (tự tăng)
--CREATE PROCEDURE Them_Nhan_Vien

--	@ten_nhanvien NVARCHAR(100),
--	@ngay_sinh DATE,
--	@sdt VARCHAR(10),
--	@gioi_tinh NVARCHAR(6),
--	@email VARCHAR(50),
--	@hinh_anh VARCHAR(100),
--	@ten_dang_nhap VARCHAR(50),
--	@mat_khau VARCHAR(50),
--	@quyen INT
--AS
--BEGIN
--    DECLARE @Ma_NV NVARCHAR(10)
--    DECLARE @Max_Ma_NV NVARCHAR(10)
--    SELECT @Max_Ma_NV = MAX(id_nhanvien) FROM nhanvien
--    IF @Max_Ma_NV IS NULL
--        SET @Ma_NV = 'NV001'
--    ELSE
--        SET @Ma_NV = 'NV' + RIGHT('000' + CAST(RIGHT(@Max_Ma_NV, 3) + 1 AS VARCHAR(3)), 3)
    
--    INSERT INTO nhanvien(id_nhanvien, ten_nhanvien, ngay_sinh, sdt, gioi_tinh, email, hinh_anh, ten_dang_nhap, mat_khau, quyen)
--	VALUES(@Ma_NV, @ten_nhanvien, @ngay_sinh, @sdt, @gioi_tinh, @email, @hinh_anh, @ten_dang_nhap, @mat_khau, @quyen)
--END;
--GO
--set dateformat dmy EXEC Them_Nhan_Vien N'Huỳnh Khánh Duy', '27-03-2002', '0123456789', N'Nam', 'duy@gmail.com', '', 'duy', '123', 0
--SELECT * FROM nhanvien

--------------------
--Thêm thiết bị, tự động thêm mã thiết bị (tự tăng)
CREATE PROCEDURE Them_Thiet_Bi
	@ten_thietbi NVARCHAR(50),
	@gia INT
AS
BEGIN
    DECLARE @id_thietbi NVARCHAR(10)
    DECLARE @id_thietbi_max NVARCHAR(10)
    SELECT @id_thietbi_max = MAX(id_thietbi) FROM thietbi
    IF @id_thietbi_max IS NULL
        SET @id_thietbi = 'TB001'
    ELSE
        SET @id_thietbi = 'TB' + RIGHT('000' + CAST(RIGHT(@id_thietbi_max, 3) + 1 AS VARCHAR(3)), 3)
    
    INSERT INTO thietbi(id_thietbi, ten_thietbi, gia)
	VALUES(@id_thietbi, @ten_thietbi, @gia)
END;
GO
--EXEC Them_Thiet_Bi N'Mì gói', 3000
--SELECT * FROM thietbi

--------------------
--Thêm dịch vụ, tự động thêm mã dịch vụ (tự tăng)
CREATE PROCEDURE Them_Dich_Vu
	@ten_dichvu NVARCHAR(50),
	@gia INT
AS
BEGIN
    DECLARE @id_dichvu NVARCHAR(10)
    DECLARE @id_dichvu_max NVARCHAR(10)
    SELECT @id_dichvu_max = MAX(id_dichvu) FROM dichvu
    IF @id_dichvu_max IS NULL
        SET @id_dichvu = 'DV001'
    ELSE
        SET @id_dichvu = 'DV' + RIGHT('000' + CAST(RIGHT(@id_dichvu_max, 3) + 1 AS VARCHAR(3)), 3)
    
    INSERT INTO dichvu(id_dichvu, ten_dichvu, gia)
	VALUES(@id_dichvu, @ten_dichvu, @gia)
END;
GO
--EXEC Them_Dich_Vu N'Thuê xe', 100000
--SELECT * FROM dichvu

--------------------
--Thêm khách hàng, tự động thêm mã khách hàng (tự tăng)
CREATE PROCEDURE Them_Khach_Hang
	@ten_khachhang NVARCHAR(50),
	@ngay_sinh DATE,
	@dia_chi NVARCHAR(100),
	@sdt VARCHAR(15),
	@cmnd VARCHAR(15),
	@gioi_tinh NVARCHAR(6)
AS
BEGIN
    DECLARE @id_khachhang NVARCHAR(10)
    DECLARE @id_khachhang_max NVARCHAR(10)
    SELECT @id_khachhang_max = MAX(id_khachhang) FROM khachhang
    IF @id_khachhang_max IS NULL
        SET @id_khachhang = 'KH001'
    ELSE
        SET @id_khachhang = 'KH' + RIGHT('000' + CAST(RIGHT(@id_khachhang_max, 3) + 1 AS VARCHAR(3)), 3)
    
    INSERT INTO khachhang(id_khachhang, ten_khachhang, ngay_sinh, dia_chi, sdt, cmnd, gioi_tinh)
	VALUES(@id_khachhang, @ten_khachhang, @ngay_sinh, @dia_chi, @sdt, @cmnd, @gioi_tinh)
END;
GO

set dateformat dmy EXEC Them_Khach_Hang N'Châu Minh Quân', '01-03-2002', N'Bình Tân', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Huỳnh Khánh Duy', '01-03-2002', N'Hóc Môn', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Ngô Hoài Nhật Duy', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Lư Gia Hoàng', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Trần Đỗ Anh Hào', '01-03-2002', N'Hóc Môn', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Vũ Nguyễn Hoàng', '01-03-2002', N'Trường Chinh', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Trần Phi Bằng', '01-03-2002', N'Quang Trung', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Huỳnh Gia Thuận', '01-03-2002', N'Hóc Môn', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Phan Chí Cường', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Lê Thành An', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nam'
set dateformat dmy EXEC Them_Khach_Hang N'Mai Ngọc Khang', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nam'

set dateformat dmy EXEC Them_Khach_Hang N'Đỗ Thị Bình', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nữ'
set dateformat dmy EXEC Them_Khach_Hang N'Nguyễn Ngọc Mai', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nữ'
set dateformat dmy EXEC Them_Khach_Hang N'Nguyễn Thị Bích Ngọc', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nữ'
set dateformat dmy EXEC Them_Khach_Hang N'Lê Ngọc Tuyền', '01-03-2002', N'Tân Phú', '0123456789', '159635784000', N'Nữ'

GO

--SELECT * FROM khachhang

--------------------
--Thêm loại phòng tăng tự động
--CREATE PROCEDURE Them_Loai_Phong
--	  @ten_loai NVARCHAR(50),
--	  @gia INT
--AS
--BEGIN
--	DECLARE @id_loaiphong INT
--	DECLARE @id_loaiphong_max INT
--	SELECT @id_loaiphong_max = MAX(id_loaiphong) FROM loaiphong
--	IF @id_loaiphong_max IS NULL
--		SET @id_loaiphong = 1
--	ELSE
--		SET @id_loaiphong = @id_loaiphong_max + 1

--	INSERT INTO loaiphong(id_loaiphong, ten_loai, gia)
--	VALUES(@id_loaiphong, @ten_loai, @gia)
--END;
--GO
--EXEC Them_Loai_Phong N'Loại gì đó', 156000
--SELECT * FROM loaiphong

--------------------
--Thêm phòng tăng tự động
CREATE PROCEDURE Them_Phong
	  @id_loaiphong INT,
	  @id_tang INT,
	  @ten NVARCHAR(50),
	  @trangthai NVARCHAR(50),
	  @gia INT
AS
BEGIN
    DECLARE @id_phong VARCHAR(10)
    DECLARE @id_phong_max NVARCHAR(10)
    SELECT @id_phong_max = MAX(id_phong) FROM phong
    IF @id_phong_max IS NULL
        SET @id_phong = 'P001'
    ELSE
        SET @id_phong = 'P' + RIGHT('000' + CAST(RIGHT(@id_phong_max, 3) + 1 AS VARCHAR(3)), 3)
    
    INSERT INTO phong(id_phong, id_loaiphong, id_tang, ten, trang_thai, gia)
	VALUES(@id_phong, @id_loaiphong, @id_tang, @ten, @trangthai, @gia)
END;
GO
--EXEC Them_Phong 1, 1, N'Phòng tầng 1', 1
--SELECT * FROM phong
--delete phong where id_phong = 'P019'


--Thêm đặt phòng tăng tự động
CREATE PROCEDURE Dat_Phong
	  @id_nhanvien VARCHAR(5),
	  @id_khachhang VARCHAR(5),
	  @id_phong VARCHAR(5),
	  @check_in datetime,
	  @check_out datetime,
	  @so_nguoi_o int,
	  @loai NVARCHAR(20),
	  @dat_coc FLOAT
AS
BEGIN
    DECLARE @id_datphong VARCHAR(10)
    DECLARE @id_datphong_max VARCHAR(10)
    SELECT @id_datphong_max = MAX(id_datphong) FROM datphong
    IF @id_datphong_max IS NULL
        SET @id_datphong = 'HD001'
    ELSE
        SET @id_datphong = 'HD' + RIGHT('000' + CAST(RIGHT(@id_datphong_max, 3) + 1 AS VARCHAR(3)), 3)
    
	INSERT INTO datphong(id_datphong, id_nhanvien, id_khachhang, id_phong, check_in, check_out, so_nguoi_o, loai, dat_coc, phu_thu_checkin, phu_thu_checkout, tong_tien)
	VALUES(@id_datphong, @id_nhanvien, @id_khachhang, @id_phong, @check_in, @check_out, @so_nguoi_o, @loai, @dat_coc, 0, 0, 0)
END;
GO 

--set dateformat dmy
--set dateformat dmy EXEC Dat_Phong 'NV001', 'KH002', 'P004', '06/05/2023 08:22:26', '12/05/2023 08:22:26', 1, N'Theo ngày', 150000 
--update phong set trang_thai = N'Đang sử dụng' where id_phong = 'P004'
--delete from datphong where id_datphong = 'HD001'
--update phong set trang_thai = N'Còn trống'
--SELECT * FROM datphong
--select * from phong


--Cập nhật trạng thái phòng
CREATE PROC Update_TrangThaiPhong_1 @idphong NVARCHAR(100)
AS
UPDATE phong 
SET trang_thai = N'Đang sử dụng'
WHERE id_phong = @idphong;
GO
--EXEC Update_TrangThaiPhong_1 @idphong = ''




--CREATE VIEW thongtindatphong AS
--SELECT dp.id_datphong, p.ten, dp.loai AS loai, dp.check_in, dp.check_out, DATEDIFF(HOUR, dp.check_in, dp.check_out) AS tong_thoi_gian
--FROM datphong dp
--INNER JOIN phong p ON dp.id_phong = p.id_phong
--INNER JOIN loaiphong lp ON p.id_loaiphong = lp.id_loaiphong;
--GO

--SELECT id_datphong, ten, loai, check_in, check_out, tong_thoi_gian FROM thongtindatphong;

--CREATE VIEW thongtindatphong1 AS
--SELECT dp.id_datphong, p.ten, dp.loai AS loai, dp.check_in, dp.check_out, DATEDIFF(DAY, dp.check_in, dp.check_out) AS tong_thoi_gian
--FROM datphong dp
--INNER JOIN phong p ON dp.id_phong = p.id_phong
--INNER JOIN loaiphong lp ON p.id_loaiphong = lp.id_loaiphong;
--GO

--SELECT id_datphong, ten, loai, check_in, check_out, tong_thoi_gian FROM thongtindatphong1;
--SELECT * FROM datphong

--CREATE VIEW view_datphong AS
--SELECT dp.id_datphong, p.ten, dp.loai, dp.check_in, dp.check_out, 
--CASE
--    WHEN dp.loai = N'Theo ngày' THEN DATEDIFF(DAY, dp.check_in, dp.check_out)
--    WHEN dp.loai = N'Theo giờ' THEN DATEDIFF(HOUR, dp.check_in, dp.check_out)
--END AS tong_thoi_gian,
--nv.ten_nhanvien AS ten_nhanvien, kh.ten_khachhang AS ten_khachhang
--FROM datphong dp
--JOIN phong p ON dp.id_phong = p.id_phong
--JOIN nhanvien nv ON dp.id_nhanvien = nv.id_nhanvien
--JOIN khachhang kh ON dp.id_khachhang = kh.id_khachhang;
--GO

--SELECT id_datphong, ten, ten_nhanvien, ten_khachhang, loai, check_in, check_out, tong_thoi_gian 
--FROM view_datphong 
--where ten = N'Phòng 101' 

--GO

--CREATE VIEW view_datphong1 AS
--SELECT dp.id_datphong, p.ten, dp.id_phong, dp.loai, dp.check_in, dp.check_out, 
--CASE
--    WHEN dp.loai = N'Theo ngày' THEN DATEDIFF(DAY, dp.check_in, dp.check_out)
--    WHEN dp.loai = N'Theo giờ' THEN DATEDIFF(HOUR, dp.check_in, dp.check_out)
--END AS tong_thoi_gian,
--nv.ten_nhanvien AS ten_nhanvien, kh.ten_khachhang AS ten_khachhang
--FROM datphong dp
--JOIN phong p ON dp.id_phong = p.id_phong
--JOIN nhanvien nv ON dp.id_nhanvien = nv.id_nhanvien
--JOIN khachhang kh ON dp.id_khachhang = kh.id_khachhang;
--GO
--SELECT id_datphong, ten, id_phong, ten_nhanvien, ten_khachhang, loai, check_in, check_out, tong_thoi_gian FROM view_datphong1;

CREATE VIEW view_datphong2 AS
SELECT dp.id_datphong, p.ten, dp.loai, dp.check_in, dp.check_out, dp.trang_thai,
CASE
    WHEN dp.loai = N'Theo ngày' THEN DATEDIFF(DAY, dp.check_in, dp.check_out)
    WHEN dp.loai = N'Theo giờ' THEN DATEDIFF(HOUR, dp.check_in, dp.check_out)
END AS tong_thoi_gian,
nv.ten_nhanvien AS ten_nhanvien, kh.ten_khachhang AS ten_khachhang
FROM datphong dp
JOIN phong p ON dp.id_phong = p.id_phong
JOIN nhanvien nv ON dp.id_nhanvien = nv.id_nhanvien
JOIN khachhang kh ON dp.id_khachhang = kh.id_khachhang;
GO


--SELECT id_datphong, ten, ten_nhanvien, ten_khachhang, loai, check_in, check_out, tong_thoi_gian, trang_thai FROM view_datphong2 
--where id = N'Phòng 101' AND ten_khachhang = N''
--GO

--CREATE FUNCTION tinh_tong_tien(@id_datphong VARCHAR(5))
--RETURNS FLOAT
--AS BEGIN
--    DECLARE @tong_tien FLOAT;
--    SELECT @tong_tien = DATEDIFF(day, check_in, ISNULL(check_out, GETDATE())) * loaiphong.gia
--    FROM datphong
--    INNER JOIN phong ON datphong.id_phong = phong.id_phong
--    INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--    WHERE id_datphong = @id_datphong;
--    RETURN @tong_tien;
--END;
--GO

--SELECT dbo.tinh_tong_tien('HD001');
--select * from phong
--select * from loaiphong;
--select * from datphong;
--select id_datphong from datphong where id_phong = ''


--CREATE FUNCTION tinh_tong_tien_co_phu_thu(@id_datphong VARCHAR(5))
--RETURNS FLOAT
--AS BEGIN
--    DECLARE @tong_tien FLOAT, @so_ngay INT;
--    SELECT @so_ngay = DATEDIFF(day, check_in, ISNULL(check_out, GETDATE()))
--    FROM datphong
--    WHERE id_datphong = @id_datphong;
--    SELECT @tong_tien = @so_ngay * loaiphong.gia
--        + CASE WHEN DATEPART(hour, check_in) < 13 THEN 0.3 * loaiphong.gia ELSE 0 END
--        + CASE WHEN DATEPART(hour, check_out) > 11 THEN 0.3 * loaiphong.gia ELSE 0 END

--    FROM datphong
--    INNER JOIN phong ON datphong.id_phong = phong.id_phong
--    INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--    WHERE id_datphong = @id_datphong;

--    RETURN @tong_tien;
--END;
--GO

--SELECT DATEPART(HOUR, check_in) FROM datphong
--SELECT DATEPART(HOUR, check_out) FROM datphong
--select * from datphong;
--SELECT dbo.tinh_tong_tien('HD002');
--SELECT dbo.tinh_tong_tien_co_phu_thu('HD002');



--CREATE FUNCTION tinh_tong_tien1(@id_datphong VARCHAR(5))
--RETURNS FLOAT
--AS BEGIN
--    DECLARE @tong_tien FLOAT;
--    DECLARE @phuthu FLOAT;
--	DECLARE @phuthu1 FLOAT;
--    DECLARE @checkin DATETIME;
--	DECLARE @checkout DATETIME;
--    SELECT @checkin = check_in FROM datphong WHERE id_datphong = @id_datphong;
--	SELECT @checkout = check_out FROM datphong WHERE id_datphong = @id_datphong;
--    SELECT @phuthu = 
--        CASE 
--            WHEN DATEPART(hour, @checkin) < 4 THEN 1
--            WHEN DATEPART(hour, @checkin) < 7 THEN 0.5
--            WHEN DATEPART(hour, @checkin) < 13 THEN 0.3
--            ELSE 0
--        END
--    FROM datphong
--    INNER JOIN phong ON datphong.id_phong = phong.id_phong
--    INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--    WHERE id_datphong = @id_datphong;
--	SELECT @phuthu1 = 
--        CASE 
--            WHEN DATEPART(hour, @checkout) > 23 THEN 1
--            WHEN DATEPART(hour, @checkout) > 18 THEN 0.5
--            WHEN DATEPART(hour, @checkout) > 11 THEN 0.3
--            ELSE 0
--        END
--    FROM datphong
--    INNER JOIN phong ON datphong.id_phong = phong.id_phong
--    INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--    WHERE id_datphong = @id_datphong;
--    SELECT @tong_tien = DATEDIFF(day, check_in, check_out) * loaiphong.gia + loaiphong.gia * @phuthu + loaiphong.gia * @phuthu1
--    FROM datphong
--    INNER JOIN phong ON datphong.id_phong = phong.id_phong
--    INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--    WHERE id_datphong = @id_datphong;
--    RETURN @tong_tien;
--END;
--GO

----SELECT dbo.tinh_tong_tien('HD002');
----SELECT dbo.tinh_tong_tien1('HD002');




--CREATE PROCEDURE Tinh_Tong_Tien_Phuthu
--    @id_datphong VARCHAR(5),
--    @tong_tien FLOAT OUTPUT,
--	@tien_phuthu FLOAT OUTPUT,
--    @tien_phuthu1 FLOAT OUTPUT
--AS 
--BEGIN
--	DECLARE @phuthu FLOAT;
--	DECLARE @phuthu1 FLOAT;
--    DECLARE @checkin DATETIME;
--    DECLARE @checkout DATETIME;
--    SELECT @checkin = check_in FROM datphong WHERE id_datphong = @id_datphong;
--    SELECT @checkout = check_out FROM datphong WHERE id_datphong = @id_datphong;
--    SELECT @phuthu = 
--        CASE 
--            WHEN DATEPART(hour, @checkin) < 4 THEN 1
--            WHEN DATEPART(hour, @checkin) < 7 THEN 0.5
--            WHEN DATEPART(hour, @checkin) < 13 THEN 0.3
--            ELSE 0
--        END
--    FROM datphong
--    INNER JOIN phong ON datphong.id_phong = phong.id_phong
--    INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--    WHERE id_datphong = @id_datphong;
--    SELECT @phuthu1 = 
--        CASE 
--            WHEN DATEPART(hour, @checkout) > 23 THEN 1
--            WHEN DATEPART(hour, @checkout) > 18 THEN 0.5
--            WHEN DATEPART(hour, @checkout) > 11 THEN 0.3
--            ELSE 0
--        END
--    FROM datphong
--    INNER JOIN phong ON datphong.id_phong = phong.id_phong
--    INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--    WHERE id_datphong = @id_datphong;
--    SELECT @tong_tien = DATEDIFF(day, check_in, check_out) * loaiphong.gia + loaiphong.gia * @phuthu + loaiphong.gia * @phuthu1
--	, @tien_phuthu = loaiphong.gia * @phuthu, @tien_phuthu1 = loaiphong.gia * @phuthu1
--    FROM datphong
--    INNER JOIN phong ON datphong.id_phong = phong.id_phong
--    INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--    WHERE id_datphong = @id_datphong;
--END;
--GO




--CREATE PROCEDURE Tinh_Tong_Tien_Phuthu_1  --Java--
--	@mychoose nvarchar(30),
--    @id_datphong VARCHAR(5),
--    @tong_tien FLOAT OUTPUT,
--	@tien_phuthu FLOAT OUTPUT,
--    @tien_phuthu1 FLOAT OUTPUT
--AS 
--BEGIN
--	IF (@mychoose LIKE N'Theo ngày')
--		BEGIN
--			DECLARE @phuthu FLOAT;
--			DECLARE @phuthu1 FLOAT;
--			DECLARE @checkin DATETIME;
--			DECLARE @checkout DATETIME;
--			SELECT @checkin = check_in FROM datphong WHERE id_datphong = @id_datphong;
--			SELECT @checkout = check_out FROM datphong WHERE id_datphong = @id_datphong;
--			SELECT @phuthu = 
--				CASE 
--					WHEN DATEPART(hour, @checkin) < 4 THEN 1
--					WHEN DATEPART(hour, @checkin) < 7 THEN 0.5
--					WHEN DATEPART(hour, @checkin) < 13 THEN 0.3
--					ELSE 0
--				END
--			FROM datphong
--			INNER JOIN phong ON datphong.id_phong = phong.id_phong
--			INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--			WHERE id_datphong = @id_datphong;
--			SELECT @phuthu1 = 
--				CASE 
--					WHEN DATEPART(hour, @checkout) > 23 THEN 1
--					WHEN DATEPART(hour, @checkout) > 18 THEN 0.5
--					WHEN DATEPART(hour, @checkout) > 11 THEN 0.3
--					ELSE 0
--				END
--			FROM datphong
--			INNER JOIN phong ON datphong.id_phong = phong.id_phong
--			INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--			WHERE id_datphong = @id_datphong;
--			SELECT @tong_tien = DATEDIFF(day, check_in, check_out) * loaiphong.gia + loaiphong.gia * @phuthu + loaiphong.gia * @phuthu1
--			, @tien_phuthu = loaiphong.gia * @phuthu, @tien_phuthu1 = loaiphong.gia * @phuthu1
--			FROM datphong
--			INNER JOIN phong ON datphong.id_phong = phong.id_phong
--			INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
--			WHERE id_datphong = @id_datphong;
--				END
--	ELSE IF (@mychoose LIKE N'Theo giờ')
--		BEGIN
--			DECLARE @checkin1 DATETIME;
--			DECLARE @checkout1 DATETIME;
--			SELECT @checkin1 = check_in FROM datphong WHERE id_datphong = @id_datphong;
--			SELECT @checkout1 = check_out FROM datphong WHERE id_datphong = @id_datphong;
--			SET @phuthu = 0.0;
--			SET @phuthu1 = 0.0;
--			SELECT @tong_tien = DATEDIFF(HOUR, @checkin1, @checkout1) * 50000
--			FROM datphong
--			WHERE id_datphong = @id_datphong;
--		END
--END;
--GO


--DECLARE @tong_tien FLOAT;
--DECLARE @tien_phuthu FLOAT;
--DECLARE @tien_phuthu1 FLOAT;
--EXEC Tinh_Tong_Tien_Phuthu_1 N'Theo giờ', 'HD002', @tong_tien OUTPUT, @tien_phuthu OUTPUT, @tien_phuthu1 OUTPUT;
--SELECT @tong_tien AS tong_tien, @tien_phuthu AS tien_phuthu_checkin, @tien_phuthu1 AS tien_phuthu_checkout;




CREATE PROCEDURE Tinh_Tong_Tien_Phuthu  --c#--
	@mychoose NVARCHAR(30),
    @id_datphong VARCHAR(5),
    @tong_tien FLOAT OUTPUT,
	@tien_phuthu FLOAT OUTPUT,
    @tien_phuthu1 FLOAT OUTPUT
AS 
BEGIN
	IF (@mychoose LIKE N'Theo ngày')
	BEGIN
		DECLARE @phuthu FLOAT;
		DECLARE @phuthu1 FLOAT;
		DECLARE @checkin DATETIME;
		DECLARE @checkout DATETIME;

		SELECT @checkin = check_in, @checkout = check_out
		FROM datphong
		WHERE id_datphong = @id_datphong;

		SELECT @phuthu = 
			CASE 
				WHEN DATEPART(hour, @checkin) < 4 THEN 1
				WHEN DATEPART(hour, @checkin) < 7 THEN 0.5
				WHEN DATEPART(hour, @checkin) < 13 THEN 0.3
				ELSE 0
			END;

		SELECT @phuthu1 = 
			CASE 
				WHEN DATEPART(hour, @checkout) > 23 THEN 1
				WHEN DATEPART(hour, @checkout) > 18 THEN 0.5
				WHEN DATEPART(hour, @checkout) > 11 THEN 0.3
				ELSE 0
			END;

		SELECT 
			@tong_tien = DATEDIFF(day, @checkin, @checkout) * phong.gia + phong.gia * @phuthu + phong.gia * @phuthu1,
			@tien_phuthu = phong.gia * @phuthu,
			@tien_phuthu1 = phong.gia * @phuthu1
		FROM datphong
		INNER JOIN phong ON datphong.id_phong = phong.id_phong
		INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
		WHERE id_datphong = @id_datphong;
	END
	ELSE IF (@mychoose LIKE N'Theo giờ')
	BEGIN
		DECLARE @checkin1 DATETIME;
		DECLARE @checkout1 DATETIME;

		SELECT @checkin1 = check_in, @checkout1 = check_out
		FROM datphong
		WHERE id_datphong = @id_datphong;

		SET @phuthu = 0.0;
		SET @phuthu1 = 0.0;

		SELECT @tong_tien = DATEDIFF(HOUR, @checkin1, @checkout1) * phong.gia
		FROM datphong
		INNER JOIN phong ON datphong.id_phong = phong.id_phong
		INNER JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong
		WHERE id_datphong = @id_datphong;
	END
END;
GO



-------------------------------------------------------------------------------------------------------------------------------------



CREATE PROCEDURE Them_chi_tiet_su_dung_dv 
(
	@id_datphong VARCHAR(10),
	@id_dvu VARCHAR(10), 
	@ngaythue DATE,
    @so_luong INT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT * FROM chitietsudungdv WHERE id_dichvu = @id_dvu AND id_datphong = @id_datphong)
    BEGIN
        UPDATE chitietsudungdv 
        SET so_luong = so_luong + @so_luong , tong_tien_dv =((select tong_tien_dv from chitietsudungdv where id_dichvu = @id_dvu) + ((select gia from dichvu where id_dichvu = @id_dvu) * @so_luong) )
        WHERE id_dichvu = @id_dvu AND id_datphong = @id_datphong
    END
    ELSE
    BEGIN
        --INSERT INTO chitietsudungdv (id_dv, id_kh, so_luong) 
        --VALUES (@id_dv, @id_kh, @so_luong)
		insert into chitietsudungdv 
		values (@id_datphong, @id_dvu, @ngaythue, @so_luong, ((select gia from dichvu where id_dichvu = @id_dvu) * @so_luong))
    END
END;
GO

--EXEC Them_chi_tiet_su_dung_dv 'HD009', 'DV001', '2023-05-28', 1

--select * from chitietsudungdv
--select * from dichvu
--select * from datphong
--delete from chitietsudungdv where id_datphong = 'HD002' and id_dichvu = 'DV001'


CREATE PROCEDURE Them_chi_tiet_su_dung_tb 
(
	@id_datphong VARCHAR(5),
	@id_tbi VARCHAR(5), 
	@ngaythue DATE,
    @so_luong INT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT * FROM chitietsudungtb WHERE id_thietbi = @id_tbi AND id_datphong = @id_datphong)
    BEGIN
        UPDATE chitietsudungtb 
        SET so_luong = so_luong + @so_luong , tong_tien_tb =((select tong_tien_tb from chitietsudungtb where id_thietbi = @id_tbi) + ((select gia from thietbi where id_thietbi = @id_tbi) * @so_luong) )
        WHERE id_thietbi = @id_tbi AND id_datphong = @id_datphong
    END
    ELSE
    BEGIN
        --INSERT INTO chitietsudungdv (id_dv, id_kh, so_luong) 
        --VALUES (@id_dv, @id_kh, @so_luong)
		insert into chitietsudungtb
		values (@id_datphong, @id_tbi, @ngaythue, @so_luong, ((select gia from thietbi where id_thietbi = @id_tbi) * @so_luong))
    END
END;
GO

--EXEC Them_chi_tiet_su_dung_tb 'HD001', 'TB001', '08/05/2023', 1

--select * from chitietsudungtb
--select * from thietbi
--select * from datphong
--delete from chitietsudungtb where id_datphong = 'HD001' and id_thietbi = 'TB001'


CREATE PROC Xoa_chi_tiet_su_dung_dv  @iddatphong NVARCHAR(50), @iddv NVARCHAR(50)
AS
DELETE chitietsudungdv 
WHERE id_datphong = @iddatphong and id_dichvu = @iddv;
GO



CREATE PROC Xoa_chi_tiet_su_dung_tb  @iddatphong NVARCHAR(50), @idtb NVARCHAR(50)
AS
DELETE chitietsudungtb
WHERE id_datphong = @iddatphong and id_thietbi = @idtb;
GO



CREATE PROC Capnhat_chi_tiet_su_dung_dv  
    @iddatphong NVARCHAR(50),
    @iddv NVARCHAR(50),
    @soluong INT
AS
BEGIN
    UPDATE chitietsudungdv 
    SET 
        so_luong = @soluong,
        tong_tien_dv = (
            (SELECT gia FROM dichvu WHERE id_dichvu = @iddv) * @soluong
        )
    WHERE 
        id_dichvu = @iddv AND 
        id_datphong = @iddatphong;
END;
GO



CREATE PROC Capnhat_chi_tiet_su_dung_tb  
    @iddatphong NVARCHAR(50),
    @idtb NVARCHAR(50),
    @soluong INT
AS
BEGIN
    UPDATE chitietsudungtb
    SET 
        so_luong = @soluong,
        tong_tien_tb = (
            (SELECT gia FROM thietbi WHERE id_thietbi = @idtb) * @soluong
        )
    WHERE 
        id_thietbi = @idtb AND 
        id_datphong = @iddatphong;
END;
GO


CREATE PROCEDURE Tinh_Tong_Tien_DichVu
    @id_datphong VARCHAR(5),
    @tong_tien_dv FLOAT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem có id_datphong nào trong bảng chitietsudungdv không
    IF EXISTS (SELECT 1 FROM chitietsudungdv WHERE id_datphong = @id_datphong)
    BEGIN
        -- Tính tổng tiền dịch vụ nếu có id_datphong
        SELECT @tong_tien_dv = SUM(tong_tien_dv)
        FROM chitietsudungdv
        WHERE id_datphong = @id_datphong;
    END
    ELSE
    BEGIN
        -- Gán tổng tiền dịch vụ = 0 nếu không có id_datphong
        SET @tong_tien_dv = 0;
    END
END;
GO


CREATE PROCEDURE Tinh_Tong_Tien_ThietBi
    @id_datphong VARCHAR(5),
    @tong_tien_tb FLOAT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem có id_datphong nào trong bảng chitietsudungdv không
    IF EXISTS (SELECT 1 FROM chitietsudungtb WHERE id_datphong = @id_datphong)
    BEGIN
        -- Tính tổng tiền dịch vụ nếu có id_datphong
        SELECT @tong_tien_tb = SUM(tong_tien_tb)
        FROM chitietsudungtb
        WHERE id_datphong = @id_datphong;
    END
    ELSE
    BEGIN
        -- Gán tổng tiền dịch vụ = 0 nếu không có id_datphong
        SET @tong_tien_tb = 0;
    END
END;
GO






--CREATE VIEW XemHoaDon AS
--SELECT
--    dp.id_datphong AS id_datphong,
--    nv.ten_nhanvien AS ten_nhanvien,
--    kh.ten_khachhang AS ten_khachhang,
--    p.ten AS ten,
--    dp.check_in AS check_in,
--    dp.check_out AS check_out,
--    dp.dat_coc AS dat_coc,
--    dp.tien_phong AS tien_phong,
--    dp.phu_thu_checkin AS phu_thu_checkin,
--    dp.phu_thu_checkout AS phu_thu_checkout,
--    dp.tong_tien_dv AS tong_tien_dv,
--    dp.tong_tien_tb AS tong_tien_tb,
--    dp.tong_tien_hoa_don AS tong_tien_hoa_don,
--    dp.tong_tien AS tong_tien
--FROM
--    datphong dp
--    JOIN nhanvien nv ON dp.id_nhanvien = nv.id_nhanvien
--    JOIN khachhang kh ON dp.id_khachhang = kh.id_khachhang
--    JOIN phong p ON dp.id_phong = p.id_phong;
--GO

--select * from XemHoaDon where datphong = 'HD001'
--SELECT
--    dp.id_datphong AS datphong,
--    nv.ten_nhanvien AS nhanvien,
--    kh.ten_khachhang AS khachhang,
--    p.ten AS phong,
--    dp.check_in AS check_in,
--    dp.check_out AS check_out,
--    dp.dat_coc AS dat_coc,
--    dp.tien_phong AS tien_phong,
--    dp.phu_thu_checkin AS phu_thu_checkin,
--    dp.phu_thu_checkout AS phu_thu_checkout,
--    dp.tong_tien_dv AS tong_tien_dv,
--    dp.tong_tien_tb AS tong_tien_tb,
--    dp.tong_tien_hoa_don AS tong_tien_hoa_don,
--    dp.tong_tien AS tong_tien
--FROM
--    datphong dp
--    JOIN nhanvien nv ON dp.id_nhanvien = nv.id_nhanvien
--    JOIN khachhang kh ON dp.id_khachhang = kh.id_khachhang
--    JOIN phong p ON dp.id_phong = p.id_phong
--WHERE id_datphong = 'HD001';






-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--update datphong set phu_thu_checkin = 0, phu_thu_checkout = 0, tong_tien = 0 where id_datphong = 'HD001'
--select * from datphong
--select * from phong
--select so_luong_nguoi from phong where ten = N''
--select * from loaiphong
--select so_luong_nguoi from phong where id_phong = '' 
--select * from view_datphong2
--select gia from loaiphong lp inner join phong p on lp.id_loaiphong = p.id_loaiphong where ten = N''
--UPDATE datphong SET id_phong = 'P008' WHERE id_datphong = 'HD004';
--UPDATE phong set trang_thai = N'Đang sử dụng' where id_phong = 'P008';
--UPDATE phong set trang_thai = N'Còn trống' where id_phong = '';
--select tong_tien from datphong where id_datphong = ''
--select * from khachhang
--set dateformat dmy update khachhang set ten_khachhang = N'Phạm Lê Anh Thư', ngay_sinh = '2002-12-05', dia_chi = N'Tôn Đản, phường 10', sdt = '145154456', cmnd = '616564454', gioi_tinh = N'Nữ' where id_khachhang = 'KH012'
--update thietbi set ten_thietbi = N'Giặt ủi', gia = 100000 where id_thietbi = 'DV001'
--select * from dichvu
--select id_loaiphong from loaiphong where ten_loai = N'Phòng đơn loại 2'
--select * from phong where id_phong = 'P001'
--select * from phong
--select * from loaiphong
--update datphong set dat_coc = ((DATEDIFF(day, check_in, check_out) * (select gia from loaiphong lp inner join phong p on p.id_loaiphong = lp.id_loaiphong where id_phong = 'P002')) * 3) / 4 
--where id_datphong = 'HD002'
--select * from nhanvien
--select * from datphong
--select * from datphong where MONTH(check_out) = MONTH(GETDATE())
--select * from chitietsudungdv where id_datphong = 'HD008'
--select * from chitietsudungtb where id_datphong = 'HD008'
--SELECT dv.ten_dichvu, dv.gia FROM chitietsudungdv ctsd JOIN dichvu dv ON ctsd.id_dichvu = dv.id_dichvu WHERE ctsd.id_datphong = 'HD008';
--SELECT dv.ten_dichvu, dv.gia, ctsd.so_luong, ctsd.tong_tien_dv FROM chitietsudungdv ctsd JOIN dichvu dv ON ctsd.id_dichvu = dv.id_dichvu WHERE ctsd.id_datphong = 'HD008';
--SELECT tb.ten_thietbi, tb.gia, cttb.so_luong, cttb.tong_tien_tb FROM chitietsudungtb cttb JOIN thietbi tb ON cttb.id_thietbi = tb.id_thietbi WHERE cttb.id_datphong = 'HD008';
--SELECT * FROM datphong WHERE YEAR(check_in) = YEAR(GETDATE())
--SELECT * FROM datphong
--WHERE DATEPART(WEEK,check_in) = DATEPART(WEEK,GETDATE())
--SELECT * FROM datphong
--WHERE DATEPART(WEEK,check_in) = DATEPART(WEEK,'2023-05-20')

--SELECT
--    CASE
--        WHEN MONTH(check_in) IN (1, 2, 3) THEN 'Quý 1'
--        WHEN MONTH(check_in) IN (4, 5, 6) THEN 'Quý 2'
--        WHEN MONTH(check_in) IN (7, 8, 9) THEN 'Quý 3'
--        WHEN MONTH(check_in) IN (10, 11, 12) THEN 'Quý 4'
--    END AS quarter,
--    COUNT(*) AS count
--FROM
--    datphong
--GROUP BY
--    CASE
--        WHEN MONTH(check_in) IN (1, 2, 3) THEN 'Quý 1'
--        WHEN MONTH(check_in) IN (4, 5, 6) THEN 'Quý 2'
--        WHEN MONTH(check_in) IN (7, 8, 9) THEN 'Quý 3'
--        WHEN MONTH(check_in) IN (10, 11, 12) THEN 'Quý 4'
--    END;
--SELECT *
--FROM datphong
--WHERE
--    MONTH(check_in) IN (4, 5, 6)
--    AND YEAR(check_in) = YEAR(GETDATE());

--SELECT * FROM datphong WHERE MONTH(check_in) = 5;
--SELECT SUM(tong_tien) FROM datphong WHERE MONTH(check_in) = 5 AND trang_thai = N'Đã thanh toán';
--SELECT id_phong, COUNT(*) AS TONGLANDAT
--FROM datphong WHERE MONTH(check_in) = 5
--GROUP BY id_phong
--HAVING COUNT(*) = (
--    SELECT MAX(TONGLANDAT)
--    FROM (
--        SELECT COUNT(*) AS TONGLANDAT
--        FROM datphong
--        GROUP BY id_phong
--    ) AS TONG
--)
--SELECT id_phong, COUNT(*) AS total_bookings FROM datphong WHERE MONTH(check_in) = 4 GROUP BY id_phong HAVING COUNT(*) > 1;
----DECLARE @Quy INT;SET @Quy = 3;SELECT * FROM datphong WHERE MONTH(check_in) BETWEEN (@Quy - 1) * 3 + 1 AND @Quy * 3;
--select * from datphong
--DECLARE @quy INT;
--SET @quy = 4;
--SELECT dp.id_phong, COUNT(*) AS tonglandat
--FROM datphong dp
--WHERE DATEPART(QUARTER, dp.check_in) = @quy
--GROUP BY dp.id_phong
--HAVING COUNT(*) > 1;
--SELECT*FROM datphong WHERE id_khachhang IN (SELECT id_khachhang FROM khachhang WHERE ten_khachhang = N'Ngô Hoài Nhật Duy')
--SELECT*FROM datphong WHERE id_khachhang IN (SELECT id_khachhang FROM khachhang WHERE sdt = '')
--select COUNT(*) from datphong
--select * from chitietsudungdv
--SELECT COUNT(*) FROM chitietsudungdv
--select SUM(tong_tien_dv) from chitietsudungdv WHERE MONTH(ngay_thue) = 5
--delete from khachhang where id_khachhang = ''
--select * from khachhang
--select * from datphongonline
--INSERT INTO datphongonline (id_phong, check_in, check_out, tong_tien, so_nguoi_o, trang_thai, ten_khachhang, ngay_sinh, dia_chi, sdt, cmnd, gioi_tinh)
--VALUES ('P001', '2023-10-20', '2023-10-25', 1500000, 2, N'Chưa thanh toán', N'Duy xanh', '2000-01-01', N'HCM', '123456789', '023939329', N'Nam');
--SELECT * FROM taikhoan
--select * from nhanvien
--INSERT INTO taikhoan VALUES('NV002', 'quan', '123', 1)
--SELECT n.ten_nhanvien
--FROM taikhoan AS t
--JOIN nhanvien AS n ON t.id_nhanvien = n.id_nhanvien
--WHERE t.id_nhanvien = 'NV001';
--SELECT phong.id_phong, loaiphong.ten_loai, phong.id_tang, phong.ten, phong.trang_thai
--FROM phong
--JOIN loaiphong ON phong.id_loaiphong = loaiphong.id_loaiphong;
--select * from datphong
--SELECT
--    ROW_NUMBER() OVER (ORDER BY chiTiet.id_datphong) AS SoThuTu,
--    dichvu.ten_dichvu AS TenDichVu,
--    chiTiet.so_luong AS SoLuong,
--    dichvu.gia AS GiaDichVu,
--    chiTiet.ngay_thue AS NgayThue
--FROM
--    chitietsudungdv chiTiet
--JOIN
--    dichvu ON chiTiet.id_dichvu = dichvu.id_dichvu
--WHERE
--    chiTiet.id_datphong = 'HD001';

select * from datphongonline

GO
SET DATEFORMAT YMD
INSERT INTO  datphongonline(id_phong, check_in, check_out, tong_tien, so_nguoi_o, trang_thai, ten_khachhang, ngay_sinh, dia_chi, sdt, cmnd, gioi_tinh) VALUES
('P007', '2023-10-14', '2023-10-16', 350000, 2, N'Đã thanh toán', N'Nguyễn Văn Bịp', '2002-11-11', N'TP HCM', '0321931931' , '021337376390', N'Nam'),
('P003', '2023-10-17', '2023-10-18', 240000, 1, N'Đã thanh toán', N'Trần Quốc Toản', '2002-09-03', N'TP Hà Nội', '0497931931' , '039997376390', N'Nam'),
('P007', '2023-10-19', '2023-10-22', 320000, 2, N'Đã thanh toán', N'Đỗ Thị Bình', '2003-01-22', N'Quãng Ngãi', '0921931931' , '001337376390', N'Nữ'),
('P016', '2023-10-25', '2023-10-27', 310000, 2, N'Đã thanh toán', N'Trần Kim Tuyền', '2002-11-11', N'TP HCM', '0121931931' , '071337376390', N'Nữ'),
('P012', '2023-10-28', '2023-10-30', 350000, 2, N'Đã thanh toán', N'Nguyễn Phi Long', '2002-11-11', N'TP HCM', '0661931931' , '009337376390', N'Nam'),
('P014', '2023-11-01', '2023-11-03', 310000, 1, N'Đã thanh toán', N'Nguyễn Ngọc Mai', '2003-11-11', N'TP HCM', '0881931931' , '011137376390', N'Nữ'),
('P012', '2023-11-04', '2023-11-06', 470000, 2, N'Đã thanh toán', N'Trần Thanh Thảo', '2002-11-11', N'TP HCM', '0921931931' , '014737376390', N'Nữ'),
('P001', '2023-11-07', '2023-11-10', 350000, 1, N'Đã thanh toán', N'Huỳnh Văn Nam', '2002-11-11', N'TP HCM', '0321661931' , '091117372290', N'Nam'),
('P002', '2023-11-11', '2023-11-14', 350000, 1, N'Đã thanh toán', N'Đinh Phi Nhung', '2002-09-11', N'TP HCM', '0321171001' , '021987376390', N'Nữ'),
('P012', '2023-11-15', '2023-11-20', 650000, 2, N'Đã thanh toán', N'Nguyễn Bảo Thư', '2002-09-30', N'TP HCM', '0998931931' , '076137376390', N'Nữ')
