
--drop database ExaminationSystem
Go


Create Database ExaminationSystem
Go
Use ExaminationSystem
GO
--------------
CREATE SCHEMA ex -- exam schema
GO
CREATE SCHEMA uni -- universty schema
GO

CREATE SCHEMA adm -- admin schema
GO

CREATE SEQUENCE CountTo10     --for Question Number
    START WITH 1  
    INCREMENT BY 1 
	MINVALUE 1
    MAXVALUE 10 
    CYCLE  
;
Go

CREATE SEQUENCE UserIdSeq	-- for user id's
 AS bigint
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
;
GO


CREATE TABLE adm.Users
(
	UserId INT PRIMARY KEY,
	userPass INT,
	userType VARCHAR(20)
)
GO


CREATE TABLE uni.student
(
	st_id INT PRIMARY KEY default (next value for UserIdSeq),
	st_fname VARCHAR(20) NOT NULL,
	st_lname VARCHAR(20),
	st_age INT NOT NULL,
	st_gender VARCHAR(1) NOT NULL,
	dept_id INT
)
GO


CREATE TABLE uni.department
(
	Dept_ID INT PRIMARY KEY IDENTITY(1,1),
	DeptName VARCHAR(20) NOT NULL,
	Dept_Desc VARCHAR(300) NOT NULL,
	Dept_location VARCHAR(50),
	mgr_id INT NOT null ,
	mgr_HireDate DATE
)
GO


CREATE TABLE uni.instructor
(
	ins_id INT PRIMARY KEY default (next value for UserIdSeq),
    ins_FName VARCHAR (25) NOT NULL,
	ins_LName VARCHAR (25) NOT NULL,
	ins_age int NOT null ,
	ins_salary DECIMAL (18, 2),
	ins_hireDate DATE,
	ins_gender VARCHAR (1) NOT NULL
)
GO


CREATE TABLE uni.Course
(
	Crs_ID int primary key IDENTITY(1,1),
	Crs_Name NVARCHAR (25) not null,
	Crs_Duration int not null,
	Topic_ID int not null
)

GO


CREATE TABLE uni.StudentCourse
(
	st_id INT,
	crs_id INT,
	FinalGrade INT
	PRIMARY KEY (st_id,crs_id)
)

GO
----------------------------------------

create table ex.St_Takes_Exam
(
	st_id  INT not null ,
	Exam_id int not null,
	Crs_Id int not null,
	Exam_Date date,
	Grade INT
	PRIMARY KEY (Exam_id)
)

GO


CREATE TABLE uni.ins_works_dept
(
	dept_id INT ,
	ins_id INT,
	PRIMARY KEY (dept_id,ins_id)
)

GO


CREATE TABLE uni.Topic
(
	Topic_ID int primary key IDENTITY(1,1),
	Topic_Name NVARCHAR (25) not null
)
GO

CREATE TABLE uni.Ins_Crs
(
	ins_id int,
	Crs_ID int,
	PRIMARY KEY(ins_id,crs_id)
)

GO

CREATE TABLE ex.Exam
(
	Exam_id INT PRIMARY KEY IDENTITY(1,1),
	Exam_Type VARCHAR(20),
)


GO


CREATE TABLE ex.exam_answers
(
	Exam_Id INT,
	QuestionNum INT,
	QuestionAns VARCHAR(2)
	PRIMARY KEY (Exam_Id,QuestionNum)
)

GO

CREATE TABLE ex.Questions
(
	Ques_ID int primary key IDENTITY(1,1),
	Model_Answer VARCHAR (2) not null,
	Marks int not null,
	Type VARCHAR (25) NOT NULL,
	body VARCHAR(200) NOt NULL,
	CrsId int NOt NULL,
	qState BIT DEFAULT 1 -- accepts 0 / 1 -> 0 in-active , 1 -> Active
)


GO

CREATE TABLE ex.Exam_Questions
(
	Ques_id INT ,
	Exam_id INT,
	QuestionNumberInExam bigint not null Default(NEXT VALUE FOR CountTo10),
	PRIMARY KEY (Ques_id,Exam_id)
)

GO

CREATE TABLE ex.MCQ_Choices
(
	ques_id int,
	lable VARCHAR (1) not null,
	text varchar(50)
	PRIMARY KEY (ques_id,lable)
)

GO



CREATE TRIGGER AddStudentToUsers
ON uni.Student
INSTEAD OF INSERT
AS

	-- first, add new user to Users table
	DECLARE @ID INT
	SELECT @ID = st_id FROM inserted
	INSERT INTO adm.Users VALUES ( @ID, FLOOR(RAND()*(9999-1111+1)+1111),'student' )

	-- second, insert into student table with the same id
	INSERT INTO uni.student select * from inserted

GO

CREATE TRIGGER AddInsToUsers
ON uni.instructor
INSTEAD OF INSERT
AS
	-- first, add new user to Users table
	DECLARE @ID INT
	SELECT @ID = ins_id FROM inserted
	INSERT INTO adm.Users VALUES ( @ID, FLOOR(RAND()*(9999-1111+1)+1111),'instructor' )

	-- second, insert into instructor table with the same id
	INSERT INTO uni.instructor select * from inserted

GO

-------FOREIGN KEY: mcq_choices ---------------------------------------
ALTER TABLE ex.MCQ_Choices ADD CONSTRAINT fk_MCQ_Choices_id FOREIGN KEY (Ques_ID) REFERENCES ex.Questions(Ques_ID)

-------FOREIGN KEY: exam_questions-------------------------------------
ALTER TABLE ex.Exam_Questions ADD CONSTRAINT fk_exam_id FOREIGN KEY (Exam_Id) REFERENCES ex.Exam(Exam_id)
ALTER TABLE ex.Exam_Questions ADD CONSTRAINT fk_Ques_id FOREIGN KEY ( Ques_id)REFERENCES ex.Questions(Ques_id)

-------FOREIGN KEY: department ----------------------------------------
ALTER TABLE uni.department ADD CONSTRAINT fk_ins_dept02 FOREIGN KEY (mgr_id) REFERENCES uni.instructor(ins_id)

-------FOREIGN KEY: ins_works_depart ----------------------------------------
ALTER TABLE uni.ins_works_dept ADD CONSTRAINT fk_ins_id03 FOREIGN KEY (ins_id) REFERENCES uni.instructor(ins_id)
ALTER TABLE uni.ins_works_dept ADD CONSTRAINT fk_dept_id04 FOREIGN KEY (dept_id) REFERENCES uni.department(dept_id)


-------FOREIGN KEY: ins_crs -------------------------------------------
alter table uni.Ins_Crs add constraint fk_Ins_Crs_id foreign key(ins_id) references uni.instructor(ins_id)
alter table uni.Ins_Crs add constraint fk2_Ins_Crs_id foreign key(Crs_ID) references uni.Course(Crs_ID)

GO
-------FOREIGN KEY: student -------------------------------------------
ALTER TABLE uni.student ADD CONSTRAINT dept_fk FOREIGN KEY (dept_id) REFERENCES uni.department(dept_id)

GO
-------FOREIGN KEY: st_takes_exam--------------------
ALTER TABLE ex.St_Takes_Exam ADD CONSTRAINT fk_st_id   FOREIGN KEY(st_Id)   REFERENCES uni.student(st_id)
ALTER TABLE ex.St_Takes_Exam ADD CONSTRAINT fk_exam_id01 FOREIGN KEY(Exam_Id) REFERENCES ex.exam(Exam_id)
ALTER TABLE ex.St_Takes_Exam ADD CONSTRAINT fk_crs_id  FOREIGN KEY(Crs_Id)  REFERENCES uni.course(Crs_id)

GO

-------FOREIGN KEY: course ------------------------
ALTER TABLE uni.course ADD CONSTRAINT ins_topic FOREIGN KEY (topic_id) REFERENCES uni.topic(topic_id);

GO
-------FOREIGN KEY: exam_answers ------------------------
ALTER TABLE ex.exam_answers ADD CONSTRAINT fk_exam_id02 FOREIGN KEY (Exam_Id) REFERENCES ex.St_Takes_Exam(Exam_Id)
Go
-------FOREIGN KEY: course_questions ------------------------
ALTER TABLE ex.Questions ADD CONSTRAINT fk_crs_ques FOREIGN KEY (CrsId) REFERENCES uni.Course(crs_Id)
GO

-------FOREIGN KEY: Student Course------------------------
ALTER TABLE uni.StudentCourse ADD CONSTRAINT fk_st FOREIGN KEY (st_id) REFERENCES uni.Student(st_id)
ALTER TABLE uni.StudentCourse ADD CONSTRAINT fk_crs FOREIGN KEY (crs_id) REFERENCES uni.Course(crs_id)
GO


-------FOREIGN KEY: USER Course------------------------
ALTER TABLE UNI.STUDENT ADD CONSTRAINT fk_st_userId FOREIGN KEY (st_id) REFERENCES adm.users(userid)
ALTER TABLE UNI.instructor ADD CONSTRAINT fk_ins_userId FOREIGN KEY (ins_id) REFERENCES adm.users(userid)
GO

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------



GO

USE ExaminationSystem

Go
-------------------------------------- INSTRUCTOR -------------------------------------------------
INSERT INTO uni.instructor (  [ins_FName], [ins_LName] ,[ins_gender], [ins_salary], [ins_age] ) VALUES  ('Bill ','Emia','m',4000 ,38)
INSERT INTO uni.instructor (  [ins_FName], [ins_LName] ,[ins_gender], [ins_salary], [ins_age] ) VALUES  ('Hap ','Cation','m',6000 ,34)
INSERT INTO uni.instructor (  [ins_FName], [ins_LName] ,[ins_gender], [ins_salary], [ins_age] ) VALUES  ('Sal ','Briss','f',5500 ,37)
INSERT INTO uni.instructor (  [ins_FName], [ins_LName] ,[ins_gender], [ins_salary], [ins_age] ) VALUES  ('Lynn ','Guini','f',9000 ,37)
INSERT INTO uni.instructor (  [ins_FName], [ins_LName] ,[ins_gender], [ins_salary], [ins_age] ) VALUES  ('Jack ','Sharon ','m',4800 ,44)

GO
-------------------------------------- DEPARTMENT -------------------------------------------------
 INSERT INTO uni.department ([DeptName],[dept_desc],[Dept_location],[mgr_id],[mgr_HireDate] ) VALUES ('SD','System Development','SmartVillage',1,'2015-1-1')
 INSERT INTO uni.department ([DeptName],[dept_desc],[Dept_location],[mgr_id],[mgr_HireDate] ) VALUES ('TS','Testing','SmartVillage',2,'2018-5-12')
 INSERT INTO uni.department ([DeptName],[dept_desc],[Dept_location],[mgr_id],[mgr_HireDate] ) VALUES ('EWD','Enterprise','SmartVillage',3,'2016-12-2')
 INSERT INTO uni.department ([DeptName],[dept_desc],[Dept_location],[mgr_id],[mgr_HireDate] ) VALUES ('GM','Gaming','SmartVillage',4,'2017-6-9')
 INSERT INTO uni.department ([DeptName],[dept_desc],[Dept_location],[mgr_id],[mgr_HireDate] ) VALUES ('AI','Artificial Intelligence','SmartVillage',5,'2019-10-4')
 
 GO
 -------------------------------------ins_works_dept--------------------------------------------
 INSERT INTO uni.ins_works_dept ([Dept_ID],[ins_id]) VALUES (1,1)
 INSERT INTO uni.ins_works_dept ([Dept_ID],[ins_id]) VALUES (2,2)
 INSERT INTO uni.ins_works_dept ([Dept_ID],[ins_id]) VALUES (3,3)
 INSERT INTO uni.ins_works_dept ([Dept_ID],[ins_id]) VALUES (4,4)
 INSERT INTO uni.ins_works_dept ([Dept_ID],[ins_id]) VALUES (5,5)

 GO
-------------------------------------- STUDENT -------------------------------------------------
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Petey','Cruiser',22,'m',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Anna ','Sthesia',26,'f',2)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Paul ','Molive',24,'m' ,3)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Tara  ','Zona',24,'f'  ,4)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Nick ','Kinnear',25,'m',5)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Nayan','Briggs',22,'m',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Christos ','Calhoun',20,'m',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Norah ','Ballard',24,'f',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Celeste ','Miles',18,'m',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Arvin ','Hammond',25,'f',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Sol  ','Graham',24,'m',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Saim ','Worthington',24,'m',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Jayden ','Gilbert',24,'m',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Dainton ','Neville',24,'m',1)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Ezra ','Burn',25,'m',2)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Aarav  ','Denton',26,'m',2)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Annabell  ','Ballard',28,'f',2)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Annabell  ','Miles',22,'m',2)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Sara   ','Tapia',20,'f',3)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Carter  ','Sohail ',21,'m',3)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Anjali  ','Randall',23,'m',3)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Taylor ','Daniaal ',23,'m',3)
INSERT INTO uni.student (  [st_fname], [st_lname], [st_age], [st_gender], [dept_id] ) VALUES ('Anderson  ','Richard',23,'m',3)

Go
INSERT INTO uni.Topic( [Topic_Name]) VALUES ( N'FullStack')
INSERT INTO uni.Topic( [Topic_Name]) VALUES ( N'CST Technologies')
Go

