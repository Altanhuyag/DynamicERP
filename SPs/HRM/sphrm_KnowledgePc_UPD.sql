IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_KnowledgePc_UPD')
DROP PROC sphrm_KnowledgePc_UPD
GO
CREATE PROC sphrm_KnowledgePc_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				int,
			@KnowledgePkID	nvarchar(16),
			@EmployeeInfoPkID	NVARCHAR(16),
			@ProgramInfoPkID	nvarchar(MAX),
			@HowStudied			nvarchar(250),
			@KnownLevel			NVARCHAR(50),
			@HowYear			Int
	
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	
				Adding				Int,
				KnowledgePkID		nvarchar(16),
				EmployeeInfoPkID	NVARCHAR(50),
				ProgramInfoPkID		nvarchar(MAX),
				HowStudied			nvarchar(250),
				KnownLevel			NVARCHAR(50),
				HowYear				Int)

	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@Adding=Adding,@KnowledgePkID=KnowledgePkID,@EmployeeInfoPkID=EmployeeInfoPkID, @ProgramInfoPkID=ProgramInfoPkID, 
			@HowStudied=HowStudied, @KnownLevel=KnownLevel, @HowYear=HowYear FROM #tmp	
	
	IF(@EmployeeInfoPkID = '' or @EmployeeInfoPkID is null)
	BEGIN
		RAISERROR(N'Ажилтнаа сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@ProgramInfoPkID = '' or @ProgramInfoPkID is null)
	BEGIN
		RAISERROR(N'Програмаа сонгоно уу!', 16, 1)
		RETURN
	END

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmKnowledgePc', @KnowledgePkID output

		INSERT INTO hrmKnowledgePc
							(	
								KnowledgePkID,
								EmployeeInfoPkID,	
								HowStudied,
								KnownLevel,
								HowYear)
		
		VALUES (				
								
								@KnowledgePkID,
								@EmployeeInfoPkID,	
								@HowStudied,
								@KnownLevel,
								@HowYear)

		declare @proid nvarchar(16)
		set @proid = 0

		declare cur cursor for 
		SELECT Name FROM dbo.splitstring(@ProgramInfoPkID)

		open cur
		fetch next from cur into @proid

		while @@FETCH_STATUS = 0
		begin
			insert into hrmKnowledgePCProgram values(@KnowledgePkID, @proid)
			fetch next from cur into @proid
		end

		close cur
		deallocate cur
		
	END
	ELSE 
		UPDATE	hrmKnowledgePc
        SET		EmployeeInfoPkID=@EmployeeInfoPkID,
				HowStudied=@HowStudied,
				KnownLevel=@KnownLevel,
				HowYear=@HowYear
		WHERE KnowledgePkID=@KnowledgePkID

		delete from hrmKnowledgePCProgram where KnowledgePkID=@KnowledgePkID

		declare @proid1 nvarchar(16)
		set @proid = 0

		declare cur cursor for 
		SELECT Name FROM dbo.splitstring(@ProgramInfoPkID)

		open cur
		fetch next from cur into @proid1

		while @@FETCH_STATUS = 0
		begin
			insert into hrmKnowledgePCProgram values(@KnowledgePkID, @proid1)
			fetch next from cur into @proid1
		end

		close cur
		deallocate cur
END
GO
