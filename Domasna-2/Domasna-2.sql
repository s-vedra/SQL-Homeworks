--first req.
select * from Student
where FirstName = 'Antonio'
go

--second req
select * from Student
where cast (DateOfBirth as date) > cast ('01.01.1999' as date)
go

--third req
select * from Student
where EnrolledDate>='1998.01.01'
and EnrolledDate<='1998.01.31'
and LastName like 'J%' 
go

--fourth req
select * from Student
order by FirstName asc
go

--fifth req
select LastName from Teacher
union 
select LastName from Student
go

--sixth req
alter table [dbo].[Grade] with check
add constraint [FK_TeacherID]
foreign key ([TeacherID])
references [dbo].[Teacher] ([ID])
go

alter table [dbo].[Grade] with check
add constraint [FK_StudentID]
foreign key ([StudentID])
references [dbo].[Student] ([ID])
go

--seventh req 
select course.Name as [Course name], atype.Name as [Achievement type]
from [dbo].[Course] course
cross join 
AchievementType atype
go

--eight req
select FirstName,LastName from Teacher
full join Grade on Grade.TeacherID = Teacher.ID 
where TeacherID is null
go



