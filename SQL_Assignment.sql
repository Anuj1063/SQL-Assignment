CREATE TABLE EmployeeDetails (
  EmpId INT PRIMARY KEY,
  FullName VARCHAR(100),
  ManagerId INT,
  DateOfJoining DATE,
  City VARCHAR(50)
);

CREATE TABLE EmployeeSalary (
  EmpId INT,
  Project VARCHAR(50),
  Salary DECIMAL(10, 2),
  Variable DECIMAL(10, 2),
  PRIMARY KEY (EmpId, Project),
  FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);


INSERT INTO EmployeeDetails VALUES
(1, 'John Smith', NULL, '2021-01-15', 'New York'),
(2, 'Jane Doe', 1, '2021-02-01', 'New York'),
(3, 'Bob Johnson', 1, '2021-03-01', 'Los Angeles'),
(4, 'Mary Lee', 3, '2021-04-01', 'Chicago'),
(5, 'David Kim', 1, '2021-05-01', 'Los Angeles');

INSERT INTO EmployeeSalary VALUES
(1, 'Project A', 5000, 1000),
(1, 'Project B', 6000, 2000),
(2, 'Project B', 5500, 1500),
(3, 'Project C', 7000, 1000),
(4, 'Project A', 6500, 2000),
(4, 'Project C', 7500, 1500),
(5, 'Project A', 5500, 1000),
(5, 'Project C', 6000, 2000);


SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.EmpId IS NULL;


SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.Project IS NULL;



SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

SELECT ed.*
FROM EmployeeDetails ed
INNER JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;


SELECT Project, COUNT(EmpId) AS NumOfEmployees
FROM EmployeeSalary
GROUP BY Project;


SELECT EmployeeDetails.FullName, COALESCE(EmployeeSalary.Salary, 'Salary Not Available') AS Salary


FROM EmployeeDetails 
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;


SELECT * FROM EmployeeDetails
WHERE EmpId IN (
    SELECT ManagerId
    FROM EmployeeDetails
);


SELECT EmpId, FullName, COUNT(*) as CountOfDuplicates
FROM EmployeeDetails
GROUP BY EmpId, FullName
HAVING COUNT(*) > 1;


SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER(ORDER BY EmpId) AS RowNum
  FROM EmployeeDetails
) AS temp
WHERE temp.RowNum % 2 = 1;



SELECT DISTINCT Salary
FROM EmployeeSalary e1
WHERE 3 = (
  SELECT COUNT(DISTINCT Salary)
  FROM EmployeeSalary e2
  WHERE e2.Salary >= e1.Salary
)


