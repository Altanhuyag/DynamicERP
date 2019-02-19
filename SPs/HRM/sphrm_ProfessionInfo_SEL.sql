IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ProfessionInfo_SEL')
DROP PROC sphrm_ProfessionInfo_SEL
GO
CREATE PROC sphrm_ProfessionInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN
	--SET NOCOUNT ON
	--DECLARE @idoc			INT,
	--		@PositionGroupPkID 	nvarchar(50)
	
	--EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	--SELECT * INTO #tmp
	--	FROM OPENXML (@idoc,'//BusinessObject',2)
	--	WITH (  PositionGroupPkID		nvarchar(50))
	
	--EXEC sp_xml_removedocument @idoc
	
	--SELECT @PositionGroupPkID=PositionGroupPkID FROM #tmp 
	
	SELECT *,ProfessionPkID as ProfessionalInfoPkID,ProfessionName as ProfessionalInfoName FROM hrmProfessionInfo
END

GO
