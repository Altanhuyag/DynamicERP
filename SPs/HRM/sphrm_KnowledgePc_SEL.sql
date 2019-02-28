IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_KnowledgePc_SEL')
DROP PROC sphrm_KnowledgePc_SEL
GO
CREATE PROC sphrm_KnowledgePc_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON

	select a.*, b.RegisterNo, b.FirstName, c.ValueStr1 from hrmKnowledgePC a join hrmEmployeeInfo b on b.EmployeeInfoPkID = a.EmployeeInfoPkID
	join (SELECT ValueNum, ValueStr1 FROM smmConstants WHERE upper(constType)=upper('hrmKnowledge')) c on c.ValueNum = a.KnownLevel
END
GO
