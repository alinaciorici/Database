


CREATE PROC [sid].[usp_Account_Processed] 

/*
Author:			Collins Emetonjor 
Date:			05/11/2019
Description:	Load SID Account data into the processed table 
Project:


Testing: 
Change History

Developer:			Date:          Jira:				Description: 


*/

AS

	 

  
                 BEGIN
                     INSERT INTO [sid].[Account_Processed]
                     (
					 [LoadId]
      ,[ID]
      ,[Action]
      ,[AutoApprove]
      ,[GroupNo]
      ,[GroupName]
      ,[Bristolmanaged]
      ,[ContractStartDate]
      ,[PMIHelpline]
      ,[ContractLength]
      ,[SalesType]
      ,[DependantsCovered]
      ,[NewContract]
      ,[AccountManagerName]
      ,[AccountManagerEmailAddress]
      ,[CoordinatorName]
      ,[CoordinatorEmailAddress]
      ,[FormName]
      ,[PrimaryCompName]
      ,[PrimaryCompEmail]
      ,[PrimaryCompTel]
      ,[IntermediaryContactName]
      ,[IntermediaryEmail]
      ,[IntermediaryTel]
      ,[Intermediary]
      ,[DirectContactAllowed]
      ,[CompanyFundedEmployeeCapped]
      ,[CompanyFundedDependantCapped]
      ,[CompanyFundedEmployeeUnlimited]
      ,[CompanyFundedDependantUnlimited]
      ,[FlexEmployeeUnlimited]
      ,[FlexDependantUnlimited]
      ,[OverallTotalLives]
      ,[NumberOfConsultationsPeremployee3CappedunLimited]
      ,[NumberofConsultationsperdependant3CappedunLimited]
      ,[AXAWorkingBody]
      ,[WorkingBodyExternalProvider]
      ,[AccesstoFastTrack]
      ,[AdvanceFastTrack]
      ,[AXAStrongerMinds]
      ,[AXAEAP]
      ,[EAPExternalProvider]
      ,[Notes]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsProcessed]
      ,[ProcessedDate]
                     )
                            SELECT [LoadId]
      ,[ID]
      ,[Action]
      ,'Yes'[AutoApprove]
      ,[GroupNo]
      ,[GroupName]
      ,[Bristolmanaged]
      ,[ContractStartDate]
      ,[PMIHelpline]
      ,[ContractLength]
      ,[SalesType]
      ,[DependantsCovered]
      ,[NewContract]
      ,[AccountManagerName]
      ,[AccountManagerEmailAddress]
      ,[CoordinatorName]
      ,[CoordinatorEmailAddress]
      ,[FormName]
      ,[PrimaryCompName]
      ,[PrimaryCompEmail]
      ,[PrimaryCompTel]
      ,[IntermediaryContactName]
      ,[IntermediaryEmail]
      ,[IntermediaryTel]
      ,[Intermediary]
      ,[DirectContactAllowed]
      ,[CompanyFundedEmployeeCapped]
      ,[CompanyFundedDependantCapped]
      ,[CompanyFundedEmployeeUnlimited]
      ,[CompanyFundedDependantUnlimited]
      ,[FlexEmployeeUnlimited]
      ,[FlexDependantUnlimited]
      ,[OverallTotalLives]
      ,[NumberOfConsultationsPeremployee3CappedunLimited]
      ,[NumberofConsultationsperdependant3CappedunLimited]
      ,[AXAWorkingBody]
      ,[WorkingBodyExternalProvider]
      ,[AccesstoFastTrack]
      ,[AdvanceFastTrack]
      ,[AXAStrongerMinds]
      ,[AXAEAP]
      ,[EAPExternalProvider]
      ,[Notes]

                                   ,'ADF' [ModifiedBy] 
                                   ,(select getdate()) [ModifiedDate] 
                                   ,1 [IsProcessed]
                                   ,(select getdate()) [ProcessedDate]
                            FROM sid.Account a
                            WHERE concat(loadid, Id) IN
                            (
                                SELECT Concat(loadid, Id)
                                FROM [sid].[Account_Processing_DynamicSync]
     
                            );

UPDATE sid.Account 
SET [IsProcessed] = 1,[ProcessedDate] = (select getdate())

 WHERE concat(loadid, Id) IN
                            (
                                SELECT Concat(loadid, Id)
                                FROM [sid].[Account_Processing_DynamicSync]
     )


UPDATE [sid].[Account_Staging]
SET [IsProcessed] = 1,[ProcessedDate] = (select getdate())

 WHERE concat(loadid, Id) IN
                            (
                                SELECT Concat(loadid, Id)
                                FROM [sid].[Account_Processing_DynamicSync]
     )


            
            


UPDATE [sid].[Account_Processing_Auto]
SET [IsProcessed] = 1,[ProcessedDate] = (select getdate())

 WHERE concat(loadid, Id) IN
                            (
                                SELECT Concat(loadid, Id)
                                FROM [sid].[Account_Processing_DynamicSync]
     )


             END;