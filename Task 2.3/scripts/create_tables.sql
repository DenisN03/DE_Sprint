-- Creation custom domains
CREATE TYPE level AS ENUM ('jun', 'middle', 'senior', 'lead');
CREATE TYPE score AS ENUM ('A', 'B', 'C', 'D', 'E');

-- Creation of department table
CREATE TABLE IF NOT EXISTS department (
  DepartmentId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Name CHARACTER VARYING(30) NOT NULL,
  HeadFirstName CHARACTER VARYING(30) NOT NULL,
  HeadLastName CHARACTER VARYING(30) NOT NULL,
  HeadPatronymicName CHARACTER VARYING(30),
  Quantity INTEGER
);

-- Creation of employees_info table
CREATE TABLE IF NOT EXISTS employees_info (
  EmployeeId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
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
  CONSTRAINT fk_department
      FOREIGN KEY(DepartmentId)
	  REFERENCES department(DepartmentId)
	  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS quarterly_score (
  EmployeeId INT PRIMARY KEY,
  FirstQuarter score,
  SecondQuarter score,
  ThirdQuarter score,
  FourthQuarter score,
  CONSTRAINT fk_employee
      FOREIGN KEY(EmployeeId)
	  REFERENCES employees_info(EmployeeId)
	  ON DELETE CASCADE
);
