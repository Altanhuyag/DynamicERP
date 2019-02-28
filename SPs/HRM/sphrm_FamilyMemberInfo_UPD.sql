IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_FamilyMemberInfo_UPD')
DROP PROC sphrm_FamilyMemberInfo_UPD
GO
CREATE PROC sphrm_FamilyMemberInfo_UPD
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
			@FamilyMemberPkID	NVARCHAR(16),
			@FamilyMemberName	NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				FamilyMemberPkID		NVARCHAR(16),
				FamilyMemberName		NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @FamilyMemberPkID=FamilyMemberPkID, @FamilyMemberName=FamilyMemberName FROM #tmp
   
	
	IF @Adding=0 BEGIN
		
		IF (SELECT COUNT(*) FROM hrmFamilyMemberInfo WHERE FamilyMemberName=@FamilyMemberName) > 0
			BEGIN
 				RAISERROR ('Гэр бүлийн гишүүдийн нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmFamilyMemberInfo', @FamilyMemberPkID output

		INSERT INTO hrmFamilyMemberInfo(FamilyMemberPkID, FamilyMemberName)		
		VALUES (@FamilyMemberPkID, @FamilyMemberName) 
	END
	ELSE
		UPDATE hrmFamilyMemberInfo
		SET FamilyMemberName=@FamilyMemberName
		WHERE FamilyMemberPkID=@FamilyMemberPkID 
END


GO
