-- Q1 Using HR Schema, Write a query to fetch the first name ,last name, name of the department and the location of work of all the employees.
SELECT * FROM eMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
SELECT * FROM JOBS;
use hr;

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;

-- Q2 Using HR Schema, Write a query to fetch the first name ,last name of all the employees who are Sales Representative.
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE FROM EMPLOYEES E JOIN JOBS J 
ON E.JOB_ID = J.JOB_ID WHERE J.JOB_TITLE = 'SALES REPRESENTATIVE';

-- 3: Using HR Schema, Write a Query to fetch all the departments and the names of the person managing them.
select * FROM EMPLOYEES;

SELECT department_name,first_name,last_name
FROM departments d
LEFT JOIN employees e ON d.manager_id=e.employee_id;

-- 4: Using HR Schema, Write a Query to fetch all the departments and the names of the person managing them in America Region.


SELECT department_name,first_name,last_name
FROM departments d
LEFT JOIN employees e ON d.manager_id=e.employee_id
JOIN Locations l ON d.location_id=l.location_id
JOIN Countries c ON l.country_id=c.country_id
JOIN Regions r ON c.region_id=r.region_id
WHERE lower(r.region_name)='americas';

SELECT * FROM REGIONS;
-- 5: Using HR Schema, Write a query to fetch the names of the departments that are unstaffed.

SELECT D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID) FROM EMPLOYEES E RIGHT JOIN departments D 
ON D.department_id = E.department_id GROUP BY D.DEPARTMENT_ID HAVING COUNT(E.EMPLOYEE_ID)=0;

-- 6: Using HR Schema, Write a query to fetch the names of thedepartments that are unstaffed and are located in Seattle.


SELECT D.DEPARTMENT_NAME, L.CITY
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.EMPLOYEE_ID IS NULL AND L.CITY = 'Seattle';



-- 7: Using HR Schema, Write a query to identify the list of names of employees who are not assigned any work and also the list of departments 
-- that areunstaffed so that the employees can be utilised to staff the departments.
SELECT E.EMPLOYEE_ID, D.department_id FROM EMPLOYEES E LEFT JOIN departments D ON E.DEPARTMENT_ID = D.department_id WHERE E.department_id IS NULL

UNION

SELECT D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID) FROM EMPLOYEES E RIGHT JOIN departments D 
ON D.department_id = E.department_id GROUP BY D.DEPARTMENT_ID HAVING COUNT(E.EMPLOYEE_ID)=0;


-- 8 : Using HR Schema, Write a query to identify the list of names of employees who are not assigned any work and also the list of departments that are 
-- unstaffed so that the employees can be utilised to staff the departments in London.

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME FROM EMPLOYEES RIGHT JOIN DEPARTMENTS USING(DEPARTMENT_ID)
JOIN LOCATIONS USING(LOCATION_ID) WHERE CITY = 'LONDON'

UNION

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME FROM EMPLOYEES LEFT JOIN DEPARTMENTS USING(DEPARTMENT_ID)
JOIN LOCATIONS USING(LOCATION_ID) WHERE CITY = 'LONDON';



-- 9: Using HR Schema, Write a query to list the names of all people who report to the same person.


SELECT E1.FIRST_NAME, E1.LAST_NAME, E2.FIRST_NAME, E2.LAST_NAME FROM EMPLOYEES E1 JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.MANAGER_ID WHERE E1.EMPLOYEE_ID > E2.EMPLOYEE_ID;


-- 10: Using HR Schema, Write a query to list the names of all people who report to the same person in department Accounting (i.e.110).

SELECT E1.FIRST_NAME, E1.LAST_NAME, E2.FIRST_NAME, E2.LAST_NAME FROM EMPLOYEES E1 JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.MANAGER_ID WHERE E1.EMPLOYEE_ID > E2.EMPLOYEE_ID AND E1.DEPARTMENT_ID = 110;


