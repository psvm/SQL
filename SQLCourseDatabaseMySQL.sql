drop database if exists SQLCourseDatabase;    

create database SQLCourseDatabase collate cp1251_general_ci;

use SQLCourseDatabase;

drop table if exists Teacher_Course_Faculty;
drop table if exists Students_marks;
drop table if exists Group_Student;
drop table if exists Groups;
drop table if exists Students;
drop table if exists Courses;
drop table if exists Teachers;
drop table if exists Faculties;

create table Faculties(
        faculty_id int auto_increment primary key,
        faculty_name nvarchar(255)
);

create table Courses(
        course_id int auto_increment primary key,
        course_name nvarchar(255) 
);

create table Teachers(
        teacher_id int auto_increment primary key,
        last_name nvarchar(255) not null,
        first_name nvarchar(255) not null,
        birthday datetime,
        curator_id int,

        constraint fk_teachers_teachers 
                foreign key (curator_id)
                references Teachers(teacher_id)
);

create table Students(
        student_id int auto_increment primary key,
        student_number nvarchar(128) not null,
        last_name nvarchar(255) not null,
        first_name nvarchar(255) not null,
        sex bit  not null,
        birthday datetime
);

create table Groups(
        group_id int auto_increment primary key,
        group_number nvarchar(24),
        faculty_id int not null,
        
        constraint fk_groups_faculties 
                foreign key (faculty_id)
                references Faculties(faculty_id)
);

create table Group_Student(
        group_student_id int auto_increment primary key,
        group_id int not null,
        student_id int not null,
        is_head bit not null,
        
        constraint fk_groups_students_groups 
                foreign key (group_id)
                references Groups(group_id),

        constraint fk_groups_students_students 
                foreign key (student_id)
                references Students(student_id)
);

create table Teacher_Course_Faculty(
        teacher_course_faculty_id int auto_increment primary key,
        teacher_id int not null,
        course_id int not null,
        faculty_id int not null,        
        duration decimal(8,2),
        
        constraint fk_teacher_course_faculty_teachers 
                foreign key (teacher_id)
                references Teachers(teacher_id),

        constraint fk_teacher_course_faculty_course 
                foreign key (course_id)
                references Courses(course_id),

        constraint fk_teacher_course_faculty_faculties 
                foreign key (faculty_id)
                references Faculties(faculty_id)
);

create table Students_marks(
        student_mark_id int auto_increment primary key,
        student_id int not null,
        course_id int not null,
        mark int,       
        
        constraint fk_students_marks_students 
                foreign key (student_id)
                references Students(student_id),

        constraint fk_students_marks_courses 
                foreign key (course_id)
                references Courses(course_id)
);

insert into Faculties
	(faculty_name) 
values
	('Математико-механический'),
	('Физический'),
	('Экономический');

insert into Courses
	(course_name) 
values
	('Алгебра'),
	('Геометрия'),
	('Высшая математика'),
	('Оптика'),
	('История'),
	('Теория вероятностей'),
	('Экономическая теория');

insert into Teachers
	(last_name, first_name, birthday, curator_id)
values
	('Петров', 'Иван', '19640413', null),
	('Никитин', 'Сергей', '19610623', null),
	('Иванов', 'Олег', '19451001', null),
	('Носов', 'Максим', '19721225', 2),
	('Алексеев', 'Алексей', '19690312', null),
	('Данилов', 'Александр', '19790422', 1),
	('Сидоров', 'Денис', '19750502', 1),
	('Лаптев', 'Андрей', '19710719', null),
	('Стеклов', 'Никита', '19500820', 2),
	('Оленев', 'Игорь', '19401025', 3);
        
insert into Students
	(student_number, last_name, first_name, sex, birthday)
values
	('12', 'Таранов', 'Максим', 1, '19891212'),
	('23', 'Жуков', 'Андрей', 1, '19891023'),
	('45', 'Шарапова', 'Анна', 0, '19860107'),
	('67', 'Власова', 'Светлана', 0, '19860308'),
	('89', 'Алиев', 'Искандер', 1, '19860427'),
	('234', 'Кузнецов', 'Павел', 1, '19850502'),
	('567', 'Кузнецова', 'Алла', 0, '19850507'),
	('28', 'Миронов', 'Андрей', 1, '19850528'),
	('13', 'Голубева', 'Полина', 0, '19850507'),
	('93', 'Орлов', 'Андрей', 1, '19850917'),
	('123', 'Толстой', 'Стас', 1, '19890606'),
	('654', 'Иванов', 'Сергей', 1, '19851207'),
	('987', 'Сидорова', 'Анастасия', 0, '19841124');
        
insert into Groups
	(group_number, faculty_id) 
values
	('13', 1),
	('14', 1),
	('13', 2),
	('13', 3),
	('15', 2);
        
insert into Group_Student
	(group_id, student_id, is_head) 
values
	(1, 1, 1),
	(1, 2, 0),
	(1, 3, 0),
	(2, 4, 1),
	(2, 5, 0),
	(2, 6, 0),
	(2, 7, 0),
	(3, 8, 1),
	(3, 9, 0),
	(4, 10, 1),
	(4, 11, 0),
	(4, 12, 0),
	(5, 13, 1);
            
        
insert into Students_marks
	(student_id, course_id, mark) 
values
	(1, 1, 5),
	(1, 2, 4),
	(1, 3, 4),
	(1, 4, 3),
	(1, 7, 5),
	(2, 1, 4),
	(2, 3, 5),
	(2, 6, 3),
	(2, 7, 5),
	(3, 2, 4),
	(3, 3, 4),
	(3, 5, 3),
	(3, 6, 4),
	(4, 1, 5),
	(4, 6, 4),
	(5, 7, 5),
	(5, 4, 4),
	(6, 2, 3),
	(6, 3, 5),
	(6, 7, 4),
	(7, 3, 4),
	(7, 7, 5),
	(7, 4, 4),
	(8, 1, 3),
	(8, 2, 5),
	(8, 7, 4),
	(8, 3, 5),
	(9, 2, 4),
	(10, 1, 4),
	(10, 2, 3),
	(10, 3, 4),
	(10, 6, 3),
	(12, 3, 4);

insert into Teacher_Course_Faculty
	(teacher_id, course_id, faculty_id, duration)
values
	(1, 1, 1, 80),
	(1, 2, 1, 56),
	(1, 3, 2, 90),
	(2, 6, 1, 40),
	(3, 4, 2, 32),           
	(4, 7, 3, 202),
	(5, 3, 1, 86),
	(5, 3, 3, 62),   
	(7, 4, 2, 34),          
	(7, 6, 2, 24),                
	(8, 2, 3, 26),
	(9, 1, 1, 88),   
	(9, 3, 3, 74),       
	(9, 6, 3, 62);     