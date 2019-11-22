
CREATE PROC [membership].[usp_MembershipList_clean_Lead_Primary]

/*
Author:			Collins Emetonjor 
Date:			12/06/2019
Description:	Load MembershipList_clean_Lead_Primary Table
Project:


Change History

Developer:			Date:          Jira:				Description: 


*/

AS
    BEGIN

        /* clean up*/

        IF OBJECT_ID('tempdb..#temp_MembershipList_clean', 'U') IS NOT NULL
            DROP TABLE #temp_MembershipList_clean;
        IF OBJECT_ID('tempdb..#temp_dw_lead', 'U') IS NOT NULL
            DROP TABLE #temp_dw_lead;

        /* Get Data */

        SELECT aml.[MembershipNumber], 
               [Title], 
               [FirstName], 
               [LastName], 
               [FullName], 
               [DateOfBirth], 
               [GroupNumber], 
               [ProductName], 
               [Relationship], 
               --[AddressLine1], 
               --[AddressLine2], 
               --[AddressLine3], 
               --[AddressLine4], 
               --[PostCode], 
               [EmailAddress], 
               [Action_AMD_Add_Modify_Delete], 
               [LoadId]
        INTO #temp_MembershipList_clean
        FROM [membership].[MembershipList_clean] aml;


        SELECT L.ReferenceNumber Lead_ReferenceNumber, 
               L.AccountId Lead_AccountId, 
               L.ContactId Lead_ContactId, 
               c.[ReferenceNumber] ContactReferenceNumber, 
               L.OriginalContactId Lead_OriginalContactId, 
               L.IsConverted Lead_IsConverted, 
               L.FullName Lead_FullName, 
               l.OrganisationMemberId, 
               l.[CreateDate]
        INTO #temp_dw_lead
        FROM [dw].[Lead] L
             LEFT JOIN [dw].[Contact] c ON L.ContactId = c.ContactId
        WHERE L.OrganisationMemberId IS NOT NULL;


        BEGIN
            DROP TABLE [membership].[MembershipList_clean_Lead_Primary];
        END;


        SELECT *
        INTO [membership].[MembershipList_clean_Lead_Primary]
        FROM #temp_MembershipList_clean mc
             OUTER APPLY
        (
            SELECT TOP 1 l.*
            FROM #temp_dw_lead l
            WHERE mc.MembershipNumber = l.OrganisationMemberId
            ORDER BY L.Lead_IsConverted DESC, -- added, there are cases of two or leads with the same Org member ID where only one lead is converted. eg. 4989553M

                     l.[CreateDate] DESC
        ) x
             OUTER APPLY
        (
            SELECT Lo.TimeStamp LoadFileTimeStamp
            FROM [admin_membership].[Load] Lo
            WHERE lo.LoadId = mc.LoadId
        ) x2
        WHERE mc.Relationship = 'Policy Holder';
        CREATE INDEX idx_MembershipList_clean_Lead_Primary ON [membership].[MembershipList_clean_Lead_Primary]([Lead_ContactId]);
    END;