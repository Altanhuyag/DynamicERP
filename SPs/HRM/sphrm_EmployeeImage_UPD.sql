IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeImage_UPD')
DROP PROC sphrm_EmployeeImage_UPD
GO
CREATE PROC sphrm_EmployeeImage_UPD
(
	@EmployeeInfoPkID				nvarchar(16),
	@ImageFile				image,
	@Adding					int

) WITH ENCRYPTION
AS

BEGIN   
	
	
		IF (SELECT COUNT(*) FROM hrmEmployeeImage WHERE EmployeePkID=@EmployeeInfoPkID) > 0
			BEGIN
 			
				UPDATE	hrmEmployeeImage
				SET		EmployeePicture=@ImageFile				
				WHERE	EmployeePkID=@EmployeeInfoPkID
			END	
	
		ELSE

			BEGIN
		
			INSERT INTO hrmEmployeeImage(EmployeePkID,EmployeePicture)
			VALUES( @EmployeeInfoPkID,@ImageFile)
			END
END
GO
