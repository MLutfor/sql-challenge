CREATE TABLE departments (
    department_id VARCHAR(4) PRIMARY KEY,
    department_name VARCHAR(40)
);

CREATE TABLE dept_emp (
    emp_no INT,
    department_id VARCHAR(4),
    from_date DATE,
    to_date DATE
);

CREATE TABLE dept_manager (
    emp_no INT,
    department_id VARCHAR(4),
    from_date DATE,
    to_date DATE
);

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    birth_date DATE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    hire_date DATE
);

CREATE TABLE salaries (
    emp_no INT,
    salary INT,
    from_date DATE,
    to_date DATE
);

CREATE TABLE titles (
    emp_no INT,
    title VARCHAR(50),
    from_date DATE,
    to_date DATE
);
