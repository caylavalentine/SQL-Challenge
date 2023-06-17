
DROP TABLE if exists dept_manager
;


DROP TABLE if exists dept_employees
;

DROP TABLE if exists salaries
;

DROP TABLE if exists employees
;

DROP TABLE if exists departments
;

DROP TABLE if exists titles
;

CREATE TABLE titles (
 	title_id VARCHAR (30) PRIMARY KEY,
 	title VARCHAR (30)
)
;



CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR (30),
	birth_date DATE,
	first_name VARCHAR (30),
	last_name VARCHAR (30),
	sex VARCHAR (30),
	hire_date DATE,
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
)
;

CREATE TABLE departments (
	dept_no VARCHAR (30) PRIMARY KEY,
	dept_name VARCHAR (30)
)
;

CREATE TABLE dept_manager (
	dept_no VARCHAR (30),
	emp_no INT,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
)
;

CREATE TABLE dept_employees (
	emp_no INT,
	dept_no VARCHAR (30),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
)
;

CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	PRIMARY KEY (emp_no,salary),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
)
;

---List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, last_name, first_name, sex, salary
FROM employees
JOIN salaries 
ON employees.emp_no = salaries.emp_no
;

SELECT *
FROM employees
;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date between '1986-01-01' and '1986-12-31'
;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_name, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments 
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON employees.emp_no = dept_manager.emp_no
;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_employees.dept_no, departments.dept_name, dept_employees.emp_no, employees.first_name, employees.last_name
FROM dept_employees
JOIN departments
ON departments.dept_no = dept_employees.dept_no
JOIN employees
ON employees.emp_no = dept_employees.emp_no
;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
;

--List each employee in the Sales department, including their employee number, last name, and first name
SELECT e.emp_no, e.first_name, e.last_name
FROM employees as e
    INNER JOIN dept_employees as de
        ON (e.emp_no = de.emp_no)
    INNER JOIN departments as d
        ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales'
ORDER BY e.emp_no
;

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees as e
    INNER JOIN dept_employees as de
        ON (e.emp_no = de.emp_no)
    INNER JOIN departments as d
        ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development')
;

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS frequency 
FROM employees
GROUP BY last_name
ORDER BY 
COUNT (last_name) DESC
;
