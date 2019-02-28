IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Advertence_UPD')
DROP PROC sphrm_Advertence_UPD
GO
CREATE PROC sphrm_Advertence_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,
			@Adding						TinyInt,
			@AdvertencePkID	   			nvarchar(16),			
			@CreatedDate				datetime,
			@CommandNo					nvarchar(16),
			@CommandName				nvarchar(150),
			@EmployeeInfoPkID				nvarchar(16),
			@AdvertenceInfoPkID			nvarchar(16),
			@AdvertenceAmt				money,
			@AdvertenceDate				datetime,
			@AdvertenceDescr			nvarchar(250),
			@AdvertenceAdditionalDescr  nvarchar(250),
			@IsAllDay					nvarchar(1),
			@StartDate					datetime,
			@FinishDate					datetime,
			@UserName			nvarchar(16)
				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
			AdvertencePkID	   			nvarchar(16),
			CreatedDate					datetime,
			CommandNo					nvarchar(16),
			CommandName					nvarchar(150),
			EmployeeInfoPkID					nvarchar(16),
			AdvertenceInfoPkID			nvarchar(16),
			AdvertenceAmt				money,
			AdvertenceDate				datetime,
			AdvertenceDescr				nvarchar(250),
			AdvertenceAdditionalDescr   nvarchar(250),
			IsAllDay					nvarchar(1),
			StartDate					datetime,
			FinishDate					datetime,
			UserName			nvarchar(16))
	EXEC sp_xml_removedocument @idoc	

	
	SELECT	@Adding=Adding,
			@AdvertencePkID=AdvertencePkID,
			@CreatedDate=CreatedDate,
			@CommandNo=isnull(CommandNo,''),
			@CommandName=isnull(CommandName,''),
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@AdvertenceInfoPkID=AdvertenceInfoPkID,
			@AdvertenceAmt=AdvertenceAmt,
			@AdvertenceDate=AdvertenceDate,
			@AdvertenceDescr=ISNULL (AdvertenceDescr,''),
			@AdvertenceAdditionalDescr=isnull(AdvertenceAdditionalDescr,''),
			@IsAllDay=IsAllDay,
			@StartDate=StartDate,
			@FinishDate=FinishDate,
			@UserName=UserName
			
	FROM #tmp
   
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmAdvertence', @AdvertencePkID output

		INSERT INTO hrmAdvertence(
			AdvertencePkID,
			CreatedDate,
			CommandNo,
			CommandName,
			EmployeeInfoPkID,
			AdvertenceInfoPkID,
			AdvertenceAmt,
			AdvertenceDate,
			AdvertenceDescr,
			AdvertenceAdditionalDescr,
			IsAllDay,
			StartDate,
			FinishDate,
			UserName)
		VALUES (
			@AdvertencePkID,
			convert(nvarchar,@CreatedDate,102),
			@CommandNo,
			@CommandName,
			@EmployeeInfoPkID,
			@AdvertenceInfoPkID,
			@AdvertenceAmt,
			@AdvertenceDate,
			@AdvertenceDescr,
			@AdvertenceAdditionalDescr,
			@IsAllDay,
			@StartDate,
			@FinishDate,
			@UserName)
	END
	ELSE
		UPDATE hrmAdvertence
		SET 
			AdvertencePkID=@AdvertencePkID,
			CreatedDate=convert(nvarchar,@CreatedDate,102),
			CommandNo=@CommandNo,
			CommandName=@CommandName,
			EmployeeInfoPkID=@EmployeeInfoPkID,
			AdvertenceInfoPkID=@AdvertenceInfoPkID,
			AdvertenceAmt=@AdvertenceAmt,
			AdvertenceDate=@AdvertenceDate,
			AdvertenceDescr=@AdvertenceDescr,
			AdvertenceAdditionalDescr=@AdvertenceAdditionalDescr,
			IsAllDay=@IsAllDay,
			StartDate=@StartDate,
			FinishDate=@FinishDate,
			UserName=@UserName

		WHERE AdvertencePkID=@AdvertencePkID
END
GO
