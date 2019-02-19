IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeMovement_DEL')
DROP PROC sphrm_EmployeeMovement_DEL
GO
CREATE PROC sphrm_EmployeeMovement_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@EmployeeMovementPkID	nvarchar(16),
			@OldDepartmentPkID		nvarchar(16),
			@OldJobEnterDate		datetime,
			@OldPositionPkID		nvarchar(16),
			@OldStatusPkID			int,
			@EmployeeInfoPkID		nvarchar(16)

	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EmployeeMovementPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @EmployeeMovementPkID=EmployeeMovementPkID FROM #tmp

	select @OldDepartmentPkID=OldDepartmentPkID,@OldPositionPkID=OldPositionPkID,
	@OldStatusPkID=OldStatusPkID,@EmployeeInfoPkID = EmployeeInfoPKID,@OldJobEnterDate = OldJobEnterDate 
	from hrmEmployeeMovement where EmployeeMovementPkID = @EmployeeMovementPkID
	
	update hrmEmployeeInfo set DepartmentPkID = @OldDepartmentPkID,
	PositionPkID = @OldPositionPkID,NowEnterPositionDate = @OldJobEnterDate,
	WorkingStatusID=@OldStatusPkID
	where EmployeeInfoPkID = @EmployeeInfoPkID

	DELETE FROM hrmEmployeeMovement
	where EmployeeMovementPkID = @EmployeeMovementPkID
	
	END
GO
