
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resRestaurantUser_SEL')
DROP PROC spres_resRestaurantUser_SEL
GO
CREATE PROC spres_resRestaurantUser_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	SELECT a.UserPkID, b.UserName FROM smmUserProgInfo a
	INNER JOIN smmUserInfo b on b.UserPkID = a.UserPkID
	WHERE a.ModuleID = 'RES'

END
GO
