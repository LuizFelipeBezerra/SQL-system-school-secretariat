CREATE DOMAIN semester_accountant INT
	CHECK (VALUE IN (1, 2)) NOT NULL;
	
CREATE DOMAIN identifier_genus AS CHAR(1)
	CHECK (VALUE IN ('M', 'F', 'O'));

CREATE TABLE SchoolSecretariat(
    Id_Func BIGINT PRIMARY KEY,
    Cpf_Func INT UNIQUE NOT NULL,
    Name_Func VARCHAR(255) NOT NULL,
    PassWord_Func VARCHAR(255) NOT NULL,
    Email_Func VARCHAR(255) NOT NULL,
    Genre_Func identifier_genus
);

CREATE TABLE Students(
    Id_Stu BIGINT PRIMARY KEY,
    Cpf_Stu INT UNIQUE NOT NULL,
    Name_Stu VARCHAR(255) NOT NULL,
	PassWord_Stu VARCHAR(255) NOT NULL,
	Email_Stu VARCHAR (255) NOT NULL,
    DtBirth_Stu DATE NOT NULL, 
    Genre_Stu identifier_genus,
    Id_Func_Stu BIGINT,
    FOREIGN KEY (Id_Func_Stu) REFERENCES SchoolSecretariat(Id_Func) ON DELETE SET NULL
);

CREATE TABLE Parents(
	Id_Paren BIGINT PRIMARY KEY,
	Cpf_Paren INT UNIQUE NOT NULL,
    Parents1_Name_Paren VARCHAR(255) DEFAULT 'Absent',
	Parents2_Name_Paren VARCHAR(255) DEFAULT 'Absent',
	Email_Paren VARCHAR(255) NOT NULL,
	Phone_Paren VARCHAR(20) NOT NULL,
	Secondary_Number_Paren VARCHAR(20) NULL,
    Ender_Paren VARCHAR(255) NOT NULL
);

CREATE TABLE StudentReport(
	Id_Stu BIGINT NOT NULL,
	Id_Cla BIGINT NOT NULL,
	Absences_StuRe INT DEFAULT 0,
	Semester_StuRe semester_accountant,
	Status_StuRe CHAR(1) CHECK (Status_StuRe IN ('A', 'F')),
	Final_Note_StuRe DECIMAL(5,2),
	Notes_StuRe DECIMAL(5,2),
	PRIMARY KEY(Id_Stu, Id_Cla, Semester_StuRe),
	CONSTRAINT Id_Stu_StuRe FOREIGN KEY (Id_Stu) REFERENCES Students(Id_Stu) ON DELETE CASCADE,
	CONSTRAINT Id_Cla_StuRe FOREIGN KEY (Id_Cla) REFERENCES Classes(Id_Cla) ON DELETE CASCADE
);

CREATE TABLE Classes(
	Id_Cla BIGINT PRIMARY KEY,
	Number_Cla INT NOT NULL,
	Semester_Cla semester_accountant,
	Shift_Cla CHAR(1) CHECK (Shift_Cla IN('M', 'N')) NOT NULL,
	Capacity_Cla BIGINT CHECK (Capacity_Cla > 0),
	Duration_Cla TIME DEFAULT '00:00:00',
	Status_Cla CHAR(1) CHECK (Status_Cla IN('O','C')) DEFAULT 'O'
);

CREATE TABLE Workload(
	Id_Cla BIGINT NOT NULL,
	Id_Prof BIGINT NOT NULL,
	Semester_Work semester_accountant,
	Time_Work TIME DEFAULT '05:00:00',
	PRIMARY KEY (Id_Cla, Id_Prof),
	CONSTRAINT Id_Cla_Work FOREIGN KEY (Id_Cla) REFERENCES Classes(Id_Cla) ON DELETE CASCADE,
	CONSTRAINT Id_Prof_Work FOREIGN KEY (Id_Prof) REFERENCES Teachers(Id_Prof) ON DELETE CASCADE
);

CREATE TABLE Teachers(
	Id_Prof BIGINT PRIMARY KEY,
	Cpf_Prof INT UNIQUE NOT NULL,
    Name_Prof VARCHAR(255) NOT NULL,
	Email_Prof VARCHAR(255) NOT NULL,
	PassWord_Prof VARCHAR(255) NOT NULL,
    Genre_Prof identifier_genus,
    Ender_Prof VARCHAR(255) NOT NULL,
	DtBirth_Prof DATE NOT NULL
);

CREATE TABLE StudentWarning(
	Id_Paren BIGINT NOT NULL,
	Id_Stu BIGINT NOT NULL, 
	Type_StuWa VARCHAR(255) NOT NULL,
	Reason_StuWa VARCHAR(255) NOT NULL,
	Days_Allowed_StuWa INT NOT NULL,
	PRIMARY KEY(Id_Paren, Id_Stu, Days_Allowed_StuWa),
	CONSTRAINT Id_Paren_StuWa FOREIGN KEY (Id_Paren) REFERENCES Parents(Id_Paren),
	CONSTRAINT Id_Stu_StuWa FOREIGN KEY (Id_Stu) REFERENCES Students(Id_Stu)
);
