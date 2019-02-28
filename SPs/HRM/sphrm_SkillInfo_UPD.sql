IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SkillInfo_UPD')
DROP PROC sphrm_SkillInfo_UPD
GO
CREATE PROC sphrm_SkillInfo_UPD
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
			@SkillPkID		NVARCHAR(16),
			@SkillName		NVARCHAR(255),
			@SkillTypePkID	nvarchar(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				SkillPkID			NVARCHAR(16),
				SkillName			NVARCHAR(255),
				SkillTypePkID	nvarchar(16))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @SkillPkID=SkillPkID, @SkillName=SkillName,@SkillTypePkID= SkillTypePkID FROM #tmp
   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmSkillInfo WHERE SkillName=@SkillName) > 0
			BEGIN
 				RAISERROR ('Ур чадварын нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmSkillInfo', @SkillPkID output

		INSERT INTO hrmSkillInfo(SkillPkID, SkillName,SkillTypePkID)		
		VALUES (@SkillPkID, @SkillName,@SkillTypePkID) 
	END
	ELSE
		UPDATE hrmSkillInfo
		SET SkillName=@SkillName,SkillTypePkID=@SkillTypePkID
		WHERE SkillPkID=@SkillPkID 
END
GO