-- 11: Write a query in SQL to display the first name, last name, department number, and department name for each employee.

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 12: Write a query in SQL to display the first and last name, department, city and state province for each employee.

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, L.STATE_PROVINCE FROM 
EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN locations L ON D.LOCATION_ID = L.location_id;

-- 13: Write a query in SQL to display the first name, last name, salary, and job grade for all employees.

select E.FIRST_NAME, E.LAST_NAME, E.SALARY, J.JOB_TITLE FROM EMPLOYEES E
JOIN JOBS J ON E.SALARY BETWEEN J.MIN_SALARY AND J.MAX_SALARY;


-- 14: Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40.

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME FROM EMPLOYEES E JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID WHERE D.DEPARTMENT_ID = 80 OR D.DEPARTMENT_ID = 40;

SELECT E.first_name , E.last_name , E.department_id , D.department_name FROM employees E JOIN departments D 
ON E.department_id = D.department_id AND E.department_id IN (80 , 40) ORDER BY E.last_name;

-- 15: Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.

SELECT E.FIRST_NAME, E.lAST_NAME, D.DEPARTMENT_NAME, L.CITY, L.STATE_PROVINCE 
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID WHERE E.FIRST_NAME LIKE '%Z%';

-- 16: Write a query in SQL to display all departments including those where does not have any employee.

SELECT first_NAME, LAST_NAME, department_name,department_id
 FROM EMPLOYEES RIGHT OUTER JOIN departments
USING(DEPARTMENT_ID);

-- 17: Write a query in SQL to display the first name of all employees including the first name of their manager.

SELECT E1.FIRST_NAME AS MANAGER_NAME, E2.FIRST_NAME AS EMPLOYEE_NAMEAS FROM EMPLOYEES E1 JOIN EMPLOYEES E2 ON E1.EMPLOYEE_ID = E2.MANAGER_ID;


-- 18: Write a query in SQL to display the department name, city, and state province for each department.

SELECT D.DEPARTMENT_NAME, L.CITY, L.STATE_PROVINCE FROM DEPARTMENTS D JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;

-- 19: Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager.

SELECT E1.FIRST_NAME, E2.FIRST_NAME FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E2.EMPLOYEE_ID = E1.MANAGER_ID;
# WE CANT REV THE E1 AND E2 IN ON CLAUSE AS IT WANT ALL EMPLOYEES WHO DONT HAVE MMANAGER

SELECT E.first_name AS "Employee Name", M.first_name AS "Manager" FROM employees E LEFT OUTER JOIN employees M ON E.manager_id = M.employee_id;


-- 20: Write a query in SQL to display the first name, last name, and department number for those employees who works in the 
-- same department as the employee who holds the last name as Taylor

SELECT E.FIRST_NAME, E.LAST_NAME, E.DEPARTMENT_ID FROM EMPLOYEES E WHERE E.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'TAYLOR');

-- OR


SELECT E1.FIRST_NAME, E1.LAST_NAME , E1.DEPARTMENT_ID FROM EMPLOYEES E1 JOIN EMPLOYEES E2 ON E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
WHERE E2.LAST_NAME = 'TAYLOR';

-- 21: Write a query in SQL to display the job title, department name, full name (first and last name ) of employee,
-- and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997.

SELECT J.JOB_TITLE, D.DEPARTMENT_NAME, CONCAT(E.FIRST_NAME,' ',E.LAST_NAME), JH.START_DATE, JH.END_DATE 
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN jobs J ON E.JOB_ID = J.JOB_ID 
JOIN job_history JH ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID
WHERE JH.start_date >= '1993-01-01' AND JH.END_DATE <= '1997-08-31';

-- 22: Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.

SELECT department_name, AVG(salary), COUNT(commission_pct) FROM departments JOIN employees USING (department_id) GROUP BY department_name;


-- 23: Write a query in SQL to display the country name, city, and number of those departments where at least 2 employees are working.

SELECT country_name,city, COUNT(department_id) FROM countries JOIN locations USING (country_id) JOIN departments USING (location_id) WHERE department_id IN 
(SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(department_id)>=2) GROUP BY country_name,city;

