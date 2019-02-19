IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfo_DEL')
DROP PROC sphrm_EmployeeInfo_DEL
GO
CREATE PROC sphrm_EmployeeInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@EmployeeInfoPkID		nvarchar(50),
			@PlaceDescriptionPkID nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EmployeeInfoPkID			nvarchar(50))
	EXEC sp_xml_removedocument @idoc
	
	select @EmployeeInfoPkID=EmployeeInfoPkID from #tmp
	--select @PlaceDescriptionPkID=PlaceDescriptionPkID from hrmPlaceDescription WHERE RegisterNo=@RegisterNo
	
	DELETE  hrmEmployeeInfo WHERE EmployeeInfoPkID=@EmployeeInfoPkID
	--DELETE  hrmGraduate	WHERE RegisterNo=@RegisterNo
	--DELETE  hrmLanguageKnowledge WHERE RegisterNo=@RegisterNo
	--DELETE  hrmAward WHERE RegisterNo=@RegisterNo
	--DELETE  hrmWorkingHistory WHERE RegisterNo=@RegisterNo
	--DELETE  hrmWorkingExperience WHERE RegisterNo=@RegisterNo
	--DELETE  hrmFamily WHERE RegisterNo=@RegisterNo	
	--DELETE  hrmSkill WHERE RegisterNo=@RegisterNo	
	--DELETE  hrmChildCareer WHERE RegisterNo=@RegisterNo
	--DELETE  hrmSalaryChange WHERE RegisterNo=@RegisterNo	
	--DELETE  hrmAdvertence WHERE RegisterNo=@RegisterNo
	--DELETE  hrmSoldier WHERE RegisterNo=@RegisterNo	
	--DELETE  hrmDegree WHERE RegisterNo=@RegisterNo
	--DELETE  hrmHealthStatus WHERE RegisterNo=@RegisterNo
	--DELETE  hrmPlaceDescription WHERE RegisterNo=@RegisterNo
	--DELETE  hrmPlaceDescriptionSkill WHERE PlaceDescriptionPkID=@PlaceDescriptionPkID
	DELETE  hrmEmployeeImage WHERE EmployeePkID=@EmployeeInfoPkID
	--DELETE  tshEnrollUser WHERE RegisterNo = @RegisterNo

END
GO
