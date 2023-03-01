DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE departments (
  dept_no character varying(45) NOT NULL PRIMARY KEY,
  dept_name character varying(45) NOT NULL
);

CREATE TABLE titles (
    title_id character varying(45) NOT NULL PRIMARY KEY,
    title character varying(45) NOT NULL
);

CREATE TABLE employees(
    emp_no integer NOT NULL PRIMARY KEY,
    emp_title_id character varying(45) NOT NULL,
    birth_date DATE NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    sex char(1) NOT NULL,
    hire_date DATE NOT NULL,
	FOREIGN KEY(emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no character varying(45) NOT NULL,
  FOREIGN KEY(emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY(dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE dept_manager (
    dept_no character varying(45) NOT NULL,
    emp_no integer NOT NULL,
    FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries (
   emp_no integer NOT NULL,
   salary integer NOT NULL,
   FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

--Querry from each table
SELECT * FROM departments;
SELECT * FROM  dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM  salaries;
SELECT * FROM titles;