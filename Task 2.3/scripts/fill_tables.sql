-- Fill department table
INSERT INTO department (Name, HeadFirstName, HeadLastName, HeadPatronymicName, Quantity)
VALUES ('Бухгалтерский', 'Дубровина', 'Александра', 'Артёмовна', 5);
INSERT INTO department (Name, HeadFirstName, HeadLastName, HeadPatronymicName, Quantity)
VALUES ('IT', 'Фомин', 'Герман', 'Егорович', 10);
INSERT INTO department (Name, HeadFirstName, HeadLastName, HeadPatronymicName, Quantity)
VALUES ('Кадры', 'Романова', 'Анастасия', 'Данииловна', 2);
INSERT INTO department (Name, HeadFirstName, HeadLastName, HeadPatronymicName, Quantity)
VALUES ('Менеджмент', 'Климов', 'Константин', 'Тимурович', 3);

-- Fill employees_info table
INSERT INTO employees_info (FirstName, LastName, PatronymicName, Birthday, StartDate, Post, Salary, DepartmentId, Grade, Permission)
VALUES ('Климов', 'Константин', 'Тимурович', '1994-06-01', '2013-07-17', 'Department Head', 200, 4, 'lead', TRUE);
INSERT INTO employees_info (FirstName, LastName, PatronymicName, Birthday, StartDate, Post, Salary, DepartmentId, Grade, Permission)
VALUES ('Фомин', 'Герман', 'Егорович', '1990-01-12', '2012-01-15', 'Department Head', 210, 2, 'lead', TRUE);
INSERT INTO employees_info (FirstName, LastName, PatronymicName, Birthday, StartDate, Post, Salary, DepartmentId, Grade, Permission)
VALUES ('Дубровина', 'Александра', 'Артёмовна', '1983-10-12', '2002-01-15', 'Department Head', 190, 1, 'lead', TRUE);
INSERT INTO employees_info (FirstName, LastName, PatronymicName, Birthday, StartDate, Post, Salary, DepartmentId, Grade, Permission)
VALUES ('Романова', 'Анастасия', 'Данииловна', '1985-09-02', '2010-11-15', 'Department Head', 215, 3, 'lead', TRUE);
INSERT INTO employees_info (FirstName, LastName, PatronymicName, Birthday, StartDate, Post, Salary, DepartmentId, Grade, Permission)
VALUES ('Смирнов', 'Давид', 'Вячеславович', '1997-08-09', '2018-01-10', 'Programmer', 180, 2, 'senior', FALSE);
INSERT INTO employees_info (FirstName, LastName, PatronymicName, Birthday, StartDate, Post, Salary, DepartmentId, Grade, Permission)
VALUES ('Никифоров', 'Артём', 'Анатольевич', '1999-08-09', '2019-01-10', 'Programmer', 150, 2, 'middle', FALSE);
INSERT INTO employees_info (FirstName, LastName, PatronymicName, Birthday, StartDate, Post, Salary, DepartmentId, Grade, Permission)
VALUES ('Белова', 'Стефания', 'Робертовна', '2000-02-18', '2021-11-18', 'Manager', 110, 3, 'jun', FALSE);

-- Fill quarterly_score table
INSERT INTO quarterly_score (EmployeeId, FirstQuarter, SecondQuarter, ThirdQuarter, FourthQuarter)
VALUES (1, 'A', 'B', 'C', 'D');
INSERT INTO quarterly_score (EmployeeId, FirstQuarter, SecondQuarter, ThirdQuarter, FourthQuarter)
VALUES (2, 'A', 'B', 'B', 'B');
INSERT INTO quarterly_score (EmployeeId, FirstQuarter, SecondQuarter, ThirdQuarter, FourthQuarter)
VALUES (3, 'A', 'B', 'A', 'A');
INSERT INTO quarterly_score (EmployeeId, FirstQuarter, SecondQuarter, ThirdQuarter, FourthQuarter)
VALUES (4, 'B', 'B', 'C', 'A');
INSERT INTO quarterly_score (EmployeeId, FirstQuarter, SecondQuarter, ThirdQuarter, FourthQuarter)
VALUES (5, 'B', 'B', 'C', 'D');
INSERT INTO quarterly_score (EmployeeId, FirstQuarter, SecondQuarter, ThirdQuarter, FourthQuarter)
VALUES (6, 'B', 'B', 'A', 'E');
INSERT INTO quarterly_score (EmployeeId, FirstQuarter, SecondQuarter, ThirdQuarter, FourthQuarter)
VALUES (7, 'C', 'C', 'C', 'A');