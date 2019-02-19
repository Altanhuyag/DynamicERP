IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SalaryInfo_SEL')
DROP PROC sphrm_SalaryInfo_SEL
GO
CREATE PROC sphrm_SalaryInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	select * from (
	SELECT '-1' SalaryInfoPkID,N'Сонгоно уу' SalaryInfoName,0 Salary1,0 Salary2,0 SortID
	union all
	SELECT A.SalaryInfoPkID,A.SalaryInfoName,A.Salary1,A.Salary2,A.SortID FROM hrmSalaryInfo A
    ) as B
	order by B.SortID
END

GO
