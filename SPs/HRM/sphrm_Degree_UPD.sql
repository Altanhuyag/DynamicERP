IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Degree_UPD')
DROP PROC sphrm_Degree_UPD
GO
CREATE PROC sphrm_Degree_UPD
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
			@DegreePkID			NVARCHAR(16),
			@EmployeeInfoPkID	NVARCHAR(16),
			@DegreeInfoPkID     NVARCHAR(16),
			@DegreeSubject		nvarchar(255),
			@DegreeDate			DATETIME
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				DegreePkID			NVARCHAR(16),
				EmployeeInfoPkID	NVARCHAR(16),
				DegreeInfoPkID		NVARCHAR(16),
				DegreeSubject		nvarchar(255),
				DegreeDate			DATETIME)
	EXEC sp_xml_removedocument @idoc 	
		
	SELECT	@Adding=Adding,
			@DegreePkID=DegreePkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@DegreeInfoPkID=DegreeInfoPkID,
			@DegreeSubject=DegreeSubject,
			@DegreeDate=DegreeDate
	FROM #tmp
   
	IF(@EmployeeInfoPkID = '' or @EmployeeInfoPkID is null)
	BEGIN
		RAISERROR(N'Ажилтнаа сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@DegreeInfoPkID = '' or @DegreeInfoPkID is null)
	BEGIN
		RAISERROR(N'Зэрэг цолоо сонгоно уу!', 16, 1)
		RETURN
	END

	IF @Adding=0 BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'Degree', @DegreePkID output

		INSERT INTO hrmDegree(DegreePkID, EmployeeInfoPkID,DegreeInfoPkID, DegreeSubject, DegreeDate)
		VALUES (@DegreePkID,	@EmployeeInfoPkID, @DegreeInfoPkID, @DegreeSubject, @DegreeDate)

	END
	ELSE
		UPDATE hrmDegree
		SET EmployeeInfoPkID=@EmployeeInfoPkID,
			DegreeInfoPkID=@DegreeInfoPkID,
			DegreeSubject=@DegreeSubject,
			DegreeDate=@DegreeDate
		WHERE DegreePkID=@DegreePkID
END
GO
