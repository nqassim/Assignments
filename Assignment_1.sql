CREATE TABLE Employer (
	Employer_ID	INTEGER NOT NULL UNIQUE,
	Full_Name	TEXT,
	Joining_Date	TEXT,
	Current_Position	TEXT,
	Department	TEXT,
	Assigned_Project	TEXT,
	PRIMARY KEY(Employer_ID AUTOINCREMENT)
);
CREATE TABLE Services (
	Software_ID	INTEGER NOT NULL UNIQUE,
	Name	INTEGER,
	Category	TEXT,
	Size	INTEGER,
	Number_of_Installments	INTEGER,
	PRIMARY KEY(Software_ID AUTOINCREMENT)
);
CREATE TABLE Software_Requests (
    Employer_ID int references Employer(Employer_ID),
    Software_ID int references Services(Software_ID),
    Request_Start_Date TEXT,
    Request_Closed_Date TEXT,
    CurrentStatus INTEGER
);

/* not sure how to get this to work as intended */
CREATE TRIGGER increment_installments AFTER INSERT  ON Software_Requests 
BEGIN
UPDATE Services SET Number_of_Installments= 1+ (SELECT Number_of_Installments FROM Services JOIN Software_Requests ON Services.Software_ID = Software_Requests.Software_ID)
END;

INSERT INTO Services (Name, Category, Size, Number_of_Installments)
VALUES
("Chromium", "A", "200", "91"),
("Jupyter", "B", "532", "2394"),
("MS Excel", "C", "10", "675"),
("Counter Strike", "D", "8000", "1");

INSERT INTO Employer (Full_Name, Joining_Date, Current_Position, Department, Assigned_Project)
VALUES
("Noor Qasem", "2022-06-20", "Intern", "Software and Data", "TBD"),
("Mike Smith", "2004-01-01", "CFO", "Finance", "Maximize Profits"),
("Diana Wellington", "2017-11-15", "HR Head", "HR", "Conflict Resoloution"),
("Johnny", "2020-12-25", "Travel Expert", "Travel", "Hawaii");
