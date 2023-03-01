

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

--List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE hire_date >= '1/1/1986' AND 
	  hire_date < '1/1/1987';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dm.dept_no, dm.emp_no, d.dept_name, e.first_name, e.last_name 
FROM dept_manager dm
LEFT JOIN departments d
ON dm.dept_no = d.dept_no
LEFT JOIN employees e
ON e.emp_no = dm.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT de.dept_no,d.dept_name,e.emp_no, e.last_name,e.first_name
FROM dept_emp de
JOIN employees e
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B

Select e.first_name, e.last_name, e.sex 
From employees e
WHERE first_name = 'Hercules'
	AND left(last_name,1) = 'B';

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
WHERE emp_no IN
(
	SELECT emp_no 
	FROM dept_emp
	WHERE dept_no IN
		(
			SELECT dept_no 
			FROM departments
			WHERE dept_name = 'Sales'
		)
);


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON (e.emp_no = de.emp_no)
JOIN departments d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales' 
	OR d.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(last_name) AS "last_name count"
FROM employees
GROUP BY "last_name"
ORDER BY "last_name count" DESC;


