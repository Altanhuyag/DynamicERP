IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LanguageKnowledge_GET')
DROP PROC sphrm_LanguageKnowledge_GET
GO
CREATE PROC sphrm_LanguageKnowledge_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@LanguageKnowledgePkID		nvarchar(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  LanguageKnowledgePkID		NVARCHAR(16))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@LanguageKnowledgePkID=LanguageKnowledgePkID
	FROM #tmp
	
	SELECT A.*, G.RegisterNo, G.FirstName, B.LanguageName, C.ValueStr1 as ReadingName, D.ValueStr1 as WritingName, E.ValueStr1 as TalkingName, F.ValueStr1 as ListeningName
	FROM hrmLanguageKnowledge A 
		JOIN hrmEmployeeInfo G ON G.EmployeeInfoPkID=A.EmployeeInfoPkID
		JOIN hrmLanguageInfo B ON A.LanguagePkID=B.LanguagePkID
		JOIN (select * from smmConstants where UPPER(ConstType)=UPPER('hrmKnowledge')) C	ON A.Reading=C.ValueNum
		JOIN (select * from smmConstants where UPPER(ConstType)=UPPER('hrmKnowledge')) D	ON A.Writing=D.ValueNum
		JOIN (select * from smmConstants where UPPER(ConstType)=UPPER('hrmKnowledge')) E	ON A.Talking=E.ValueNum
		JOIN (select * from smmConstants where UPPER(ConstType)=UPPER('hrmKnowledge')) F	ON A.Listening=F.ValueNum
	WHERE A.LanguageKnowledgePkID = @LanguageKnowledgePkID
END
GO
