CREATE PROC [membership].[usp_membership_Reset]

/*
Author:			Collins Emetonjor 
Date:			05/11/2019
Description:	To reset all tables used for membership Processing
Project:


Testing: 
Change History

Developer:			Date:          Jira:				Description: 


*/

AS
    BEGIN
        TRUNCATE TABLE [admin_membership].[Load];
        TRUNCATE TABLE [admin_membership].[ProcessingLog];
        TRUNCATE TABLE [membership].[MembershipList];
        TRUNCATE TABLE [membership].[MembershipList_clean];
        TRUNCATE TABLE [membership].[MembershipList_clean_Lead_Dependant];
        TRUNCATE TABLE [membership].[MembershipList_clean_Lead_Primary];
        TRUNCATE TABLE [membership].[reporting_Account_Check];
    END;