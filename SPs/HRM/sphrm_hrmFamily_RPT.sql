IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmFamily_RPT')
DROP PROC sphrm_hrmFamily_RPT
GO
CREATE PROC sphrm_hrmFamily_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN

select E.FirstName as ChildName , E.FamilyRegisterNo,H.FamilyMemberName from hrmEmployeeInfo A
inner join (
select * from hrmFamily F) E on A.EmployeeInfoPkID = E.EmployeeInfoPkID
inner join hrmPositionInfo P on A.PositionPkID = P.PositionPkID

inner join (
select * from smmConstants
where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on A.Gender = M.ValueNum
inner join (
select *  from hrmFamilyMemberInfo) H on E.FamilyMemberPkID = H.FamilyMemberPkID
 order by A.FirstName



END
GO
