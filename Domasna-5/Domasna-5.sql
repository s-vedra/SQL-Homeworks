
--1st req
create or alter procedure usp_CreateGrade (@StudentID int,@CourseID int, @TeacherID int, @Grade int, @Comment nvarchar(100) = '')
as
begin
	declare @CreatedDate date
	select @CreatedDate = GETDATE()
	insert into [dbo].[Grade]([StudentID],[CourseID],[TeacherID],[Grade],[Comment],[CreatedDate])
	values(@StudentID,@CourseID,@TeacherID,@Grade,@Comment,@CreatedDate)

	select count(g.Grade) as Total_Grades from [dbo].[Grade] g
	where g.StudentID = @StudentID


	select MAX(g.Grade) as MAXGrade
	from [dbo].[Grade] g
	where g.StudentID = @StudentID AND g.TeacherID = @TeacherID
end


exec usp_CreateGrade @StudentID=2, @CourseID=5, @TeacherID=10, @Grade=6
go

--2nd req
create or alter procedure CreateGradeDetails 
(
	@GradeID int, 
	@AchievementTypeID tinyint, 
	@AchievementPoints tinyint, 
	@AchievementMaxPoints tinyint = 100, 
	@SumGradePoints decimal (18,2) output
) 
as 
begin
	declare @AchievementDate date 
	select @AchievementDate = GETDATE()

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
	select @ParticipationRate = a.ParticipationRate from [dbo].[AchievementType] a where a.ID = @AchievementTypeID
	select @SumGradePoints = (CAST(@AchievementPoints as decimal) / CAST(@AchievementMaxPoints as decimal)) * CAST(@ParticipationRate as decimal)
	
	 
end
go

declare @TotalPoints decimal (18,2)
exec CreateGradeDetails 6, 3 , 98, 100, @TotalPoints OUTPUT
select @TotalPoints as Total_Grades
go


