IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SalaryInfo_UPD')
DROP PROC sphrm_SalaryInfo_UPD
GO
CREATE PROC sphrm_SalaryInfo_UPD
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
			@SalaryInfoPkID	nvarchar(16),
			@SalaryInfoName	nvarchar(16),	
			@Salary1				int,
			@Salary2				int,
			@SortID				int
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				SalaryInfoPkID	nvarchar(16),
				SalaryInfoName	nvarchar(16),	
				Salary1				int,
				Salary2				int,
				SortID				int)
					
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
			@Adding=Adding,
			@SalaryInfoPkID =SalaryInfoPkID,
			@SalaryInfoName=SalaryInfoName ,
			@Salary1  =Salary1,
			@Salary2 =Salary2,
			@SortID =SortID 	
						
			
	FROM #tmp

	IF @Adding=0 BEGIN
	
		exec dbo.spsmm_LastSequence_SEL 'hrmSalaryInfo',@SalaryInfoPkID output
		
		IF (SELECT COUNT(*) FROM hrmSalaryInfo where SalaryInfoPkID=@SalaryInfoPkID)>0
		BEGIN
			RAISERROR('Таны мэдээлэл давхардаж байна.',16,1)
			RETURN
		END
		
		INSERT INTO hrmSalaryInfo
					(	SalaryInfoPkID ,
						SalaryInfoName,
						Salary1 ,
						Salary2 ,
						SortID)
		
		VALUES (@SalaryInfoPkID,
				@SalaryInfoName ,
				@Salary1 ,
				@Salary2 ,
				@SortID)
	END
	ELSE BEGIN

		UPDATE hrmSalaryInfo
		SET SalaryInfoName =@SalaryInfoName,Salary1 =@Salary1 ,Salary2 =@Salary2,SortID=@SortID
		WHERE SalaryInfoPkID =@SalaryInfoPkID
	END
END

GO
