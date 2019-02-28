IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Employee_DASH')
DROP PROC sphrm_Employee_DASH
GO

CREATE PROC sphrm_Employee_DASH
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	declare 
	@Cnt decimal,
	@YearPkID nvarchar(16)

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID = 'YearPkID'

	set @Cnt=0

	select @Cnt = count(*) from hrmEmployeeInfo
	where YearPkID = @YearPkID
	and Status=1

	select count(*) as cnt from hrmEmployeeInfo
	where Status=1 and YearPkID = @YearPkID
	
	
	select A.MaleCnt/@Cnt * 100  as MaleCnt, A.FeMaleCnt /@Cnt * 100 as FeMaleCnt,
	case when A.FeMaleCnt>A.MaleCnt then Convert(decimal,A.FeMaleCnt)/Convert(decimal,A.MaleCnt) 
	else Convert(decimal,A.MaleCnt)/Convert(decimal,A.FeMaleCnt) end
	 as MalePro 
	from (select sum(case when Gender=0 then 1 else 0 end) as MaleCnt,
		   sum(case when Gender=1 then 1 else 0 end) as FeMaleCnt from hrmEmployeeInfo
	where Status=1 and YearPkID = @YearPkID) A

	select MIN(Year(getdate())-Year(BirthDay)) AgeMin,MAX(Year(getdate())-Year(BirthDay)) AgeMax,AVG(Year(getdate())-Year(BirthDay)) AgeAvg from hrmEmployeeInfo
	where Status=1 and YearPkID = @YearPkID

	--Байршлаар 
	select top 5 BirthAimagID,BirthSumID,AI.AimagName,SI.SumName,count(*) Cnt from hrmEmployeeInfo A
	inner join hrmAimagInfo AI on A.BirthAimagID = AI.AimagID
	inner join hrmSumInfo SI on A.BirthAimagID = SI.AimagID and A.BirthSumID = SI.SumID
	where BirthAimagID is not null
	and BirthSumID is not null
	and Status=1 and YearPkID = @YearPkID
	group by BirthAimagID,BirthSumID,AI.AimagName,SI.SumName
	order by count(*) desc
	
	--Bolovsroloor
	select A.EducationName,A.Cnt/@Cnt * 100 as Cnt from (
	select A.EducationPkID,EI.EducationName,count(*) Cnt from hrmEmployeeInfo A
	inner join hrmEducationInfo EI on A.EducationPkID = EI.EducationPkID
	where A.EducationPkID is not null
	and Status=1 and YearPkID = @YearPkID
	group by A.EducationPkID,EI.EducationName

	union all

	select EducationPkID,EducationName,0 Cnt from hrmEducationInfo
	where EducationPkID not in (select A.EducationPkID from hrmEmployeeInfo A
								where A.EducationPkID is not null
								and Status=1 and YearPkID = @YearPkID
								group by A.EducationPkID
								)
								) A

	--Surguiliar
	select  top 5 A.EducationCountryID,A.UniversityPkID,CI.CountryName,UI.UniversityName,count(*) Cnt from hrmEmployeeInfo A
	inner join hrmCountryInfo CI on CI.CountryID = A.EducationCountryID
	inner join hrmUniversityInfo UI on A.UniversityPkID = UI.UniversityPkID and UI.CountryID = A.EducationCountryID
	where A.EducationCountryID is not null
	and A.UniversityPkID is not null
	and Status = 1 and YearPkID = @YearPkID
	group by EducationCountryID,A.UniversityPkID ,CI.CountryName,UI.UniversityName
	order by  count(*) desc

	--Surguiliar
	select  top 5 A.EducationCountryID,CI.CountryName,count(*) Cnt from hrmEmployeeInfo A
	inner join hrmCountryInfo CI on CI.CountryID = A.EducationCountryID
	where A.EducationCountryID is not null
	and A.UniversityPkID is not null
	and Status = 1 and YearPkID = @YearPkID
	group by EducationCountryID ,CI.CountryName
	order by  count(*) desc

	--Мэргэжил
	select  top 5 PI.ProfessionName,count(*) Cnt from hrmEmployeeInfo A
	inner join hrmProfessionInfo PI on PI.ProfessionPkID= A.ProfessionPkID
	where A.ProfessionPkID is not null
	and Status = 1 and YearPkID = @YearPkID
	group by EducationCountryID ,PI.ProfessionName
	order by  count(*) desc

	--ОРон сууцны нөхцөл
	select HouseName,A.Cnt/@Cnt * 100 as Cnt from (
	select ValueStr1 as HouseName,count(*) cnt from hrmEmployeeInfo A
	inner join (select * from smmConstants where ConstType='hrmHouseType' ) B on A.HouseType = B.ValueNum
	where A.Status = 1 and YearPkID = @YearPkID
	group by ValueStr1 ) A

	--Цаг ашиглалт Хэлтэсээр
	select top 5 DI.DepartmentName,
	dbo.fntsh_MinToTime(
	sum(
	case  when ReasonID<>'' then 0 
	else
		case 
		when A.InCheckTime<>'' then 
			case when (dbo.fntsh_TimeToMin(A.InCheckTime)-dbo.fntsh_TimeToMin('08:30'))>0 then 
				dbo.fntsh_TimeToMin(A.InCheckTime)-dbo.fntsh_TimeToMin('08:30') 
			else 
				0
			end
		
		else 
			0
		end
		+
		case 
		when A.OutCheckTime<>'' then 
			case when (dbo.fntsh_TimeToMin('17:30')  - dbo.fntsh_TimeToMin(A.OutCheckTime))>0 then 
			dbo.fntsh_TimeToMin('17:30')  - dbo.fntsh_TimeToMin(A.OutCheckTime)
			else 
			0
			end		
		else 
			0
		end
	end
	)
	) as LateTimeMin from tshMachineDataCalc A
	inner join tshEnrollUser EU on A.EnrollUserID = EU.EnrollUserID
	inner join hrmEmployeeInfo EI on EU.RegisterNo = EI.RegisterNo
	inner join hrmDepartmentInfo DI on EI.DepartmentPkID = DI.DepartmentPkID
	where month(Convert(datetime,InCheckDate)) = month(getdate())
	group by DI.DepartmentName
	order by (sum(
	case when ReasonID<>'' then 0 
	else
		case 
		when A.InCheckTime<>'' then 
			case when (dbo.fntsh_TimeToMin(A.InCheckTime)-dbo.fntsh_TimeToMin('08:30'))>0 then 
				dbo.fntsh_TimeToMin(A.InCheckTime)-dbo.fntsh_TimeToMin('08:30') 
			else 
				0
			end
		
		else 
			0
		end
		+
		case 
		when A.OutCheckTime<>'' then 
			case when (dbo.fntsh_TimeToMin('17:30')  - dbo.fntsh_TimeToMin(A.OutCheckTime))>0 then 
			dbo.fntsh_TimeToMin('17:30')  - dbo.fntsh_TimeToMin(A.OutCheckTime)
			else 
			0
			end		
		else 
			0
		end
	end)) desc

	--Цаг ашиглалт Ажилчдаар
	select top 5 substring(EI.LastName,1,1) + '.'+EI.FirstName as EmployeeName,
	dbo.fntsh_MinToTime(
	sum(
	case when ReasonID<>'' then 0 
	else 
		case 
		when A.InCheckTime<>'' then 
			case when (dbo.fntsh_TimeToMin(A.InCheckTime)-dbo.fntsh_TimeToMin('08:30'))>0 then 			
				dbo.fntsh_TimeToMin(A.InCheckTime)-dbo.fntsh_TimeToMin('08:30') 
			else 
				0
			end		
		else 
			0
		end
		+
		case 
		when A.OutCheckTime<>'' then 
			case when (dbo.fntsh_TimeToMin('17:30')  - dbo.fntsh_TimeToMin(A.OutCheckTime))>0 then 
			dbo.fntsh_TimeToMin('17:30')  - dbo.fntsh_TimeToMin(A.OutCheckTime)
			else 
			0
			end		
		else 
			0
		end
	end	
	)
	) as LateTimeMin from tshMachineDataCalc A
	inner join tshEnrollUser EU on A.EnrollUserID = EU.EnrollUserID
	inner join hrmEmployeeInfo EI on EU.RegisterNo = EI.RegisterNo	
	where month(Convert(datetime,InCheckDate)) = month(getdate())
	group by substring(EI.LastName,1,1) + '.'+EI.FirstName
	order by (sum(case when ReasonID<>'' then 0 
	else 
		case 
		when A.InCheckTime<>'' then 
			case when (dbo.fntsh_TimeToMin(A.InCheckTime)-dbo.fntsh_TimeToMin('08:30'))>0 then 			
				dbo.fntsh_TimeToMin(A.InCheckTime)-dbo.fntsh_TimeToMin('08:30') 
			else 
				0
			end		
		else 
			0
		end
		+
		case 
		when A.OutCheckTime<>'' then 
			case when (dbo.fntsh_TimeToMin('17:30')  - dbo.fntsh_TimeToMin(A.OutCheckTime))>0 then 
			dbo.fntsh_TimeToMin('17:30')  - dbo.fntsh_TimeToMin(A.OutCheckTime)
			else 
			0
			end		
		else 
			0
		end
	end	)) desc

	--Илүү цаг Хэлтэсээр
	select top 5 DI.DepartmentName,
	dbo.fntsh_MinToTime(sum(dbo.fntsh_TimeToMin(A.OutCheckTime)-dbo.fntsh_TimeToMin('17:30'))) as ExtraTime from tshMachineDataCalc A
	inner join tshEnrollUser EU on A.EnrollUserID = EU.EnrollUserID
	inner join hrmEmployeeInfo EI on EU.RegisterNo = EI.RegisterNo
	inner join hrmDepartmentInfo DI on EI.DepartmentPkID = DI.DepartmentPkID
	where month(Convert(datetime,InCheckDate)) = month(getdate())
	and A.OutCheckTime<>''
	and A.OutCheckTime>'17:30'
	group by DI.DepartmentName
	order by (sum(dbo.fntsh_TimeToMin(A.OutCheckTime)-dbo.fntsh_TimeToMin('17:30'))) desc

	--Илүү цаг Ажилчдаар
	select top 5 substring(EI.LastName,1,1) + '.'+EI.FirstName as EmployeeName,dbo.fntsh_MinToTime(sum(dbo.fntsh_TimeToMin(A.OutCheckTime)-dbo.fntsh_TimeToMin('17:30'))) as ExtraTime from tshMachineDataCalc A
	inner join tshEnrollUser EU on A.EnrollUserID = EU.EnrollUserID
	inner join hrmEmployeeInfo EI on EU.RegisterNo = EI.RegisterNo	
	where month(Convert(datetime,InCheckDate)) = month(getdate())
	and A.OutCheckTime<>''
	and A.OutCheckTime>'17:30'
	group by substring(EI.LastName,1,1) + '.'+EI.FirstName
	order by (sum(dbo.fntsh_TimeToMin(A.OutCheckTime)-dbo.fntsh_TimeToMin('17:30'))) desc
END
GO
