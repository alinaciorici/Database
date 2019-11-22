
CREATE PROC [sid].[usp_Account_Processing_DynamicSync]

/*
Author:			Collins Emetonjor 
Date:			05/11/2019
Description:	Load SID Account data in a state that can be pushed to Dynamics
Project:


Testing: 
Change History

Developer:			Date:          Jira:				Description: 


*/

AS
     IF EXISTS
     (
         SELECT *
         FROM sys.tables
         WHERE name = 'Account_Processing_DynamicSync'

		 AND schema_id = 
		 (
		 SELECT schema_id FROM sys.schemas WHERE name = 'sid' 
		 )
     )
         BEGIN
             DROP TABLE sid.Account_Processing_DynamicSync;
     END

	 SELECT * 
	 INTO sid.Account_Processing_DynamicSync
	 FROM [sid].[vw_Account_Processing_DynamicSync]