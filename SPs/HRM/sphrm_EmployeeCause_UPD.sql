IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeCause_UPD')
DROP PROC sphrm_EmployeeCause_UPD
GO
CREATE PROC sphrm_EmployeeCause_UPD
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
			@EmployeeCausePkID	nvarchar(16),
			@EmployeeInfoPkID	nvarchar(16),
			@DocumentNo	nvarchar(16),
			@DocumentDate	datetime,
			@CommandNo	nvarchar(16),
			@CommandDate	datetime,
			@VacationDay	int,
			@StartDate	datetime,
			@StartTime	datetime,
			@FinishDate	datetime,
			@FinishTime	datetime,
			@FreedomTypePkID	nvarchar(16),
			@PatientTypePkID	nvarchar(16),
			@CountryInfoPkID	nvarchar(16),
			@AimagID	nvarchar(16),
			@SumName	nvarchar(150),
			@IsCountry	nvarchar(1),
			@IsSalary	nvarchar(1),
			@IsHumanManager	nvarchar(1),
			@IsHoliday	nvarchar(1),
			@IsAbNormal	nvarchar(1),
			@IsCustomer	nvarchar(1),
			@CustomerName	nvarchar(255),
			@HospitalName	nvarchar(150),
			@DoctorName	nvarchar(150),
			@FreedomDescr	nvarchar(255),
			@CreatedFormName	nvarchar(255),
			@EmployeeName	nvarchar(255),
			@YearPkID nvarchar(16)	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
			Adding						TinyInt,
			EmployeeCausePkID	nvarchar(16),
			EmployeeInfoPkID	nvarchar(16),
			DocumentNo	nvarchar(16),
			DocumentDate	datetime,
			CommandNo	nvarchar(16),
			CommandDate	datetime,
			VacationDay	int,
			StartDate	datetime,
			StartTime	datetime,
			FinishDate	datetime,
			FinishTime	datetime,
			FreedomTypePkID	nvarchar(16),
			PatientTypePkID	nvarchar(16),
			CountryInfoPkID	nvarchar(16),
			AimagID	nvarchar(16),
			SumName	nvarchar(150),
			IsCountry	nvarchar(1),
			IsSalary	nvarchar(1),
			IsHumanManager	nvarchar(1),
			IsHoliday	nvarchar(1),
			IsAbNormal	nvarchar(1),
			IsCustomer	nvarchar(1),
			CustomerName	nvarchar(255),
			HospitalName	nvarchar(150),
			DoctorName	nvarchar(150),
			FreedomDescr	nvarchar(255),
			CreatedFormName	nvarchar(255),
			EmployeeName	nvarchar(255)
			)
	EXEC sp_xml_removedocument @idoc	

	
	SELECT	@Adding	=Adding,					
			@EmployeeCausePkID=EmployeeCausePkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@DocumentNo=DocumentNo,
			@DocumentDate=DocumentDate,
			@CommandNo=CommandNo,
			@CommandDate=CommandDate,
			@VacationDay=VacationDay,
			@StartDate=StartDate,
			@StartTime=StartTime,
			@FinishDate=FinishDate,
			@FinishTime=FinishTime,
			@FreedomTypePkID=FreedomTypePkID,
			@PatientTypePkID=PatientTypePkID,
			@CountryInfoPkID=CountryInfoPkID,
			@AimagID=AimagID,
			@SumName=SumName,
			@IsCountry=isnull(IsCountry,'N'),
			@IsSalary=isnull(IsSalary,'N'),
			@IsHumanManager=isnull(IsHumanManager,'N'),
			@IsHoliday=isnull(IsHoliday,'N'),
			@IsAbNormal=isnull(IsAbNormal,'N'),
			@IsCustomer=isnull(IsCustomer,'N'),
			@CustomerName=CustomerName,
			@HospitalName=HospitalName,
			@DoctorName=DoctorName,
			@FreedomDescr=FreedomDescr,
			@CreatedFormName=CreatedFormName,
			@EmployeeName=EmployeeName
	
	FROM #tmp
		select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	
 IF @Adding=0 BEGIN     
		EXEC spsmm_LastSequence_SEL 'hrmEmployeeCause', @EmployeeCausePkID output

		INSERT INTO hrmEmployeeCause(
			EmployeeCausePkID,
			EmployeeInfoPkID,
			DocumentNo,
			DocumentDate,
			CommandNo,
			CommandDate,
			VacationDay,
			StartDate,
			StartTime,
			FinishDate,
			FinishTime,
			FreedomTypePkID,
			PatientTypePkID,
			CountryInfoPkID,
			AimagID,
			SumName,
			IsCountry,
			IsSalary,
			IsHumanManager,
			IsHoliday,
			IsAbNormal,
			IsCustomer,
			CustomerName,
			HospitalName,
			DoctorName,
			FreedomDescr,
			CreatedFormName,
			EmployeeName
				)
		VALUES (
			@EmployeeCausePkID,
			@EmployeeInfoPkID,
			@DocumentNo,
			@DocumentDate,
			@CommandNo,
			@CommandDate,
			@VacationDay,
			@StartDate,
			@StartTime,
			@FinishDate,
			@FinishTime,
			@FreedomTypePkID,
			@PatientTypePkID,
			@CountryInfoPkID,
			@AimagID,
			@SumName,
			@IsCountry,
			@IsSalary,
			@IsHumanManager,
			@IsHoliday,
			@IsAbNormal,
			@IsCustomer,
			@CustomerName,
			@HospitalName,
			@DoctorName,
			@FreedomDescr,
			@CreatedFormName,
			@EmployeeName)
	END
		ELSE     
		UPDATE hrmEmployeeCause
		SET 
			EmployeeInfoPkID=@EmployeeInfoPkID,
			DocumentNo=@DocumentNo,
			DocumentDate=@DocumentDate,
			CommandNo=@CommandNo,
			CommandDate=@CommandDate,
			VacationDay=@VacationDay,
			StartDate=@StartDate,
			StartTime=@StartTime,
			FinishDate=@FinishDate,
			FinishTime=@FinishTime,
			FreedomTypePkID=@FreedomTypePkID,
			PatientTypePkID=@PatientTypePkID,
			CountryInfoPkID=@CountryInfoPkID,
			AimagID=@AimagID,
			SumName=@SumName,
			IsCountry=isnull(@IsCountry,'N'),
			IsSalary=isnull(@IsSalary,'N'),
			IsHumanManager=isnull(@IsHumanManager,'N'),
			IsHoliday=isnull(@IsHoliday,'N'),
			IsAbNormal=isnull(@IsAbNormal,'N'),
			IsCustomer=isnull(@IsCustomer,'N'),
			CustomerName=@CustomerName,
			HospitalName=@HospitalName,
			DoctorName=@DoctorName,
			FreedomDescr=@FreedomDescr,
			CreatedFormName=@CreatedFormName,
			EmployeeName=@EmployeeName
		WHERE EmployeeCausePkID=@EmployeeCausePkID		

		if (@CreatedFormName = 'frmPregnant') --Жирэмсний амралт байвал
		BEGIN
			update hrmEmployeeInfo
			set Status = 5
			where EmployeeInfoPkID = @EmployeeInfoPkID and YearPkID = @YearPkID
		END
END
GO
