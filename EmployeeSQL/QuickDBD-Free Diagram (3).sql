-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/RCMyGX
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

ALTER DATABASE "employee database" SET datestyle TO "ISO, MDY";

SELECT * FROM employees;

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "First_Name" VARCHAR   NOT NULL,
    "Last_Name" VARCHAR   NOT NULL,
    "SEX" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--1. List the employee number, last name, first name, sex, and salary of each employee.

SELECT e.emp_no, e."Last_Name", e."First_Name", e."SEX", s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT "First_Name", "Last_Name", "hire_date"
FROM employees
WHERE EXTRACT(YEAR FROM "hire_date") = 1986;

--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT
    d."dept_no",
    d."dept_name",
    m."emp_no" AS "manager_emp_no",
    e."Last_Name" AS "manager_last_name",
    e."First_Name" AS "manager_first_name"
FROM "departments" AS d
JOIN "dept_manager" AS m ON d."dept_no" = m."dept_no"
JOIN "employees" AS e ON m."emp_no" = e."emp_no";

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT
    de."dept_no",
    e."emp_no",
    e."Last_Name",
    e."First_Name",
    d."dept_name"
FROM "employees" AS e
JOIN "dept_emp" AS de ON e."emp_no" = de."emp_no"
JOIN "departments" AS d ON de."dept_no" = d."dept_no";

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT "First_Name", "Last_Name", "SEX"
FROM employees
WHERE "First_Name" = 'Hercules' AND "Last_Name" LIKE 'B%';

--6. List each employee in the Sales department, including their employee number, last name, and first name.

SELECT
    e."emp_no",
    e."Last_Name",
    e."First_Name"
FROM "employees" AS e
JOIN "dept_emp" AS de ON e."emp_no" = de."emp_no"
JOIN "departments" AS d ON de."dept_no" = d."dept_no"
WHERE d."dept_name" = 'Sales';

--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT
    e."emp_no",
    e."Last_Name",
    e."First_Name",
    d."dept_name"
FROM "employees" AS e
JOIN "dept_emp" AS de ON e."emp_no" = de."emp_no"
JOIN "departments" AS d ON de."dept_no" = d."dept_no"
WHERE d."dept_name" IN ('Sales', 'Development');

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT "Last_Name", COUNT(*) AS "Frequency"
FROM employees
GROUP BY "Last_Name"
ORDER BY "Frequency" DESC, "Last_Name";

