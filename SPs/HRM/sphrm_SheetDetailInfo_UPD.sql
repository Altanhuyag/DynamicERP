IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SheetDetailInfo_UPD')
DROP PROC sphrm_SheetDetailInfo_UPD
GO

CREATE PROC sphrm_SheetDetailInfo_UPD
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
			@SheetDetailInfoPkID		nvarchar(16),
			@SheetInfoPkID				nvarchar(16),
			@SheetDetailInfoNameMon		nvarchar(255),
			@SheetDetailInfoNameEng		nvarchar(255),
			@IsHandEnter				nvarchar(1),
			@IsCurrencyToString			nvarchar(1),
			@CurrencyToStringField		nvarchar(255),
			@HRMTableNameMon			nvarchar(255),
			@HRMTableNameEng			nvarchar(255),
			@HRMTableFieldNameMon		nvarchar(255),
			@HRMTableFieldNameEng		nvarchar(255),
			@IsSystemDate				nvarchar(1),
			@IsSubYear					nvarchar(1),
			@IsSubMonth				nvarchar(1),
			@IsSubDay				nvarchar(1),
			@RelatedTable			nvarchar(255),
			@RelatedField			nvarchar(255)
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				SheetDetailInfoPkID	nvarchar(16),
				SheetInfoPkID		nvarchar(16),
				SheetDetailInfoNameMon		nvarchar(255),
				SheetDetailInfoNameEng		nvarchar(255),
				IsHandEnter					nvarchar(1),
				IsCurrencyToString			nvarchar(1),
				CurrencyToStringField		nvarchar(255),
				HRMTableNameMon				nvarchar(255),
				HRMTableNameEng				nvarchar(255),
				HRMTableFieldNameMon		nvarchar(255),	
				HRMTableFieldNameEng		nvarchar(255),	
				IsSystemDate				nvarchar(1),
				IsSubYear					nvarchar(1),
				IsSubMonth					nvarchar(1),
				IsSubDay					nvarchar(1),
				RelatedTable				nvarchar(255),
				RelatedField				nvarchar(255)
				)
	EXEC sp_xml_removedocument @idoc

	
	SELECT	@Adding=Adding,
			@SheetDetailInfoPkID=SheetDetailInfoPkID,
			@SheetInfoPkID=SheetInfoPkID,
			@SheetDetailInfoNameMon=SheetDetailInfoNameMon,
			@SheetDetailInfoNameEng=SheetDetailInfoNameEng,
			@IsHandEnter=IsHandEnter,
			@IsCurrencyToString=IsCurrencyToString,
			@CurrencyToStringField=CurrencyToStringField,
			@HRMTableNameMon=HRMTableNameMon,
			@HRMTableNameEng=HRMTableNameEng,
			@HRMTableFieldNameMon=HRMTableFieldNameMon,
			@HRMTableFieldNameEng=HRMTableFieldNameEng,
			@IsSystemDate=IsSystemDate,
			@IsSubYear=IsSubYear,
			@IsSubMonth=IsSubMonth,
			@IsSubDay=IsSubDay,
			@RelatedTable=RelatedTable,
			@RelatedField=RelatedField
			
	FROM #tmp
 	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmSheetDetailInfo', @SheetDetailInfoPkID output

		INSERT INTO hrmSheetDetailInfo
							(	
			SheetDetailInfoPkID,
			SheetInfoPkID,
			SheetDetailInfoNameMon,
			SheetDetailInfoNameEng,
			IsHandEnter,
			IsCurrencyToString,
			CurrencyToStringField,
			HRMTableNameMon,
			HRMTableNameEng,
			HRMTableFieldNameMon,
			HRMTableFieldNameEng,
			IsSystemDate,
			IsSubYear,
			IsSubMonth,
			IsSubDay,
			RelatedTable,
			RelatedField)
		
		VALUES (
			@SheetDetailInfoPkID,
			@SheetInfoPkID,
			@SheetDetailInfoNameMon,
			@SheetDetailInfoNameEng,
			@IsHandEnter,
			@IsCurrencyToString,
			@CurrencyToStringField,
			@HRMTableNameMon,
			@HRMTableNameEng,
			@HRMTableFieldNameMon,
			@HRMTableFieldNameEng,
			@IsSystemDate,
			@IsSubYear,
			@IsSubMonth,
			@IsSubDay,
			@RelatedTable,
			@RelatedField)
	END
	ELSE
		UPDATE hrmSheetDetailInfo
		SET 								
			SheetInfoPkID=@SheetInfoPkID,
			SheetDetailInfoNameMon=@SheetDetailInfoNameMon,
			SheetDetailInfoNameEng=@SheetDetailInfoNameEng,
			IsHandEnter=@IsHandEnter,
			IsCurrencyToString=@IsCurrencyToString,
			CurrencyToStringField=@CurrencyToStringField,
			HRMTableNameMon=@HRMTableNameMon,
			HRMTableNameEng=@HRMTableNameEng,
			HRMTableFieldNameMon=@HRMTableFieldNameMon,
			IsSystemDate=@IsSystemDate,
			IsSubYear=@IsSubYear,
			IsSubMonth=@IsSubMonth,
			IsSubDay=@IsSubDay,
			RelatedTable=@RelatedTable,
			RelatedField=@RelatedField
		WHERE SheetDetailInfoPkID=@SheetDetailInfoPkID
END
GO
