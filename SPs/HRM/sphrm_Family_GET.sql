IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Family_GET')
DROP PROC sphrm_Family_GET
GO
CREATE PROC sphrm_Family_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@FamilyPkID	nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  FamilyPkID		nvarchar(16))

	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@FamilyPkID=FamilyPkID	FROM #tmp
	
	select A.*,C.FirstName as FirstName1, B.FamilyMemberName,D.DepartmentName,P.PositionName,YEAR(getdate())-YEAR(A.BirthDay) as Age from hrmFamily A
	left join hrmFamilyMemberInfo B on A.FamilyMemberPkID=B.FamilyMemberPkID
	left join hrmEmployeeInfo C on A.EmployeeInfoPkID=C.EmployeeInfoPkID
	left join hrmDepartmentInfo D on C.DepartmentPkID=D.DepartmentPkID
	left join hrmPositionInfo P on C.PositionPkID=P.PositionPkID	
	WHERE A.FamilyPkID=@FamilyPkID
	
end
GO
