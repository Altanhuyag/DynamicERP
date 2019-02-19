USE GeganetMedical
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROC sphrm_ProjectGroupInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	
	select A.*,D.DepartmentName,
	case A.IsDepartment when 'Y' then N'Хамаарна' else N'Хамаарахгүй' end as Department from hrmProjectGroupInfo A
	left join hrmDepartmentInfo D on A.DepartmentPkID=D.DepartmentPkID
	order by A.SortedOrder
	
END

GO
