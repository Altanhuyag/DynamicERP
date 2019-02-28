IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_PositionInfo_SEL')
DROP PROC sphrm_PositionInfo_SEL
GO
CREATE PROC sphrm_PositionInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN
	SELECT A.*, B.PositionGroupName FROM hrmPositionInfo A
	INNER JOIN hrmPositionGroup B ON A.PositionGroupPkID = B.PositionGroupPkID
	order by A.SortedOrder
END
GO
