IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LearningInfo_LIST')
DROP PROC sphrm_LearningInfo_LIST
GO
CREATE PROC sphrm_LearningInfo_LIST
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE 
			@idoc			int,
			@StartDate		datetime,
			@FinishDate		datetime,
			@DateIs		nvarchar(1),
			@QueryString	nvarchar(MAX),
			@SubQueryString	nvarchar(MAX),
			@FieldName		nvarchar(MAX),
			@StartDate1		datetime
   EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (				StartDate	datetime,
							FinishDate	datetime,
							DateIs nvarchar(1)
							)
	EXEC sp_xml_removedocument @idoc 		
	select
			@StartDate = StartDate,
			@FinishDate = FinishDate,
			@DateIs = DateIs
	FROM #tmp	
	if (isnull(@DateIs,'N')='N')
	BEGIN
		SET @StartDate = convert(datetime,Convert(nvarchar,YEAR(GETDATE()))+'.'+convert(nvarchar,MONTH(GETDATE()))+'.01')
		SET @FinishDate = DATEADD(day,-1,convert(datetime,Convert(nvarchar,YEAR(GETDATE()))+'.'+convert(nvarchar,MONTH(GETDATE())+1)+'.01'))
	END
	
	set @FieldName=','
	set @QueryString = ''
	set @SubQueryString=''
	set @StartDate1=@StartDate
	while (@StartDate<=@FinishDate)
	BEGIN
		set @FieldName=@FieldName+'isnull(C'+convert(nvarchar,YEAR(@StartDate))+'_'+convert(nvarchar,MONTH(@StartDate))+'_'+convert(nvarchar,DAY(@StartDate))+'.Descr,'''') as F'+convert(nvarchar,YEAR(@StartDate))+'_'+convert(nvarchar,MONTH(@StartDate))+'_'+convert(nvarchar,DAY(@StartDate))+',' 
		set @SubQueryString=@SubQueryString+' left join dbo.fnhrm_LearningInfo(convert(datetime,'''+convert(nvarchar,@StartDate,102)+''')) C'+convert(nvarchar,YEAR(@StartDate))+'_'+convert(nvarchar,MONTH(@StartDate))+'_'+convert(nvarchar,DAY(@StartDate))+' on C'+convert(nvarchar,YEAR(@StartDate))+'_'+convert(nvarchar,MONTH(@StartDate))+'_'+convert(nvarchar,DAY(@StartDate))+'.LearningPkID = A.LearningPkID '
		SET @StartDate = DATEADD(day,1,@StartDate)
	END	
	SET @QueryString = 'select C.LearningTypeName, B.DepartmentName,A.*'+substring(@FieldName,0,Len(@FieldName))+' from hrmLearning A
	left join hrmDepartmentInfo B on A.DepartmentPkID = B.DepartmentPkID
	left join hrmLearningInfo C on A.LearningTypePkID=C.LearningTypePkID '
	SET @QueryString = @QueryString + @SubQueryString
	set @QueryString = @QueryString + ' where convert(nvarchar,A.DocumentDate,102) between convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@StartDate1,102)+'''),102) and convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@FinishDate,102)+'''),102)'
	set @QueryString = @QueryString +' order by A.LearningPkID '
		
	--raiserror(@QueryString,16,1)
	exec(@QueryString)
END
GO
