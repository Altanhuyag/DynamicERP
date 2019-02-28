IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SkillTypeInfo_UPD')
DROP PROC sphrm_SkillTypeInfo_UPD
GO
CREATE PROC sphrm_SkillTypeInfo_UPD
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
			@SkillTypePkID		NVARCHAR(16),
			@SkillTypeName		NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				SkillTypePkID			NVARCHAR(16),
				SkillTypeName			NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @SkillTypePkID=SkillTypePkID, @SkillTypeName=SkillTypeName FROM #tmp
   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmSkillTypeInfo WHERE SkillTypeName=@SkillTypeName) > 0
			BEGIN
 				RAISERROR ('Ур чадварын төрөл нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmSkillTypeInfo', @SkillTypePkID output

		INSERT INTO hrmSkillTypeInfo(SkillTypePkID, SkillTypeName)		
		VALUES (@SkillTypePkID, @SkillTypeName) 
	END
	ELSE
		UPDATE hrmSkillTypeInfo
		SET SkillTypeName=@SkillTypeName
		WHERE SkillTypePkID=@SkillTypePkID 
END
GO
