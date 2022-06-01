--1st req
select t.FirstName + N' ' + t.LastName as Teacher, 
count(g.Grade) as Grade_Count  from [dbo].[Grade] g
join [dbo].[Teacher] t on t.ID = g.TeacherID
group by t.FirstName + N' ' + t.LastName
go

--2nd req
select t.FirstName + N' ' + t.LastName as Teacher, 
count(g.Grade) as Grade_Count from [dbo].[Grade] g
join [dbo].[Student] s on s.ID = g.StudentID
join [dbo].[Teacher] t on t.ID = g.StudentID
where s.ID < 100
group by t.FirstName + N' ' + t.LastName
go

--3rd req
select s.FirstName + N' ' + s.LastName, 
MAX(g.Grade) as Max_Grade,
AVG(g.Grade) Average_Grade from [dbo].[Grade] g 
join [dbo].[Student] s on s.ID = g.StudentID
group by s.FirstName + N' ' + s.LastName
go

--4th req
select t.FirstName + N' ' + t.LastName, COUNT(g.Grade) as Grade_Count from [dbo].[Grade] g 
join [dbo].[Teacher] t on t.ID = g.TeacherID
group by t.FirstName + N' ' + t.LastName
having COUNT(g.Grade) > 200
go

--5th req
select s.ID, s.FirstName + ' ' + s.LastName as Student_Name,
COUNT(g.Grade) as Total_Count,
MAX(g.Grade) as max_Grade,
MIN(g.Grade) as MIN_Grade,  
AVG(g.Grade) as AVG_Grade
from [dbo].[Grade] g
join [dbo].[Student] s on s.ID = g.StudentID
group by s.ID, s.FirstName + ' ' + s.LastName
having MAX(g.Grade) = AVG(g.Grade)
go

--6th req
create or alter view dbo.vv_StudentGrades 
as select s.ID ,s.FirstName + ' ' + s.LastName as Student_Name ,COUNT(g.Grade) as Grade_Count from [dbo].[Grade] g
join [dbo].[Student] s on s.ID = g.StudentID
group by s.ID ,s.FirstName + ' ' + s.LastName
go
select * from [dbo].[vv_StudentGrades] s
order by s.Grade_Count desc

