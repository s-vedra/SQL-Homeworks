--1st req
create or alter procedure usp_CreateGrade (@StudentID int, @TeacherID int)
as
begin
	select s.FirstName + ' ' + s.LastName as Student_Name ,count(g.Grade) as Total_Grades from [dbo].[Grade] g
	join [dbo].[Student] s on g.StudentID = s.ID
	where s.ID = @StudentID
	group by s.FirstName + ' ' + s.LastName

	select t.ID, t.FirstName + ' ' + t.LastName as TeacherName, MAX(g.Grade) as MAXTeacherGrade,
	s.ID,s.FirstName + ' ' + s.LastName as Student_Name, MAX(g.Grade) as MAXStudentGrade
	from [dbo].[Grade] g
	join [dbo].[Student] s on s.ID = g.StudentID
	join [dbo].[Teacher] t on g.TeacherID = t.ID
	where s.ID = @StudentID AND t.ID = @TeacherID
	group by t.ID, t.FirstName + ' ' + t.LastName,
	s.ID,s.FirstName + ' ' + s.LastName
end

exec usp_CreateGrade @TeacherID = 42 ,@StudentID = 254


select * from [dbo].[Grade]
select * from [dbo].[GradeDetails] g
order by g.GradeID desc
select * from [dbo].[Student]
go

--2nd req
create or alter procedure CreateGradeDetails 
(
	@GradeID int, 
	@AchievementTypeID tinyint, 
	@AchievementPoints tinyint, 
	@AchievementMaxPoints tinyint = 100, 
	@AchievementDate date
) 
as 
begin
	insert into [dbo].[GradeDetails] (GradeID,AchievementTypeID,AchievementPoints,AchievementMaxPoints,AchievementDate)
	values 
	(
	@GradeID,
	@AchievementTypeID, 
	@AchievementPoints, 
	@AchievementMaxPoints, 
	@AchievementDate
	)

	declare @ParticipationRate int
	select @ParticipationRate = COUNT(g.AchievementDate) from [dbo].[GradeDetails] g
	where g.AchievementDate = @AchievementDate 
	declare @SumGradePoints decimal
	select @SumGradePoints = CAST(SUM((@AchievementMaxPoints * @ParticipationRate) / @AchievementPoints) as decimal) from [dbo].[GradeDetails] g
	where g.ID = @GradeID

	select @GradeID as Grade_Id,@ParticipationRate as Participation_Rate ,@SumGradePoints as SUM_GradePoints
	 
end
go

declare @Date date
select @Date = GETDATE()
exec CreateGradeDetails 
@GradeID = 10,
@AchievementTypeID = 2,
@AchievementPoints = 52,
@AchievementDate = @Date
go


