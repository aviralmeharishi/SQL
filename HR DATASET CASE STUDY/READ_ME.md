# HR Dataset Case Study: Joins and Subqueries 🎓💼

## Overview 📊

This case study analyzes the HR dataset, focusing on SQL queries using Joins and Subqueries to solve common business questions related to employee management. The dataset includes details about employees, departments, jobs, locations, and salary information. The goal is to retrieve insightful data about employee performance, department statistics, salary distribution, and job roles.

## Dataset Structure 📂

The HR dataset consists of the following tables:

### EMPLOYEES 👩‍💻👨‍💻
- `EMPLOYEE_ID`: Unique ID for each employee.
- `FIRST_NAME`: Employee's first name.
- `LAST_NAME`: Employee's last name.
- `JOB_ID`: Job role assigned to the employee.
- `DEPARTMENT_ID`: Department where the employee works.
- `SALARY`: Employee’s salary.
- `MANAGER_ID`: Manager's employee ID.
- `HIRE_DATE`: Date the employee joined.
- `COMMISSION_PCT`: Employee’s commission percentage (if applicable).

### DEPARTMENTS 🏢
- `DEPARTMENT_ID`: Unique ID for each department.
- `DEPARTMENT_NAME`: Name of the department.
- `LOCATION_ID`: Location where the department is situated.

### JOBS 💼
- `JOB_ID`: Unique ID for each job.
- `JOB_TITLE`: Job title/role name.
- `MIN_SALARY`: Minimum salary for the job.
- `MAX_SALARY`: Maximum salary for the job.

### LOCATIONS 📍
- `LOCATION_ID`: Unique ID for each location.
- `CITY`: City where the location is situated.
- `COUNTRY_ID`: ID linking to the country.

### COUNTRIES 🌍
- `COUNTRY_ID`: Unique ID for each country.
- `COUNTRY_NAME`: Name of the country.
- `REGION_ID`: ID linking to the region.

### REGIONS 🌎
- `REGION_ID`: Unique ID for each region.
- `REGION_NAME`: Name of the region.

## Case Study Focus 🔍

The focus of this case study is to perform data retrieval using Joins and Subqueries to answer various business questions that provide insights into employee performance, department statistics, salary trends, and job roles.

## Key SQL Concepts Covered:
- **Inner Joins** 🔗
- **Left Joins** ↔️
- **Right Joins** ↪️
- **Self Joins** 🧑‍🤝‍🧑
- **Subqueries in SELECT, WHERE, and HAVING clauses** 🧐
- **Aggregate Functions** (e.g., `MAX`, `COUNT`, `AVG`) 📈

## TOOL USED 🛠️:
- **MySQL Workbench** 💻

---

## Approach and Techniques ⚙️

### Joins:
- **Inner Joins** 🔗 were predominantly used to combine employee data with other related tables, such as `DEPARTMENTS`, `JOBS`, and `LOCATIONS`.
- **Self Joins** 🧑‍🤝‍🧑 were used when employees needed to be compared with one another, such as finding employees who report to the same manager.
- **Left and Right Joins** ↔️↪️ were used where we needed all records from one table, even if there were no corresponding records in the other table.

### Subqueries:
- **Subqueries in the SELECT Clause** 🧐 helped in retrieving the maximum salary within each department.
- **Subqueries in the WHERE Clause** 📋 were used to filter employees who earned less than the maximum salary for their job.

## Conclusion 🎉

This case study provided an opportunity to work with complex SQL queries involving joins and subqueries to answer real-world business questions about employees, salaries, and departments. These techniques are fundamental for querying and analyzing relational data in any organization. The queries we developed help answer questions that provide insights into employee performance, job compensation, and department metrics.

## How to Run 🚀

To execute the queries in this case study, follow these steps:

1. **Set up the HR database**: Ensure that the database schema is set up with the tables mentioned above.
2. **Execute the SQL queries**: Copy and paste the queries into your SQL client or database management tool (e.g., MySQL Workbench, SQL Server Management Studio, etc.).
3. **Review the Results**: Review the results based on the data in your database to check the correctness of the answers.

## License 📜

This case study is open-source and available under the [MIT License](https://opensource.org/licenses/MIT).


