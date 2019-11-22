

CREATE PROC [membership].[usp_MembershipList_clean]

/*
Author:			Collins Emetonjor 
Date:			12/06/2019
Description:	Load MembershipList_clean Table
Project:


Change History

Developer:			Date:          Jira:				Description: 


*/

AS
    BEGIN

	-- Clean up
	   IF OBJECT_ID('tempdb..#Deleted_PH_MemberNumber', 'U') IS NOT NULL
         DROP TABLE #Deleted_PH_MemberNumber;




        IF EXISTS
        (
            SELECT *
            FROM sys.tables
            WHERE name = 'MembershipList_clean'
                  AND schema_id =
            (
                SELECT TOP 1 schema_id
                FROM sys.schemas
                WHERE name = 'membership'
            )
        )
            BEGIN
                DROP TABLE [membership].[MembershipList_clean];
        END;
        SELECT *
        INTO [membership].[MembershipList_clean]
        FROM [membership].[vw_MembershipList_clean];
    END;
        CREATE INDEX idx_MembershipList_clean ON [membership].[MembershipList_clean]([MembershipNumber], [Relationship]);
        CREATE INDEX idx_MembershipList_clean_2 ON [membership].[MembershipList_clean](GroupNumber, [FullName]);

        -- Post Update on Group Number
        -- Check if lenght of Group Number is less than 5 characters
        IF EXISTS
        (
            SELECT concat('0', LTRIM(RTRIM(GroupNumber)))
            FROM membership.MembershipList_clean
            WHERE LEN(LTRIM(RTRIM(GroupNumber))) = 4
                  AND LEFT(GroupNumber, 1) <> 0
        )
            BEGIN
                UPDATE membership.MembershipList_clean
                  SET 
                      GroupNumber = concat('0', LTRIM(RTRIM(GroupNumber)))
                WHERE LEN(LTRIM(RTRIM(GroupNumber))) = 4
                      AND LEFT(GroupNumber, 1) <> 0;
        END;
        UPDATE membership.MembershipList_clean
          SET 
              [MembershipNumber] = LTRIM(RTRIM(MembershipNumber));
        UPDATE membership.MembershipList_clean
          SET 
              [FirstName] = LTRIM(RTRIM(FirstName));
        UPDATE membership.MembershipList_clean
          SET 
              [LastName] = LTRIM(RTRIM(LastName));

        --UPDATE membership.MembershipList_clean 
        --SET [FullName] = LTRIM(RTRIM(FullName))

        UPDATE membership.MembershipList_clean
          SET 
              [DateOfBirth] = LTRIM(RTRIM(DateOfBirth));
        UPDATE membership.MembershipList_clean
          SET 
              [GroupNumber] = LTRIM(RTRIM(GroupNumber));

-- Deleted Policy Holder Members
-- Once the policy holder is deleted, every member on the policy is deleted as well

		SELECT [MembershipNumber]
		INTO #Deleted_PH_MemberNumber
		FROM [membership].[MembershipList]
		WHERE [Relationship] = 'Policy Holder'
			  AND [Action_AMD_Add_Modify_Delete] = 'D';


		UPDATE membership.MembershipList_clean
		  SET 
			  [Action_AMD_Add_Modify_Delete] = 'D'
		WHERE [MembershipNumber] IN
		(
			SELECT [MembershipNumber]
			FROM #Deleted_PH_MemberNumber
		)
			  AND [Action_AMD_Add_Modify_Delete] <> 'D';