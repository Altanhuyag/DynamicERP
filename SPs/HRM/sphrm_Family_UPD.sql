IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Family_UPD')
DROP PROC sphrm_Family_UPD
GO
CREATE PROC sphrm_Family_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				TinyInt,
			@FamilyPkID				nvarchar(16),
			@EmployeeInfoPkID			nvarchar(16),
			@LastName			nvarchar(50),
			@FirstName			nvarchar(50),
			@BirthDay			datetime,
			@PhoneNum			nvarchar(50),
			@FamilyMemberPkID	nvarchar (16),
			@JobAddress			nvarchar(250),
			@Location			nvarchar(250),
			@FamilyRegisterNo	nvarchar(50)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding			TinyInt,
			FamilyPkID			nvarchar(16),
			EmployeeInfoPkID			nvarchar(16),
			LastName			nvarchar(50),
			FirstName			nvarchar(50),
			BirthDay			datetime,
			PhoneNum			nvarchar(50),
			FamilyMemberPkID	nvarchar (16),
			JobAddress			nvarchar(250),
			Location			nvarchar(250),
			FamilyRegisterNo	nvarchar(50)
			)
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@FamilyPkID	=FamilyPkID,
			@EmployeeInfoPkID	=EmployeeInfoPkID,
			@LastName	=LastName,
			@FirstName	=FirstName,
			@BirthDay	=BirthDay,
			@PhoneNum	=isnull(PhoneNum,'#'),
			@FamilyMemberPkID	=FamilyMemberPkID,
			@JobAddress	=JobAddress,
			@Location	=Location,
			@FamilyRegisterNo=FamilyRegisterNo
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmFamily', @FamilyPkID output

		INSERT INTO hrmFamily(
			FamilyPkID	,
			EmployeeInfoPkID	,
			LastName	,
			FirstName	,
			BirthDay	,
			PhoneNum	,
			FamilyMemberPkID	,
			JobAddress		,
			Location	,
			FamilyRegisterNo
			)
		VALUES (
			@FamilyPkID	,
			@EmployeeInfoPkID	,
			@LastName	,
			@FirstName	,
			@BirthDay	,
			@PhoneNum	,
			@FamilyMemberPkID,
			@JobAddress	,
			@Location	,
			@FamilyRegisterNo)
	END
	ELSE
		UPDATE hrmFamily
		SET 
			FamilyPkID=@FamilyPkID,
			EmployeeInfoPkID=@EmployeeInfoPkID,
			LastName=@LastName,
			FirstName=@FirstName,
			BirthDay=@BirthDay,
			PhoneNum=@PhoneNum,
			FamilyMemberPkID=@FamilyMemberPkID,
			JobAddress=@JobAddress,
			FamilyRegisterNo=@FamilyRegisterNo

		WHERE FamilyRegisterNo=@FamilyRegisterNo
END
GO
