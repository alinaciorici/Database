






CREATE PROC [membership].[usp_MembershipList_clean_Lead_Dependant] 


/*
Author:			Collins Emetonjor 
Date:			12/06/2019
Description:	Load MembershipList_clean_Lead_Dependant Table
Project:


Change History

Developer:			Date:          Jira:				Description: 


*/

AS
BEGIN

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'MembershipList_clean_Lead_Dependant')
BEGIN
DROP TABLE [membership].[MembershipList_clean_Lead_Dependant]
END

SELECT * INTO [membership].[MembershipList_clean_Lead_Dependant]
FROM [membership].[vw_MembershipList_clean_Lead_Dependant]
END;


--CREATE INDEX idx_Fuzzy_Membership_Lead_Dependant ON  [staging].[Fuzzy_Membership_Lead_Dependant] ([dca_ContactId])