INSERT INTO uni.Course ( [Crs_Name], [Crs_Duration],[Topic_ID]) VALUES ( N'Csharp',16,1)
INSERT INTO uni.Course ( [Crs_Name], [Crs_Duration],[Topic_ID]) VALUES ( N'SQL',8,1)
INSERT INTO uni.Course ( [Crs_Name], [Crs_Duration],[Topic_ID]) VALUES ( N'ASP.net',12,1)
INSERT INTO uni.Course ( [Crs_Name], [Crs_Duration],[Topic_ID]) VALUES ( N'HTML5',7,2)
INSERT INTO uni.Course ( [Crs_Name], [Crs_Duration],[Topic_ID]) VALUES ( N'CSS3',5,2)
INSERT INTO uni.Course ( [Crs_Name], [Crs_Duration],[Topic_ID]) VALUES ( N'JavaScript',11,2)
INSERT INTO uni.Course ( [Crs_Name], [Crs_Duration],[Topic_ID]) VALUES ( N'XML',8,2)

GO

-------------------------------------- STUDENTCOURSE -------------------------------------------------

INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (6,1)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (6,2)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (6,4)

INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (7,1)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (7,2)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (7,3)

INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (8,1)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (8,2)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (8,3)

INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (9,1)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (9,2)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (9,3)

INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (10,4)
INSERT INTO uni.StudentCourse ( [st_id] , [Crs_Id]) VALUES (10,3)


--- instructor course

INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (1 ,1 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (1 ,2 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (1 ,3 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (1 ,7 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (3 ,1 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (3 ,2 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (3 ,3 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (3 ,7 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (2 , 4)
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (2 , 5)
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (2 , 6)
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (4 ,1 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (4 ,6 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (4 ,5 )
INSERT INTO uni.Ins_Crs (ins_id,Crs_ID) VALUES (4 ,4 )


Go


INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which of the following is not a class of constraint in SQL Server?', N'MCQ', 5, N'c', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Point out the correct statement.', N'MCQ', 5, N'd', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'What is a view?', N'MCQ', 3, N'b', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'What type of join is needed when you wish to include rows that do not have matching values?', N'MCQ', 5, N'c', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'What type of join is needed when you wish to return rows that do have matching values?', N'MCQ', 5, N'd', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'A function can return more than one value.', N'TF', 4, N'b', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'If a function returns no value, the return type must be declared as void.', N'TF', 4, N'a', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'We can use reserved keywords as identifiers in C# by prefixing them with @ character?', N'TF', 4, N'a', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'The comparison operators can be overloaded.', N'TF', 6, N'a', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'You can define one namespace inside another namespace.', N'TF', 6, N'a', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which of the following converts a type to a string in C#?', N'MCQ', 5, N'd', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'What is an iterator?', N'MCQ', 6, N'd', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'How many Bytes are stored by ‘Long’ Data type in C# .net?', N'MCQ', 6, N'a', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Choose “.NET class” name from which data type “UInt” is derived?', N'MCQ', 6, N'b', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Correct Declaration of Values to variables ‘a’ and ‘b’?', N'MCQ', 3, N'c', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Arrange the following data type in order of increasing magnitude sbyte, short, long, int.', N'MCQ', 3, N'b', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which data type should be more preferred for storing a simple number like 35 to improve execution speed of a program?', N'MCQ', 5, N'a', 1)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N' Correct way to assign values to variable ‘c’ when int a=12, float b=3.5, int c;', N'MCQ', 5, N'c', 1)


INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which SQL function is used to count the number of rows in a SQL query?', N'MCQ', 3, N'd', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which SQL keyword is used to retrieve a maximum value?', N'MCQ', 3, N'c', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which of the following SQL clauses is used to DELETE tuples from a database table?', N'MCQ', 3, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N' ___________removes all rows from a table without logging the individual row deletions.', N'MCQ', 3, N'd', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which of the following is not a DDL command?', N'MCQ', 3, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which of the following are TCL commands?', N'MCQ', 3, N'd', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N' ________________ is not a category of SQL command.?', N'MCQ', 3, N'b', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'If you don’t specify ASC or DESC after a SQL ORDER BY clause, the following is used by default ______________?', N'MCQ', 3, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which of the function provides consecutive numbering except in the case of a tie?', N'MCQ', 3, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Which of the following will not raise error if not used?', N'MCQ', 3, N'c', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'AFTER trigger in SQL Server can be applied to _________________', N'MCQ', 3, N'c', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'DML triggers in SQL Server is applicable to _____________ _________________', N'MCQ', 3, N'd', 2)



INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'The condition in a WHERE clause can refer to only one value.', N'TF', 4, N'b', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'SQL provides the AS keyword, which can be used to assign meaningful column names to the results of queries using the SQL built-in functions.', N'TF', 4, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'The rows of the result relation produced by a SELECT statement can be sorted, but only by one column.', N'TF', 4, N'b', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'There is an equivalent join expression that can be substituted for all subquery expressions.', N'TF', 4, N'b', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'SQL is a programming language.', N'TF', 4, N'b', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'SELECT DISTINCT is used if a user wishes to see duplicate columns in a query.', N'TF', 4, N'b', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Indexes can usually be created for both primary and secondary keys.', N'TF', 4, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'The HAVING clause acts like a WHERE clause, but it identifies groups that meet a criterion, rather than rows.', N'TF', 4, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'The qualifier DISTINCT must be used in an SQL statement when we want to eliminate duplicate rows.', N'TF', 4, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Indexes may be created or dropped at any time.', N'TF', 4, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'ORDER BY can be combined with the SELECT statements.', N'TF', 4, N'a', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'Scalar aggregate are multiple values returned from an SQL query that includes an aggregate function..', N'TF', 4, N'b', 2)
INSERT INTO ex.Questions( body, Type, Marks, Model_Answer, CrsId) VALUES ( N'The keyword LIKE can be used in a WHERE clause to refer to a range of values.', N'TF', 4, N'b', 2)






Go

INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES  (1, N'A', N'NOT NULL')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (1, N'B', N'CHECK')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (1, N'C', N'NULL')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (1, N'D', N'UNIQUE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (3, N'A', N'A view is a special stored procedure executed when')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (3, N'B', N'A view is a virtual table which results of executi')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (3, N'C', N'A view is a database diagram')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (3, N'D', N'None of the Mentioned')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (2, N'A', N'ORDER BY Does Not Work')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (2, N'B', N' Index Created on View Used Often')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (2, N'C', N'Cross Database Queries Not Allowed in Indexed View')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (2, N'D', N' Adding Column is Expensive by Joining Table Outsi')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (4, N'A', N'Equi-join')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (4, N'B', N'Natural join')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (4, N'C', N'Outer join')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (4, N'D', N'All of the Mentioned')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (5, N'A', N'Equi-join')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (5, N'B', N'Natural join')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (5, N'C', N'Outer join')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (5, N'D', N'All of the Mentioned')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (11, N'A', N'ToInt64')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (11, N'B', N'ToSbyte')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (11, N'C', N'ToSingle')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (11, N'D', N'TOString')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (12, N'A', N'a method')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (12, N'B', N'n operator')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (12, N'C', N'accessor')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (12, N'D', N'all of the mentioned')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (13, N'A', N'8')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (13, N'B', N'4')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (13, N'C', N'2')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (13, N'D', N'1')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (14, N'A', N'System.Int16')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (14, N'B', N'System.UInt32')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (14, N'C', N'System.UInt64')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (14, N'D', N'System.UInt16')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (15, N'A', N'nt a = 32, b = 40.6;')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (15, N'B', N'int a = 42; b = 40;')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (15, N'C', N'int a = 32; int b = 40;')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (15, N'D', N' int a = b = 42;')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (16, N'A', N'long < short < int < sbyte')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (16, N'B', N'sbyte < short < int < long')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (16, N'C', N'hort < sbyte < int < long')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (16, N'D', N'short < int < sbyte < long')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (17, N'A', N'sbyte')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (17, N'B', N'short')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (17, N'C', N'int')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (17, N'D', N'long')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (18, N'A', N'c = a + b;')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (18, N'B', N'c = a + int(float(b));')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (18, N'C', N'c =a+convert.ToInt32(b);')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (18, N'D', N' c = int(a + b);')


INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (19, N'A', N'COUNT()')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (19, N'B', N'NUMBER()')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (19, N'C', N'SUM()')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (19, N'D', N'COUNT(*)')




INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (20, N'A', N'MOST')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (20, N'B', N'TOP')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (20, N'C', N'MAX')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (20, N'D', N'UPPER')



INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (21, N'A', N'DELETE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (21, N'B', N'REMOVE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (21, N'C', N'DROP')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (21, N'D', N'CLEAR')



INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (22, N'A', N'DELETE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (22, N'B', N'REMOVE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (22, N'C', N'DROP')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (22, N'D', N'TRUNCATE')

INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (23, N'A', N'UPDATE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (23, N'B', N'TRUNCATE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (23, N'C', N'ALTER')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (23, N'D', N'None of the Mentioned')


INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (24, N'A', N'UPDATE and TRUNCATE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (24, N'B', N'SELECT and INSERT')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (24, N'C', N'GRANT and REVOKE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (24, N'D', N'ROLLBACK and SAVEPOINT')




INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (25, N'A', N'TCL')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (25, N'B', N'SCL')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (25, N'C', N'DCL')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (25, N'D', N'DDL')


INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (26, N'A', N'ASC')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (26, N'B', N'DESC')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (26, N'C', N'There is no default value')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (26, N'D', N'None of the mentioned')


INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (27, N'A', N'RANK')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (27, N'B', N'NTILE')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (27, N'C', N'ROW_NUMBER')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (27, N'D', N'All of the mentioned')



INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (28, N'A', N'OVER clause')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (28, N'B', N'ORDER BY clause')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (28, N'C', N'PARTITION BY clause')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (28, N'D', N' All of the mentioned')


INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (29, N'A', N'Stored')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (29, N'B', N'Function')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (29, N'C', N'View')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (29, N'D', N'Table')



INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (30, N'A', N'Table')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (30, N'B', N'Views')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (30, N'C', N'Table and Views')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (30, N'D', N'Function')


INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (31, N'A', N'Insert')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (31, N'B', N'Update')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (31, N'C', N'Delete')
INSERT INTO ex.MCQ_Choices(ques_id,lable,text)  VALUES (31, N'D', N'All of the mentioned')








------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
-------------------------------------- SELECT PROCEDURES ---------------------------------------------
------------------------------------------------------------------------------------------------------
GO





USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Exam Correction
-- Inputs: Exam Id
-- Returns:      
--				0-> Success
--				1-> Exam id Invalid : Null
--				2-> Exam Not Found
--				3-> Failure
--				More Than 10 -> Error in Updating StudentTakeExamTable, check for error - 10 code
--				More Than 20 -> Error in Updating Student Course, check for error - 20 code
-- =============================================

CREATE PROC ex.spExamCorrection
	@ExamId INT

WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON
	
	IF (@ExamId IS NULL) RETURN 1
	IF NOT EXISTS ( SELECT 1 FROM ex.exam_answers WHERE Exam_id = @ExamId) RETURN 2

	DECLARE @ExamData TABLE
	(
		QuestionNumberInExam INT,
		StudentAnswer VARCHAR(25),
		ModelAnswer VARCHAR(25),
		QuestionMarks INT
	)

	--Get Student ID , Course ID
	DECLARE @StudentId INT, @CourseId INT

	SELECT @StudentId = st_id, @CourseId = crs_id
	FROM ex.St_Takes_Exam
	WHERE Exam_id = @ExamId

	-- populate Exam Data table
	INSERT @ExamData
	SELECT QuestionNum,QuestionAns,Model_Answer,Marks
	FROM ex.exam_answers 
		INNER JOIN ex.Exam_Questions ON QuestionNum = QuestionNumberInExam
		INNER JOIN ex.Questions ON ex.Exam_Questions.Ques_id = ex.Questions.Ques_ID
	WHERE Exam_Questions.Exam_Id = @ExamId

	-- Get number of questions in the exam
	DECLARE @NumberOfQuestions INT, @Counter INT = 1 
	SELECT @NumberOfQuestions = Count(0) FROM @ExamData
	
	DECLARE @StudentAnswer VARCHAR(2), @ModelAnswer VARCHAR(2) -- for comparison
	DECLARE @QuestionMark INT, @TotalExamMarks INT = 0, @TotalStudentMarks INT = 0
	-- loop over the questions in the exam
	WHILE(@Counter <= @NumberOfQuestions)
	BEGIN
		SELECT @StudentAnswer = StudentAnswer, @ModelAnswer = ModelAnswer, @QuestionMark = QuestionMarks
		FROM @ExamData
		WHERE QuestionNumberInExam = @Counter
		SET @TotalExamMarks += @QuestionMark -- calculate total exam marks

		IF (@StudentAnswer = @ModelAnswer) -- add marks to student if correct
			SET @TotalStudentMarks += @QuestionMark
		SET @Counter += 1 -- go to next question
	END

	-- Get Percentage
	DECLARE @StudentMarksPercentage INT 

	IF @TotalStudentMarks = 0 -- check for zero division
		SET @StudentMarksPercentage = 0
	ELSE
		SET @StudentMarksPercentage = (@TotalStudentMarks * 100.00) / @TotalExamMarks 

	-- update student take exam table
	DECLARE @CheckReturn INT

	EXEC @CheckReturn = ex.spStudentTakeExamUpdateRecordByExamId @ExamId,@NewGrade = @StudentMarksPercentage
	IF (@CheckReturn <> 0 ) RETURN @CheckReturn+10

	--update student course table for final grade
	EXEC @CheckReturn = uni.spStudentCourseUpdateRecordByStudentIdAndCourseId @StudentId,@CourseId,@StudentMarksPercentage 
	IF (@CheckReturn <> 0 ) RETURN @CheckReturn+20

	RETURN 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH

GO



-- =============================================
-- Author:		Abdallh
-- Description:	Get All Course Data From Course Table
-- Inputs: None
-- =============================================

CREATE PROC uni.spCourseGetAll
WITH ENCRYPTION 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Crs_id,Crs_Name,Crs_Duration,Topic_ID
	FROM uni.Course
END

GO
------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Course Data By Course ID From Course Table
-- =============================================
CREATE PROC uni.spCourseGetAllByCrsId
	@id INT

WITH ENCRYPTION 

AS
BEGIN 
	SET NOCOUNT ON;

	SELECT Crs_Name,Crs_Duration,Topic_ID
	FROM uni.Course
	WHERE Crs_ID = @id
END 
GO
------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Get All Course Data By Course Name From Course Table
-- =============================================


CREATE PROC uni.spCourseGetAllByCrsName
	@crsName nvarchar(25)

WITH ENCRYPTION 


AS
BEGIN 
	SET NOCOUNT ON;

	SELECT Crs_ID, Crs_Name,Crs_Duration,Topic_ID
	FROM uni.Course
	WHERE Crs_Name = @crsName;
END 


GO
------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Course Data By Topic ID From Course Table
-- =============================================

CREATE PROC uni.spCourseGetAllByTopicId
	@topicId INT

WITH ENCRYPTION 

AS
BEGIN
	SET NOCOUNT ON
	SELECT Crs_ID,Crs_Name,Crs_Duration
	FROM uni.Course
	WHERE Topic_ID = @topicId
END

GO



------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Course Data By Topic Name From Course Table
-- =============================================

CREATE PROC uni.spCourseGetAllByTopicName
	@topicName NVARCHAR(25)


WITH ENCRYPTION 
AS
BEGIN
	SET NOCOUNT ON

	SELECT Crs_id, crs_Name,crs_Duration
	FROM uni.Course
		INNER JOIN uni.Topic
		ON uni.Course.Topic_ID = uni.Topic.Topic_ID
		AND uni.Topic.Topic_Name = @topicName
END

GO
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
-------------------------------------- DELETE PROCEDURES ---------------------------------------------
------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Delete Record By CourseID From Course Table
-- Input : Course ID 
-- Returns:		0 -> Success
--				1 -> Course ID NULL
--				2 -> Course ID Doesn't Exist
--				3 -> failure


-- =============================================

CREATE PROC spCourseDeleteRecordById
	@crs_id INT


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	if @crs_id IS NULL return 1
	if ( NOT EXISTS (select 1 FROM uni.Course where Crs_ID =  @crs_id ) ) RETURN 2
	
	DELETE
	FROM uni.Course
	WHERE Crs_ID = @Crs_ID;

	return 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH


GO

------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Delete Record By Course Name From Course Table
-- Input : Course Name 
-- Returns:		0 -> Success
--				1 -> Course Name NULL | Empty
--				2 -> Course Name Doesn't Exist
--				3 -> Failure


-- =============================================

CREATE PROC uni.spCourseDeleteRecordByName
	@CourseName NVARCHAR(25)


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	IF (NULLIF(@CourseName,'') IS NULL ) return 1
	IF ( NOT EXISTS (select 1 FROM uni.Course where Crs_Name =  @CourseName ) ) RETURN 2
	
	DELETE
	FROM uni.Course
	WHERE Crs_Name = @CourseName;

	return 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH


GO

------------------------------------------------------------------------------------------------------
-------------------------------------- UPDATE PROCEDURES ---------------------------------------------
------------------------------------------------------------------------------------------------------

USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Update a Record In Course Table With Course Id
-- Input : Course Id, New Course Name [optional], new Course Duration [optional], new Topic ID [optional],  
-- Returns:		0 -> Success
--				1 -> invalid Course Id : Null
--				2 -> Course doesn't exist
--				3 -> New Topic key doesn't exist
--				4 -> General Failure ?? 

-- =============================================

CREATE PROC uni.spCourseUpdateRecordWithCourseId
	@CourseId INT,
	@NewCourseName NVARCHAR(25) = NULL,
	@NewCourseDuration INT = NULL,
	@NewTopicId INT = NULL


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	if @CourseId IS NULL RETURN 1
	if NOT EXISTS ( SELECT 1 FROM uni.Course WHERE Crs_ID = @CourseId ) RETURN 2
	IF ( 
	     @NewTopicId IS NOT NULL 
		 AND
		 NOT EXISTS ( SELECT 1 FROM uni.Topic WHERE Topic_ID = @NewTopicId )
	   )  
		 RETURN 3 -- check for user input topic id that is not defaulted parameter

	UPDATE uni.Course
	SET Crs_Name = ISNULL(@NewCourseName,Crs_Name),
		Crs_Duration = ISNULL(@NewCourseDuration,Crs_Duration),
		Topic_ID = ISNULL(@NewTopicId,Topic_ID)
	WHERE Crs_ID = @CourseId;

	return 0
END TRY
BEGIN CATCH
	return 4
END CATCH

GO





------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Update a Record In Course Table With Course Name
-- Input : Old Course Name, New Course Name [optional], new Course Duration [optional] , new Topic ID [optional],  
-- Returns:		0 -> Success
--				1 -> invalid Course Name : null | ''
--				2 -> Course doesn't exist
--				3 -> New Topic key doesn't exist
--				4 -> General Failure ?? 

-- =============================================

CREATE PROC uni.spCourseUpdateRecordWithCourseName
	@CourseName NVARCHAR(25),
	@NewCourseName NVARCHAR(25) = NULL,
	@NewCourseDuration INT = NULL,
	@NewTopicId INT = NULL

WITH ENCRYPTION 


AS
BEGIN TRY
	SET NOCOUNT ON

	if NULLIF(@CourseName,'') IS NULL RETURN 1
	if NOT EXISTS ( SELECT 1 FROM uni.Course WHERE Crs_Name = @CourseName ) RETURN 2
	IF ( 
	     @NewTopicId IS NOT NULL 
		 AND
		 NOT EXISTS ( SELECT 1 FROM uni.Topic WHERE Topic_ID = @NewTopicId )
	   )  
		 RETURN 3 -- check for user input topic id that is not defaulted parameter

	UPDATE uni.Course
	SET Crs_Name = ISNULL(@NewCourseName,Crs_Name),
		Crs_Duration = ISNULL(@NewCourseDuration,Crs_Duration),
		Topic_ID = ISNULL(@NewTopicId,Topic_ID)
	WHERE Crs_Name = @CourseName;

	return 0
END TRY
BEGIN CATCH
	return 4
END CATCH

GO

------------------------------------------------------------------------------------------------------
-------------------------------------- INSERT PROCEDURES ---------------------------------------------
------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Insert a record into Course Table
-- Input : Course Name , Course Duration , Topic ID
-- Returns:		0 -> Success
--				1 -> invalid topic ID / NULL topic ID
--				2 -> Course Name Cant Be Null
--				3 -> Course Duration Cant Be Null

-- =============================================

CREATE PROC uni.spCourseInsertRecord
	@CourseName NVARCHAR(25),
	@CourseDuration INT,
	@TopicID INT

WITH ENCRYPTION 


AS
BEGIN TRY
	SET NOCOUNT ON

	if NULLIF(@CourseName,'') IS NULL return 2
	if @CourseDuration IS NULL return 3

	INSERT INTO uni.Course VALUES (@CourseName,@CourseDuration,@TopicID)
	return 0
END TRY
BEGIN CATCH
	return 1
END CATCH

GO
------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Insert a Record into Course Table With Topic ID
-- Input : Topic ID , CourseName , Course Duration
-- Returns:		0 -> Success
--				1 -> Topic Id Doesn't Exist
--				2 -> invalid Course Name
--				3 -> invalid Course Duration
--				4 -> General Failure 


-- =============================================

CREATE PROC uni.spCourseInsertRecordWithTopicId
	@CourseName NVARCHAR(25),
	@CourseDuration INT,
	@TopicID INT

WITH ENCRYPTION 


AS
BEGIN TRY
	SET NOCOUNT ON

	if (@TopicID IS NULL) RETURN 1
	if NULLIF(@CourseName,'') IS NULL RETURN 2
	if (@CourseDuration IS NULL) RETURN 3

	IF NOT EXISTS ( SELECT 1 FROM uni.Topic WHERE Topic_ID = @TopicID ) RETURN 1

	INSERT INTO uni.Course VALUES(@CourseName,@CourseDuration,@TopicID)

	return 0
END TRY
BEGIN CATCH
	return 4
END CATCH

GO

------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Insert a Record into Course Table With Topic Name
-- Input : TopicName , Course Name , Course Duration
-- Returns:		        0 -> Success
--				1 -> invalid Topic Name : null | ''
--				2 -> invalid Course Name : null | ''
--				3 -> invalid Course Duration
--				4 -> Topic Name Doesn't Exist
--				5 -> General Failure ?? 


-- =============================================

CREATE PROC uni.spCourseInsertRecordWithTopicName
	@CourseName NVARCHAR(25),
	@CourseDuration INT,
	@TopicName NVARCHAR(25)

WITH ENCRYPTION 

AS
BEGIN TRY
	SET NOCOUNT ON

	if NULLIF(@TopicName,'') IS NULL RETURN 1
	if NULLIF(@CourseName,'') IS NULL RETURN 2
	if @CourseDuration IS NULL RETURN 3

	declare @TopicID INT
	EXEC uni.spTopicGetTopicIdByTopicName @TopicName , @TopicID OUTPUT

	IF @TopicID IS NULL RETURN 4

	INSERT INTO uni.Course VALUES(@CourseName,@CourseDuration,@TopicID)

	return 0
END TRY
BEGIN CATCH
	return 5
END CATCH
GO
------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------
----------------------------------SELECT PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------

USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Data From StudentTakesExam  Table
-- =============================================

CREATE PROC ex.spStudentTakeExamGetAll

WITH ENCRYPTION 
AS
BEGIN
	SELECT st_id,Exam_id,Crs_Id,Exam_Date,Grade
	FROM St_Takes_Exam
END

GO

--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Data From Student StudentTakesExam  By Student ID
-- =============================================

CREATE PROC ex.spStudentTakeExamGetAllByStudentId
	@StudentId INT

WITH ENCRYPTION 
AS
BEGIN
	SELECT st_id,Exam_id,Crs_Id,Exam_Date,Grade
	FROM St_Takes_Exam
	WHERE st_id = @StudentId
END

GO

--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Data From StudentTakesExam  Table By Course ID
-- Inputs : Course ID
-- =============================================

CREATE PROC ex.spStudentTakeExamGetAllByCourseId
	@CourseId INT

WITH ENCRYPTION 
AS
BEGIN
	SELECT st_id,Exam_id,Crs_Id,Exam_Date,Grade
	FROM St_Takes_Exam
	WHERE Crs_Id = @CourseId
END

GO

--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Data From StudentTakesExam  Table By Exam Id
-- Inputs : Exam ID
-- =============================================

CREATE PROC ex.spStudentTakeExamGetAllByExamId
	@ExamId INT

WITH ENCRYPTION 
AS
BEGIN
	SELECT st_id,Exam_id,Crs_Id,Exam_Date,Grade
	FROM St_Takes_Exam
	WHERE Exam_id = @ExamId
END

GO


--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Data From StudentTakesExam  Table By Grade -- Gets Who is higher than this grade
-- Inputs: Grade
-- =============================================

CREATE PROC ex.spStudentTakeExamGetAllByGrade
	@Grade INT

WITH ENCRYPTION 
AS
BEGIN
	SELECT st_id,Exam_id,Crs_Id,Exam_Date,Grade
	FROM St_Takes_Exam
	WHERE Grade > @Grade
END

GO

--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
----------------------------------UPDATE PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Update a Record In StudentTakesExam Table With Exam Id
-- Input : Exam Id ,New Grade [optional],  New Course Id [optional],
--		   New Student Id [optional], New Exam Date  [optional]
-- Returns:		0 -> Success
--				1 -> invalid Exam Id : NULL
--				2 -> Exam doesn't exist
--				3 -> Course not found
--				4 -> Student not found
--				5 -> Failure 

-- =============================================

CREATE PROC ex.spStudentTakeExamUpdateRecordByExamId
	@ExamId INT,
	@NewGrade INT = NULL,
	@NewCourseId INT = NULL,
	@NewExamDate DATE = NULL,
	@NewStudentId INT = NULL




WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	IF @ExamId IS NULL RETURN 1
	IF NOT EXISTS ( SELECT 1 FROM ex.St_Takes_Exam WHERE Exam_id = @ExamId ) RETURN 2
	IF ( 
	     @NewCourseId IS NOT NULL 
		 AND
		 NOT EXISTS ( SELECT 1 FROM uni.Course WHERE Crs_ID = @NewCourseId )
	   )  
		 RETURN 3 -- check for user input course id that is not defaulted parameter

	IF ( 
	     @NewStudentId IS NOT NULL 
		 AND
		 NOT EXISTS ( SELECT 1 FROM uni.student WHERE st_id = @NewStudentId )
	   )  
		 RETURN 4 -- check for user input student id that is not defaulted parameter


	UPDATE ex.St_Takes_Exam
	SET Grade = ISNULL(@NewGrade,Grade),
		Crs_Id = ISNULL(@NewCourseId,Crs_Id),
		Exam_Date = ISNULL(@NewExamDate,Exam_Date),
		st_id = ISNULL(@NewStudentId,st_id)
	WHERE Exam_id = @ExamId

	return 0
END TRY
BEGIN CATCH
	return 5
END CATCH

GO





--------------------------------------------------------------------------------------------------
----------------------------------DELETE PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------


-- =============================================
-- Author:		Abdallh
-- Description:	Delete Record From StudentTakesExam Table By Exam ID
-- Input : Exam ID 
-- Returns:		0 -> Success
--				1 -> Exam ID NULL
--				2 -> Exam ID Doesn't Exist
--				3 -> failure


-- =============================================

CREATE PROC ex.spStudentTakeExamDeleteRecordByExamId
	@ExamId INT

WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	if @ExamId IS NULL return 1
	if ( NOT EXISTS (select 1 FROM ex.St_Takes_Exam where Exam_id =  @ExamId ) ) RETURN 2
	
	DELETE
	FROM ex.St_Takes_Exam
	WHERE Exam_id = @ExamId;

	return 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH


GO

--------------------------------------------------------------------------------------------------


USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Delete Records By Course ID From StudentTakesExam Table
-- NOTE (DELETES ALL COURSE EXAMS) ( CAN DELETE MULTIPLE ROWS )
-- Input : Course ID 
-- Returns:		0 -> Success
--				1 -> Course ID NULL
--				2 -> Course ID Doesn't Exist
--				3 -> failure


-- =============================================

CREATE PROC ex.spStudentTakeExamDeleteCourseRecordsByCourseId
	@CourseId INT

WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	if @CourseId IS NULL return 1
	if ( NOT EXISTS (select 1 FROM ex.St_Takes_Exam where Crs_Id =  @CourseId ) ) RETURN 2
	
	DELETE
	FROM ex.St_Takes_Exam
	WHERE Crs_Id = @CourseId;

	return 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH


GO



--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
----------------------------------INSERT PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------

USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description: Insert New Record  Data into StudentTakesExam  Table
-- Inputs : Student ID , Exam ID, Course ID , Exam Date , Grade
-- Returns:		0 -> Success
--				1 -> Student id cant be NULL
--				2 -> Course id Cant Be NULL
--				3 -> Exam id Cant Be Null
--				4 -> Exam Date Cant Be Null
--				5 -> Exam Grade Cant Be Null
--				6 -> Student Doesn't exist
--				7 -> Course Doesn't exist
--				8 -> Exam Doesn't exist
--				9 -> Exam ID Already Exists
--				10-> Failure

-- =============================================

CREATE PROC ex.spStudentTakeExamInsertRecord
	@StudentId INT,
	@CourseId INT,
	@ExamId INT,
	@ExamDate DATE,
	@ExamGrade INT

WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	IF @StudentId IS NULL return 1
	IF @CourseId IS NULL return 2
	IF @ExamId IS NULL return 3
	IF (@ExamDate IS NULL) RETURN 4
	IF (@ExamGrade IS NULL) RETURN 5

	IF NOT EXISTS ( SELECT 1 FROM uni.student WHERE st_id = @StudentId ) RETURN 6
	IF NOT EXISTS ( SELECT 1 FROM uni.Course WHERE Crs_ID = @CourseId ) RETURN 7
	IF NOT EXISTS ( SELECT 1 FROM ex.Exam WHERE Exam_id = @ExamId ) RETURN 8

	IF EXISTS ( SELECT 1 FROM ex.St_Takes_Exam WHERE Exam_id = @ExamId ) RETURN 9

	INSERT INTO ex.St_Takes_Exam VALUES (@StudentId,@ExamId,@CourseId,@ExamDate,@ExamGrade)
	return 0
END TRY
BEGIN CATCH
	return 10
END CATCH

GO
--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
----------------------------------SELECT PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Topic Data From Topic Table
-- =============================================

CREATE PROC uni.spTopicGetAll

WITH ENCRYPTION 
AS
BEGIN
	SELECT topic_id,topic_name
	FROM uni.Topic
END

GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Topic Data By Course ID From Topic Table
-- Input: Course ID
-- Return:			0 -> Success
--					1 -> Course Id Invalid : NULL
--					2 -> Course Not Found
-- =============================================

CREATE PROC uni.spTopicGetAllByCourseId
	@crsId INT

WITH ENCRYPTION 
AS
BEGIN
	SET NOCOUNT ON

	IF (@crsId IS NULL) RETURN 1
	IF NOT EXISTS ( SELECT 1 FROM UNI.Course WHERE Crs_ID = @crsId ) RETURN 2

	SELECT TOP (1) topic.Topic_ID,Topic_Name
	FROM uni.Topic 
		INNER JOIN uni.Course
		ON uni.Topic.Topic_ID = uni.Course.Crs_ID
		AND Crs_ID = @crsId
END


GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Topic Data By Course Name From Topic Table
-- =============================================

CREATE PROC uni.spTopicGetAllByCourseName
	@crsName NVARCHAR(25)

WITH ENCRYPTION 
AS
BEGIN
	SET NOCOUNT ON

	SELECT TOP (1) topic.Topic_ID,Topic_Name
	FROM uni.Topic 
		INNER JOIN uni.Course
		ON uni.Topic.Topic_ID = uni.Course.Crs_ID
		AND Crs_Name = @crsName
END

GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Get Topic Id By Topic Name from Topic Table
-- Input : Topic Name , Topic ID OUTPUT
-- output: @TopicID

-- =============================================

CREATE PROC uni.spTopicGetTopicIdByTopicName
	@TopicName NVARCHAR(25),
	@TopicID INT OUTPUT	

WITH ENCRYPTION 
AS
BEGIN
	SELECT TOP (1) @topicID = Topic_ID
	FROM uni.Topic
	WHERE Topic_Name = @TopicName
END


GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get Topic Name By Course ID From Topic Table
-- =============================================

CREATE PROC uni.spTopicGetTopicNameByCourseId
	@crsId INT

WITH ENCRYPTION 
AS
BEGIN
	SET NOCOUNT ON

	SELECT TOP (1) Topic_Name
	FROM uni.Topic 
		INNER JOIN uni.Course
		ON uni.Topic.Topic_ID = uni.Course.Crs_ID
		AND Crs_ID = @crsId
END


GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get TopicName By Course Name From Topic Table
-- =============================================

CREATE PROC uni.spTopicGetTopicNameByCourseName
	@crsName NVARCHAR(25)

WITH ENCRYPTION 
AS
BEGIN
	SET NOCOUNT ON

	SELECT TOP (1) Topic_Name
	FROM uni.Topic 
		INNER JOIN uni.Course
		ON uni.Topic.Topic_ID = uni.Course.Crs_ID
		AND Crs_Name = @crsName
END

GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Get All Topic Names From Topic Table
-- =============================================

CREATE PROC uni.spTopicGetTopicNames

WITH ENCRYPTION 
AS
BEGIN
	SELECT topic_name
	FROM uni.Topic
END
GO
--------------------------------------------------------------------------------------------------
----------------------------------DELETE PROCEDURES-----------------------------------------------
-------------------------------------------------------------------------------------------------

USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Delete Record By Topic ID From Topic Table
-- Input : Topic ID 
-- Returns:		0 -> Success
--				1 -> Topic Name NULL | Empty
--				2 -> Topic Name Doesn't Exist
--				3 -> FK Error , Topic has subjects not deleted.


-- =============================================

CREATE PROC uni.spTopicDeleteRecordById
	@TopicID INT

WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	IF ( @TopicID IS NULL ) return 1
	IF ( NOT EXISTS (select 1 FROM uni.Topic where Topic.Topic_ID =  @TopicID ) ) RETURN 2
	
	DELETE
	FROM uni.Topic
	WHERE Topic_ID = @TopicID;

	return 0
END TRY

BEGIN CATCH
	RETURN 3
END CATCH


GO




--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Delete Record By Topic Name From Topic Table
-- Input : Topic Name 
-- Returns:		0 -> Success
--				1 -> Topic Name NULL | Empty
--				2 -> Topic Name Doesn't Exist
--				3 -> FK Error , Topic has subjects not deleted.


-- =============================================

CREATE PROC uni.spTopicDeleteRecordByName
	@TopicName NVARCHAR(25)

WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	IF (NULLIF(@TopicName,'') IS NULL ) return 1
	IF ( NOT EXISTS (select 1 FROM uni.Topic where Topic.Topic_Name =  @TopicName ) ) RETURN 2
	
	DELETE
	FROM uni.Topic
	WHERE Topic_Name = @TopicName;

	return 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH


GO


--------------------------------------------------------------------------------------------------
----------------------------------UPDATE PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Update a Record In Topic Table With Topic Id
-- Input : Topic Id, New Topic Name 
-- Returns:		0 -> Success
--				1 -> invalid Topic Id : NULL
--				2 -> Invalid New Topic Name: Null | ''
--				3 -> Topic not found
--				4 -> General Failure ?? 

-- =============================================

CREATE PROC uni.spTopicUpdateRecordWithTopicId
	@TopicID INT,
	@NewTopicName NVARCHAR(25)


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON
	IF @TopicID IS NULL RETURN 1

	IF NULLIF(@NewTopicName,'') IS NULL RETURN 2

	IF NOT EXISTS ( SELECT 1 FROM uni.Topic WHERE Topic_ID = @TopicID) RETURN 3

	UPDATE uni.Topic
	SET Topic_Name = @NewTopicName
	WHERE Topic_ID = @TopicID

	return 0
END TRY
BEGIN CATCH
	return 4
END CATCH

GO



--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Update a Record In Topic Table With Topic Name
-- Input : Old Topic Name, New Topic Name 
-- Returns:		0 -> Success
--				1 -> invalid Topic Name : NULL | '' 
--				2 -> invalid New Topic Name : NULL | ' ' 
--				3 -> Topic not found
--				4 -> General Failure ?? 

-- =============================================

CREATE PROC uni.spTopicUpdateRecordWithTopicName
	@TopicName NVARCHAR(25),
	@NewTopicName NVARCHAR(25)


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON
	IF NULLIF(@TopicName,'') IS NULL RETURN 1
	IF NULLIF(@NewTopicName,'') IS NULL RETURN 2
	IF NOT EXISTS ( SELECT 1 FROM uni.Topic WHERE Topic_Name = @TopicName) RETURN 3
	UPDATE uni.Topic
	SET Topic_Name = @NewTopicName
	WHERE Topic_Name = @TopicName

	return 0
END TRY
BEGIN CATCH
	return 4
END CATCH

GO



--------------------------------------------------------------------------------------------------
----------------------------------INSERT PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Insert a record into Topic Table
-- Input : Topic Name  
-- Returns:		0 -> Success
--				1 -> invalid topic Name

-- =============================================

CREATE PROC uni.spTopicInsertRecord
	@TopicName NVARCHAR(25)


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON
	if NULLIF(@TopicName,'') IS NULL return 1

	INSERT INTO uni.Topic VALUES (@TopicName)
	return 0
END TRY
BEGIN CATCH
	return 1
END CATCH

GO
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
----------------------------------SELECT PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------

USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Get All Courses and thier Grade By Student Id From StudentCourse Table
-- Inputs: Student Id
-- Returns:      
--				0-> Success
--				1-> Student Id Not Valid : NULL
--				2-> Student not found
--				3-> Failure
-- =============================================

CREATE PROC uni.spStudentCourseGetCourseAndGradeByStudentId
	@StudentId INT


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF (@StudentId IS NULL) RETURN 1
	IF NOT EXISTS ( SELECT 1 FROM uni.student WHERE st_id = @StudentId ) RETURN 2


	SELECT Crs_Name, finalGrade
	FROM uni.Course 
	INNER JOIN uni.StudentCourse
	ON uni.Course.Crs_ID = uni.StudentCourse.crs_id AND st_id = @StudentId

	RETURN 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH


GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Get All Courses and thier Grade By Student Full Name From StudentCourse Table
-- Inputs: Student Full Name
-- Returns:      
--				0-> Success
--				1-> Student Name Not Valid : NULL | '' 
--				2-> Student not found
--				3-> Failure
-- =============================================

CREATE PROC uni.spStudentCourseGetCourseAndGradeByStudentName
	@StudentFullName VARCHAR(60)


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON;

	DECLARE @StudentId INT


	IF (NULLIF(@StudentFullName,'') IS NULL) RETURN 1

	SELECT @StudentId = st_id from uni.student where st_fname +' '+st_lname = @StudentFullName
	IF ( @StudentId IS NULL ) RETURN 2

	SELECT Crs_Name, finalGrade
	FROM uni.Course 
	INNER JOIN uni.StudentCourse
	ON uni.Course.Crs_ID = uni.StudentCourse.crs_id AND st_id = @StudentId

	RETURN 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH

GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Get All Students and thier Grade By Course Id From StudentCourse Table
-- Inputs: Course Id
-- Returns:      
--				0-> Success
--				1-> Course Id Not Valid : NULL
--				2-> Course not found
--				3-> Failure
-- =============================================

CREATE PROC uni.spStudentCourseGetStudentAndGradeByCourseId
	@CourseId INT


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF (@CourseId IS NULL) RETURN 1
	IF NOT EXISTS ( SELECT 1 FROM uni.Course WHERE Crs_ID = @CourseId ) RETURN 2


	SELECT st_fname + ' ' + st_lname 

AS [FullName] , finalGrade
	FROM uni.student
	INNER JOIN uni.StudentCourse
	ON uni.student.st_id= uni.StudentCourse.st_id AND crs_id = @CourseId

	RETURN 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH

GO
--------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Get All Student and thier Grade By Course Name From StudentCourse Table
-- Inputs: Student Full Name
-- Returns:      
--				0-> Success
--				1-> Course Name Not Valid : NULL | '' 
--				2-> Course not found
--				3-> Failure
-- =============================================

CREATE PROC uni.spStudentCourseGetStudetAndGradeByCourseName 
	@CourseName VARCHAR(60)


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON;

	DECLARE @CourseId INT


	IF (NULLIF(@CourseName,'') IS NULL) RETURN 1

	SELECT @CourseId = crs_id from uni.Course where Crs_Name = @CourseName
	IF ( @CourseId IS NULL ) RETURN 2

	SELECT st_fname + ' ' + st_lname 

AS [FullName] , finalGrade
	FROM uni.student
	INNER JOIN uni.StudentCourse
	ON uni.student.st_id= uni.StudentCourse.st_id AND crs_id = @CourseId

	RETURN 0
END TRY
BEGIN CATCH
	RETURN 3
END CATCH


GO
--------------------------------------------------------------------------------------------------
----------------------------------UPDATE PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------

USE ExaminationSystem
GO


-- =============================================
-- Author:		Abdallh
-- Description:	Update Student Grade in Student Course Table By Student ID + Course ID
-- Input : Student ID , Course ID , New Grade
-- Returns:		0 -> Success
--				1 -> invalid Student Id : NULL
--				2 -> invalid Course Id : NULL
--				3 -> Student doesn't exist
--				4 -> Course doesn't exist
--				5 -> Failure 

-- =============================================

CREATE PROC uni.spStudentCourseUpdateRecordByStudentIdAndCourseId
	@StudentId INT,
	@CourseId INT,
	@NewGrade INT


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	IF @StudentId IS NULL RETURN 1
	IF @CourseId IS NULL RETURN 2

	IF NOT EXISTS ( SELECT 1 FROM uni.student WHERE st_id = @StudentId ) RETURN 3
	IF NOT EXISTS ( SELECT 1 FROM uni.Course WHERE Crs_ID = @CourseId ) RETURN 4


	UPDATE uni.StudentCourse
		SET finalGrade = @NewGrade
	WHERE uni.StudentCourse.st_id = @StudentId AND uni.StudentCourse.crs_id = @CourseId

	return 0
END TRY
BEGIN CATCH
	return 5
END CATCH

GO

--------------------------------------------------------------------------------------------------
----------------------------------DELETE PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------

USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description:	Delete Record From StudentCourse Table By StudentId + Course Id
-- Input : Student id , Course ID 
-- Returns:		0 -> Success
--				1 -> Course ID NULL
--				2 -> Student ID NULL
--				5 -> failure


-- =============================================

CREATE PROC uni.spStudentCourseDeleteRecordByStudentIdAndCourseId
	@StudentId INT,
	@CourseId INT


WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	IF @StudentId IS NULL return 1
	IF @CourseId IS NULL return 1
	
	DELETE
	FROM uni.StudentCourse
	WHERE Crs_ID = @CourseId AND st_id = @StudentId

	return 0
END TRY
BEGIN CATCH
	RETURN 5
END CATCH


GO

--------------------------------------------------------------------------------------------------
----------------------------------INSERT PROCEDURES-----------------------------------------------
--------------------------------------------------------------------------------------------------

USE ExaminationSystem
GO

-- =============================================
-- Author:		Abdallh
-- Description: Insert New Record Data into StudentCourse Table
-- Inputs : Student ID ,Course ID ,FinalGrade
-- Returns:		0 -> Success
--				1 -> Student id cant be NULL
--				2 -> Course id Cant Be NULL
--				3 -> Final Grade Cant Be Null
--				4 -> Student Doesn't exist
--				5 -> Course Doesn't exist
--				6->  Record Already Exists

-- =============================================

CREATE PROC uni.spStudentCourseInsertRecord
	@StudentId INT,
	@CourseId INT,
	@FinalGrade INT

WITH ENCRYPTION 
AS
BEGIN TRY
	SET NOCOUNT ON

	IF @StudentId IS NULL return 1
	IF @CourseId IS NULL return 2
	IF @FinalGrade IS NULL RETURN 3

	IF NOT EXISTS ( SELECT 1 FROM uni.student WHERE st_id = @StudentId ) RETURN 4
	IF NOT EXISTS ( SELECT 1 FROM uni.Course WHERE Crs_ID = @CourseId ) RETURN 5

	INSERT INTO uni.StudentCourse VALUES (@StudentId,@CourseId,@FinalGrade)
	return 0
END TRY
BEGIN CATCH
	return 6
END CATCH

GO
----------------------------------------------------------------------------------------------------------------------
-------------------------- Users ------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
USE ExaminationSystem
GO

-- =============================================
-- Author:		Shawky
-- Description:	Check if user exists in users files
-- Input : Exam ID 


CREATE PROC adm.spUsersCheckUser
	@UserId INT,
	@UserPass INT

WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS ( SELECT userid from adm.Users WHERE UserId = @UserId AND userPass = @UserPass )
	BEGIN
		SELECT userType
		FROM adm.Users
		WHERE USERID = @UserId
	END
	ELSE
		SELECT 'invalid'
END

GO


USE ExaminationSystem
GO


----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

--------Ins_crs------

use ExaminationSystem
----------------------------Select---------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: get All courses taught by specific instructor
-- Parameters: 
-- @Instructor_Id
-- =============================================

create proc uni.spSelectCoursesByInsId
	@InstructorID int

With Encryption 
As
begin
	SET NOCOUNT ON;
	select Crs_ID, ins_id 
	from uni.Ins_Crs 
	where ins_id = @InstructorID
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: get All Instructors teaching specific course
-- Parameters: 
-- @Course_Id
-- =============================================
create proc uni.spSelectInstructorsByCrsId
	@CourseID int

With Encryption 
As
begin
	SET NOCOUNT ON;
	select Crs_ID, ins_id 
	from uni.Ins_Crs 
	where Crs_ID = @CourseID
end
-----------------------------Update---------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: replace instructor with new one to teach the same courses
-- Parameters: 
-- @OldInstructorId
-- @NewOldInstructorId
-- =============================================
create proc uni.spReplaceInstructorToOntherOne
	@OldInstructor int, @NewInstructor int

With Encryption 
As
begin
	SET NOCOUNT ON;
	update uni.Ins_Crs 
	set ins_id = @NewInstructor
	where ins_id = @OldInstructor
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: set new instructor to teach specific course
-- Parameters: 
-- @courseId
-- @InstructorId
-- =============================================
create proc uni.spUpdateCourseInstructor
	@CourseId int, @NewInstructorId int

With Encryption 
As
begin
	SET NOCOUNT ON;
	update uni.Ins_Crs
	set ins_id = @NewInstructorId
	where Crs_ID= @CourseId
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 22/1/2020 - My BirthDate :) 
-- Description: set instructor to teach another course
-- Parameters: 
-- @courseId
-- @InstructorId
-- =============================================
create proc uni.spUpdateInstructorCourse
	@InstructorId int, @NewCourseId int

With Encryption 
As
begin
	SET NOCOUNT ON;
	update uni.Ins_Crs
	set Crs_ID = @NewCourseId
	where ins_id= @InstructorId
end
--------------------------------Delete-------------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Delete relation between an instructor and course
-- Parameters: 
-- @CourseId
-- =============================================
create proc uni.spDeleteInstructorCourse
	@CourseId int

With Encryption 
As
begin
	SET NOCOUNT ON;
	delete from uni.Ins_Crs 
	where Crs_ID = @CourseId
end

---------------------------Insert----------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Set new course taught by specific Instructor
-- Parameters: 
-- @InstructorID
-- @CourseId
-- =============================================
--
create proc uni.spInsertInstructorCourse
	@InstructorID int, @CourseID int
With Encryption 
As
begin
	SET NOCOUNT ON;
	insert into uni.Ins_Crs 
	values(@InstructorID, @CourseID)
end
--------------------------------------------------------------------------
---------------------student-----------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
	--version update 22/1/2020 fdfdf
-- Description: Get all students in All departments
-- Parameters: NON
-- =============================================
create proc spGetAllStudents

With Encryption 
As
begin
	SET NOCOUNT ON;
	select st_id,st_fname,st_lname,st_age,st_gender,dept_id 
	from uni.student
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Get all students in specific department
-- Parameters: 
--   @Department_id
-- =============================================
create proc spGetStudentsInDepartment
	@DepartmentId int

With Encryption 
As
begin
	SET NOCOUNT ON;
	select st_id,st_fname,st_lname,st_age,st_gender,dept_id 
	from uni.student
	where dept_id = @DepartmentId
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Get a student Information knowing his ID 
-- Parameters: 
--   @Student_id 
-- =============================================
Create proc spGetStudentById
	@StudentId int

With Encryption 
As
begin
	SET NOCOUNT ON;
	select st_id,st_fname,st_lname,st_age,st_gender,dept_id 
	from uni.student
	where st_id = @StudentId
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Get a student Information knowing his Name
-- Parameters: 
--   @Student_id 
-- =============================================
Create proc spGetStudentByName
	@StudentFullName varchar(60)

With Encryption 
As
begin
	SET NOCOUNT ON;
	select st_id,st_fname,st_lname,st_age,st_gender,dept_id 
	from uni.student
	where st_fname +' '+st_lname = @StudentFullName
end
-----------------------------------------------update student Info--------------
--we should have an atribute represents student address
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Updates Department Id for a student
-- Parameters: 
--   @Student_id 
--   @Department_id
-- =============================================
create proc spUpdateStudentDepartment
	@StudentId int,
	@DeptID int

With Encryption 
As
begin 
	SET NOCOUNT ON;
	update uni.student
	set dept_id = @DeptID
	where st_id=@StudentId
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: update All Students Ages, this run every year 
-- Parameters:  NON
-- =============================================
create proc spUpdateStudentsAge

With Encryption 
As
begin 
	SET NOCOUNT ON;
	update uni.student 
	set st_age= st_age+1
end
-------------------------------------------Insert new student--------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Insert New Student
-- Parameters:
-- @st_fname 
-- @st_lname Accepts Null
-- @st_age 
-- @stGender
-- @Dept_id Accepts Null
-- =============================================

create proc spInsertStudent
	 @stfname varchar(20), @stlname varchar(20),
	@stAge int, @stGender varchar(1),@StDept int 
With Encryption
As
begin
	SET NOCOUNT ON;
	insert into uni.student(st_fname,st_lname,st_age,st_gender,dept_id) 
	values(@stfname, @stlname, @stAge,@stGender,@StDept)
end
-------------------------------------------Delete student--------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Delete Student by ID 
-- Parameters:  
-- @st_id
-- =============================================
create proc spDeleteStudentById
	@StudentId int
With Encryption
As
begin
	SET NOCOUNT ON;
	delete
	from uni.student 
	where st_id=@StudentId
end
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 20/1/2020 - My BirthDate :) 
-- Description: Delete Student by Name 
-- Parameters:  
-- @st_FullName
-- =============================================
Go
create proc spDeleteStudentByName
	@FullName varchar(50)
With Encryption
As
begin
	SET NOCOUNT ON;
	delete
	from uni.student
	where st_fname +' '+ st_lname = @FullName
end
----------------------------------------------------------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 23/1/2020 
-- Description: Get all Questions within a course
-- Parameters: 
--	@CourseID
-- =============================================
create proc ex.spGetQuestionsByCourseId
	@CourseId int

With Encryption 
As
begin
	SET NOCOUNT ON;
	select Ques_ID, body, Model_Answer
	from ex.Questions
	where CrsId = @CourseId and qState=1
end
--------------------------No update if the question taken in exam------------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 23/1/2020 
-- Description: Update Question Marks if it's not choosen in exam
-- Parameters: 
--	@QuestionID
-- =============================================
create proc ex.spUpdateQuestionMarksById
	@QuestionId int, @NewMarks int

With Encryption 
As
begin
	SET NOCOUNT ON;
	if NOT Exists (select ques_id from ex.Questions where Ques_id=@QuestionId)
	begin
		update ex.Questions
		set Marks = @NewMarks
		where Ques_ID = @QuestionId
	end
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 23/1/2020 
-- Description: Update Question state to be not active 
-- Parameters: 
--	@QuestionID
-- =============================================
create proc ex.spUpdateQuestionStateById
	@QuestionId int, @NewStateOfQuestion bit

With Encryption 
As
begin
	SET NOCOUNT ON;
		update ex.Questions
		set qState = @NewStateOfQuestion
		where Ques_ID = @QuestionId
end
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 23/1/2020 
-- Description: Update Question ModelAnswer if it's not choosen in exam
-- Parameters: 
--	@QuestionID
-- =============================================
create proc ex.spUpdateQuestionAnswerById
	@QuestionId int, @NewModelAnswer int

With Encryption 
As
begin
	SET NOCOUNT ON;
	if NOT Exists (select ques_id from ex.Questions where Ques_id=@QuestionId)
	begin
		update ex.Questions
		set Model_Answer = @NewModelAnswer
		where Ques_ID = @QuestionId
	end
end
------------------------------------No Delete if the question taken in exam----------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 23/1/2020 
-- Description: Delete Question ..change it's state to be not active
-- Parameters: 
--	@QuestionID
-- =============================================
create proc ex.spDeleteQuestionById
	@QuestionId int

With Encryption 
As
begin
	SET NOCOUNT ON;
	EXEC spUpdateQuestionStateById @QuestionId ,0
end

-----------------------------------Insert new Question--------------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 23/1/2020 
-- Description: Delete Question if it's not choosen in exam
-- Parameters: 
--	@ModelAnswer
--	@Marks
--	@Type
--	@Body
--	@CourseID
-- =============================================
create proc ex.spInsertQuestion
	 @ModelAnswer varchar(25), @Marks int,
	@Type varchar(25), @Body varchar(200), @CourseID int

With Encryption 
As
begin
	SET NOCOUNT ON;
		insert into ex.Questions(Model_Answer,Marks,Type,body,CrsId) 
		values(@ModelAnswer,@Marks,@Type,@Body,@CourseID)
end
-------------------------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 23/1/2020 
	--version update 22/1/2020 
-- Description: Get Questions with multi choices in specific Exam
-- Parameters: 
--	@ExamID
-- =============================================
Create proc ex.spGetExambyID
	@ExamID int
with encryption
as
begin
	with result as
	(
		select ques_id, [a],[b],[c],[d]
		From
			(select ques_id, lable, [text] from ex.MCQ_Choices) p
		pivot
			(max([text]) for lable in ([a],[b],[c],[d]) ) as pvtd
	)
	select eq.QuestionNumberInExam,q.body,q.Marks,result.a,result.b,result.c,result.d into #z
	from ex.Questions q, result, ex.Exam_Questions eq
	where q.Ques_ID = result.ques_id and q.Type='MCQ' and
		  eq.Exam_id =@ExamID and eq.Ques_id = q.Ques_ID;

	 select eq.QuestionNumberInExam,q.body,q.Marks, 'True' [a], 'False'[b],'Null'[c],'Null'[d] into #y 
	 from ex.Questions q, ex.Exam_Questions eq
	 where q.Ques_ID=eq.Ques_id and eq.Exam_id=@ExamID and q.Type='TF'

	select * from #z union select * from #y
end
----------------------------------------------------------
Go
-- =============================================
-- Author:      Mohamed Shawky
-- Create date: 23/1/2020 
	--version update 26/1/2020 
-- Description: Generate new Exam with random questions
-- Parameters: 
--	@CourseName
--	@@StudentID
--	@ExamType
--  @NumberOfTrueFalseQuestions
--	@NumberOfMCQQuestions
-- =============================================
Create proc ex.spGenerateExam
	@CourseName varchar(25),@StudentID int, @ExamType varchar(20),
	@NumberOfTrueFalseQuestions int, @NumberOfMCQQuestions int
with Encryption
as
begin
	set NOCOUNT ON;
	--Check if course not exist
	if NOT Exists(select 1 from uni.Course where Crs_Name= @CourseName)
		begin
			select 'This Course is not Exist';
			return 0;
		end
	--Get CourseID by course Name
	declare @CourseID int = (select crs_id from uni.Course where Crs_Name=@CourseName)
	--Check if Student is not exist
	if NOT Exists(select 1 from uni.student where st_id= @StudentID)
		begin
			select 'This student is not Exist';
			return 0;
		end

	--Insert new Exam ID into Exam table
	insert into ex.Exam(Exam_Type) values(@ExamType)
	declare @ExamID int = (select top(1) Exam_id from ex.Exam order by Exam_id desc);
	---Restart Sequence to count more that 10 questins
	ALTER SEQUENCE CountTo10 
    RESTART WITH 1 
    INCREMENT BY 1 
    MINVALUE 1
    MAXVALUE 50
    CYCLE  
;
	-- max top max number of questions exists
	SELECT TOP (@NumberOfTrueFalseQuestions) q.Ques_ID, @ExamID as Exam_id into #x
	FROM ex.Questions q
	where q.Type= 'TF' and q.CrsId = @CourseID and q.qState=1
	ORDER BY NEWID() 

	SELECT TOP (@NumberOfMCQQuestions) q.Ques_ID ,@ExamID as Exam_id into #y
	FROM ex.Questions q
	where q.Type= 'MCQ' and q.CrsId = @CourseID and q.qState=1
	ORDER BY NEWID()
	
	--Insert new record in student takes exam
	declare @ExamDate date = CAST(GETDATE() AS DATE);

	insert into ex.St_Takes_Exam(st_id,Exam_id,Crs_Id,Exam_Date)
	values(@StudentID,@ExamID,@CourseID, @ExamDate)
	--Insert Exam Questions
	insert into ex.Exam_Questions(Ques_id,Exam_id)
	select * from #x union select * from #y	
end


GO


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------


USE ExaminationSystem
GO
------------------------Delete Exam--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- CREATE date: 25/1/2020 	
-- Description:	Delete Record By Exam_Id From Exam Table
-- Parameters: Exam ID 
-- =============================================

CREATE PROC ex.spDeleteExamById (@Exam_id int)
with Encryption
As
Begin
	Delete From ex.Exam
	Where Exam_id = @Exam_id
End

GO
--EXEC spDeleteExamById 1

------------------------Retrive Exam Data--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- CREATE date: 25/1/2020 	
-- Description:	Retrive All Data From Exam Table
-- Parameters: NON  
-- =============================================

CREATE PROC ex.spGetAllExamsData 
with Encryption
As
Begin
	Select * from ex.Exam
End

GO
--EXEC spGetAllExamsData 

------------------------Update Exam Data--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- CREATE date: 25/1/2020 	
-- Description:	Update Exam Type By Exam_Id From Exam Table
-- Parameters: 
-- Exam_id
-- Exam_Type
-- =============================================

CREATE PROC ex.spUpdateExamTypeById (@Exam_id int, @Exam_Type varchar(20))
with Encryption
As
Begin
	Update ex.Exam
		set Exam_Type = @Exam_Type
	Where Exam_id = @Exam_id
End

GO
--EXEC spUpdateExamTypeById 1, 'Final'

------------------------Insert New Exam --------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- CREATE date: 25/1/2020 	
-- Description:	Insert Record In Exam Table
-- Parameters: 
-- Exam_Id
-- Exam_Type
-- =============================================
CREATE PROC ex.spInsertExam (@Exam_Type varchar(20))
with Encryption
As
Begin
	Insert into ex.Exam 
	values (@Exam_Type)
End

GO
--EXEC spInsertExam 22, 'Practical'a




-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------

USE ExaminationSystem
GO
------------------------Delete Instructor--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Delete Record By Ins_Id From Instructor Table
-- Parameters: Instrcutor ID 
-- =============================================

CREATE PROC uni.spDeleteInstructorById (@ins_id int)
with Encryption
As
Begin
	Delete From uni.instructor
	Where ins_id = @ins_id
End

GO
--EXEC spDeleteInstructorById 1
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Delete Record By Instructor Full Name From Instructor Table
-- Parameters: 
-- ins_FName
-- ins_LName
-- =============================================

CREATE PROC uni.spDeleteInstructorByFullName (@ins_FName varchar(25), @ins_LName varchar(25))
with Encryption
As
Begin
	Delete From uni.instructor
	Where ins_FName = @ins_FName and ins_LName = @ins_LName
End

GO
--EXEC spDeleteInstructorByFullName 'Hap', 'Cation'

------------------------Retrive Instructor Data--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Retrive All Data From Instructor Table
-- Parameters: NON  
-- =============================================

CREATE PROC uni.spGetAllInstructorsData 
with Encryption
As
Begin
	Select * from uni.instructor
End

GO
--EXEC spGetAllInstructorsData 

-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Retrive Record By Ins_Id From Instructor Table
-- Parameters: Instrcutor ID  
-- =============================================

CREATE PROC uni.spGetInstructorById @ins_id int
with Encryption
As
Begin
	Select * from uni.instructor
	Where ins_id = @ins_id
End

GO
--EXEC spGetInstructorById 1

------------------------Update Instructor Data--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Update Record By Ins_Id From Instructor Table
-- Parameters: 
-- ins_id
-- ins_FName  
-- ins_LName
-- ins_age  
-- ins_salary
-- ins_hireDate 
-- ins_gender
-- =============================================

CREATE PROC uni.spUpdateInstructorDataById 
(@ins_id int, @ins_FName varchar(25), @ins_LName varchar(25), 
 @ins_age int, @ins_salary decimal(18, 2), @ins_hireDate date, @ins_gender varchar(1))
with Encryption
As
Begin
	Update uni.instructor
		set ins_FName = @ins_FName,
			ins_LName = @ins_LName,
			ins_age = @ins_age,
			ins_salary = @ins_salary,
			ins_hireDate = @ins_hireDate,
			ins_gender = @ins_gender
	Where ins_id = @ins_id
End

GO
--EXEC spUpdateInstructorDataById 1, 'Ahmed', 'Nasr', 23, 3000, '11-29-1997', 'M'

------------------------Insert New Instructor --------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Insert Record From Instructor Table
-- Parameters: 
-- ins_id
-- ins_FName  
-- ins_LName
-- ins_age  
-- ins_salary
-- ins_hireDate 
-- ins_gender
-- =============================================
CREATE PROC uni.spInsertInstructor 
(@ins_FName varchar(25), @ins_LName varchar(25), 
 @ins_age int, @ins_salary decimal(18, 2), @ins_hireDate date, @ins_gender varchar(1))
with Encryption
As
Begin
	Insert into uni.instructor
	(ins_FName, ins_LName, ins_age, ins_salary, ins_hireDate, ins_gender)
	values (@ins_FName,@ins_LName,@ins_age,@ins_salary,@ins_hireDate,@ins_gender)
End

GO
--EXEC spInsertInstructor 'Mohamed', 'Nasr', 23, 3000, '11-29-1997', 'M'




USE ExaminationSystem
GO
------------------------Delete Question--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Delete Record By Question_Id From MCQ_Choices Table
-- Parameters: Question ID 
-- =============================================

Create PROC ex.spDeleteMCQQuestionById (@Question_id int)
with Encryption
As
Begin
	Delete From ex.MCQ_Choices
	Where ques_id = @Question_id
End

GO
--EXEC spDeleteMCQQuestionById 1

------------------------Retrive MCQ Questions Data--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Retrive All Data From MCQ_Choices Table
-- Parameters: NON  
-- =============================================

Create PROC ex.spGetAllMCQQuestionsData 
with Encryption
As
Begin
	Select * from ex.MCQ_Choices
End

GO
--EXEC spGetAllMCQQuestionsData 

-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Retrive Record By Question_Id From MCQ_Choices Table
-- Parameters: Question ID  
-- =============================================

Create PROC ex.spGetMCQQuestionById @Question_id int
with Encryption
As
Begin
	Select * from ex.MCQ_Choices
	Where ques_id = @Question_id
End

GO
--EXEC spGetMCQQuestionById 1

------------------------Update Question Data--------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Update Question Data By Question_Id From MCQ_Choices Table
-- Parameters: 
-- Question_id
-- Label
-- Text
-- =============================================

Create PROC ex.spUpdateMCQuestionDataById 
(@Question_id int, @Label varchar(1), @Text varchar(50))
with Encryption
As
Begin
	Update ex.MCQ_Choices
		set lable = @Label,
			text = @Text
	Where ques_id = @Question_id
End

GO
--EXEC spUpdateMCQuestionDataById 1, 'A', 'Testttttttttttttttt'

------------------------Insert New MCQ Question --------------------------
-- =============================================
-- Author:		Ahmed Nasr
-- Create date: 25/1/2020 	
-- Description:	Insert Record In MCQ_Choices Table
-- Parameters: 
-- Question_id
-- Label
-- Text
-- =============================================
Create PROC ex.spInsertMCQuestion (@Question_id int, @Label varchar(1), @Text varchar(50))
with Encryption
As
Begin
	Insert into ex.MCQ_Choices 
	values (@Question_id, @Label, @Text)
End

GO
--EXEC spInsertMCQuestion 22, 'A', 'Who is The Best'



------------------------Retrive The Exam Questions and Student Answers--------------------------
-- =============================================
-- Author: Ahmed Nasr
-- Create date: 25/1/2020
-- Description: Takes Exam number and the student ID then returns the Questions in
-- this exam with the student answers.
-- Parameters:
-- Exam ID
-- Student ID
-- =============================================

GO
CREATE PROC ex.spRetriveTheExamQuestionsStudentAnswers
(@Exam_id int, @Student_id int)
with Encryption
As
Begin
select distinct top(10) EA.QuestionNum, Q.body, Q.Marks, EA.QuestionAns, STE.st_id, E.Exam_id
from ex.St_Takes_Exam STE, ex.exam_answers EA, Ex.Exam E, ex.Exam_Questions EQ, ex.Questions Q
where @Exam_id = STE.Exam_id and @Student_id = STE.st_id
and EA.Exam_Id = @Exam_id and EQ.Exam_id =@Exam_id and Q.Ques_ID = EQ.Ques_id
and STE.Exam_id = EA.Exam_Id and E.Exam_id = STE.Exam_id
and E.Exam_id = EQ.Exam_id and Q.Ques_ID = EQ.Ques_id
order by EA.QuestionAns

End


---------------------------ex.Exam_Questions----------------------
GO

use ExaminationSystem
----------------------------Select---------------------------
Go
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 24/1/2020 
-- Description: get All Data in Exam_Questions
-- Parameters: NON

-- =============================================


CREATE PROC ex.spExam_QuestionsGetAll
 WITH ENCRYPTION 
 AS
BEGIN
	SET NOCOUNT ON;
SELECT Ques_id,Exam_id,QuestionNumberInExam  FROM ex.Exam_Questions
END

GO

-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 24/1/2020 
-- Description: Get info about specific Question
-- Parameters: 
-- @question_Id
-- =============================================

CREATE PROC ex.spExam_QuestionsGetinfoaboutspecficQuestions
@question_Id INT
 WITH ENCRYPTION 
 AS
BEGIN
	SET NOCOUNT ON;
SELECT Ques_id,Exam_id,QuestionNumberInExam 
FROM ex.Exam_Questions
where Ques_id= @question_Id
END

GO
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 24/1/2020 
-- Description: Get info about specific Exam
-- Parameters: 
-- @Exam_Id
-- =============================================

CREATE PROC ex.spExam_QuestionsGetInfoAboutSpecficExam
@Exam_Id INT
 WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON;
SELECT Ques_id,Exam_id,QuestionNumberInExam 
FROM ex.Exam_Questions
where Exam_id= @Exam_Id
END

GO

-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 24/1/2020 
-- Description: Get info about specific Question
-- Parameters: 
-- @question_Number
-- =============================================

CREATE PROC ex.spExam_QuestionsGetinfoaboutspecficQuestionNumber
@question_Number INT
 WITH ENCRYPTION 
 AS
BEGIN
	SET NOCOUNT ON;
SELECT Ques_id,Exam_id,QuestionNumberInExam 
FROM ex.Exam_Questions
where QuestionNumberInExam= @question_Number
END

GO


-----------------------------------------------update Exam_Questions ---------------------------------



-- =============================================
-- Author:     lojiun elsayed
-- Create date: 24/1/2020 
-- Description: Updates NumberOfQuestion  in Specific Exam
-- Parameters: 
-- @Exam_Id 
--@OldQuestionNumber  
--@NewQuestionNumber
-- =============================================
CREATE PROC ex.spExam_QuestionsUpdateQuestionNumberInExam
@Exam_Id INT,
@OldQuestionNumber int,
@NewQuestionNumber int
                                         
 WITH ENCRYPTION
 AS
 BEGIN  
    UPDATE ex.Exam_Questions 
    SET    QuestionNumberInExam=@NewQuestionNumber 
    WHERE  Exam_Id=@Exam_Id
	and    QuestionNumberInExam=@OldQuestionNumber
END  

GO
-- =============================================
-- Author:     lojiun elsayed
-- Create date: 24/1/2020 
-- Description: Updates QuestionID  in Specific Exam
-- Parameters: 
-- @Exam_Id 
--@OldQuestionNumber  
--@NewQuestionNumber
-- =============================================
CREATE PROC ex.spExam_QuestionsUpdateQuestionIDInExam
@Exam_Id INT,
@OldQuestionID int,
@NewQuestionID int
                                         
 WITH ENCRYPTION 
 AS
 BEGIN  
    UPDATE ex.Exam_Questions 
    SET    Ques_id=@NewQuestionID 
    WHERE  Exam_Id=@Exam_Id
	and    Ques_id=@OldQuestionID
END  
GO

-- =============================================
-- Author:     lojiun elsayed
-- Create date: 24/1/2020 
-- Description: Replace QuestionID  by anthor one
-- Parameters: 
--@OldQuestionNumber  
--@NewQuestionNumber
-- =============================================
CREATE PROC ex.spExam_QuestionsUpdateQuestionIdReplaceItByAnthorOne

@OldQuestionID int,
@NewQuestionID int
                                         
 WITH ENCRYPTION
 AS
 BEGIN 
    UPDATE ex.Exam_Questions 
    SET    Ques_id=@NewQuestionID 
    WHERE  Ques_id=@OldQuestionID

END  
GO


GO
-- =============================================
-- Author:     lojiun elsayed
-- Create date: 24/1/2020 
-- Description: Replace QuestionNumber  by anthor one
-- Parameters: 
--@OldQuestionNumber  
--@NewQuestionNumber
-- =============================================
CREATE PROC ex.spExam_QuestionsUpdateQuestionNumberReplaceItByAnthorOne

@OldQuestionNumber int,
@NewQuestionNumber int
                                         
 WITH ENCRYPTION 
 AS
 BEGIN  
    UPDATE ex.Exam_Questions 
    SET    QuestionNumberInExam=@NewQuestionNumber
    WHERE  QuestionNumberInExam=@OldQuestionNumber
END  
Go
GO
-- =============================================
-- Author:     lojiun elsayed
-- Create date: 24/1/2020 
-- Description: Replace Exam id  by anthor one
-- Parameters: 
--@OldExamId  
--@NewExamId
-- =============================================
CREATE PROC ex.spExam_QuestionsUpdateExamIdReplaceItByAnthorOne

@OldExamId int,
@NewExamId int
                                         
 WITH ENCRYPTION
 AS
 BEGIN  
    UPDATE ex.Exam_Questions 
    SET    QuestionNumberInExam=@NewExamId 
    WHERE  QuestionNumberInExam=@OldExamId 
END  
Go
GO

-----------------------------------------------Delete Exam_Questions ---------------------------------
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: Delete All Data in Exam_Questions
-- Parameters: NON

-- =============================================
CREATE PROC ex.spExam_QuestionsDeleteAllData
 WITH ENCRYPTION 
 AS
BEGIN
	SET NOCOUNT ON;
DELETE  FROM  ex.Exam_Questions 
END
GO
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: Delete QuestionNumber  by questionId
-- Parameters: 
--@questionId

-- =============================================
--------------------------------------------------------
CREATE PROC ex.spExam_QuestionsDeleteQuestionNumberByQuestionId
@questionId int
 WITH ENCRYPTION 
 AS
BEGIN
	SET NOCOUNT ON;
DELETE  FROM  ex.Exam_Questions
WHERE Ques_id=@questionId
END
GO
EXEC ex.spExam_QuestionsDeleteQuestionNumberByQuestionId 1
GO

-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: Delete QuestionId  by questionNum
-- Parameters: 
--@questionNumber

-- =============================================
--------------------------------------------------------
CREATE PROC ex.spExam_QuestionsDeleteQuestionIdByQuestionNumber
@questionNumber int
 WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON;
DELETE  FROM  ex.Exam_Questions
WHERE QuestionNumberInExam =@questionNumber
END

GO
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: Delete specific Question  in Specfic Exam
-- Parameters: 
--@ExamId

-- =============================================
--------------------------------------------------------
CREATE PROC ex.spExam_QuestionsDeleteQuestionbyExamId
@ExamId int
 WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON;
DELETE  FROM  ex.Exam_Questions
WHERE Exam_id =@ExamId
END
GO

-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: Delete specific Exam  by QuestionId
-- Parameters: 
--QuestionId

-- =============================================
--------------------------------------------------------

CREATE PROC ex.spExam_QuestionsDeleteExamByQuestionId
@QuestionId int
 WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON;
DELETE  FROM  ex.Exam_Questions
WHERE Ques_id =@QuestionId
END
GO

-----------------------------------------------insert new Exam_Questions ---------------------------------
Go
-- =============================================
-- Author:      lojiun 
-- Create date: 22/1/2020
-- Description: Insert New question
-- Parameters:
--@questiomn_Id INT
--@examId int Null
--@QuestionNumber int Null  
-- =============================================
CREATE PROC ex.spExam_QuestionsInserNewQuestion
@questiomn_Id INT,
@examId  INT,
@QuestionNumber INT
 WITH ENCRYPTION
 AS
BEGIN  
            INSERT INTO ex.Exam_Questions  
                        ( Ques_id
						  ,Exam_id
						  ,QuestionNumberInExam)  
            VALUES     ( @questiomn_Id ,@examId,@QuestionNumber )  
        END 
GO





--------Ins_works_dept------

use ExaminationSystem
----------------------------Select---------------------------
Go
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: get All Data in Ins_works_dept
-- Parameters: NON

-- =============================================


CREATE PROC uni.spIns_works_deptGetAll1
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
SELECT dept_id,ins_id FROM uni.Ins_works_dept
END
GO
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: get Get Instructor Name By Department Id
-- Parameters: @ID

-- =============================================



CREATE PROC uni.spGetInsNameByDeptId
	@ID INT	
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
SELECT I.ins_FName  FROM uni.Instructor I,uni.Ins_works_dept IWD
WHERE  IWD.ins_id= I.ins_id  AND IWD.dept_id=@ID
END


GO
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: get Get Department Name By Instructor ID
-- Parameters: @ID

-- =============================================
CREATE PROC uni.spGetDeptNameByInsId
	@ID INT	
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
SELECT d.DeptName  FROM uni.Ins_works_dept IWD,uni.Department D
WHERE  D.mgr_id= IWD.ins_id  AND IWD.ins_id=@ID
END


GO

-- =============================================
-- Author:     Lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: get  department  by instructorID
-- Parameters: 
-- @Ins_Id
-- =============================================

CREATE PROC uni.spGetDepartmentByInsId
	@InstructorID INT
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
	SELECT dept_id,ins_id 
	FROM uni.Ins_works_dept 
	WHERE ins_id = @InstructorID
END
GO

-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: get Instructor working on department
-- Parameters: 
-- @Dept_Id
-- =============================================
CREATE PROC uni.spGetInstructorByDepartmentid
	@Dept_Id INT
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
	SELECT dept_id,ins_id 
	FROM uni.Ins_works_dept 
	WHERE dept_id = @Dept_Id
END
GO
----------------------------------------------------------------

-----------------------------Update---------------------------
Go
-- =============================================
-- Author:      Lojiun elsayed
-- Create date: 22/1/2020 
-- Description: set new  Instructor to work in the same department
-- Parameters:  @OldInsId @NewInsId
-- =============================================
CREATE PROC uni.spUpdateInstructorofDepartMent
	@OldInsId INT, 
	@NewInsId INT
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
	UPDATE uni.Ins_works_dept
	SET ins_id = @NewInsId
	WHERE ins_id = @OldInsId
END

Go
-- =============================================
-- Author:      Lojiun elsayed
-- Create date: 22/1/2020 
-- Description: set new  Department to  the same Instructor
-- Parameters:  @OldInsId @NewInsId
-- =============================================
CREATE PROC uni.spUpdateDepartMentToMangeByNewOne
	@OldDeptId INT, 
	@NewDeptId INT
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
	UPDATE uni.Ins_works_dept
	SET dept_id = @NewDeptId
	WHERE dept_id = @OldDeptId
END

Go
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: Delete All Data in Ins_works_dept
-- Parameters: NON

-- =============================================
CREATE PROC uni.spIns_works_deptDeleteAllData
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
DELETE  FROM  uni.Ins_works_dept 
END

GO
-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: Delete department in Ins_works_dept by instructor 
-- Parameters: NON

-- =============================================
--------------------------------------------------------
CREATE PROC uni.spIns_works_deptDeleteDeptIdByInsId
@id int
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
DELETE  FROM  uni.Ins_works_dept 
WHERE ins_id=@id
END
GO

-- =============================================
-- Author:      lojiun Elsayed
-- Create date: 22/1/2020 
-- Description: Delete department in Ins_works_dept by instructor 
-- Parameters: NON

-- =============================================
--------------------------------------------------------


--------------------------------------------------------
CREATE PROC uni.spIns_works_deptDeleteInsIdByDeptId
@id int
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
DELETE  FROM  uni.Ins_works_dept 
WHERE dept_id=@id
END

GO





GO
--------------------------------------------------

-- =============================================
-- Author:      Lojiun elsayed
-- Create date: 22/1/2020  
-- Description: Set  Instructor to Department
-- Parameters: 
-- @InsID
-- @deptId
-- =============================================

CREATE PROC uni.spIns_works_deptSetValue
@Dept_id INT ,
@Ins_id INT
 WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
INSERT INTO uni.Ins_works_dept  
VALUES (@Dept_id,@Ins_id)
END

GO


---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-- Create a table data type
CREATE TYPE ex.ExamAnswerTable As Table
(
--This type has structure similar to the DB table 
[Exam_Id] int Not Null
      ,[QuestionNum] int Not Null
      ,[QuestionAns] varchar(10) Not Null -- Having one String
)
--This is the Stored Procedure
go
CREATE PROCEDURE ex.spExamAnswerInserNewExamAnswerByTable
(
-- which accepts one table value parameter. 
-- It should be noted that the parameter is readonly
@Sample As ex.ExamAnswerTable Readonly
)

-- We simply insert values into the DB table from the parameter
-- The table value parameter can be used like a table with only read rights
WITH ENCRYPTION AS
BEGIN  
            INSERT INTO ex.exam_answers  
                        ( Exam_Id
						,QuestionNum
						  ,QuestionAns)  
             select  Exam_Id,QuestionNum,QuestionAns from @Sample  
END 



GO


---------------------Department-----------------

GO

use ExaminationSystem
Go
-----------------------------------------------Get Department Info--------------
-- =============================================
-- Author:     Moaz ayman 
-- Create date: 20/1/2020 	
-- Description: Get all information about All departments
-- Parameters: NON
-- =============================================
CREATE PROCEDURE uni.spDepartmentGetall
WITH ENCRYPTION AS
BEGIN 
SELECT *  FROM uni.department 
END
--EXEC uni.spDepartmentGetall
Go
-- =============================================
-- Author:     Moaz ayman 
-- Create date: 20/1/2020 
-- Description: Get all information about specific department
-- Parameters: 
--   @Department_id
-- =============================================
CREATE PROCEDURE uni.spDepartmentGetById (@PID INT)
WITH ENCRYPTION AS
BEGIN
SELECT *  FROM uni.department 
WHERE Dept_ID=@PID
END
--EXEC uni.spDepartmentGetById 1
Go
---------------------------------------------------------------------------------------
-----------------------------------------------update Department Info--------------
 Go
-- =============================================
-- Author:      moaz ayman 
-- Create date: 20/1/2020 
-- Description: Updates Department Name for a Department
-- Parameters: 
--   @Dept_ID 
--   @DeptName
-- =============================================
CREATE PROCEDURE uni.spDepartmentUpdateName(@Dept_ID    int= 0,  
                                          @DeptName    varchar(20)= ' '  
                                         ) 
                                         
WITH ENCRYPTION AS
 BEGIN  
            UPDATE uni.department 
            SET    
                   DeptName = @DeptName  
            WHERE  Dept_ID = @Dept_ID 
        END  
	--	EXEC  uni.spDepartmentUpdateName 10,'moaz1' 
Go
-- =============================================
-- Author:     moaz ayman 
-- Create date: 20/1/2020  
-- Description: update Department's Manger_ID for specific department 
-- Parameters:  @Dept_ID, @mgr_id ,@mgr_HireDate
-- =============================================
create PROCEDURE uni.spDepartmentUpdateMangerID(@Dept_ID    int= 0,    
                                          @mgr_id         int= NULL,
										  @mgr_HireDate date= NULL) 
                                         
WITH ENCRYPTION AS
 BEGIN  
            UPDATE uni.department 
            SET    
                  
				   mgr_id=@mgr_id,
				   mgr_HireDate=@mgr_HireDate
				     
            WHERE  Dept_ID = @Dept_ID 
        END   
--EXEC   uni.spDepartmentUpdateMangerID 10,17,'2018-03-16 00:00:00.000'
Go
-- =============================================
-- Author:     moaz ayman 
-- Create date: 20/1/2020  
-- Description: update Department's Manger__HireDate for specific department 
-- Parameters:  @Dept_ID,@mgr_HireDate
-- =============================================
CREATE PROCEDURE uni.spDepartmentUpdateMangerHireDate(@Dept_ID    int= 0,    
										  @mgr_HireDate date) 
                                         
WITH ENCRYPTION AS
 BEGIN  
            UPDATE uni.department 
            SET    
                  
				   mgr_HireDate=@mgr_HireDate
				     
            WHERE  Dept_ID = @Dept_ID 
        END   
--EXEC   uni.spDepartmentUpdateMangerHireDate 10,'2018-03-16 00:00:00.000'
Go
---------------------------------------------------------------------------------------
-----------------------------------------------insert New Department --------------
Go
-- =============================================
-- Author:      Moaz ayman 
-- Create date: 20/1/2020
-- Description: Insert New Department
-- Parameters:
-- @DeptName
-- @Dept_Desc NULL 
-- @Dept_location NULL
-- @mgr_id     
-- @mgr_HireDate  
-- =============================================
CREATE PROCEDURE uni.spDepartmentInser(/*@Dept_ID   int= 0,*/  
                                          @DeptName    varchar(20),  
                                          @Dept_Desc     varchar(300)= NULL,  
                                          @Dept_location  varchar(50)= NULL,  
                                          @mgr_id          int,
										  @mgr_HireDate date )
WITH ENCRYPTION AS
BEGIN  
            INSERT INTO uni.department  
                        (/*[Dept_ID]
							  ,*/[DeptName]
							  ,[Dept_Desc]
							  ,[Dept_location]
							  ,[mgr_id]
							  ,[mgr_HireDate])  
            VALUES     (/* @Dept_ID, */ 
						@DeptName ,  
						@Dept_Desc ,  
						@Dept_location,  
						@mgr_id,
						@mgr_HireDate)  
        END 
--EXEC   uni.spDepartmentInser 'moaz','moaz is manger','fayoum',15,'2014-03-16 00:00:00.000'
Go
-------------------------------------------Delete Department--------------------------
Go
-- =============================================
-- Author:      Moaz ayman 
-- Create date: 20/1/2020  
-- Description: Delete Department by ID 
-- Parameters:  
-- @Dept_ID
-- =============================================
CREATE PROCEDURE uni.spDepartmentDeleteById @Dept_ID  int
WITH ENCRYPTION AS
 BEGIN  
            DELETE FROM uni.department  
            WHERE  Dept_ID = @Dept_ID  
        END  
--EXEC   uni.spDepartmentDeleteById 10


-- =============================================
-- Author:      Moaz ayman 
-- Create date: 20/1/2020 
-- Description: Delete Department by Name 
-- Parameters:  
-- @DeptName
-- =============================================
Go
CREATE PROCEDURE uni.spDepartmentDeleteByName @DeptName    varchar(20)
WITH ENCRYPTION AS
 BEGIN  
            DELETE FROM uni.department  
            WHERE  DeptName =@DeptName  
        END  
---EXEC   uni.spDepartmentDeleteByName 'moaz'
--======================================================================================================
--=======================================================================================================
--========================================================================================================
---------------------Exams'Answers-----------------
-----------------------------------------------Get Exams'Answers Info--------------
-- =============================================
-- Author:     Moaz ayman 
-- Create date: 22/1/2020 	
-- Description: Get all information about All Exams'Answers
-- Parameters: NON
-- =============================================
go

CREATE PROCEDURE ex.spExamAnswersGetall

WITH ENCRYPTION AS
BEGIN 
SELECT Exam_Id
      ,QuestionNum
      ,QuestionAns
  FROM ex.exam_answers
END
--EXEC ex.spExamAnswersGetall 
Go
-- =============================================
-- Author:     Moaz ayman 
-- Create date: 22/1/2020 
-- Description: Get all information about specific Eaxm
-- Parameters: 
--   @Exam_Id
-- =============================================
CREATE PROCEDURE ex.spExamAnswersGetById (@Exam_Id INT)
WITH ENCRYPTION AS
BEGIN
SELECT Exam_Id
      ,QuestionNum
      ,QuestionAns
  FROM ex.exam_answers
WHERE Exam_Id=@Exam_Id
END
--EXEC ex.spExamAnswersGetById 1001
Go
-- =============================================
-- Author:     Moaz ayman 
-- Create date: 22/1/2020 
-- Description: Get Answer about specific Question in Eaxm
-- Parameters: 
--   @Exam_Id,@QuestionNum
-- =============================================
CREATE PROCEDURE ex.spExamAnswersGetSpecificAnswer (@Exam_Id INT,@QuestionNum int)
WITH ENCRYPTION AS
BEGIN
SELECT
      QuestionAns
  FROM ex.exam_answers
WHERE Exam_Id=@Exam_Id and QuestionNum=@QuestionNum
END
--EXEC ex.spExamAnswersGetSpecificAnswer 1001,5
Go
---------------------------------------------------------------------------------------
-----------------------------------------------update Exams'Answers Info--------------
 Go
-- =============================================
-- Author:      moaz ayman 
-- Create date: 22/1/2020 
-- Description: Updates Number of Specific Question  in Specific Exam
-- Parameters: 
--   @Exam_Id 
--@OldQuestionNum  
--@NewQuestionNum
-- =============================================
CREATE PROCEDURE ex.spExamAnswerUpdateSpecificNumQuestion(@Exam_Id INT,@OldQuestionNum int,@NewQuestionNum int) 
                                         
WITH ENCRYPTION AS
 BEGIN  
            UPDATE ex.exam_answers 
            SET    
                   QuestionNum=@NewQuestionNum  
            WHERE  Exam_Id=@Exam_Id and QuestionNum=@OldQuestionNum 
        END  
	--	EXEC   ex.spExamAnswerUpdateSpecificNumQuestion 10,3,5 
Go
-- =============================================
-- Author:     moaz ayman 
-- Create date: 22/1/2020  
-- Description: Updates Answer of Specific Question  in Specific Exam 
--  @Exam_Id 
--@QuestionNum  
--@QuestionAns
-- =============================================
CREATE PROCEDURE ex.spExamAnswerUpdateSpecificAnswer(@Exam_Id INT,@QuestionNum int,@QuestionAns VARCHAR(2)) 
                                         
WITH ENCRYPTION AS
 BEGIN  
            UPDATE ex.exam_answers 
            SET    
                   QuestionAns=@QuestionAns  
            WHERE  Exam_Id=@Exam_Id and QuestionNum=@QuestionNum 
END  
--EXEC   ex.spExamAnswerUpdateSpecificAnswer 10,3,'a' 

Go
-- =============================================
-- Author:     moaz ayman 
-- Create date: 20/1/2020  
-- Description: Updates  Specific Exam By Anthor 
-- Parameters:  @oldExam_Id INT,@NewExam_Id int
-- =============================================
CREATE PROCEDURE ex.spExamAnswerUpdateSpecificExam(@oldExam_Id INT,@NewExam_Id int) 
                                         
WITH ENCRYPTION AS
 BEGIN  
            UPDATE ex.exam_answers 
            SET    
                   Exam_Id=@NewExam_Id  
            WHERE  Exam_Id=@oldExam_Id 

END
--EXEC   ex.spExamAnswerUpdateSpecificExam 1001,1003
Go
---------------------------------------------------------------------------------------
-----------------------------------------------insert New Exams'Answers --------------
Go
-- =============================================
-- Author:      Moaz ayman 
-- Create date: 22/1/2020
-- Description: Insert New Exam
-- Parameters:
--@Exam_Id INT
--@QuestionNum int 
--@QuestionAns int  
-- =============================================
CREATE PROCEDURE ex.spExamAnswerInserNewExam(@Exam_Id INT,@QuestionNum int,@QuestionAns VARCHAR(2)) 
WITH ENCRYPTION AS
BEGIN  
            INSERT INTO ex.exam_answers  
                        ( Exam_Id
						  ,QuestionNum
						  ,QuestionAns)  
            VALUES     ( @Exam_Id ,@QuestionNum ,@QuestionAns )  
        END 
--EXEC   ex.spExamAnswerInserNewExam 1001,1,'a'
Go
-------------------------------------------Delete Exams'Answers--------------------------
Go
-- =============================================
-- Author:      Moaz ayman 
-- Create date: 22/1/2020  
-- Description: Delete Exam by ID 
-- Parameters:  
-- @Exam_Id
-- =============================================
CREATE PROCEDURE ex.spExamAnswerDeleteExamById @Exam_Id  int
WITH ENCRYPTION AS
 BEGIN  
            DELETE FROM ex.exam_answers  
            WHERE  Exam_Id = @Exam_Id  
        END  
--EXEC   ex.spExamAnswerDeleteExamById 1001

Go
-- =============================================
-- Author:      Moaz ayman 
-- Create date: 22/1/2020 
-- Description: Delete specific Question in Eaxm and Itis Answer 
-- Parameters:  
--  @Exam_Id INT,@QuestionNum int
-- =============================================
Go
CREATE PROCEDURE ex.spExamAnswerDeleteQuestion @Exam_Id INT,@QuestionNum int
WITH ENCRYPTION AS
 BEGIN  
            DELETE FROM ex.exam_answers  
            WHERE  Exam_Id =@Exam_Id  and QuestionNum=@QuestionNum
        END  

GO

USE ExaminationSystem
Go
-- =============================================
-- Author:      Lojiun Elsayed
-- Create date: 24/1/2020 
-- Description: takes the instructor ID and returns  the courses that he teaches and the number of students per course.
-- Parameters: 
--@InstructorID
-- =============================================

Create PROC uni.spReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse
@InstructorID INT
WITH ENCRYPTION
AS
BEGIN

	set NOCOUNT ON;
SELECT c.Crs_Name,count(sc.st_id) AS NumberOfStudent
FROM uni.Course C,uni.instructor I,uni.Ins_Crs IC,uni.StudentCourse sc
WHERE I.ins_id=IC.ins_id AND IC.Crs_ID=sc.crs_id and C.Crs_ID=IC.Crs_ID AND I.ins_id=@InstructorID
GROUP BY  c.Crs_Name 
End

GO


Create PROC uni.spReturnGradesOfStudentInAllCourses
@studentId INT
AS
BEGIN
 
    set NOCOUNT ON;
 
SELECT S.st_fname+''+s.st_lname AS FullName,C.Crs_Name,SC.FinalGrade 
FROM UNI.student S, uni.Course C,UNI.StudentCourse SC 
WHERE S.st_id=SC.st_id AND SC.crs_id=C.Crs_ID AND S.st_id=@studentId AND SC.FinalGrade IS NOT NULL
END
GO









