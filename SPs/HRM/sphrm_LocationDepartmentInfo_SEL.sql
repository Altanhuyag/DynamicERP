IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LocationDepartmentInfo_SEL')
DROP PROC sphrm_LocationDepartmentInfo_SEL
GO
CREATE PROC sphrm_LocationDepartmentInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)
WITH ENCRYPTION
AS
  
BEGIN

DECLARE @idoc				INT,			
			@LocationCodePkID	    nvarchar(16)			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( LocationCodePkID	    nvarchar(16))
	EXEC sp_xml_removedocument @idoc 

    SELECT @LocationCodePkID=LocationCodePkID FROM #tmp	

	SELECT case when isnull(LD.LocationCodePkID,'')='' then 'N' else 'Y' end as IsCheck,A.*,isnull(B.DepartmentName,'') as ParentDepartmentName,P.PositionName FROM hrmDepartmentInfo A
	left join hrmDepartmentInfo B on A.ParentPkID = B.DepartmentPkID	
	left join hrmPositionInfo  P on A.ControlPositionPkID=P.PositionPkID
	left join hrmLocationDepartmentInfo LD on A.DepartmentPkID = LD.DepartmentPkID and LD.LocationCodePkID = @LocationCodePkID
	

END

GO
