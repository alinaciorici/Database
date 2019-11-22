




CREATE PROC [sid].[usp_Account_Reset] 

/*
Author:			Collins Emetonjor 
Date:			05/11/2019
Description:	To reset all tables used for SID account Processing
Project:


Testing: 
Change History

Developer:			Date:          Jira:				Description: 


*/

AS



  
BEGIN
  TRUNCATE TABLE [admin_sid].[Load]
   TRUNCATE TABLE [sid].[Account];
  TRUNCATE TABLE [sid].[Account_Staging];
  TRUNCATE TABLE [sid].[Account_Processed];
  TRUNCATE TABLE [sid].[Account_Processing_Auto];
  TRUNCATE TABLE [sid].[Account_Processing_Manual];
  TRUNCATE TABLE [sid].[Account_Staging];

END;