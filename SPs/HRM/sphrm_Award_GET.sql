IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Award_GET')
DROP PROC sphrm_Award_GET
GO
CREATE PROC sphrm_Award_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@AwardPkID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( AwardPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc
	SELECT @AwardPkID=AwardPkID FROM #tmp
	select 
	A.*,B.AwardName,C.AwardTypeInfoName,D.FirstName,D.RegisterNo from hrmAward A
	left join hrmAwardInfo B on A.AwardInfoPkID=B.AwardInfoPkID
	left join hrmAwardTypeInfo C on A.AwardTypeInfoPkID=C.AwardTypeInfoPkID
	left join hrmEmployeeInfo D on A.EmployeeInfoPkID=D.EmployeeInfoPkID
	where A.AwardPkID=@AwardPkID
END
GO
