
USE [SEDCCodeAcademyDB]
GO

DROP TABLE IF EXISTS [dbo].[Student];
DROP TABLE IF EXISTS [dbo].[Teacher];
DROP TABLE IF EXISTS [dbo].[Grade];
DROP TABLE IF EXISTS [dbo].[Course];
drop table if exists [dbo].[GradeDetails];
drop table if exists [dbo].[AchievementType];
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Student](
	[ID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[EnrolledDate] [int] NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[NationalIDNumber] [bigint] NOT NULL,
	[StudentCardNumber] [bigint] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
	(
	[ID] ASC
	)
)
GO
create table [dbo].[Teacher](
	[ID][int] NOT NULL, 
	[FirstName] [nvarchar] (50) NOT NULL,
	[LastName] [nvarchar] (50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[AcademicRank] [int] NULL,
	[HireDate] [date] NULL,
	CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED
	(
	[ID] ASC
	)
)
GO

create table [dbo].[Grade](
	ID [int] NOT NULL,
	StudentID [int] not null, 
	CourseID [int] not null,
	TeacherID [int] not null, 
	Grade [int] null, 
	Comment [nvarchar] (100) null, 
	CreateDate [date] not null,
	constraint [PK_Grade] primary key clustered (
	ID asc
	)
)
GO

create table [dbo].[Course] (
	ID [int] not null,
	[Name] nvarchar (50) not null,
	Credit int not null,
	AcademicYear date not null,
	Semester int not null

	constraint PK_Course primary key clustered (
	ID asc
	)
)
GO

create table [dbo].[GradeDetails](
	ID [int] NOT NULL,
	GradeID int not null,
	AchievementTypeID int not null,
	AchievementPoints int not null, 
	AchievementMaxPoints int not null,
	AchievementDate date not null
	constraint [PK_GradeDetails] primary key clustered (
	ID asc
	)
)
GO

create table [dbo].[AchievementType](
	ID int not null,
	[Name] nvarchar not null,
	[Description] nvarchar (100) null,
	ParticipationRate int null
	constraint [PK_AchievementType] primary key clustered (
	ID asc
	)
)
GO