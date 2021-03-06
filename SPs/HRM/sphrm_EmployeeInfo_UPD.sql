﻿IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfo_UPD')
DROP PROC sphrm_EmployeeInfo_UPD
GO
CREATE PROC sphrm_EmployeeInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @idoc					Int,
			@Adding					TinyInt,
			@EmployeeInfoPkID		nvarchar(16),
			@YearPkID				nvarchar(16),
			@RegisterNo				nvarchar(50),
			@FirstName				nvarchar(50),
			@LastName				nvarchar(50),
			@Birthday				DateTime,
			@NationalityPkID		nvarchar(50),
			@FamilySurname			nvarchar(50),
			@AimagID				nvarchar(50),
			@BirthAimak				nvarchar(50),
			@Gender					nvarchar(10),
			@CountryID				nvarchar(16),
			@thisWeight				nvarchar(50),
			@thisHeight				nvarchar(50),
			@EducationCountryID		nvarchar(16),
			@UniversityPkID			nvarchar(16),
			@DegreeInfoPkID			nvarchar(16),			
			@WeightAndHeight		nvarchar(50),
			@Deduce					nvarchar(50),
			@BloodGroup				nvarchar(10),
			@IsMarred				nchar(1),
			@HouseType				nvarchar(16),
			@IsCar					nchar(1),
			@EnterWorkDate			datetime,
			@PositionPkID			nvarchar(16),
			@PositionGroupPkID		nvarchar(16),
			@NowEnterPositionDate	datetime,
			@ProfessionPkID			nvarchar(16),
			@EducationPkID			nvarchar(16),
			@WorkedYear				Int,
			@WorkedMonth			Int,
			@WorkFixedDate			datetime,
			@FamilyCount			Int,
			@ActualEnterJobDate		datetime,
			@IsPositionProfessional	nchar(1),
			@IsMainWorker			nchar(1),
			@WorkingAgreementNo		nvarchar(50),
			@WorkingStartDate		datetime,
			@WorkingFinishDate		datetime,
			@PassportNo				nvarchar(50),
			@EPassportNo			nvarchar(50),
			@DriveCertifyNo			nvarchar(50),
			@JobCertifyNo			nvarchar(50),
			@NDDNo					nvarchar(50),
			@EMDNo					nvarchar(50),
			@BankID					nvarchar(16),		
			@HomePhone				nvarchar(50),
			@HandPhone				nvarchar(50),
			@JobPhoneOut			nvarchar(50),
			@JobPhoneIn				nvarchar(50),
			@Email					nvarchar(50),
			@PrivateEmail			nvarchar(50),
			@Address				nvarchar(255),			
			@CreatedProgID			nvarchar(10),
			@WorkingStatusID		nvarchar(3),
			@SalaryTypeID			nvarchar(3),
			@DepartmentPkID			nvarchar(16),
			@Status					nchar(1),
			@SafetyWorking			DateTime,
			@IUAddress				nvarchar(255),
			@InCode					nvarchar(16),
			@BirthAimagID	nvarchar(16),
			@BirthSumID	nvarchar(16),
			@CustomerPkID		NVARCHAR(16),
			@CustomerID			NVARCHAR(50),
			@GroupPkID			nvarchar(16),
			@CustomerName		nvarchar(250),
			@SequenceNo			int,			
			@RegNo				nvarchar(10),			
			@DepartmentName		nvarchar(250),			
			@Phone				nvarchar(50),
			@Fax				nvarchar(50),			
			@SignFile			nvarchar(75),
			@PhotoFile			nvarchar(75),
			@VATID				nvarchar(75),
			@IsVAT				nvarchar(1),			
			@CreatedDate		datetime,
			@LastUpdate			datetime,
			@LastUserName		NVARCHAR(30),			
			@IPAddress			NVARCHAR(30),
			@MACAddress			nvarchar(50),
			@EnrollUserID		int,
			@SalaryAmt			money,
			@SalaryCardNo		nvarchar(50),
			@Benefit			nvarchar(1),
			@ContactFirstName	nvarchar(50),
			@ContactPhoneNo		nvarchar(50),
			@ContactFirstName1	nvarchar(50),
			@ContactPhoneNo1	nvarchar(50),
			@ContactFirstName2	nvarchar(50),
			@ContactPhoneNo2	nvarchar(50),
			@IsMilitary			nvarchar(1),
			@LocationCodePkID	nvarchar(16),
			@IsTimeAuto			nvarchar(1),
			@TotalWorkedYear	int

			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				EmployeeInfoPkID		nvarchar(16),
				RegisterNo				nvarchar(50),
				FirstName				nvarchar(50),
				LastName				nvarchar(50),
				Birthday				DateTime,
				NationalityPkID			nvarchar(50),
				FamilySurname			nvarchar(50),
				AimagID					nvarchar(50),
				BirthAimak				nvarchar(50),
				Gender					nvarchar(10),
				CountryID				nvarchar(16),
				thisWeight				nvarchar(50),
				thisHeight				nvarchar(50),
				EducationCountryID		nvarchar(16),
				UniversityPkID			nvarchar(16),
				DegreeInfoPkID			nvarchar(16),
				WeightAndHeight			nvarchar(50),
				Deduce					nvarchar(50),
				BloodGroup				nvarchar(10),
				IsMarred				nchar(1),
				HouseType				nvarchar(16),
				IsCar					nchar(1),
				EnterWorkDate			datetime,
				PositionPkID			nvarchar(16),
				PositionGroupPkID		nvarchar(16),
				NowEnterPositionDate	datetime,
				ProfessionPkID			nvarchar(16),
				EducationPkID			nvarchar(16),
				WorkedYear				Int,
				WorkedMonth				Int,
				WorkFixedDate			datetime,
				FamilyCount				Int,
				ActualEnterJobDate		datetime,
				IsPositionProfessional	nchar(1),
				IsMainWorker			nchar(1),
				WorkingAgreementNo		nvarchar(50),
				WorkingStartDate		datetime,
				WorkingFinishDate		datetime,
				PassportNo				nvarchar(50),
				EPassportNo				nvarchar(50),
				DriveCertifyNo			nvarchar(50),
				JobCertifyNo			nvarchar(50),
				NDDNo					nvarchar(50),
				EMDNo					nvarchar(50),
				BankID					nvarchar(16),
				HomePhone				nvarchar(50),
				HandPhone				nvarchar(50),
				JobPhoneOut				nvarchar(50),
				JobPhoneIn				nvarchar(50),
				Email					nvarchar(50),
				PrivateEmail			nvarchar(50),
				Address					nvarchar(255),				
				CreatedProgID			nvarchar(10),
				WorkingStatusID			nvarchar(3),
				SalaryTypeID			nvarchar(3),
				DepartmentPkID			nvarchar(16),
				Status					nchar(1),
				SafetyWorking			DateTime,
				IUAddress				nvarchar(255),
				InCode					nvarchar(16),
				BirthAimagID	nvarchar(16),
				BirthSumID	nvarchar(16),
				EnrollUserID			int,
				SalaryAmt				money,
				SalaryCardNo			nvarchar(50),
				Benefit					nvarchar(1),
				ContactFirstName	nvarchar(50),
				ContactPhoneNo	nvarchar(50),
				ContactFirstName1	nvarchar(50),
				ContactPhoneNo1	nvarchar(50),
				ContactFirstName2	nvarchar(50),
				ContactPhoneNo2	nvarchar(50),
				IsMilitary			nvarchar(1),
				LocationCodePkID	nvarchar(16),
				IsTimeAuto			nvarchar(1),
				TotalWorkedYear		int

				)
	EXEC sp_xml_removedocument @idoc 	

	SET @YearPkID=''
	SELECT		@Adding = Adding,
				@RegisterNo = RegisterNo,
				@EmployeeInfoPkID = EmployeeInfoPkID,
				@FirstName = FirstName,
				@LastName = LastName,
				@Birthday = Birthday,
				@NationalityPkID = NationalityPkID,
				@FamilySurname = FamilySurname,
				@AimagID = AimagID,
				@BirthAimak = isnull(BirthAimak,''),
				@Gender = Gender,
				@EducationCountryID = EducationCountryID,
				@UniversityPkID = UniversityPkID,
				@DegreeInfoPkID = DegreeInfoPkID,
				@CountryID = CountryID,
				@thisWeight = thisWeight,
				@thisHeight = thisHeight,
				@WeightAndHeight = WeightAndHeight,
				@Deduce = Deduce,
				@BloodGroup = BloodGroup,
				@IsMarred = IsMarred,
				@HouseType = HouseType,
				@IsCar = IsCar,
				@EnterWorkDate = isnull(EnterWorkDate,getdate()),
				@PositionPkID = PositionPkID,
				@PositionGroupPkID = PositionGroupPkID,
				@NowEnterPositionDate = NowEnterPositionDate,
				@ProfessionPkID = ProfessionPkID,
				@EducationPkID = EducationPkID,
				@WorkedYear = WorkedYear,
				@WorkedMonth = WorkedMonth,
				@WorkFixedDate = isnull(WorkFixedDate,getdate()),
				@FamilyCount = FamilyCount,
				@ActualEnterJobDate = isnull(ActualEnterJobDate,getdate()),
				@IsPositionProfessional = IsPositionProfessional,
				@IsMainWorker = IsMainWorker,
				@WorkingAgreementNo = isnull(WorkingAgreementNo,''),
				@WorkingStartDate = isnull(WorkingStartDate,getdate()),
				@WorkingFinishDate = isnull(WorkingFinishDate,getdate()),
				@PassportNo = isnull(PassportNo,''),
				@EPassportNo = isnull(EPassportNo,''),
				@DriveCertifyNo = isnull(DriveCertifyNo,''),
				@JobCertifyNo = isnull(JobCertifyNo,''),
				@NDDNo = isnull(NDDNo,''),
				@EMDNo = isnull(EMDNo,''),
				@BankID=isnull(BankID,''),
				@HomePhone = isnull(HomePhone,''),
				@HandPhone = isnull(HandPhone,''),
				@JobPhoneOut = JobPhoneOut,
				@JobPhoneIn = JobPhoneIn,
				@Email = isnull(Email,''),
				@PrivateEmail = isnull(PrivateEmail,''),
				@Address = Address,				
				@CreatedProgID = CreatedProgID,
				@WorkingStatusID = WorkingStatusID,
				@SalaryTypeID = SalaryTypeID,
				@DepartmentPkID = DepartmentPkID,
				@Status = Status,
				@SafetyWorking=SafetyWorking,
				@IUAddress = isnull(IUAddress,''),
				@InCode = ISNULL(InCode,''),
				@BirthAimagID = BirthAimagID,
				@BirthSumID = BirthSumID,
				@EnrollUserID = ISNULL(EnrollUserID,''),
				@SalaryAmt = ISNULL(SalaryAmt,0),
				@SalaryCardNo = SalaryCardNo,
				@Benefit = Benefit,
				@ContactFirstName=ContactFirstName,
				@ContactPhoneNo=ContactPhoneNo,
				@ContactFirstName1=ContactFirstName1,
				@ContactPhoneNo1=ContactPhoneNo1,
				@ContactFirstName2=ContactFirstName2,
				@ContactPhoneNo2=ContactPhoneNo2,
				@IsMilitary=IsMilitary,
				@LocationCodePkID = LocationCodePkID,
				@IsTimeAuto = isnull(IsTimeAuto,'N'),
				@TotalWorkedYear = isnull(TotalWorkedYear,0)

	FROM #tmp
   	
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	
	--2 Халагдсан
			-- 3 Тэтгэвэрт гарсан
			-- 5 Жирэмсэний амралт
			IF (@Status=2 or @Status=3 or @Status=5)
			BEGIN
				RAISERROR (N'Та уг ажилтны төлвийг ашиглан ажилтныг үүсгэх боломжгүй гэдгийг анхаарна уу. Төлөв: Халагдсан, Тэтгэвэрт гарсан, Жирэмсэний амралт', 16, 1)
				RETURN (1)
			END

	IF @Adding=0 BEGIN
		

		IF (SELECT COUNT(*) FROM hrmEmployeeInfo WHERE RegisterNo=@RegisterNo and YearPkID = @YearPkID) > 0
			BEGIN
 				RAISERROR (N'Регистрийн дугаар давхардаж байна !', 16, 1)
				RETURN (1)
			END
			
		
		EXEC spsmm_LastSequence_SEL 'hrmEmployeeInfo', @EmployeeInfoPkID output

		INSERT INTO hrmEmployeeInfo(
									EmployeeInfoPkID,
									YearPkID,
									RegisterNo,
									FirstName,
									LastName,
									Birthday,
									NationalityPkID,
									FamilySurname,
									AimagID,
									BirthAimak,
									Gender,
									CountryID,
									thisWeight,
									thisHeight,
									Deduce,
									BloodGroup,
									IsMarred,
									HouseType,
									IsCar,
									EnterWorkDate,
									PositionPkID,
									PositionGroupPkID,
									NowEnterPositionDate,
									EducationCountryID,
									UniversityPkID,
									ProfessionPkID,
									EducationPkID,
									DegreeInfoPkID,
									WorkedYear,
									WorkedMonth,
									WorkFixedDate,
									FamilyCount,
									ActualEnterJobDate,
									IsPositionProfessional,
									IsMainWorker,
									PassportNo,
									EPassportNo,
									DriveCertifyNo,
									JobCertifyNo,
									NDDNo,
									EMDNo,
									BankID,
									HomePhone,
									HandPhone,
									JobPhoneOut,
									JobPhoneIn,
									Email,
									PrivateEmail,
									Address,
									CreatedProgID,
									WorkingStatusID,
									SalaryTypeID,
									DepartmentPkID,
									Status,
									SafetyWorking,
									IUAddress,
									InCode,
									SalaryCardNo,
									BirthAimagID,
									BirthSumID,
									SalaryAmt,
									Benefit,
									ContactFirstName,
									ContactPhoneNo,
									ContactFirstName1,
									ContactPhoneNo1,
									ContactFirstName2,
									ContactPhoneNo2,
									IsMilitary,
									LocationCodePkID,
									TotalWorkedYear
	
)
		VALUES (					
									@EmployeeInfoPkID,
									@YearPkID,
									@RegisterNo,
									@FirstName,
									@LastName,
									@Birthday,
									@NationalityPkID,
									@FamilySurname,
									@AimagID,
									@BirthAimak,
									@Gender,
									@CountryID,
									@thisWeight,
									@thisHeight,
									@Deduce,
									@BloodGroup,
									@IsMarred,
									@HouseType,
									@IsCar,
									@EnterWorkDate,
									@PositionPkID,
									@PositionGroupPkID,
									@NowEnterPositionDate,
									@EducationCountryID,
									@UniversityPkID,
									@ProfessionPkID,
									@EducationPkID,
									@DegreeInfoPkID,
									@WorkedYear,
									@WorkedMonth,
									@WorkFixedDate,
									@FamilyCount,
									@ActualEnterJobDate,
									@IsPositionProfessional,
									@IsMainWorker,
									@PassportNo,
									@EPassportNo,
									@DriveCertifyNo,
									@JobCertifyNo,
									@NDDNo,
									@EMDNo,
									@BankID,
									@HomePhone,
									@HandPhone,
									@JobPhoneOut,
									@JobPhoneIn,
									@Email,
									@PrivateEmail,
									@Address,
									@CreatedProgID,
									@WorkingStatusID,
									@SalaryTypeID,
									@DepartmentPkID,
									@Status,
									@SafetyWorking,
									@IUAddress,
									@InCode,
									@SalaryCardNo,
									@BirthAimagID,
									@BirthSumID,
									@SalaryAmt,
									@Benefit,
									@ContactFirstName,
									@ContactPhoneNo,
									@ContactFirstName1,
									@ContactPhoneNo1,
									@ContactFirstName2,
									@ContactPhoneNo2,
									@IsMilitary,
									@LocationCodePkID,
									@TotalWorkedYear)		
									--accCustomerInfo харилцагчийн бүртгэл рүү ажилтан болгож оруулна.
		
			if (isnull(@EnrollUserID,0)>0)

			BEGIN
					delete from tshEnrollUser where RegisterNo=@RegisterNo or EnrollUserID = @EnrollUserID
				
					INSERT INTO tshEnrollUser(RegisterNo,EnrollUserID,IsTimeAuto)
					values (@RegisterNo,CONVERT(int,@EnrollUserID),@IsTimeAuto)		
				SET @EnrollUserID=0
			END
	END
	ELSE 
	 BEGIN
		UPDATE	hrmEmployeeInfo
		SET		
				FirstName = @FirstName,
				LastName = @LastName,
				Birthday = @Birthday,
				NationalityPkID = @NationalityPkID,
				FamilySurname = @FamilySurname,
				AimagID = @AimagID,
				RegisterNo = @RegisterNo,
				BirthAimak = @BirthAimak,
				Gender = @Gender,
				CountryID = @CountryID,
				EducationCountryID=@EducationCountryID,
				UniversityPkID = @UniversityPkID,
				DegreeInfoPkID = @DegreeInfoPkID,
				thisWeight = @thisWeight,
				thisHeight = @thisHeight,
				Deduce = @Deduce,
				Benefit = @Benefit,
				BloodGroup = @BloodGroup,
				IsMarred = @IsMarred,
				HouseType = @HouseType,
				IsCar = @IsCar,
				EnterWorkDate = @EnterWorkDate,
				PositionPkID = @PositionPkID,
				PositionGroupPkID = @PositionGroupPkID,
				NowEnterPositionDate = @NowEnterPositionDate,
				ProfessionPkID = @ProfessionPkID,
				EducationPkID = @EducationPkID,
				WorkedYear = @WorkedYear,
				WorkedMonth = @WorkedMonth,
				WorkFixedDate = @WorkFixedDate,
				FamilyCount = @FamilyCount,
				ActualEnterJobDate = @ActualEnterJobDate,
				IsPositionProfessional = @IsPositionProfessional,
				IsMainWorker = @IsMainWorker,
				PassportNo = @PassportNo,
				EPassportNo = @EPassportNo,
				DriveCertifyNo = @DriveCertifyNo,
				JobCertifyNo = @JobCertifyNo,
				NDDNo = @NDDNo,
				EMDNo = @EMDNo,
				BankID = @BankID,
				HomePhone = @HomePhone,
				HandPhone = @HandPhone,
				JobPhoneOut = @JobPhoneOut,
				JobPhoneIn = @JobPhoneIn,
				Email = @Email,
				PrivateEmail = @PrivateEmail,
				Address = @Address,				
				WorkingStatusID = @WorkingStatusID,
				SalaryTypeID = @SalaryTypeID,
				DepartmentPkID = @DepartmentPkID,
				Status = @Status,
				SafetyWorking=@SafetyWorking	,
				IUAddress = @IUAddress,
				InCode = @InCode,
				BirthAimagID = @BirthAimagID,
				BirthSumID = @BirthSumID,
				SalaryAmt = @SalaryAmt,
				SalaryCardNo = @SalaryCardNo,
				ContactFirstName=@ContactFirstName,
				ContactPhoneNo=@ContactPhoneNo,
				ContactFirstName1=@ContactFirstName1,
				ContactPhoneNo1=@ContactPhoneNo1,
				ContactFirstName2=@ContactFirstName2,
				ContactPhoneNo2=@ContactPhoneNo2,
				IsMilitary=@IsMilitary,
				LocationCodePkID = @LocationCodePkID,
				TotalWorkedYear = @TotalWorkedYear
				
		WHERE	EmployeeInfoPkID=@EmployeeInfoPkID
		and YearPkID = @YearPkID
				
		if (isnull(@EnrollUserID,0)>0)
		BEGIN
				delete from tshEnrollUser where EnrollUserID=@EnrollUserID or RegisterNo = @RegisterNo
				
				INSERT INTO tshEnrollUser(RegisterNo,EnrollUserID,IsTimeAuto)
				values (@RegisterNo,CONVERT(int,@EnrollUserID),@IsTimeAuto)		
		END	
		ELSE
		BEGIN
				delete from tshEnrollUser where RegisterNo = @RegisterNo
		END
	END

	select @EmployeeInfoPkID as EmployeeInfoPkID
END

GO
