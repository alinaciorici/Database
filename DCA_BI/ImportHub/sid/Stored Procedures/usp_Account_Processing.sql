




CREATE PROC [sid].[usp_Account_Processing] 

/*
Author:			Collins Emetonjor 
Date:			05/11/2019
Description:	Post Processing For SID Account Data
Project:


Testing: 
Change History

Developer:			Date:          Jira:				Description: 


*/

AS



  
BEGIN
EXEC [sid].[usp_Account_Staging]
EXEC [sid].[usp_Account_Processing_Manual]
EXEC [sid].[usp_Account_Processing_Auto]
EXEC [sid].[usp_Account_Processing_DynamicSync]

END;