IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_RetiredEmployee_UPD')
DROP PROC sphrm_RetiredEmployee_UPD
GO
CREATE PROC sphrm_RetiredEmployee_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,
			@Adding						TinyInt,
			@RetiredEmployeePkID		nvarchar(16) ,
			@EmployeeInfoPkID					nvarchar(16) ,
			@CommandNo					nvarchar(16),
			@CommandDate				datetime,
			@Age						int,
			@IsAbNormal					nvarchar(1),
			@Descr						nvarchar(255),
			@UserName	    nvarchar(16)	,
			@YearPkID nvarchar(16)			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( Adding					TinyInt,
			RetiredEmployeePkID			nvarchar(16) ,
			EmployeeInfoPkID		            nvarchar(16) ,
			CommandNo					nvarchar(16),
			CommandDate					datetime,
			Age							int,
			IsAbNormal					nvarchar(1),
			RetiredDate					datetime ,
			Descr						nvarchar(255),
			UserName	    nvarchar(16))
	EXEC sp_xml_removedocument @idoc	

	
	SELECT	@Adding	=Adding,					
			@RetiredEmployeePkID=RetiredEmployeePkID,		
			@EmployeeInfoPkID = EmployeeInfoPkID,
			@CommandNo=CommandNo,
			@CommandDate=CommandDate,	
			@Age	= Age,	
			@IsAbNormal=isnull(IsAbNormal,'N'),	
			@Descr=isnull(Descr,''),		
			@UserName=UserName		
						
	FROM #tmp
   select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmRetiredEmployee', @RetiredEmployeePkID output

		INSERT INTO hrmRetiredEmployee(
			RetiredEmployeePkID	 ,
			EmployeeInfoPkID	 ,
			CommandNo			,
			CommandDate		,
			Age				,
			IsAbNormal			,
			Descr				,
			UserName	)
		VALUES (
			@RetiredEmployeePkID		 ,
			@EmployeeInfoPkID	 ,
			@CommandNo		,
			@CommandDate			,
			@Age				,
			@IsAbNormal		,
			@Descr			,
			@UserName	)
	END
	ELSE
		UPDATE hrmRetiredEmployee
		SET 
			UserName	 =@UserName,
			EmployeeInfoPkID			=@EmployeeInfoPkID,
			CommandNo			=@CommandNo,
			CommandDate			=@CommandDate,
			Age					=@Age,
			IsAbNormal			=@IsAbNormal	,
			Descr				=@Descr	

		WHERE RetiredEmployeePkID=@RetiredEmployeePkID
	
		update hrmEmployeeInfo
		set Status=3
		where EmployeeInfoPkID=@EmployeeInfoPkID and YearPkID = @YearPkID
		
END
GO
