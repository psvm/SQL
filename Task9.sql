select  st.student_id, c.course_name, sm.mark
from 
students st
left join 
group_student grs
on
st.student_id = grs.student_id
left join
groups gr
on
grs.group_id = gr.group_id
inner join
teacher_course_faculty tcf
on gr.faculty_id = tcf.faculty_id
left join
courses c
on tcf.course_id = c.course_id
left join 
students_marks sm
on st.student_id = sm.student_id and c.course_id = sm.course_id
group by last_name, course_name