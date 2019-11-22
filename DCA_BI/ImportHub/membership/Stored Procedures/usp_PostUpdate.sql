



CREATE PROC [membership].[usp_PostUpdate]

/*
Author:			Collins Emetonjor 
Date:			12/06/2019
Description:	Post processing of data
Project:




Change History

Developer:			Date:          Jira:				Description: 


*/

AS
     --  delay to ensure all data needed must have been loaded
     WAITFOR DELAY '00:00:30';


	 -- Capture start of post processing
     INSERT INTO [admin_membership].[ProcessingLog]
     ([LoadType], 
      [StartTime]
     )
            SELECT 'Membership - Post Processsing', 
                   GETDATE();
     PRINT CONCAT('Running usp_MembershipList_clean ran @ ', CURRENT_TIMESTAMP);
     EXEC [membership].[usp_MembershipList_clean];
     PRINT CONCAT('Running usp_reporting_Account_Check ran @ ', CURRENT_TIMESTAMP);
     EXEC [membership].[usp_reporting_Account_Check];
     PRINT CONCAT('Running [axa].[usp_MembershipList_clean_Lead_Primary] ran @ ', CURRENT_TIMESTAMP);
     EXEC [membership].[usp_MembershipList_clean_Lead_Primary];

     -- Dependent on processing of Primary data -> [axa].[usp_MembershipList_clean_Lead_Primary]

     PRINT CONCAT('Running [axa].[usp_MembershipList_clean_Lead_Dependant] ran @ ', CURRENT_TIMESTAMP);
     EXEC [membership].[usp_MembershipList_clean_Lead_Dependant];

     -- process data for Veda View
     PRINT CONCAT('Running [veda].[usp_Appointment] ran @ ', CURRENT_TIMESTAMP);
     EXEC [veda].[usp_Appointment];
     PRINT CONCAT('All steps completed @ ', CURRENT_TIMESTAMP);

	 	 -- Capture end of post processing

     UPDATE [admin_membership].[ProcessingLog]
       SET 
           [EndTime] = GETDATE()
     WHERE ID =
     (
         SELECT MAX(ID)
         FROM [admin_membership].[ProcessingLog]
         WHERE LoadType = 'Membership - Post Processsing'
     );