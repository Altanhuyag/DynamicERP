IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Department_PrepareTree')
DROP PROC sphrm_Department_PrepareTree
GO

CREATE PROC [dbo].[sphrm_Department_PrepareTree] AS
BEGIN
   
	SELECT IDENTITY(Numeric(4), 1000,1) As IdentityId, DepartmentPkID, ParentPkID, GroupLevel, SortedOrder INTO #SortedTable 
	FROM hrmDepartmentInfo WHERE IsLastGroup='A'

	INSERT INTO #SortedTable(DepartmentPkID, ParentPkID, GroupLevel,SortedOrder)
	SELECT DepartmentPkID, ParentPkID, GroupLevel,SortedOrder FROM hrmDepartmentInfo
	ORDER BY ParentPkId, SequenceNo

	

   DECLARE Sorted_cursor CURSOR FOR
	SELECT DISTINCT GroupLevel FROM #SortedTable ORDER BY GroupLevel
   DECLARE @MyLevel Int
   OPEN Sorted_cursor
   FETCH NEXT FROM Sorted_cursor INTO @MyLevel
   WHILE @@FETCH_STATUS = 0
   BEGIN
     IF @MyLevel <> 0
        Update A Set A.SortedOrder=B.SortedOrder + Convert(Char(4),A.IdentityId)
        FROM #SortedTable A, #SortedTable B
	    WHERE A.ParentPkID=B.DepartmentPkID AND A.GroupLevel= @MyLevel
     ELSE
        Update #SortedTable Set SortedOrder=Convert(Char(4), IdentityId)
	    WHERE ParentPkId = '-1'
     FETCH NEXT FROM Sorted_Cursor INTO @MyLevel
   END
   CLOSE Sorted_Cursor
   DEALLOCATE Sorted_Cursor

   Update A Set A.SortedOrder=S.SortedOrder FROM hrmDepartmentInfo A, #SortedTable S 
   Where A.DepartmentPkID=S.DepartmentPkID
   RETURN @@ROWCOUNT
END

GO
