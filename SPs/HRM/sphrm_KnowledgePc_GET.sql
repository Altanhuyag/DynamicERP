IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_KnowledgePc_GET')
DROP PROC sphrm_KnowledgePc_GET
GO
CREATE PROC sphrm_KnowledgePc_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@KnowledgePkID		nvarchar(16)

	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	KnowledgePkID		nvarchar(16))

	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@KnowledgePkID=KnowledgePkID FROM #tmp	

	select a.*, b.RegisterNo, b.FirstName, c.ValueStr1 from hrmKnowledgePC a join hrmEmployeeInfo b on b.EmployeeInfoPkID = a.EmployeeInfoPkID
	join (SELECT ValueNum, ValueStr1 FROM smmConstants WHERE upper(constType)=upper('hrmKnowledge')) c on c.ValueNum = a.KnownLevel
	where a.KnowledgePkID = @KnowledgePkID
END
GO
