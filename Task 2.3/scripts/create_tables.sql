-- Creation custom domains
CREATE DOMAIN level VARCHAR(10)
   CHECK (VALUE IN ('jun', 'middle', 'senior', 'lead'));

CREATE DOMAIN score VARCHAR(1)
   CHECK (VALUE IN ('A', 'B', 'C', 'D', 'E'));

-- Creation of department table
CREATE TABLE IF NOT EXISTS department (
  DepartmentId SERIAL NOT NULL,
  Name CHARACTER VARYING(30) NOT NULL,
  HeadFirstName CHARACTER VARYING(30) NOT NULL,
  HeadLastName CHARACTER VARYING(30) NOT NULL,
  HeadPatronymicName CHARACTER VARYING(30),
  Quantity INTEGER,
  PRIMARY KEY (DepartmentId)
);

-- Creation of employees_info table
CREATE TABLE IF NOT EXISTS employees_info (
  EmployeeId SERIAL NOT NULL,
  FirstName CHARACTER VARYING(30) NOT NULL,
  LastName CHARACTER VARYING(30) NOT NULL,
  PatronymicName CHARACTER VARYING(30),
  Birthday DATE NOT NULL,
  StartDate DATE NOT NULL,
  Post CHARACTER VARYING(30) NOT NULL,
  Salary INTEGER NOT NULL,
  DepartmentId INTEGER,
  Grade level NOT NULL,
  Permission BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (EmployeeId),
  CONSTRAINT fk_department
      FOREIGN KEY(DepartmentId)
	  REFERENCES department(DepartmentId)
);

CREATE TABLE IF NOT EXISTS quarterly_score (
  EmployeeId INTEGER NOT NULL,
  FirstQuarter score,
  SecondQuarter score,
  ThirdQuarter score,
  FourthQuarter score,
  CONSTRAINT fk_employee
      FOREIGN KEY(EmployeeId)
	  REFERENCES employees_info(EmployeeId)
);