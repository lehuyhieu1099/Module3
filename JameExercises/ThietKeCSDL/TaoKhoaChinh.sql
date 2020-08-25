CREATE TABLE Users(
	UserId INT IDENTITY(1,1) PRIMARY KEY,
	Username VARCHAR(20) NOT NULL,
	Password VARCHAR(20) NOT NULL,
	Email VARCHAR(50) NOT NULL,
);
/*Cú pháp định nghĩa khoá chính tổ hợp
CREATE TABLE Users(
	UserId INT IDENTITY(1,1),
	Username VARCHAR(20) NOT NULL,
	Password VARCHAR(20) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	PRIMARY KEY (UserId, UserName)
);*/
-- Tạo khoá chính khi thay đổi bảng
ALTER TABLE Persons
ADD PRIMARY KEY (ID);