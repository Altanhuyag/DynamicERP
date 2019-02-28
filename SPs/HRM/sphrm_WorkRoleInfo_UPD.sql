USE GeganetMedical
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROC sphrm_WorkRoleInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@Adding				TinyInt,
			@WorkRolePkID		NVARCHAR(16),
			@WorkRoleGroupPkID	NVARCHAR(16),
			@WorkRoleName		NVARCHAR(50),
			@SortID				int
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				WorkRolePkID		NVARCHAR(16),
				WorkRoleGroupPkID	NVARCHAR(16),
				WorkRoleName		NVARCHAR(50),
				SortID				int	)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding, @WorkRolePkID=WorkRolePkID, 
			@WorkRoleGroupPkID=WorkRoleGroupPkID, @WorkRoleName=WorkRoleName, @SortID=SortID FROM #tmp   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmWorkRoleInfo WHERE WorkRoleName=@WorkRoleName) > 0
			BEGIN
 				RAISERROR ('Ажил үүргийн бүртгэлийн нэр давхардаж байна !', 16, 1)
				RETURN (1)
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmWorkRoleInfo', @WorkRolePkID output

		INSERT INTO hrmWorkRoleInfo(WorkRolePkID, WorkRoleGroupPkID, WorkRoleName, SortID)
		VALUES (@WorkRolePkID, @WorkRoleGroupPkID, @WorkRoleName, @SortID)
	END
	ELSE
		UPDATE hrmWorkRoleInfo
		SET WorkRoleGroupPkID=@WorkRoleGroupPkID,
			WorkRoleName=@WorkRoleName,
			SortID=@SortID
		WHERE WorkRolePkID=@WorkRolePkID
END


GO
