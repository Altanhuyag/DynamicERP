USE GeganetMedical
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROC sphrm_WorkRoleGroup_UPD
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
			@WorkRoleGroupPkID	NVARCHAR(16),
			@WorkRoleGroupName	NVARCHAR(255),
			@SortID				NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				WorkRoleGroupPkID	NVARCHAR(16),
				WorkRoleGroupName	NVARCHAR(255),
				SortID				NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding, @WorkRoleGroupPkID=WorkRoleGroupPkID, 
			@WorkRoleGroupName=WorkRoleGroupName, @SortID=SortID FROM #tmp   
	
	IF @Adding=0 BEGIN 
	
		IF (SELECT COUNT(*) FROM hrmWorkRoleGroup WHERE WorkRoleGroupName=@WorkRoleGroupName) > 0
			BEGIN
 				RAISERROR ('Ажил үүргийн бүлгийн нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmWorkRoleGroup', @WorkRoleGroupPkID output

		INSERT INTO hrmWorkRoleGroup(WorkRoleGroupPkID, WorkRoleGroupName, SortID)
		VALUES (@WorkRoleGroupPkID, @WorkRoleGroupName, @SortID)
	END
	ELSE
		UPDATE hrmWorkRoleGroup
		SET WorkRoleGroupName=@WorkRoleGroupName,
			SortID=@SortID
		WHERE WorkRoleGroupPkID=@WorkRoleGroupPkID
END


GO
