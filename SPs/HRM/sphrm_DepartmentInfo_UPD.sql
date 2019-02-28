IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentInfo_UPD')
DROP PROC sphrm_DepartmentInfo_UPD
GO
CREATE PROC sphrm_DepartmentInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)	WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@Adding				TinyInt,
			@YearPkID			nvarchar(16),
			@DepartmentPkID		nvarchar(16),
			@DepartmentID		nvarchar(16),
			@ParentPkID			nvarchar(16),
		    @GroupLevel			int,
		    @SortedOrder		nvarchar(50),
		    @DepartmentName		nvarchar(250),
		    @GroupType			nvarchar(1),
		    @IsLastGroup		nvarchar(1),
			@SequenceNo			int,
			@EmployeeCount		int,
			@CreatedProgID		nvarchar(10),
			@CreatedDate		datetime,
			@LastUpdate			datetime,
			@IsIndependent		nvarchar(1),
			@CompanyRegisterNo	nvarchar(50),
			@CompanyName		nvarchar(150),
			@AimagOrCityName	nvarchar(150),
			@SumOrDistrictName	nvarchar(150),
			@BagOrQuarterName	nvarchar(150),
			@StreetName			nvarchar(150),
			@DoorName			nvarchar(150),
			@PhoneNo1			nvarchar(50),
			@PhoneNo2			nvarchar(50),
			@Fax				nvarchar(50),
			@Postbox			nvarchar(150),
			@EmailAddress		nvarchar(150),
			@ControlPositionPkID	nvarchar(16),
			@EventInfoPkID			nvarchar(16),
			@SortNo				int
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				Adding				TinyInt,
				DepartmentPkID		nvarchar(16),
				DepartmentID		nvarchar(16),
				ParentPkID			nvarchar(16),
				GroupLevel			int,
				SortedOrder			nvarchar(50),
				DepartmentName		nvarchar(250),
				GroupType			nvarchar(1),
				IsLastGroup			nvarchar(1),
				SequenceNo			int,
				EmployeeCount		int,
				CreatedProgID		nvarchar(10),
				CreatedDate			datetime,
				LastUpdate			datetime,
				IsIndependent		nvarchar(1),
				CompanyRegisterNo	nvarchar(50),
				CompanyName		nvarchar(150),
				AimagOrCityName	nvarchar(150),
				SumOrDistrictName	nvarchar(150),
				BagOrQuarterName	nvarchar(150),
				StreetName			nvarchar(150),
				DoorName			nvarchar(150),
				PhoneNo1			nvarchar(50),
				PhoneNo2			nvarchar(50),
				Fax				nvarchar(50),
				Postbox			nvarchar(150),
				EmailAddress		nvarchar(150),
				ControlPositionPkID	nvarchar(16),
				EventInfoPkID			nvarchar(16),
				SortNo				int
			)
	EXEC sp_xml_removedocument @idoc 	
	--raiserror(@XML,16,1)
	SELECT 
		   @Adding=Adding, 
		   @DepartmentPkID=DepartmentPkID, 
		   @DepartmentID = isnull(DepartmentID,''),
		   @ParentPkID=ParentPkID, 
		   @GroupLevel=GroupLevel,
		   @SortedOrder=isnull(SortedOrder,''),
		   @DepartmentName=DepartmentName, 
		   @GroupType=GroupType,
		   @IsLastGroup=IsLastGroup,
		   @SequenceNo=SequenceNo,
		   @EmployeeCount=EmployeeCount,
		   @CreatedProgID=CreatedProgID ,
		   @CreatedDate=CreatedDate ,
		   @LastUpdate=LastUpdate,
		   @IsIndependent		=isnull(IsIndependent,'N'),
			@CompanyRegisterNo	=isnull(CompanyRegisterNo,''),
			@CompanyName		=isnull(CompanyName,''),
			@AimagOrCityName	=isnull(AimagOrCityName,''),
			@SumOrDistrictName	=isnull(SumOrDistrictName,''),
			@BagOrQuarterName	=isnull(BagOrQuarterName,''),
			@StreetName			=isnull(StreetName,''),
			@DoorName			=isnull(DoorName,''),
			@PhoneNo1			=isnull(PhoneNo1,''),
			@PhoneNo2			=isnull(PhoneNo2,''),
			@Fax				=isnull(Fax,''),
			@Postbox			=isnull(Postbox,''),
			@EmailAddress		=isnull(EmailAddress,''),
			@ControlPositionPkID	=isnull(ControlPositionPkID,''),
			@EventInfoPkID = isnull(EventInfoPkID,''),
			@SortNo = isnull(SortNo,0)
	FROM #tmp

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	   			
	IF @Adding=0 BEGIN 	
	
	if (isnull(@ParentPkID,'-1')='-1')
			SET @ParentPkID='-1'
	if (@ParentPkID='')
			SET @ParentPkID = '-1'
		SELECT @GroupLevel = isnull(MAX(GroupLevel),-1)+1 FROM hrmDepartmentInfo
		WHERE DepartmentPkID = @ParentPkID
		
		SELECT @GroupType = GroupType FROM hrmDepartmentInfo
		WHERE DepartmentPkID = @ParentPkID	
	IF (SELECT COUNT(*) FROM hrmDepartmentInfo WHERE DepartmentName=@DepartmentName) > 0
			BEGIN
 				RAISERROR ('Бүлгийн нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END			
		
	  IF @GroupLevel = 6
      BEGIN
         RAISERROR('Бүлгийн түвшин 5 аас илүүгүй байна. !', 16, 1)
         RETURN
      END
        
		SELECT @SequenceNo = isnull(MAX(SequenceNo),0)+1 FROM hrmDepartmentInfo
		WHERE ParentPkID = @ParentPkID
   
		exec dbo.spsmm_LastSequence_SEL 'hrmDepartmentInfo', @DepartmentPkID output

		INSERT INTO hrmDepartmentInfo
					(
					YearPkID,
					DepartmentID,
					DepartmentPkID,
					ParentPkID,
					GroupLevel,
					SortedOrder,
					DepartmentName,
					GroupType,
					IsLastGroup,
					SequenceNo,
					EmployeeCount,
					CreatedProgID,
					CreatedDate,
					LastUpdate,
					IsIndependent,
					CompanyRegisterNo,
					CompanyName,
					AimagOrCityName,
					SumOrDistrictName,
					BagOrQuarterName,
					StreetName,
					DoorName,
					PhoneNo1,
					PhoneNo2,
					Fax	,
					Postbox	,
					EmailAddress,
					ControlPositionPkID,
					EventInfoPkID,
					SortNo
					 )
		VALUES (
				@YearPkID,
				@DepartmentID,
			   @DepartmentPkID, 
			   @ParentPkID, 
			   @GroupLevel,
			   @SortedOrder,
			   @DepartmentName, 
			   '0',
			   'Y',
			   @SequenceNo,
			   '0',
			   @CreatedProgID,
			   GETDATE(),
			   GETDATE(),
			   @IsIndependent,
				@CompanyRegisterNo,
				@CompanyName,
				@AimagOrCityName,
				@SumOrDistrictName,
				@BagOrQuarterName,
				@StreetName,
				@DoorName,
				@PhoneNo1,
				@PhoneNo2,
				@Fax,
				@Postbox,
				@EmailAddress,
				@ControlPositionPkID,
				@EventInfoPkID,
				@SortNo
				) 
		
		UPDATE hrmDepartmentInfo SET IsLastGroup = 'N' WHERE DepartmentPkID = @ParentPkID	
		exec sphrm_Department_PrepareTree
	END
	ELSE 
	BEGIN 	
		UPDATE hrmDepartmentInfo
		SET 		  
		   DepartmentName=@DepartmentName, 
		   CreatedProgID=@CreatedProgID ,
		   CreatedDate=GETDATE(),
		   LastUpdate=GETDATE(),
			IsIndependent		=@IsIndependent,
			CompanyRegisterNo	=@CompanyRegisterNo,
			CompanyName		=@CompanyName,
			AimagOrCityName	=@AimagOrCityName,
			SumOrDistrictName	=@SumOrDistrictName,
			BagOrQuarterName	=@BagOrQuarterName,
			StreetName			=@StreetName,
			DoorName			=@DoorName,
			PhoneNo1			=@PhoneNo1,
			PhoneNo2			=@PhoneNo2,
			Fax				=@Fax,
			Postbox			=@Postbox,
			EmailAddress		=@EmailAddress,
			ControlPositionPkID	=@ControlPositionPkID,
			DepartmentID =@DepartmentID,
			ParentPkID = @ParentPkID,
			EventInfoPkID = @EventInfoPkID,
			SortNo = @SortNo
		WHERE DepartmentPkID =@DepartmentPkID
		and YearPkID = @YearPkID

		exec sphrm_Department_PrepareTree
	END  

	select @DepartmentPkID as DepartmentPkID
END




GO
