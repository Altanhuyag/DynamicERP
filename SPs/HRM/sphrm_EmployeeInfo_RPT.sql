IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfo_RPT')
DROP PROC sphrm_EmployeeInfo_RPT
GO
CREATE PROC sphrm_EmployeeInfo_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@EmployeeInfoPkID			nvarchar(50),
			@RegisterNo			nvarchar(50),
			@YearPkID			nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  EmployeeInfoPkID			nvarchar(50))

	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@EmployeeInfoPkID=EmployeeInfoPkID	FROM #tmp   
	select @YearPkID = ConfigValue from smmConfig where ConfigID='YearPkID'
	
	select @RegisterNo=RegisterNo from hrmEmployeeInfo where EmployeeInfoPKID = @EmployeeInfoPkID and YearPkID = @YearPkID

	SELECT substring(A.LastName,1,1)+'.'+A.FirstName as LastName,Relationship as FamilyMemberName,A.CurrentJob as JobAddress,A.BirthDay FROM hrmFamilyInfo A 
	where A.EmployeePkID = @EmployeeInfoPkID
	
	select A.*,U.UniversityName,P.ProfessionName from hrmGraduate A
	left join hrmUniversityInfo U on A.UniversityPkID = U.UniversityPkID
	left join hrmProfessionInfo P on A.ProfessionPkID = P.ProfessionPkID
	where A.EmployeePkID = @EmployeeInfoPkID
	order by A.EnteredDate asc
	
	select * from hrmExpert
	where RegisterNo = @RegisterNo
	
	select T1.ValueStr1 Reading,T2.ValueStr1 as Listening,T3.ValueStr1 as Talking,T4.ValueStr1 as Writing,L.LanguageName from hrmLanguageKnowledge A
	left join hrmLanguageInfo L on A.LanguagePkID = L.LanguagePkID
	inner join (select * from smmConstants where ModuleID='HRM' and ConstType='hrmKnowledge') T1 on A.Reading = T1.ConstKey
	inner join (select * from smmConstants where ModuleID='HRM' and ConstType='hrmKnowledge') T2 on A.Listening = T2.ConstKey
	inner join (select * from smmConstants where ModuleID='HRM' and ConstType='hrmKnowledge') T3 on A.Talking = T3.ConstKey
	inner join (select * from smmConstants where ModuleID='HRM' and ConstType='hrmKnowledge') T4 on A.Writing = T4.ConstKey
	where A.RegisterNo = @RegisterNo
	
	select A.*,T1.ValueStr1 as LevelName from hrmKnowledgePc A
	inner join (select * from smmConstants where ModuleID='HRM' and ConstType='hrmKnowledge') T1 on A.KnownLevel = T1.ConstKey
	where A.RegisterNo = @RegisterNo	
	
	
	
	select A.*,J.JobExitReasonName AS [Description],PI.PositionName from hrmWorkingHistory A
	left join hrmJobExitReason J on A.ReasonInfoPkID = J.JobExitReasonPkID
	left join hrmPositionInfo PI on A.PositionPkID = PI.PositionPkID
	where A.RegisterNo = @RegisterNo
	
	SELECT A.*,H.HobbyInfoName from hrmEmployeeHobby A
	left join hrmHobbyInfo H on A.HobbyInfoPkID = H.HobbyInfoPkID
	where A.RegisterNo = @RegisterNo
	
	select * from hrmSkill A
	where A.RegisterNo = @RegisterNo
	
	
	
	--LEFT JOIN	(SELECT A.*, B.LanguageName, C.ValueStr1 as ReadingName, D.ValueStr1 as WritingName, E.ValueStr1 as TalkingName, F.Valuestr1 as ListeningName 
	--			FROM hrmLanguageKnowledge A 
	--			INNER JOIN hrmLanguageInfo B ON B.LanguagePkID=A.LanguagePkID collate SQL_Latin1_General_CP1_CI_AS
	--			INNER JOIN (SELECT * FROM SystemManager.dbo.smmConstants WHERE upper(constType)=upper('hrmKnowledge')) C ON C.ConstKey=A.Reading collate SQL_Latin1_General_CP1_CI_AS
	--			INNER JOIN (SELECT * FROM SystemManager.dbo.smmConstants WHERE upper(constType)=upper('hrmKnowledge')) D ON D.ConstKey=A.Writing collate SQL_Latin1_General_CP1_CI_AS
	--			INNER JOIN (SELECT * FROM SystemManager.dbo.smmConstants WHERE upper(constType)=upper('hrmKnowledge')) E ON E.ConstKey=A.Talking collate SQL_Latin1_General_CP1_CI_AS
	--			INNER JOIN (SELECT * FROM SystemManager.dbo.smmConstants WHERE upper(constType)=upper('hrmKnowledge')) F ON F.ConstKey=A.Listening collate SQL_Latin1_General_CP1_CI_AS
	--			WHERE A.RegisterNo=@RegisterNo) D ON D.RegisterNo=A.RegisterNo


	--LEFT JOIN	(SELECT A.*  FROM hrmExpert A 
	--			WHERE A.RegisterNo=@RegisterNo) E ON E.RegisterNo=A.RegisterNo


	--LEFT JOIN	(SELECT A.*, B.PositionName  FROM hrmWorkingHistory A 
	--			LEFT JOIN hrmPositionInfo B ON B.PositionPkID=A.PositionPkID 
	--			WHERE A.RegisterNo=@RegisterNo) F ON F.RegisterNo=A.RegisterNo

	--LEFT JOIN	(SELECT A.*, C.ValueStr1 as LevelName FROM hrmKnowledgePc A 	
	--			LEFT JOIN (SELECT * FROM SystemManager.dbo.smmConstants WHERE upper(constType)=upper('hrmKnowledge')) C ON C.ConstKey=A.KnownLevel collate SQL_Latin1_General_CP1_CI_AS
	--			WHERE A.RegisterNo=@RegisterNo) G ON G.RegisterNo=A.RegisterNo

	--LEFT JOIN   (SELECT * FROM hrmEmployeeImage WHERE RegisterNo=@RegisterNo) H ON H.RegisterNo=A.RegisterNo

	--WHERE A.RegisterNo=@RegisterNo
	
	
	
END
GO
