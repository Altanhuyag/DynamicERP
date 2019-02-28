USE GeganetMedical
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROC sphrm_WorkRoleInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT A.*, B.WorkRoleGroupName 
	FROM hrmWorkRoleInfo A INNER JOIN hrmWorkRoleGroup B
	ON A.WorkRoleGroupPkID=B.WorkRoleGroupPkID
END
GO
