﻿USE GeganetMedical
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROC sphrm_WorkRoleGroup_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT * FROM hrmWorkRoleGroup
END
GO
