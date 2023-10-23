CREATE TABLE departments (
    dept_no VARCHAR(20),
    dept_name VARCHAR(20)
);

CREATE TABLE dept_emp (
    emp_no VARCHAR(20),
    dept_no VARCHAR(20)
);

CREATE TABLE dept_manager (
    emp_no VARCHAR(20),
    dept_no VARCHAR(20)
);

CREATE TABLE employees (
    emp_no SERIAL PRIMARY KEY,
    emp_title VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    sex CHAR(1),
    birth_date DATE,
    hire_date DATE
);

UPDATE employees
SET birth_date = CONCAT(
  SUBSTRING(birth_date FROM 7), '-', -- Year
  SUBSTRING(birth_date FROM 1 FOR 2), '-', -- Month
  SUBSTRING(birth_date FROM 4 FOR 2) -- Day
),
hire_date = CONCAT(
  SUBSTRING(hire_date FROM 7), '-', -- Year
  SUBSTRING(hire_date FROM 1 FOR 2), '-', -- Month
  SUBSTRING(hire_date FROM 4 FOR 2) -- Day
);


-- Alter the table to add new date columns with DATE data type
ALTER TABLE employees
ADD COLUMN new_birth_date DATE,
ADD COLUMN new_hire_date DATE;

-- Update the new columns with the converted date values in 'YYYY-MM-DD' format
UPDATE employees
SET new_birth_date = TO_DATE(birth_date, 'MM-DD-YYYY')::DATE,
    new_hire_date = TO_DATE(hire_date, 'MM-DD-YYYY')::DATE;

-- Remove the old string date columns
ALTER TABLE employees
DROP COLUMN birth_date,
DROP COLUMN hire_date;

Drop Table employees
SELECT * from employees


CREATE TABLE salaries (

);

CREATE TABLE titles (
);