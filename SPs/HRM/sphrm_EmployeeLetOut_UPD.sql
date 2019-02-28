IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeLetOut_UPD')
DROP PROC sphrm_EmployeeLetOut_UPD
GO
CREATE PROC sphrm_EmployeeLetOut_UPD
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
			@EmployeeLetOutPkID	nvarchar(16),
			@CreatedDate		datetime,
			@CommandNo           nvarchar(16),
			@EmployeeInfoPkID			nvarchar(16),
			@JobExitReasonPkID  nvarchar(16),
			@UserName nvarchar(16),
			@Descr				nvarchar(255),
			@YearPkID			nvarchar(16)
				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			EmployeeLetOutPkID	nvarchar(16),
			CreatedDate			datetime,
			CommandNo           nvarchar(16),
			EmployeeInfoPkID	nvarchar(16),
			JobExitReasonPkID	nvarchar(16),
			UserName			nvarchar(16),
			Descr				nvarchar(255)
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@EmployeeLetOutPkID=EmployeeLetOutPkID,
			@CreatedDate=CreatedDate,
			@CommandNo=CommandNo,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@JobExitReasonPkID=JobExitReasonPkID,
			@UserName=UserName,
			@Descr=isnull(Descr,'')
	FROM #tmp
  
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmEmployeeLetOut', @EmployeeLetOutPkID output

		INSERT INTO hrmEmployeeLetOut(
			EmployeeLetOutPkID,
			CreatedDate,
			CommandNo,
			EmployeeInfoPkID,
			JobExitReasonPkID,
			UserName,
			Descr)
		VALUES (
			@EmployeeLetOutPkID,
			@CreatedDate,
			@CommandNo,
			@EmployeeInfoPkID,
			@JobExitReasonPkID,
			@UserName,
			@Descr)
	END
	ELSE
		UPDATE hrmEmployeeLetOut
		SET 
			EmployeeLetOutPkID=@EmployeeLetOutPkID,
			CreatedDate=@CreatedDate,
			CommandNo=@CommandNo,
			EmployeeInfoPkID=@EmployeeInfoPkID,
			JobExitReasonPkID=@JobExitReasonPkID,
			UserName=@UserName,
			Descr=@Descr

		WHERE EmployeeLetOutPkID=@EmployeeLetOutPkID

	update hrmEmployeeInfo
	set Status = 2
	where EmployeeInfoPkID = @EmployeeInfoPkID and YearPkID = @YearPkID
END
GO
