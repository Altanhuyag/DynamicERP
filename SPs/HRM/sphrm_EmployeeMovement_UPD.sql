IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeMovement_UPD')
DROP PROC sphrm_EmployeeMovement_UPD
GO
CREATE PROC sphrm_EmployeeMovement_UPD
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
			@EmployeeMovementPkID nvarchar(16) ,
			@EmployeeInfoPkID nvarchar(16) ,
			@CommandNo	nvarchar(16),
			@CommandDate datetime,
			@OldJobEnterDate datetime,
			@OldDepartmentPkID nvarchar(16) ,
			@OldPositionPkID nvarchar(16) ,
			@OldStatusPkID nvarchar(16) ,						
			@DepartmentPkID nvarchar(16),
			@PositionPkID nvarchar(16),
			@StatusPkID nvarchar(16),
			@StartDate datetime,
			@IsFinishDate nvarchar(1),
			@FinishDate datetime ,
			@UserName nvarchar(255) ,
			@Descr nvarchar(255)				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
			EmployeeMovementPkID nvarchar(16),
			EmployeeInfoPkID nvarchar(16),
			CommandNo	nvarchar(16),
			CommandDate datetime,
			OldDepartmentPkID nvarchar(16),
			OldPositionPkID nvarchar(16),
			OldStatusPkID nvarchar(16),	
			OldJobEnterDate datetime,		
			DepartmentPkID nvarchar(16) ,
			PositionPkID nvarchar(16) ,
			StatusPkID nvarchar(16) ,
			StartDate datetime ,
			IsFinishDate nvarchar(1),
			FinishDate datetime ,
			UserName nvarchar(255),
			Descr nvarchar(255))
	EXEC sp_xml_removedocument @idoc	

	
	SELECT	@Adding=Adding,
			@EmployeeMovementPkID=EmployeeMovementPkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@CommandNo=isnull(CommandNo,''),
			@CommandDate=CommandDate,
			@OldJobEnterDate = OldJobEnterDate,
			@OldDepartmentPkID=OldDepartmentPkID,
			@OldPositionPkID=OldPositionPkID,
			@OldStatusPkID=OldStatusPkID,			
			@DepartmentPkID=DepartmentPkID,
			@PositionPkID=PositionPkID,
			@StatusPkID=StatusPkID,
			@StartDate=StartDate,
			@IsFinishDate=IsFinishDate,
			@FinishDate=FinishDate,
			@UserName=UserName,
			@Descr=isnull(Descr,'')
			
	FROM #tmp
   
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmEmployeeMovement', @EmployeeMovementPkID output

		INSERT INTO hrmEmployeeMovement(
			EmployeeMovementPkID,
			EmployeeInfoPkID,
			CommandNo,
			CommandDate,
			OldDepartmentPkID,
			OldPositionPkID,
			OldStatusPkID ,
			OldJobEnterDate ,			
			DepartmentPkID ,
			PositionPkID ,
			StatusPkID ,
			StartDate ,
			IsFinishDate,
			FinishDate,
			UserName,
			Descr)
		VALUES (
			@EmployeeMovementPkID,
			@EmployeeInfoPkID,
			@CommandNo,
			@CommandDate,
			@OldDepartmentPkID,
			@OldPositionPkID,
			@OldStatusPkID,
			@OldJobEnterDate,			
			@DepartmentPkID,
			@PositionPkID,
			@StatusPkID,
			@StartDate,
			@IsFinishDate,
			@FinishDate,
			@UserName,
			@Descr)
	END
		ELSE
		UPDATE hrmEmployeeMovement
		SET 
			EmployeeMovementPkID=@EmployeeMovementPkID,
			EmployeeInfoPkID=@EmployeeInfoPkID,
			CommandDate=@CommandDate,
			CommandNo=@CommandNo,
			OldDepartmentPkID=@OldDepartmentPkID,
			OldPositionPkID=@OldPositionPkID,
			OldStatusPkID =@OldStatusPkID,
			OldJobEnterDate = @OldJobEnterDate,			
			DepartmentPkID=@DepartmentPkID ,
			PositionPkID=@PositionPkID ,
			StatusPkID =@StatusPkID,
			StartDate =@StartDate,
			IsFinishDate=@IsFinishDate,
			FinishDate=@FinishDate,
			UserName=@UserName,
			Descr=@Descr

		WHERE EmployeeMovementPkID=@EmployeeMovementPkID
		
		update hrmEmployeeInfo
		set 
			DepartmentPkID=@DepartmentPkID,
			PositionPkID=@PositionPkID,
			Status=@StatusPkID,
			NowEnterPositionDate = @StartDate
		where EmployeeInfoPkID=@EmployeeInfoPkID
	
END
GO
