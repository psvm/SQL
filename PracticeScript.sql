select * from students;
select * from group_student;
select * from groups;

select *
from 
	students s
inner join
	group_student gs
		on s.student_id = gs.student_id
inner join
	groups g
		on g.group_id = gs.group_id
inner join
	faculties f
		on f.faculty_id = g.faculty_id;
        
        
        
select last_name, group_number, faculty_name
from 
	faculties f -- 3
inner join
	groups g -- 5
		on f.faculty_id = g.faculty_id
inner join
	group_student gs
		on gs.group_id = g.group_id and is_head = 1
inner join
	students s
		on s.student_id = gs.student_id

/*1
1.	Выбрать фамилию, дату рождения и номер студенческого 
билета для студентов мужского пола. 
Результат отсортировать по дате рождения так, 
чтобы самый старший студент находился на первом месте.*/
	
select last_name, first_name, birthday, student_number
from Students
where sex = 1
order by birthday

/*2 2.	Написать запрос, возвращающий преподавателей у 
которых есть кураторы. Результат должен содержать одно 
поле teacher_name, в котором содержится Фамилия и 
Имя преподавателя через пробел.
*/
select last_name, first_name, 
	concat(last_name, ' ', first_name) teacher_name
from teachers        
where curator_id is not null
        
/*3.	Написать запрос, возвращающий преподавателей, 
которым больше 50 лет или фамилия которых начинается на букву «С».*/
select last_name, first_name, birthday, cast(birthday as date)
from teachers
where -- birthday <= '1968-03-29'
birthday <= (curdate() - interval 50 year)
or last_name like 'С%'

/*select curdate() + 1, now() + 1

select (curdate() - interval 50 year)*/
        
/*4.Написать запрос, который выбирает фамилию, 
имя и номер группы студента, в которой он учится.*/
select last_name, first_name, group_number
from
	students s
inner join
	group_student gs on gs.student_id = s.student_id
inner join
	groups g on g.group_id = gs.group_id
        
/*5.Написать запрос, который возвращает фамилии всех преподавателей, 
если у преподавателя есть куратор, то вывести и фамилию куратора.*/
select t.last_name, ifnull(t2.last_name, '') curator_last_name, t2.first_name
from 
	teachers t
left join
	teachers t2 on t.curator_id = t2.teacher_id
    

select * from 
(select t.teacher_id, t.last_name, t2.last_name curator_last_name
from 
	teachers t
inner join
	teachers t2 on t.curator_id = t2.teacher_id
union
select t.teacher_id, t.last_name, ''
from 
	teachers t
where curator_id is null) t
order by teacher_id


select teacher_id, curator_id, last_name, 
	( select last_name from teachers where teacher_id = t.curator_id ) curator_last_name
from teachers t

/*6. Выбрать номер группы и фамилию старосты данной группы.*/
select last_name, group_number
from
	students s
inner join
	group_student gs on gs.student_id = s.student_id and is_head = 1
inner join
	groups g on g.group_id = gs.group_id
-- where is_head = 1

/*7.Написать запрос, возвращающий фамилии преподавателей, 
которые читают и Алгебру, и Высшую математику.*/

select last_name from
teachers t
inner join
teacher_course_faculty tcf on tcf.teacher_id = t.teacher_id
inner join
courses c on c.course_id = tcf.course_id and c.course_name = 'Высшая математика'
where
	last_name IN (
select last_name from
teachers t
inner join
teacher_course_faculty tcf on tcf.teacher_id = t.teacher_id
inner join
courses c on c.course_id = tcf.course_id and c.course_name = 'Алгебра')


select last_name from
teachers t
inner join
teacher_course_faculty tcf on tcf.teacher_id = t.teacher_id
inner join
courses c on c.course_id = tcf.course_id and c.course_name = 'Высшая математика'
where
	exists(
select teacher_id from
teacher_course_faculty tcf2 
inner join
courses c2 on c2.course_id = tcf2.course_id and c2.course_name = 'Алгебра'
where tcf2.teacher_id = t.teacher_id)


select last_name
from
	teachers t
inner join
	teacher_course_faculty tcf on tcf.teacher_id = t.teacher_id
inner join
	courses c on c.course_id = tcf.course_id and c.course_name = 'Высшая математика'
inner join
	teacher_course_faculty tcf2 on tcf2.teacher_id = t.teacher_id
inner join
	courses c2 on c2.course_id = tcf2.course_id and c2.course_name = 'Алгебра'

/*8. Выбрать преподавателей, которые читают лекции больше 
чем на одном факультете.*/
select t.last_name -- , count(distinct faculty_id)
from
	teachers t
inner join
	teacher_course_faculty tcf on tcf.teacher_id = t.teacher_id
group by
	t.teacher_id, t.last_name
having
	count(distinct faculty_id) > 1


select distinct t.last_name, tcf.faculty_id, tcf2.faculty_id 
from
	teachers t
inner join
	teacher_course_faculty tcf 
		on tcf.teacher_id = t.teacher_id
inner join
	teacher_course_faculty tcf2 
		on tcf2.teacher_id = t.teacher_id
where
	tcf.faculty_id > tcf2.faculty_id

/*10.Написать запрос, который возвращает название факультета 
и среднюю продолжительность курсов, читаемых на данном факультете.*/

select faculty_name, avg(duration)
from
	faculties f
inner join
	teacher_course_faculty tcf
		on tcf.faculty_id = f.faculty_id
group by
	f.faculty_id, f.faculty_name


select faculty_name, 
	(select avg(duration) 
     from teacher_course_faculty where faculty_id = f.faculty_id) duration
from
	faculties f
        
        
        
        