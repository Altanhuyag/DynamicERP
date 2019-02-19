IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Family_PARA')
DROP PROC sphrm_Family_PARA
GO
create proc sphrm_Family_PARA

(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) with encryption

as

begin
SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@IsType			nvarchar(1),
			@IsEmployee		nvarchar(1),
			@IsMember		nvarchar(1),
			@DepartmentPkID	nvarchar(16),
			@FirstName		nvarchar(50),
			@FamilyMemberPkID	nvarchar(16),
			@QueryString nvarchar(max)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( IsType			nvarchar(1),
			  IsEmployee		nvarchar(1),
			IsMember		nvarchar(1),
			DepartmentPkID	nvarchar(16),
			FirstName		nvarchar(50),
			FamilyMemberPkID	nvarchar(16)
			    )
	EXEC sp_xml_removedocument @idoc

	SELECT @IsType = IsType, @IsMember = IsMember,@IsEmployee=IsEmployee,@IsMember=IsMember,
	@DepartmentPkID = DepartmentPkID,@FirstName=FirstName,@FamilyMemberPkID=FamilyMemberPkID from #tmp
	
	SET @QueryString = 'select A.*,C.FirstName as FirstName1, B.FamilyMemberName,D.DepartmentName,P.PositionName,YEAR(getdate())-YEAR(A.BirthDay) as Age from hrmFamily A
	left join hrmFamilyMemberInfo B on A.FamilyMemberPkID=B.FamilyMemberPkID
	left join hrmEmployeeInfo C on A.EmployeeInfoPkID=C.EmployeeInfoPkID
	left join hrmDepartmentInfo D on C.DepartmentPkID=D.DepartmentPkID
	left join hrmPositionInfo P on C.PositionPkID=P.PositionPkID
	where 1=1 '
	if (isnull(@IsType,'N')='Y')
		SET @QueryString = @QueryString + ' and C.DepartmentPkID = '''+@DepartmentPkID+''''
	if (ISNULL(@IsEmployee,'N') = 'Y')
	set @QueryString = @QueryString + ' and C.FirstName = N'''+@FirstName+''''
	if (ISNULL(@IsMember,'N') = 'Y')
	set @QueryString = @QueryString + ' and A.FamilyMemberPkID = '''+@FamilyMemberPkID+''''
	--raiserror(@QueryString,16,1)
	exec(@QueryString)
END
GO
