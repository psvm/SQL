CREATE DATABASE IF NOT EXISTS employeeDb;
USE employeeDb;
DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee(

ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,

emp_name varchar(512),

department_ID int,

chief_ID int,

salary int,

FOREIGN KEY (chief_ID) references employee(ID));

INSERT INTO employee(emp_name, department_ID, chief_ID, salary)
VALUES 	
		('Самый главный босс', 1, null, 100000),
		('Заместитель самого главного босса', 2, 1, 450000),
        ('Второй заместитель самого главного босса', 3, 1, 85000),
        ('Секретарша самого главного босса', 1, 1, 1000000),
        ('Секретарша заместителя самого главного босса', 2, 2, 500000),
        ('Секретарша второго заместителя самого главного босса', 3, 3, 50000),
        ('Секретарша секретарши самого главного босса', 1, 4, 1000001),
        ('Вася', 1, 7, 1000);
		/* Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек.*/
        select  department_ID, count(ID) as number_of_employee_in_department
        from employee
        group by department_ID
        having count(ID) <=3;
        
        /*Вывести список сотрудников, получающих заработную плату большую чем у непосредственного руководителя.*/
        select F.emp_name as looser_chief, F.salary as chiefs_salary, S.emp_name as lucky_employee, S.salary as employees_salary
        from employee F, employee S
        where F.ID = S.chief_ID
        and F.salary < S.salary
        order by F.emp_name, S.emp_name;
        
        
		/*Вывести список сотрудников, чей руководитель работает в другом отделе.*/
        select S.emp_name, S.department_ID, F.department_ID as chiefs_department_ID
        from employee F, employee S
        where F.ID = S.chief_ID
        and F.department_ID != S.department_ID
        order by F.emp_name, S.emp_name;
