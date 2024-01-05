﻿CREATE database QUANLYHOCSINH;
GO 
USE QUANLYHOCSINH;
CREATE TABLE NAMHOC (
    MANH nvarchar(7) NOT NULL PRIMARY key,
    TENNAMHOC nvarchar(20),
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE HOCKY (
    MAHK nvarchar(7) NOT NULL PRIMARY key,
    TENHK nvarchar(20),
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE TAIKHOAN (
    USERNAME nvarchar(100) NOT NULL PRIMARY key,
    PASSWRD nvarchar(100) NOT NULL,
    VAITRO nvarchar(7),
    HOTEN nvarchar(100) NOT NULL,
    NGSINH SMALLDATETIME,
    EMAIL nvarchar(50),
    DCHI nvarchar(250),
    GIOITINH BIT DEFAULT 0,
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE GIAOVIEN (
    MAGV nvarchar(7) NOT NULL PRIMARY KEY,
    USERNAME nvarchar(100) NOT NULL FOREIGN KEY REFERENCES TAIKHOAN (USERNAME),
    HOCVI nvarchar(50),
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE NHANVIENPHONGDAOTAO (
    MANV nvarchar(7) NOT NULL PRIMARY KEY,
    USERNAME nvarchar(100) NOT NULL FOREIGN KEY REFERENCES TAIKHOAN (USERNAME),
    CHUCVU nvarchar(50),
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE HOCSINH (
    MAHS nvarchar(7) NOT NULL PRIMARY key,
    CCCD nvarchar(12),
    HOTENHS nvarchar(100),
    NGSINH DATE,
    EMAIL nvarchar(250),
    SDT nvarchar(11),
    DCHI nvarchar(250),
    GIOITINH BIT DEFAULT 0,
    TONGIAO nvarchar(10),
    DANTOC nvarchar(10),
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE PHHS (
    MAPHHS nvarchar(7) NOT NULL PRIMARY key,
    MAHS nvarchar(7) FOREIGN KEY REFERENCES HOCSINH (MAHS),
    HOTENPHHS nvarchar(100),
	SDT nvarchar(11),
);
CREATE TABLE MONHOC (
    MAMH nvarchar(7) NOT NULL PRIMARY key,
    TENMH nvarchar(30),
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE LOP (
    MALOP nvarchar(7) NOT NULL PRIMARY key,
    KHOI INT,
    TENLOP nvarchar(30),
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE LOPHOCTHUCTE (
    MALHTT nvarchar(10) NOT NULL PRIMARY key,
    MALOP nvarchar(7) FOREIGN KEY REFERENCES LOP (MALOP),
    MANH nvarchar(7) FOREIGN KEY REFERENCES NAMHOC (MANH),
    MAGVCN nvarchar(7) FOREIGN KEY REFERENCES GIAOVIEN (MAGV),
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE LOPHOCTHUCTE_HOCSINH (
    MALHTT nvarchar(10) FOREIGN KEY REFERENCES LOPHOCTHUCTE (MALHTT),
    MAHS nvarchar(7) FOREIGN KEY REFERENCES HOCSINH (MAHS),
    PRIMARY key (MALHTT, MAHS)
);
CREATE TABLE LOAIKIEMTRA (
    MALKT nvarchar(7) PRIMARY KEY,
    TENLOAIKIEMTRA nvarchar(50),
    TILE FLOAT NOT NULL,
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE DIEMMONHOC (
    MAHS nvarchar(7) FOREIGN KEY REFERENCES HOCSINH (MAHS),
    MAHK nvarchar(7) FOREIGN KEY REFERENCES HOCKY (MAHK),
    MAMH nvarchar(7) FOREIGN KEY REFERENCES MONHOC (MAMH),
    MANH nvarchar(7) FOREIGN KEY REFERENCES NAMHOC (MANH),
    MALKT nvarchar(7) FOREIGN KEY REFERENCES LOAIKIEMTRA (MALKT),
    DIEM FLOAT NOT NULL,
    PRIMARY key (MAHS, MAHK, MANH, MAMH, MALKT)
);
CREATE TABLE DIEMTRUNGBINHMONHOCNAMHOC(
	MAHS nvarchar(7) FOREIGN KEY REFERENCES HOCSINH (MAHS),
    MANH nvarchar(7) FOREIGN KEY REFERENCES NAMHOC (MANH),
	MAMH nvarchar(7) FOREIGN KEY REFERENCES MONHOC (MAMH),
    DTBMonHocNamHoc FLOAT NOT NULL,
    PRIMARY key (MAHS, MANH, MAMH)
);
CREATE TABLE HOCLUC (
    MaHocLuc NVARCHAR (7) NOT NULL PRIMARY KEY,
    TenHocLuc NVARCHAR (50) NOT NULL,
    DiemCanDuoi FLOAT NOT NULL,
    DiemCanTren FLOAT NOT NULL,
    DiemKhongChe FLOAT NOT NULL,
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE HANHKIEM (
    MaHanhKiem NVARCHAR (7) NOT NULL PRIMARY KEY,
    TenHanhKiem NVARCHAR (50) NOT NULL,
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE KETQUA (
    MaKetQua NVARCHAR (7) NOT NULL PRIMARY KEY,
    TenKetQua NVARCHAR (50) NOT NULL,
    ISDELETED BIT DEFAULT 0,
);
CREATE TABLE KQHOCKYMONHOC
(
	MAHS	NVARCHAR (7)		NOT NULL FOREIGN KEY REFERENCES HOCSINH(MAHS),
	MAMH	NVARCHAR (7)		NOT NULL FOREIGN KEY REFERENCES MONHOC(MAMH),
	MAHK	NVARCHAR (7)		NOT NULL FOREIGN KEY REFERENCES HOCKY(MAHK),
	MANH	NVARCHAR (7)		NOT NULL FOREIGN KEY REFERENCES NAMHOC(MANH),
	DTBMonHocKy	FLOAT			NOT NULL,
	PRIMARY KEY(MAHS, MAMH, MAHK, MANH),
);

CREATE TABLE KQHOCKYTONGHOP
(
	MAHS NVARCHAR (7) NOT NULL FOREIGN KEY REFERENCES HOCSINH(MAHS),
	MAHK NVARCHAR (7) NOT NULL FOREIGN KEY REFERENCES HOCKY(MAHK),
	MANH NVARCHAR (7) NOT NULL FOREIGN KEY REFERENCES NAMHOC(MANH),
    MaHocLuc NVARCHAR (7) FOREIGN KEY REFERENCES HOCLUC (MaHocLuc),
    MaHanhKiem NVARCHAR (7) FOREIGN KEY REFERENCES HANHKIEM (MaHanhKiem),
	DTBTatCaMonHocKy FLOAT,
	PRIMARY KEY(MAHS, MAHK, MANH),

);
CREATE TABLE KQNAMHOC (
    MAHS nvarchar(7) FOREIGN KEY REFERENCES HOCSINH (MAHS),
    MANH nvarchar(7) FOREIGN KEY REFERENCES NAMHOC (MANH),
    MaHocLuc NVARCHAR (7) FOREIGN KEY REFERENCES HOCLUC (MaHocLuc),
    MaHanhKiem NVARCHAR (7) FOREIGN KEY REFERENCES HANHKIEM (MaHanhKiem),
    MaKetQua NVARCHAR (7) FOREIGN KEY REFERENCES KETQUA (MaKetQua),
	DTBNamHoc FLOAT NOT NULL,
	PRIMARY KEY (MAHS, MANH),
);
CREATE TABLE KHANANGGIANGDAY (
    MAGV nvarchar(7) FOREIGN KEY REFERENCES GIAOVIEN (MAGV),
    MAMH nvarchar(7) FOREIGN KEY REFERENCES MONHOC (MAMH),
    ISDELETED BIT DEFAULT 0,
    PRIMARY KEY (MAGV, MAMH)
);
CREATE TABLE PHANCONGGIANGDAY (
    MANH nvarchar(7) FOREIGN KEY REFERENCES NAMHOC (MANH),
    MALHTT nvarchar(10) FOREIGN KEY REFERENCES LOPHOCTHUCTE (MALHTT),
    MAGV nvarchar(7) FOREIGN KEY REFERENCES GIAOVIEN (MAGV),
    MAMH nvarchar(7) FOREIGN KEY REFERENCES MONHOC (MAMH),
    ISDELETED BIT DEFAULT 0,
    PRIMARY KEY (MANH, MALHTT, MAMH, MAGV),
    FOREIGN KEY (MAGV, MAMH) REFERENCES KHANANGGIANGDAY (MAGV, MAMH)
);
CREATE TABLE THAMSO (
    ID nvarchar(10) NOT NULL PRIMARY key,
    TENTS nvarchar(100),
    TYPETS nvarchar(100),
    GIATRI nvarchar(1000),
    GHICHU nvarchar(1000),
    ISDELETED BIT DEFAULT 0,
);
SET
    DATEFORMAT DMY;

--Trigger
GO
CREATE TRIGGER CalculateKQHOCKYMONHOC
ON DIEMMONHOC
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @totalMALKT INT;
    DECLARE @countMALKT INT;
	DECLARE @MAHS NVARCHAR(7);
    DECLARE @MAHK NVARCHAR(7);
    DECLARE @MANH NVARCHAR(7);
	DECLARE @MAMH NVARCHAR(7);

    -- Lấy thông tin MAHS, MAHK, MANH từ bảng INSERTED
    SELECT @MAHS = MAHS, @MAHK = MAHK, @MANH = MANH, @MAMH = MAMH FROM INSERTED;

    SELECT @totalMALKT = COUNT(*) FROM LOAIKIEMTRA;

    SELECT @countMALKT = COUNT(DISTINCT MALKT)
    FROM DIEMMONHOC
    WHERE MAHS = @MAHS
        AND MAHK = @MAHK
        AND MAMH = @MAMH
        AND MANH = @MANH;
	
    IF @countMALKT = @totalMALKT
    BEGIN
        DECLARE @dtb FLOAT;

        SELECT @dtb = SUM(MH.DIEM * LKT.TILE) 
		FROM DIEMMONHOC MH
		JOIN LOAIKIEMTRA LKT ON MH.MALKT = LKT.MALKT
		WHERE MH.MAHS = @MAHS
			AND MH.MAHK =  @MAHK
			AND MH.MAMH = @MAMH
			AND MH.MANH =  @MANH;

        MERGE KQHOCKYMONHOC AS target
        USING (SELECT @MAHS AS MAHS, @MAHK AS MAHK, @MANH AS MANH, @MAMH AS MAMH, @dtb AS DTBMonHocKy) AS source
        ON (target.MAHS = source.MAHS AND target.MAHK = source.MAHK AND target.MANH = source.MANH AND target.MAMH = source.MAMH)
        WHEN MATCHED THEN
            UPDATE SET DTBMonHocKy = ROUND(source.DTBMonHocKy,1)
        WHEN NOT MATCHED THEN
            INSERT (MAHS, MAHK, MANH, MAMH, DTBMonHocKy)
            VALUES (source.MAHS, source.MAHK, source.MANH, source.MAMH, ROUND(source.DTBMonHocKy,1));
    END
END;
-- trigger bảng KQHOCKYMONHOC
GO
CREATE TRIGGER CalculateKQHOCKYTONGHOP
ON	KQHOCKYMONHOC
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @totalMAMH INT;
    DECLARE @countMAMH INT;
    DECLARE @MAHS NVARCHAR(7);
    DECLARE @MAHK NVARCHAR(7);
    DECLARE @MANH NVARCHAR(7);
    DECLARE @dtb FLOAT;
	DECLARE @maHocLuc NVARCHAR(7);
	DECLARE @maHocLucDTB NVARCHAR(7);
	DECLARE @maHocLucDKC NVARCHAR(7);
	DECLARE @diemKhongChe FLOAT;
	DECLARE @diemThapNhat FLOAT;

    SELECT @MAHS = MAHS, @MAHK = MAHK, @MANH = MANH FROM INSERTED;

    SELECT @totalMAMH = COUNT(*) FROM MONHOC;

    SELECT @countMAMH = COUNT(DISTINCT MAMH)
    FROM KQHOCKYMONHOC
    WHERE MAHS = @MAHS
        AND MAHK = @MAHK
        AND MANH = @MANH;

    IF @countMAMH = @totalMAMH
    BEGIN
        -- Tính toán DTBTatCaMonHocKy
        SELECT @dtb = AVG(DTBMonHocKy)
        FROM KQHOCKYMONHOC
        WHERE MAHS = @MAHS
            AND MAHK = @MAHK
            AND MANH = @MANH;

		SELECT @maHocLucDTB = MaHocLuc
        FROM HOCLUC
        WHERE @dtb <= DiemCanTren
            AND @dtb >= DiemCanDuoi;
        
		SELECT @diemThapNhat = MIN(DTBMonHocKy)
		FROM KQHOCKYMONHOC
		WHERE MAHS = @MAHS AND MAHK = @MAHK AND MANH = @MANH;

		SELECT TOP 1 @maHocLucDKC = MaHocLuc
		FROM HOCLUC
		WHERE @diemThapNhat > DiemKhongChe
		ORDER BY DiemKhongChe DESC;

		SELECT @maHocLuc = CASE
			WHEN @maHocLucDTB IS NOT NULL AND @maHocLucDKC IS NOT NULL THEN
				CASE WHEN @maHocLucDTB > @maHocLucDKC THEN @maHocLucDTB ELSE @maHocLucDKC END
			WHEN @maHocLucDTB IS NOT NULL THEN @maHocLucDTB
			WHEN @maHocLucDKC IS NOT NULL THEN @maHocLucDKC
			ELSE NULL
		END;

		INSERT INTO logs (logstring) VALUES ('maHocLucDTB: ' + @maHocLucDTB + 'diemthap nhat' + CAST(@diemThapNhat AS VARCHAR(50)) + ' maHocLucDKC' + @maHocLucDKC + 'mahocluc' + @maHocLuc);

        MERGE KQHOCKYTONGHOP AS target
        USING (SELECT @MAHS AS MAHS, @MAHK AS MAHK, @MANH AS MANH, @dtb AS DTBTatCaMonHocKy, @maHocLuc AS MaHocLuc) AS source
        ON (target.MAHS = source.MAHS AND target.MAHK = source.MAHK AND target.MANH = source.MANH)
        WHEN MATCHED THEN
            UPDATE SET DTBTatCaMonHocKy = ROUND(source.DTBTatCaMonHocKy,1), MaHocLuc = source.MaHocLuc
        WHEN NOT MATCHED THEN
            INSERT (MAHS, MAHK, MANH, DTBTatCaMonHocKy, MaHocLuc, MaHanhKiem)
            VALUES (source.MAHS, source.MAHK, source.MANH, ROUND(source.DTBTatCaMonHocKy,1), source.MaHocLuc, 'HK001');
    END
END;
GO

-- Tạo trigger cho bảng KQNAMHOC
CREATE TRIGGER CalculateKQHNAMHOC
ON KQHOCKYTONGHOP
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @totalMAHK INT;
    DECLARE @countMAHK INT;
    DECLARE @MAHS NVARCHAR(7);
    DECLARE @MAHK NVARCHAR(7);
    DECLARE @MANH NVARCHAR(7);
    DECLARE @dtb FLOAT;
	DECLARE @mkq NVARCHAR(7);
	DECLARE @maHocLuc NVARCHAR(7);
	DECLARE @maHocLucDTB NVARCHAR(7);
	DECLARE @maHocLucDKC NVARCHAR(7);
	DECLARE @diemKhongChe FLOAT;
	DECLARE @diemThapNhat FLOAT;

    SELECT @MAHS = MAHS, @MANH = MANH FROM INSERTED;

    SELECT @totalMAHK = COUNT(*) FROM HOCKY;

    SELECT @countMAHK = COUNT(DISTINCT MAHK)
    FROM KQHOCKYTONGHOP
    WHERE MAHS = @MAHS
        AND MANH = @MANH;

    IF @countMAHK = @totalMAHK
    BEGIN

        -- Tính toán DTBTatCaMonHocKy
        SELECT @dtb = AVG(DTBTatCaMonHocKy)
        FROM KQHOCKYTONGHOP
        WHERE MAHS = @MAHS
            AND MANH = @MANH;

		SELECT @maHocLucDTB = MaHocLuc 
		FROM HOCLUC
		WHERE ( @dtb > DiemCanDuoi AND @dtb < DiemCanTren)

		SELECT @diemThapNhat = MIN(DTBMonCaNam)
		FROM (
			SELECT MAMH, AVG(DTBMonHocKy) AS DTBMonCaNam
			FROM KQHOCKYMONHOC
			WHERE MAHS = @MAHS AND MANH = @MANH
			GROUP BY MAMH
		) AS Subquery;

		SELECT TOP 1 @maHocLucDKC = MaHocLuc
		FROM HOCLUC
		WHERE @diemThapNhat > DiemKhongChe
		ORDER BY DiemKhongChe DESC;

		SELECT @maHocLuc = CASE
			WHEN @maHocLucDTB IS NOT NULL AND @maHocLucDKC IS NOT NULL THEN
				CASE WHEN @maHocLucDTB > @maHocLucDKC THEN @maHocLucDTB ELSE @maHocLucDKC END
			WHEN @maHocLucDTB IS NOT NULL THEN @maHocLucDTB
			WHEN @maHocLucDKC IS NOT NULL THEN @maHocLucDKC
			ELSE NULL
		END;

		IF @maHocLuc = 'HL005'
			SET @mkq = 'KQ001';
		ELSE
			SET @mkq = 'KQ002';


		MERGE KQNAMHOC AS target
		USING (SELECT @MAHS AS MAHS, @MANH AS MANH, @mkq AS MaKetQua, @maHocLuc as MaHocLuc) AS source
		ON (target.MAHS = source.MAHS AND target.MANH = source.MANH)
		WHEN MATCHED THEN
			UPDATE SET MaKetQua = source.MaKetQua, MaHocLuc = source.MaHocLuc
		WHEN NOT MATCHED THEN
			INSERT (MAHS, MANH, MaKetQua, MaHocLuc, MaHanhKiem)
			VALUES (source.MAHS, source.MANH, source.MaKetQua, source.MaHocLuc, 'HK001');

    END
END;


--Trigger tính điểm tb năm học
GO
CREATE TRIGGER CalculateDTBNamHoc
ON KQHOCKYTONGHOP
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @totalMAHK INT;
    DECLARE @countMAHK INT;
	    
	SELECT @totalMAHK = COUNT(*) FROM HOCKY;
	SELECT @countMAHK = COUNT(DISTINCT MAHK)
    FROM KQHOCKYTONGHOP
    WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED)
	IF @totalMAHK = @countMAHK
	BEGIN
		IF NOT EXISTS (
        SELECT 1
        FROM KQNAMHOC
        WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED)
    )
    BEGIN
        INSERT INTO KQNAMHOC (MAHS, MANH, DTBNamHoc)
        SELECT MAHS, MANH, (SELECT AVG(DTBTatCaMonHocKy) FROM KQHOCKYTONGHOP WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED))
        FROM INSERTED;
    END
    ELSE
    BEGIN
        UPDATE KQNAMHOC
        SET DTBNamHoc = (SELECT AVG(DTBTatCaMonHocKy) FROM KQHOCKYTONGHOP WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED))
        WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED);
    END;
	END
END;

--Trigger tính điểm tb môn học năm học
GO
CREATE TRIGGER CalculateDTBMonHocNamHoc
ON KQHOCKYMONHOC
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
DECLARE @totalMAHK int;
	DECLARE @countlMAHK int;
	SELECT @totalMAHK = COUNT(*) FROM HOCKY;

    SELECT @countlMAHK = COUNT(DISTINCT MAHK)
	From KQHOCKYMONHOC WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED) AND MAMH = (SELECT MAMH FROM INSERTED)
	IF @totalMAHK = @countlMAHK
	BEGIN
		IF NOT EXISTS (
			SELECT 1
			FROM DIEMTRUNGBINHMONHOCNAMHOC
			WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED) AND MAMH = (SELECT MAMH FROM INSERTED)
		)
		BEGIN
			INSERT INTO DIEMTRUNGBINHMONHOCNAMHOC (MAHS, MANH, MAMH, DTBMonHocNamHoc)
			SELECT MAHS, MANH, MAMH, (SELECT AVG(DTBMonHocKy) FROM KQHOCKYMONHOC WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MAMH = (SELECT MAMH FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED))
			FROM INSERTED;
		END
		ELSE
		BEGIN
			UPDATE DIEMTRUNGBINHMONHOCNAMHOC
			SET DTBMonHocNamHoc = (SELECT AVG(DTBMonHocKy) FROM KQHOCKYMONHOC WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MAMH = (SELECT MAMH FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED))
			WHERE MAHS = (SELECT MAHS FROM INSERTED) AND MANH = (SELECT MANH FROM INSERTED) AND MAMH = (SELECT MAMH FROM INSERTED);
		END;
	END
END;
