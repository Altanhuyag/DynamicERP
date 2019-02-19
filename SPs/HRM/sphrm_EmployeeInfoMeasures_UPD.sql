IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoMeasures_UPD')
DROP PROC sphrm_EmployeeInfoMeasures_UPD
GO
CREATE PROC sphrm_EmployeeInfoMeasures_UPD
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
			@EmployeeInfoMeasuresPkID nvarchar(16),
			@EmployeeInfoPkID			nvarchar(16),
			@BreachPkID	nvarchar(16),
			@CommandNo			nvarchar(16),
			@BeginDate			datetime,
			@EndDate			datetime,
			@MeasuresAmt		money,
			@ReasonDescr		nvarchar(250),
			@Descr				nvarchar(250),
			@UserName	nvarchar(150),
			@CreatedDate		datetime
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			EmployeeInfoMeasuresPkID nvarchar(16),
			EmployeeInfoPkID			nvarchar(16),
			BreachPkID	nvarchar(16),
			CommandNo			nvarchar(16),
			BeginDate			datetime,
			EndDate				datetime,
			MeasuresAmt			money,
			ReasonDescr			nvarchar(250),
			Descr				nvarchar(250),
			UserName	nvarchar(150),
			CreatedDate		datetime)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@EmployeeInfoMeasuresPkID=EmployeeInfoMeasuresPkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@BreachPkID=BreachPkID,
			@CommandNo=CommandNo,
			@BeginDate=BeginDate,
			@EndDate=EndDate,
			@MeasuresAmt=MeasuresAmt,
			@ReasonDescr=ReasonDescr,
			@Descr=isnull(Descr,''),
			@UserName=UserName,
			@CreatedDate=CreatedDate

	FROM #tmp
   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmEmployeeInfoMeasures', @EmployeeInfoMeasuresPkID output

		INSERT INTO hrmEmployeeInfoMeasures(EmployeeInfoMeasuresPkID ,
				EmployeeInfoPkID,
				BreachPkID,
				CommandNo,
				BeginDate,
				EndDate	,
				MeasuresAmt	,
				ReasonDescr	,
				Descr	,
				UserName	,
				CreatedDate		)
		VALUES (
				@EmployeeInfoMeasuresPkID ,
				@EmployeeInfoPkID,
				@BreachPkID,
				@CommandNo,
				@BeginDate,
				@EndDate	,
				@MeasuresAmt	,
				@ReasonDescr	,
				@Descr	,
				@UserName	,
				@CreatedDate	)	
	END
	ELSE
		UPDATE hrmEmployeeInfoMeasures
		SET EmployeeInfoMeasuresPkID=@EmployeeInfoMeasuresPkID,
			EmployeeInfoPkID=@EmployeeInfoPkID,
			BreachPkID=@BreachPkID,
			CommandNo=@CommandNo,
			BeginDate=@BeginDate,
			EndDate=@EndDate,
			MeasuresAmt=@MeasuresAmt,
			ReasonDescr=@ReasonDescr,
			Descr=@Descr,
			UserName=@UserName,
			CreatedDate=@CreatedDate
		WHERE EmployeeInfoMeasuresPkID=@EmployeeInfoMeasuresPkID
END
GO
