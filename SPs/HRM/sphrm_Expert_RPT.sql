IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Expert_RPT')
DROP PROC sphrm_Expert_RPT
GO
CREATE PROC sphrm_Expert_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@DepartmentPkID		nvarchar(250),
			@RegisterNo			nvarchar(50),
			@Condition			nvarchar(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(250)	)
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DepartmentPkID=isnull(DepartmentPkID,'')	FROM #tmp
	
	select A.ExpertPkID,EI.RegisterNo,A.Title as ExpertName,A.Organization as Location,A.InDate FinishDate,A.Period EnteredYear,A.CertNo DiplomNo,EI.LastName,EI.FirstName,Po.PositionName,DI.DepartmentName from hrmExpert A
	inner join hrmEmployeeInfo EI on A.EmployeeInfoPkID = EI.EmployeeInfoPkID
	left join hrmPositionInfo Po on EI.PositionPkID = Po.PositionPkID
	inner join hrmDepartmentInfo DI on EI.DepartmentPkID = DI.DepartmentPkID
	where  case when @DepartmentPkID='' then '' else EI.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end



END
GO
