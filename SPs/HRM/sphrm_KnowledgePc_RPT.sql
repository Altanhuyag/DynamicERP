IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_KnowledgePc_RPT')
DROP PROC sphrm_KnowledgePc_RPT
GO
CREATE PROC sphrm_KnowledgePc_RPT
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

	
	SELECT A.*, B.FirstName, B.LastName, B.DepartmentName, C.ValueStr1 as LevelName FROM hrmKnowledgePc A
		LEFT JOIN (SELECT A.RegisterNo, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID) B 
				ON A.RegisterNo=B.RegisterNo
		LEFT JOIN SystemManager.dbo.smmConstants C	ON A.KnownLevel=C.Constkey collate Cyrillic_General_CI_AS AND upper(C.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS

	IF @Condition = '-'

		SELECT A.*, B.FirstName, B.LastName, B.DepartmentName, C.ValueStr1 as LevelName FROM hrmKnowledgePc A
		LEFT JOIN (SELECT A.RegisterNo, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID) B 
				ON A.RegisterNo=B.RegisterNo
		LEFT JOIN SystemManager.dbo.smmConstants C	ON A.KnownLevel=C.Constkey collate Cyrillic_General_CI_AS AND upper(C.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		WHERE B.DepartmentPkID=@DepartmentPkID

	IF @Condition = '+'

		SELECT A.*, B.FirstName, B.LastName, B.DepartmentName, C.ValueStr1 as LevelName FROM hrmKnowledgePc A
		LEFT JOIN (SELECT A.RegisterNo, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID) B 
				ON A.RegisterNo=B.RegisterNo
		LEFT JOIN SystemManager.dbo.smmConstants C	ON A.KnownLevel=C.Constkey collate Cyrillic_General_CI_AS AND upper(C.ConstType)=upper('hrmKnowledge') collate Cyrillic_General_CI_AS
		WHERE B.RegisterNo=@RegisterNo



END
GO
