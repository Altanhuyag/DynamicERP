IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfo_GET')
DROP PROC sphrm_EmployeeInfo_GET
GO

CREATE PROC sphrm_EmployeeInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@EmployeeInfoPkID 	nvarchar(16),
			@YearPkID nvarchar(16)
	
	if (ISNULL(@XML,'')='')
		SELECT A.*,A.FirstName+'.'+SUBSTRING(A.LastName,1,1) as EmployeeName,A.PositionGroupPkID,E.EnrollUserID,D.DepartmentName FROM hrmEmployeeInfo A
		left join tshEnrollUser E on A.RegisterNo = E.RegisterNo
		left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID		
	else
	BEGIN
		
		EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
		
		SELECT * INTO #tmp
			FROM OPENXML (@idoc,'//BusinessObject',2)
			WITH (  EmployeeInfoPkID		nvarchar(50))
		
		EXEC sp_xml_removedocument @idoc
		
		SELECT @EmployeeInfoPkID=EmployeeInfoPkID FROM #tmp 
		
		select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID = 'YearPkID'

			SELECT A.EmployeeInfoPkID,
			A.YearPkID
,A.RegisterNo
,A.FirstName
,A.LastName
,isnull(A.Birthday,GETDATE()) as Birthday
,A.NationalityPkID
,A.FamilySurname
,A.AimagID
,A.BirthAimak
,A.Gender
,A.CountryID
,A.thisWeight
,A.thisHeight
,A.Deduce
,A.BloodGroup
,A.IsMarred
,A.HouseType
,A.IsCar
,A.EnterWorkDate
,A.PositionPkID
,A.NowEnterPositionDate
,A.EducationCountryID
,A.UniversityPkID
,A.ProfessionPkID
,A.EducationPkID
,A.DegreeInfoPkID
,A.WorkedYear
,A.WorkedMonth
,A.WorkFixedDate
,A.FamilyCount
,A.ActualEnterJobDate
,A.IsPositionProfessional
,A.IsMainWorker
,A.PassportNo
,A.EPassportNo
,A.DriveCertifyNo
,A.JobCertifyNo
,A.NDDNo
,A.EMDNo
,A.BankID
,A.HomePhone
,A.HandPhone
,A.JobPhoneOut
,A.JobPhoneIn
,A.Email
,A.PrivateEmail
,A.Address
,A.CreatedProgID
,A.WorkingStatusID
,A.SalaryTypeID
,A.DepartmentPkID
,A.Status
,A.IUAddress
,A.InCode
,A.SalaryCardNo
,A.BirthAimagID
,A.BirthSumID,
A.SalaryAmt,
A.Benefit,
A.ContactFirstName,
A.ContactPhoneNo,
A.ContactFirstName1,
A.ContactPhoneNo1,
A.ContactFirstName2,
A.ContactPhoneNo2,
A.IsMilitary,
A.thisHeight,
A.thisWeight,
			A.FirstName+'.'+SUBSTRING(A.LastName,1,1) as EmployeeName,A.PositionGroupPkID,B.PositionName,E.EnrollUserID,E.IsTimeAuto,D.DepartmentName
			,NI.NationalityName,AI.AimagName+' '+A.BirthAimak as AimagName,
			case when A.IsMarred='Y' then N'Тийм' else N'Үгүй' end as MarredName,DI.DeduceInfoName,
			EI.EducationName,(select EmployeePicture from hrmEmployeeImage where EmployeePkID = A.EmployeeInfoPkID) as ImageFile,
			MA.ValueStr1 MaleName,Year(getdate())-Year(A.BirthDay) as Age,
			case when DATEDIFF(month, A.ActualEnterJobDate , GETDATE()) - DATEDIFF(year, A.ActualEnterJobDate , GETDATE())*12<0 then 
				DATEDIFF(year, A.ActualEnterJobDate , GETDATE()) -1
			else 
				DATEDIFF(year, A.ActualEnterJobDate , GETDATE())
			end
			 cYear,
			 case when DATEDIFF(month, A.ActualEnterJobDate , GETDATE()) - DATEDIFF(year, A.ActualEnterJobDate , GETDATE())*12<0 then 
			 12 + (DATEDIFF(month, A.ActualEnterJobDate , GETDATE()) - DATEDIFF(year, A.ActualEnterJobDate , GETDATE())*12)
			 else 
			 DATEDIFF(month, A.ActualEnterJobDate , GETDATE()) - DATEDIFF(year, A.ActualEnterJobDate , GETDATE())*12
			 end cMonth
			 FROM hrmEmployeeInfo A
			left join hrmPositionInfo B on A.PositionPkID = B.PositionPkID
			left join tshEnrollUser E on A.RegisterNo = E.RegisterNo
			left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID
			left join hrmNationalityInfo NI on A.NationalityPkID = NI.NationalityPkID
			left join hrmAimagInfo AI on A.AimagID = AI.AimagID
			left join hrmDeduceInfo DI on A.Deduce = DI.DeduceInfoPkID
			left join hrmEducationInfo EI on A.EducationPkID = EI.EducationPkID
			left join (select * from smmConstants where ConstType='hrmMaleInfo') MA on A.Gender = MA.ValueNum
			WHERE A.EmployeeInfoPkID=@EmployeeInfoPkID
			and A.YearPkID = @YearPkID
		END
END
GO
