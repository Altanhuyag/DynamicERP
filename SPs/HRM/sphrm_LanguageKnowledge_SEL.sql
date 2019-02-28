IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LanguageKnowledge_SEL')
DROP PROC sphrm_LanguageKnowledge_SEL
GO
CREATE PROC sphrm_LanguageKnowledge_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT A.*, G.RegisterNo, G.FirstName, B.LanguageName, C.ValueStr1 as ReadingName, D.ValueStr1 as WritingName, E.ValueStr1 as TalkingName, F.ValueStr1 as ListeningName
	FROM hrmLanguageKnowledge A 
		JOIN hrmEmployeeInfo G ON G.EmployeeInfoPkID=A.EmployeeInfoPkID
		JOIN hrmLanguageInfo B ON A.LanguagePkID=B.LanguagePkID
		JOIN (select * from smmConstants where UPPER(ConstType)=UPPER('hrmKnowledge')) C	ON A.Reading=C.ValueNum
		JOIN (select * from smmConstants where UPPER(ConstType)=UPPER('hrmKnowledge')) D	ON A.Writing=D.ValueNum
		JOIN (select * from smmConstants where UPPER(ConstType)=UPPER('hrmKnowledge')) E	ON A.Talking=E.ValueNum
		JOIN (select * from smmConstants where UPPER(ConstType)=UPPER('hrmKnowledge')) F	ON A.Listening=F.ValueNum
END
GO