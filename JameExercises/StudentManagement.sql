CREATE DATABASE StudentManagement
CREATE TABLE Student(
    student_id INT PRIMARY KEY,
    student_name NVARCHAR(50),
    student_address NVARCHAR(255),
    student_age INT
)

INSERT INTO Student (student_id,student_name,student_address,student_age) VALUES (1,'White Clover Markets',N'Hà Nội',18)
INSERT INTO Student (student_id,student_name,student_address,student_age) VALUES (2,'Matti Karttunen',N'Hà Nội',20)
INSERT INTO Student (student_id,student_name,student_address,student_age) VALUES (3,'Zbyszek',N'Hà Nội',25)
INSERT INTO Student (student_id,student_name,student_address,student_age) VALUES (4,'Thomas',N'Hà Nội',31)
SELECT * FROM Student

DELETE Student WHERE student_age > 18 AND student_age < 25
GO
SELECT * FROM Student

UPDATE Student
SET student_name = 'Obama', student_address='New York',student_age = 60
WHERE student_id = 3;
GO
SELECT * FROM Student