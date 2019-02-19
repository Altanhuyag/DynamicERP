﻿IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EventInfo_SEL')
DROP PROC sphrm_EventInfo_SEL
GO
CREATE PROC sphrm_EventInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

		select * from hrmEventInfo

END
GO
