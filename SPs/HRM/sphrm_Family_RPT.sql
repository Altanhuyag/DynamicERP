IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Family_RPT')
DROP PROC sphrm_Family_RPT
GO
CREATE PROC sphrm_Family_RPT
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
			@EmployeeInfoPkID			nvarchar(16),
			@Condition			nvarchar(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(250),
				EmployeeInfoPkID			nvarchar(16),
				Condition			nvarchar(1)	)
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DepartmentPkID=DepartmentPkID, @EmployeeInfoPkID=EmployeeInfoPkID, @Condition=Condition	FROM #tmp
	
	IF @Condition = '*'

	
	SELECT A.EmployeeInfoPkID, A.PhoneNum, A.Location, A.FirstName as FName, A.LastName as LName, A.JobAddress, B.FirstName, B.LastName, B.DepartmentName, C.FamilyMemberName FROM hrmFamily A
		LEFT JOIN (SELECT A.EmployeeInfoPkID, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID) B 
				ON A.EmployeeInfoPkID=B.DepartmentPkID
		LEFT JOIN hrmFamilyMemberInfo C ON A.FamilyMemberPkID=C.FamilyMemberPkID

	IF @Condition = '-'

		SELECT A.EmployeeInfoPkID, A.PhoneNum, A.Location, A.FirstName as FName, A.LastName as LName, A.JobAddress, B.FirstName, B.LastName, B.DepartmentName, C.FamilyMemberName FROM hrmFamily A
		LEFT JOIN (SELECT A.EmployeeInfoPkID, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID) B 
				ON A.EmployeeInfoPkID=B.EmployeeInfoPkID
		LEFT JOIN hrmFamilyMemberInfo C ON A.FamilyMemberPkID=C.FamilyMemberPkID
		WHERE B.DepartmentPkID=@DepartmentPkID

	IF @Condition = '+'

		SELECT A.EmployeeInfoPkID, A.PhoneNum, A.Location, A.FirstName as FName, A.LastName as LName, A.JobAddress, B.FirstName, B.LastName, B.DepartmentName, C.FamilyMemberName FROM hrmFamily A
		LEFT JOIN (SELECT A.EmployeeInfoPkID, A.LastName, A.FirstName, A.DepartmentPkID, B.DepartmentName 
					FROM hrmEmployeeInfo A
					INNER JOIN hrmDepartmentInfo B ON A.DepartmentPkID=B.DepartmentPkID) B 
				ON A.EmployeeInfoPkID=B.EmployeeInfoPkID
		LEFT JOIN hrmFamilyMemberInfo C ON A.FamilyMemberPkID=C.FamilyMemberPkID
		WHERE B.EmployeeInfoPkID=@EmployeeInfoPkID

END
GO
