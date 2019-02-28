IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeSearch_PARA')
DROP PROC sphrm_EmployeeSearch_PARA
GO
CREATE PROC sphrm_EmployeeSearch_PARA
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE 
		@idoc				Int,
		@RegisterNo			nvarchar(16),
		@FirstName			nvarchar(150),
		@LastName			nvarchar(150),
		@HandPhone			nvarchar(50),
		@QueryString		nvarchar(MAX),
		@YearPkID			nvarchar(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	set @QueryString='SELECT A.*, B.NationalityName, C.AimagName, D.PositionName, E.ProfessionName, 
	F.EducationName, G.DepartmentName,CC.ValueStr1 as MaleName  FROM hrmEmployeeInfo A
	LEFT JOIN hrmNationalityInfo B ON A.NationalityPkID=B.NationalityPkID
	LEFT JOIN hrmAimagInfo C ON A.AimagID=C.AimagID
	left join (select * from smmConstants where ConstType=''hrmMaleInfo'') as CC on A.Gender = CC.ConstKey
	LEFT JOIN hrmPositionInfo D ON A.PositionPkID=D.PositionPkID
	LEFT JOIN hrmProfessionInfo E ON A.ProfessionPkID=E.ProfessionPkID
	LEFT JOIN hrmEducationInfo F ON A.EducationPkID=F.EducationPkID
	LEFT JOIN hrmDepartmentInfo G ON A.DepartmentPkID=G.DepartmentPkID and A.YearPkID = G.YearPkID
	where A.YearPkID = '''+@YearPkID+''''

	if (ISNULL(@XML,'')<>'')
	BEGIN	
		EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
		
		SELECT * INTO #tmp
			FROM OPENXML (@idoc,'//BusinessObject',2)
			WITH (
			 				RegisterNo			nvarchar(16),
							FirstName			nvarchar(150),
							LastName			nvarchar(150),
							HandPhone			nvarchar(50)	  			  			  
				  )
						
		EXEC sp_xml_removedocument @idoc
		
		SELECT	
					
				@RegisterNo = isnull(RegisterNo,'')				,
				@FirstName = isnull(FirstName,''),
				@LastName = isnull(LastName,''),
				@HandPhone = isnull(HandPhone,'')
				
		FROM #tmp	
	
		if (LEN(isnull(@RegisterNo,''))<>0)
			SET @QueryString = @QueryString + ' and A.RegisterNo like N'''+@RegisterNo+'%''' 
		if (LEN(isnull(@FirstName,''))<>0)
				SET @QueryString = @QueryString + ' and A.FirstName like N'''+@FirstName+'%'''
		if (LEN(isnull(@LastName,''))<>0)
				SET @QueryString = @QueryString + ' and A.LastName like N'''+@LastName+'%'''
		if (LEN(isnull(@HandPhone,''))<>0)
				SET @QueryString = @QueryString + ' and A.HandPhone like N'''+@HandPhone+'%'''
		
		--raiserror(@QueryString,16,1)	
		SET @QueryString = @QueryString + ' order by A.FirstName'	
	END
	exec(@QueryString)
	

	
	
	
	
END
GO
