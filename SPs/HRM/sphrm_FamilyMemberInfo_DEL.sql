IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_FamilyMemberInfo_DEL')
DROP PROC sphrm_FamilyMemberInfo_DEL
GO
CREATE PROC sphrm_FamilyMemberInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	FamilyMemberPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

  	DELETE A
	FROM hrmFamilyMemberInfo A
		INNER JOIN #tmp B ON A.FamilyMemberPkID =B.FamilyMemberPkID
END
GO
