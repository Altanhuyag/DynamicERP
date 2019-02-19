IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoContact_UPD')
DROP PROC sphrm_EmployeeInfoContact_UPD
GO
CREATE PROC sphrm_EmployeeInfoContact_UPD
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
			@EmployeeInfoContactPkID	nvarchar(16),
			@EmployeeInfoPkID	nvarchar(16),
			@ContactNo	nvarchar(16),
			@CommandNo	nvarchar(16),
			@DepartmentPkID	nvarchar(16),
			@PositionGroupPkID	nvarchar(16),
			@PositionPkID	nvarchar(16),
			@Status	nvarchar(16),
			@WorkingStatusID	nvarchar(16),
			@SalaryTypeID	nvarchar(16),
			@BeginDate	datetime,
			@EndDate	datetime,
			@IsTermLess	nvarchar(1),
			@SalaryAmt	money,
			@Descr	nvarchar(255),
			@ContactEmployeeName	nvarchar(16),
			@CreatedDate	datetime,
			@YearPkID nvarchar(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				EmployeeInfoContactPkID	nvarchar(16),
				EmployeeInfoPkID	nvarchar(16),
				ContactNo	nvarchar(16),
				CommandNo	nvarchar(16),
				DepartmentPkID	nvarchar(16),
				PositionGroupPkID	nvarchar(16),
				PositionPkID	nvarchar(16),
				Status	nvarchar(16),
				WorkingStatusID	nvarchar(16),
				SalaryTypeID	nvarchar(16),
				BeginDate	datetime,
				EndDate	datetime,
				IsTermLess	nvarchar(1),
				SalaryAmt	money,
				Descr	nvarchar(255),
				ContactEmployeeName	nvarchar(16),
				CreatedDate	datetime
				)
	EXEC sp_xml_removedocument @idoc 	

	--raiserror(@XML,16,1)

	SELECT	@Adding=Adding,
			@EmployeeInfoContactPkID=EmployeeInfoContactPkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@ContactNo=ContactNo,
			@CommandNo=CommandNo,
			@DepartmentPkID=DepartmentPkID,
			@PositionGroupPkID=PositionGroupPkID,
			@PositionPkID=PositionPkID,
			@Status=Status,
			@WorkingStatusID=WorkingStatusID,
			@SalaryTypeID=SalaryTypeID,
			@BeginDate=BeginDate,
			@EndDate=EndDate,
			@IsTermLess=isnull(IsTermLess,'N'),
			@SalaryAmt=SalaryAmt,
			@Descr=isnull(Descr,''),
			@ContactEmployeeName=isnull(ContactEmployeeName,''),
			@CreatedDate=CreatedDate
			
	FROM #tmp
   
    select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID = 'YearPkID'
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmEmployeeInfoContact', @EmployeeInfoContactPkID output

		INSERT INTO hrmEmployeeInfoContact(	EmployeeInfoContactPkID,
											EmployeeInfoPkID,
											ContactNo,
											CommandNo,
											DepartmentPkID,
											PositionGroupPkID,
											PositionPkID,
											Status,
											WorkingStatusID,
											SalaryTypeID,
											BeginDate,
											EndDate,
											IsTermLess,
											SalaryAmt,
											Descr,
											ContactEmployeeName,
											CreatedDate
											)
		VALUES (@EmployeeInfoContactPkID,
											@EmployeeInfoPkID,
											@ContactNo,
											@CommandNo,
											@DepartmentPkID,
											@PositionGroupPkID,
											@PositionPkID,
											@Status,
											@WorkingStatusID,
											@SalaryTypeID,
											@BeginDate,
											@EndDate,
											@IsTermLess,
											@SalaryAmt,
											@Descr,
											@ContactEmployeeName,
											@CreatedDate)
	END
	ELSE
	BEGIN
		UPDATE hrmEmployeeInfoContact
		SET 
				EmployeeInfoPkID=@EmployeeInfoPkID,
				ContactNo=@ContactNo,
				CommandNo=@CommandNo,
				DepartmentPkID=@DepartmentPkID,
				PositionGroupPkID=@PositionGroupPkID,
				PositionPkID=@PositionPkID,
				Status=@Status,
				WorkingStatusID=@WorkingStatusID,
				SalaryTypeID=@SalaryTypeID,
				BeginDate=@BeginDate,
				EndDate=@EndDate,
				IsTermLess=@IsTermLess,
				SalaryAmt=@SalaryAmt,
				Descr=@Descr,
				ContactEmployeeName=@ContactEmployeeName,
				CreatedDate=@CreatedDate
		WHERE EmployeeInfoContactPkID=@EmployeeInfoContactPkID
	END
		UPDATE hrmEmployeeInfo
		set Status = @Status , WorkingStatusID = @WorkingStatusID,
		SalaryTypeID = @SalaryTypeID,
		SalaryAmt = @SalaryAmt,
		DepartmentPkID = @DepartmentPkID,
		PositionGroupPkID =@PositionGroupPkID,
		PositionPkID = @PositionPkID
		where EmployeeInfoPkID = @EmployeeInfoPkID
		and YearPkID = @YearPkID

END
GO
