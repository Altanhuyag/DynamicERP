IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Advertence_PARA')
DROP PROC sphrm_Advertence_PARA
GO
create proc sphrm_Advertence_PARA

(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) with encryption

as

begin
SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@StartDate		datetime,
			@FinishDate		datetime,
			@IsType			nvarchar(1),
			@DateIs			nvarchar(1),
			@AdvertenceTypeInfoPkID nvarchar(16),
			@QueryString nvarchar(max)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( StartDate		datetime,
			   FinishDate		datetime,
			   IsType			nvarchar(1),
			   DateIs			nvarchar(1),
			   AdvertenceTypeInfoPkID nvarchar(16)
			    )
	EXEC sp_xml_removedocument @idoc

	SELECT @StartDate=Startdate , @FinishDate=FinishDate,
	@IsType = IsType, @DateIs = DateIs, @AdvertenceTypeInfoPkID = AdvertenceTypeInfoPkID from #tmp
	
	SET @QueryString = 'select 
	A.*,B.AdvertenceName,E.AdvertenceTypeName,C.PositionName,SUBSTRING(D.LastName,1,1)+''.''+ D.FirstName as FirstName, 
	A.UserName as EmployeeName,D.RegisterNo from hrmAdvertence A
	inner join hrmAdvertenceInfo B on A.AdvertenceInfoPkID=B.AdvertenceInfoPkID
	inner join hrmEmployeeInfo D on A.EmployeeInfoPkID=D.EmployeeInfoPkID	
	left join hrmPositionInfo C on D.PositionPkID=C.PositionPkID	
	left join hrmAdvertenceTypeInfo E on B.AdvertenceTypeInfoPkID=E.AdvertenceTypeInfoPkID
	where 1=1 '
	if (isnull(@IsType,'N')='Y')
		SET @QueryString = @QueryString + ' and B.AdvertenceTypeInfoPkID = '''+@AdvertenceTypeInfoPkID+''''
	if (ISNULL(@DateIs,'N') = 'Y')
		set @QueryString = @QueryString + ' and convert(nvarchar,A.AdvertenceDate,102) between convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@StartDate,102)+'''),102) and convert(nvarchar,convert(datetime,'''+CONVERT(nvarchar,@FinishDate,102)+'''),102)'
	--raiserror(@QueryString,16,1)
	exec(@QueryString)
END
GO
