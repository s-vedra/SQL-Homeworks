--1st req
declare @FirstName nvarchar(100)
set @FirstName = 'Antonio'

select * from [dbo].[Student] s
where s.FirstName = @FirstName
go

--2nd req
declare @StudentList table 
(StudentID int, StudentName nvarchar(100), DateOfBirth date)

insert into @StudentList
select s.ID,s.FirstName + ' ' + s.LastName, s.DateOfBirth from [dbo].[Student] s
where s.Gender = 'F'
select * from @StudentList
go

--3rd req	
create table #StudentList 
(LastName nvarchar(100), EnrolledDate date)

insert into #StudentList
select s.LastName, s.EnrolledDate from [dbo].[Student] s
where s.Gender = 'M'
AND 
s.FirstName like 'A%'
select * from #StudentList s
where LEN(s.LastName) = 7
go

--4th req
create or alter function fn_FindTeachers(@TeacherID int)
returns nvarchar(100)
as
begin
declare @Output nvarchar(100)
select @Output = t.FirstName
from [dbo].[Teacher] t
where LEN(t.FirstName) < 5
AND LEFT(t.FirstName, 3) = LEFT(t.LastName,3)
AND t.ID = @TeacherID
return @Output
end
go

select *,[dbo].[fn_FindTeachers](t.ID) as Teacher_Name from [dbo].[Teacher] t
where [dbo].[fn_FindTeachers](t.ID) is not null
go