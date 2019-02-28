IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LanguageKnowledge_RPT')
DROP PROC sphrm_LanguageKnowledge_RPT
GO
CREATE PROC sphrm_LanguageKnowledge_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@DepartmentPkID		nvarchar(250),
			@RegisterNo			nvarchar(50),
			@Condition			nvarchar(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(250),
				RegisterNo			nvarchar(50),
				Condition			nvarchar(1)	)
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DepartmentPkID=DepartmentPkID, @RegisterNo=RegisterNo, @Condition=Condition	FROM #tmp
	
	IF @Condition = '*'

	
		SELECT A.*, B.FirstName, B.LastName, B.DepartmentName, C.LanguageName, D.ValueStr1 as SkillR, E.ValueStr1 as SkillW, F.ValueStr1 as SkillT, G.ValueStr1 as SkillL
		FROM hrmLanguageKnowledge A
		LEFT JOIN (SELECT A.RegisterNo, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID) B 
				ON A.RegisterNo=B.RegisterNo
		LEFT JOIN hrmLanguageInfo C ON A.LanguagePkID=C.LanguagePkID
		LEFT JOIN SystemManager.dbo.smmConstants D	ON A.Reading=D.Constkey collate Cyrillic_General_CI_AS AND upper(D.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants E	ON A.Writing=E.Constkey collate Cyrillic_General_CI_AS AND upper(E.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants F	ON A.Talking=F.Constkey collate Cyrillic_General_CI_AS AND upper(F.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants G	ON A.Listening=G.Constkey collate Cyrillic_General_CI_AS AND upper(G.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS

	IF @Condition = '-'

		SELECT A.*, B.FirstName, B.LastName, B.DepartmentName, C.LanguageName, D.ValueStr1 as SkillR, E.ValueStr1 as SkillW, F.ValueStr1 as SkillT, G.ValueStr1 as SkillL
		FROM hrmLanguageKnowledge A
		LEFT JOIN (SELECT A.RegisterNo, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID) B 
				ON A.RegisterNo=B.RegisterNo
		LEFT JOIN hrmLanguageInfo C ON A.LanguagePkID=C.LanguagePkID
		LEFT JOIN SystemManager.dbo.smmConstants D	ON A.Reading=D.Constkey collate Cyrillic_General_CI_AS AND upper(D.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants E	ON A.Writing=E.Constkey collate Cyrillic_General_CI_AS AND upper(E.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants F	ON A.Talking=F.Constkey collate Cyrillic_General_CI_AS AND upper(F.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants G	ON A.Listening=G.Constkey collate Cyrillic_General_CI_AS AND upper(G.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		WHERE B.DepartmentPkID=@DepartmentPkID
		

	IF @Condition = '+'

		SELECT A.*, B.FirstName, B.LastName, B.DepartmentName, C.LanguageName, D.ValueStr1 as SkillR, E.ValueStr1 as SkillW, F.ValueStr1 as SkillT, G.ValueStr1 as SkillL
		FROM hrmLanguageKnowledge A
		LEFT JOIN (SELECT A.RegisterNo, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID collate Cyrillic_General_CI_AS) B 
				ON A.RegisterNo=B.RegisterNo
		LEFT JOIN hrmLanguageInfo C ON A.LanguagePkID=C.LanguagePkID
		LEFT JOIN SystemManager.dbo.smmConstants D	ON A.Reading=D.Constkey collate Cyrillic_General_CI_AS AND upper(D.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants E	ON A.Writing=E.Constkey collate Cyrillic_General_CI_AS AND upper(E.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants F	ON A.Talking=F.Constkey collate Cyrillic_General_CI_AS AND upper(F.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		LEFT JOIN SystemManager.dbo.smmConstants G	ON A.Listening=G.Constkey collate Cyrillic_General_CI_AS AND upper(G.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		WHERE B.RegisterNo=@RegisterNo



END
GO