-- 24: Write a query in SQL to display the department name and number of employees in each of the department.

SELECT D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID) AS TOAL_EMPLOYEE FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID GROUP BY 1;


-- 25: Write a query in SQL to display the full name (first and last name ) of employee with ID and name of the country presently where (s)he is working

SELECT CONCAT(E.FIRST_NAME,' ', E.LAST_NAME), E.EMPLOYEE_ID, C.COUNTRY_NAME FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID;

-- 26: Write a query to display the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163

SELECT CONCAT(E.FIRST_NAME,' ', E.LAST_NAME) FROM EMPLOYEES E WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 163);


SELECT concat(E.FIRST_NAME,' ',E.LAST_NAME) FROM EMPLOYEES E JOIN EMPLOYEES E1 ON E1.EMPLOYEE_ID = 163
WHERE E.SALARY > E1.SALARY;

-- 27: Write a query to display the name ( first name and last name ), salary, department id for those 
-- employees who earn such amount of salary which is the smallest salary of any of the departments.

SELECT CONCAT(E.FIRST_NAME,' ', E.LAST_NAME), E.SALARY, E.DEPARTMENT_ID FROM EMPLOYEES E WHERE SALARY IN (select MIN(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID);

SELECT CONCAT(E1.FIRST_NAME,' ', E1.LAST_NAME), E1.SALARY, E1.DEPARTMENT_ID FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2
ON E1.DEPARTMENT_ID = E2.DEPARTMENT_ID AND E1.SALARY > E2.SALARY WHERE E2.EMPLOYEE_ID IS NULL;

-- 28: Write a query to display the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.

SELECT AVG(SALARY) FROM EMPLOYEES;

SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME FROM EMPLOYEES WHERE SALARY > 6461.68223;

SELECT CONCAT(E1.FIRST_NAME,' ',E1.LAST_NAME) FROM EMPLOYEES E1 WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);


-- 29: Write a query to display the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.

SELECT CONCAT(FIRST_NAME,' ',LAST_NAME), EMPLOYEE_ID, SALARY FROM EMPLOYEES WHERE MANAGER_ID = (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'PAYAM');

-- 30: Write a query to display all the information of the employees who does not work in those departments where some employees
-- works whose manager id within the range 100 and 200.

SELECT * FROM EMPLOYEES WHERE DEPArtment_id NOT IN (select DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID BETWEEN 100 AND 200);

-- 31: Write a query to display the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.

SELECT FIRST_NAME || ' ' || LAST_NAME, hire_date FROM EMPLOYEES WHERE DEPARTMENT_ID =
(SELECT department_id FROM EMPLOYEES WHERE FIRST_NAME = 'CLARA' )AND FIRST_NAME != 'CLARA';


-- 32: Write a query to display the employee id, name ( first name and last name ), salary, department name and city for all the employees who
--  gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 1997 and December 31st,1997

select * from employees;

SELECT E.EMPLOYEE_ID, CONCAT(E.FIRST_NAME,' ',E.LAST_NAME), E.SALARY, D.DEPARTMENT_NAME, l.city
FROM employees E JOIN departments D ON E.department_id = D.department_id
JOIN LOCATIONs L ON D.LOCATION_ID = L.LOCATION_ID WHERE SALARY in
(SELECT MAX(SALARY) from employees where hire_date between '1997-01-01' and '1997-12-31');

-- 33: Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn less than the average salary, 
-- and also work at the department where the employee Laura is working as a first name holder.


select avg(salary) from employees;
select first_name, last_name, salary, department_id from employees where salary < (select avg(salary) from employees) and
department_id = (select department_id from employees where first_name = 'laura');


-- 34: Display the name & department ID of all departments that has at least one employee with salary greater than 10,000.

select department_name, department_id from departments d where exists (select 1 from employees e where e.salary > 10000 and e.department_id = d.department_id);


-- 35: Write a query to fetch the employee ID, First Name, Last Name, Salary and Department ID of those employees who draw a 
-- salary more than the average salary of their respective department.

