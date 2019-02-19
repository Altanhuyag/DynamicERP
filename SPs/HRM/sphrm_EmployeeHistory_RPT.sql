IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeHistory_RPT')
DROP PROC sphrm_EmployeeHistory_RPT
GO
CREATE PROC sphrm_EmployeeHistory_RPT
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
			@RegisterNo			nvarchar(50),
			@Condition			nvarchar(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(250)	)
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DepartmentPkID=isnull(DepartmentPkID,'')	FROM #tmp
	
	
	select A.LastName,A.FirstName,A.RegisterNo,A.NowEnterPositionDate as EnteredDate,Po.PositionName,DI.DepartmentName
	,isnull(B.CompanyJil,0) + (Year(getdate())-Year(A.EnterWorkDate))  as CompanyYear,B.CountryJil,A.WorkedYear +(Year(getdate())-Year(A.EnterWorkDate))  as CountryYear,C.NiitJIl as EventYear from hrmEmployeeInfo A
	left join hrmPositionInfo Po on A.PositionPkID = Po.PositionPkID
	left join hrmDepartmentInfo DI on A.DepartmentPkID = DI.DepartmentPkID
	left join (
				select EmployeeInfoPkID,SUM(CountryJil) as CountryJil,SUM(CompanyJil) as CompanyJil,SUM(CountryJil)+SUM(CompanyJil) as NiitJIl from
				(
				select EmployeeInfoPkID,case when IsCompany='N' then sum(DATEDIFF(YEAR,NominativeDate,RemissiveDate))  else 0 end as CountryJil,case when IsCompany='Y' then sum(DATEDIFF(YEAR,NominativeDate,RemissiveDate))  else 0 end as CompanyJil from hrmWorkingHistory
				group by EmployeeInfoPkID,IsCompany
				) A
				group by EmployeeInfoPkID
				
				) B on A.EmployeeInfoPkID = B.EmployeeInfoPkID
	left join (
			    select EmployeeInfoPkID,EventInfoPkID,SUM(CountryJil) as CountryJil,SUM(CompanyJil) as CompanyJil,SUM(CountryJil)+SUM(CompanyJil) as NiitJIl from
				(				
				select EmployeeInfoPkID,EventInfoPkID,case when IsCompany='N' then sum(DATEDIFF(YEAR,NominativeDate,RemissiveDate))  else 0 end as CountryJil,case when IsCompany='Y' then sum(DATEDIFF(YEAR,NominativeDate,RemissiveDate))  else 0 end as CompanyJil from hrmWorkingHistory
				where EventInfoPkID in (select Dep.EventInfoPkID from hrmEmployeeInfo Emp
										inner join hrmDepartmentInfo Dep on Emp.DepartmentPkID=Dep.DepartmentPkID)
				group by EmployeeInfoPkID,EventInfoPkID,IsCompany
				union all
				select EmployeeInfoPkID,Dep.EventInfoPkID,0 CountryJil,DATEDIFF(YEAR,EnterWorkDate,GETDATE()) as CompanyJil from hrmEmployeeInfo Emp
				inner join hrmDepartmentInfo Dep on Emp.DepartmentPkID=Dep.DepartmentPkID
				
				) A
				group by EmployeeInfoPkID,EventInfoPkID			
			 )	C on A.EmployeeInfoPkID = C.EmployeeInfoPkID
	where case when @DepartmentPkID='' then '' else A.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end

	
END
GO
