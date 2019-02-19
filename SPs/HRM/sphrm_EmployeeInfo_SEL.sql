IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfo_SEL')
DROP PROC sphrm_EmployeeInfo_SEL
GO

CREATE PROC sphrm_EmployeeInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	IF (isnull(@XML,'')!='')
	BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@DepartmentPkID	nvarchar(16)
	 
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  DepartmentPkID		nvarchar(16))
	
	EXEC sp_xml_removedocument @idoc
	
	SELECT @DepartmentPkID=DepartmentPkID FROM #tmp 
	
	SELECT count(*) as EmployeeCount FROM hrmEmployeeInfo
	WHERE DepartmentPkID=@DepartmentPkID
	
	END
	else
	begin
		select A.*,A.LastName+N' овогтой ' + A.FirstName as FullName,DI.DepartmentName from hrmEmployeeInfo A
		inner join hrmDepartmentInfo DI on A.DepartmentPkID = DI.DepartmentPkID
		
	end
	
END
GO