select employee_id, first_name, last_name, salary, department_id from employees
where salary >any (select avg(salary) from employees group by department_id);


-- 36: Display first name ,last name of employees where deparment id is equal to Adam department id  and employee_id is 144 using subquery.

select first_name, last_name from employees where department_id = (select department_id from employees where first_name = 'adam') 
and employee_id = 144;

-- 37: Display all the employees who have their manager and department matching with the employee having an Employee ID of 121 or 200 
-- but not 121 or 200 using subquery .

select employee_id, manager_id, department_id from employees 
where (manager_id, department_id) in (select manager_id, department_id from employees where employee_id in (121,200))
and employee_id not in (121,200);


select manager_id, employee_id, department_id from employees
where (manager_id, department_id) in (select manager_id, department_id from employees where employee_id in (121,200)) and employee_id not in (121,200);

 
-- 38: Display 5th highest salary of employee using subquery

select min(salary) from (select salary from employees order by salary desc limit 5)alias;


-- 39: Display the employee number, name (first name and last name) and job title for all employees 
-- whose salary is smaller than any salary of those employees whose job title is MK_MAN using subquery.

select E.EMPLOYEE_ID, CONCAT(E.FIRST_NAME, ' ' , E.LAST_NAME), J.JOB_TITLE, J.JOB_ID
FROM employees E JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE SALARY < ANY(SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'MK_MAN');

-- 40: Write a query to find the name (first_name, last_name) of the employees 
-- who have a manager and worked in a US based department using subquery. 

SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) FROM EMPLOYEES WHERE DEPARTMENT_ID IN 
(SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID IN
(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE LOCATION_ID IN
(SELECT LOCATION_ID FROM LOCATIONS WHERE COUNTRY_ID = 'US')));


-- 41: Write a query in SQL to display the details of the current job for those employees who worked as a Sales Representative in the past

SELECT * FROM jOB_HISTORY;
select * from jobs;


SELECT * FROM JOBS WHERE JOB_ID in
(SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID IN
(SELECT EMPLOYEE_ID FROM JOB_HISTORY WHERE JOB_ID = 'SA_REP'));


-- 42: Write a query in SQL to display the country name, city, and number of those departments where at least 2 employees are working.

SELECT COUNTRY_NAME, CITY, COUNT(DEPARTMENT_ID) FROM COUNTRIES JOIN LOCATIONS USING(COUNTRY_ID)
JOIN DEPARTMENTS USING(LOCATION_ID) WHERE DEPARTMENT_ID IN
(SELECT DEPARTMENT_ID FROM EMPLOYEES GROUP BY DEPARTMENT_ID HAVING COUNT(DEPARTMENT_ID) >= 2)
GROUP BY 1,2;



-- 43: Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.


SELECT DEPARTMENT_NAME, AVG(SALARY), COUNT(EMPLOYEE_ID) FROM departments JOIN EMPLOYEES 
USING(DEPARTMENT_ID) WHERE COMMISSION_PCT IS NOT NULL GROUP BY 1;


-- 44: Display the count of employees whose last_name starts with 'A'
SELECT COUNT(*) FROM (SELECT * FROM EMPLOYEES WHERE LAST_NAME LIKE 'a%')A;

SELECT COUNT(EMPLOYEE_ID) FROM EMPLOYEES WHERE LAST_NAME LIKE'A%';


-- 45: List the first name, last name, job title, department name, and salary for the highest paid employee in each department.
-- Ensure that the highest salary for each employee is less than or equal to the maximum salary for their respective job.
-- If multiple employees in the same department have the highest salary, show only one of them (i.e., pick any one of them).
-- Do not use window functions like ROW_NUMBER() or RANK().

SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME, E.SALARY FROM EMPLOYEES E JOIN departments D USING(DEPARTMENT_ID)
JOIN JOBS J USING(JOB_ID) WHERE E.SALARY <= J.MAX_SALARY AND E.SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = D.DEPARTMENT_ID);



