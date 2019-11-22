



CREATE PROC [sid].[usp_Account_Processing_Manual] 

/*
Author:			Collins Emetonjor 
Date:			05/11/2019
Description:	Load SID Account data in manual processing table 
Project:


Testing: 
Change History

Developer:			Date:          Jira:				Description: 


*/

AS
     IF EXISTS
     (
         SELECT LoadId, 
                Id
         FROM [sid].[vw_Account_Transformed]
         WHERE [BusinessRuleCheck] LIKE '%error%'
     )
         BEGIN

             -- remove already processed data 
             --DELETE FROM [sid].[Account_Processing_Manual]
             --WHERE [IsProcessed] = 1

             IF NOT EXISTS
             (
                 SELECT *
                 FROM [sid].[Account_Processing_Manual]
                 WHERE concat(loadid, Id) IN
                 (
                     SELECT Concat(loadid, Id)
                     FROM [sid].[vw_Account_Transformed]
                     WHERE [BusinessRuleCheck] LIKE '%error%'
                 )
             )
                 BEGIN
                     INSERT INTO [sid].[Account_Processing_Manual]
                     ([LoadId], 
                      [ID], 
                      [Action], 
                      [IsApproved], 
                      [ApprovalNote], 
                      [GroupNo], 
                      [GroupName], 
                      [Bristolmanaged], 
                      [ContractStartDate], 
                      [PMIHelpline], 
                      [ContractLength], 
                      [SalesType], 
                      [DependantsCovered], 
                      [NewContract], 
                      [AccountManagerName], 
                      [AccountManagerEmailAddress], 
                      [CoordinatorName], 
                      [CoordinatorEmailAddress], 
                      [FormName], 
                      [PrimaryCompName], 
                      [PrimaryCompEmail], 
                      [PrimaryCompTel], 
                      [IntermediaryContactName], 
                      [IntermediaryEmail], 
                      [IntermediaryTel], 
                      [Intermediary], 
                      [DirectContactAllowed], 
                      [CompanyFundedEmployeeCapped], 
                      [CompanyFundedDependantCapped], 
                      [CompanyFundedEmployeeUnlimited], 
                      [CompanyFundedDependantUnlimited], 
                      [FlexEmployeeUnlimited], 
                      [FlexDependantUnlimited], 
                      [OverallTotalLives], 
                      [NumberOfConsultationsPeremployee3CappedunLimited], 
                      [NumberofConsultationsperdependant3CappedunLimited], 
                      [AXAWorkingBody], 
                      [WorkingBodyExternalProvider], 
                      [AccesstoFastTrack], 
                      [AdvanceFastTrack], 
                      [AXAStrongerMinds], 
                      [AXAEAP], 
                      [EAPExternalProvider], 
                      [Notes], 
                      [ModifiedBy], 
                      [ModifiedDate], 
                      [IsProcessed], 
                      [ProcessedDate],
					  BusinessRuleCheck
                     )
                            SELECT [LoadId], 
                                   [ID], 
                                   [Action], 
                                   'No' [IsApproved], 
                                   NULL [ApprovalNote], 
                                   [GroupNo], 
                                   [GroupName], 
                                   [Bristolmanaged], 
                                   [ContractStartDate], 
                                   [PMIHelpline], 
                                   [ContractLength], 
                                   [SalesType], 
                                   [DependantsCovered], 
                                   [NewContract], 
                                   [AccountManagerName], 
                                   [AccountManagerEmailAddress], 
                                   [CoordinatorName], 
                                   [CoordinatorEmailAddress], 
                                   [FormName], 
                                   [PrimaryCompName], 
                                   [PrimaryCompEmail], 
                                   [PrimaryCompTel], 
                                   [IntermediaryContactName], 
                                   [IntermediaryEmail], 
                                   [IntermediaryTel], 
                                   [Intermediary], 
                                   [DirectContactAllowed], 
                                   [CompanyFundedEmployeeCapped], 
                                   [CompanyFundedDependantCapped], 
                                   [CompanyFundedEmployeeUnlimited], 
                                   [CompanyFundedDependantUnlimited], 
                                   [FlexEmployeeUnlimited], 
                                   [FlexDependantUnlimited], 
                                   xa.[OverallTotalLives], 
                                   [NumberOfConsultationsPeremployee3CappedunLimited], 
                                   [NumberofConsultationsperdependant3CappedunLimited], 
                                   [AXAWorkingBody], 
                                   [WorkingBodyExternalProvider], 
                                   [AccesstoFastTrack], 
                                   [AdvanceFastTrack], 
                                   [AXAStrongerMinds], 
                                   [AXAEAP], 
                                   [EAPExternalProvider], 
                                   [Notes], 
                                   NULL [ModifiedBy], 
                                   NULL [ModifiedDate], 
                                   0 [IsProcessed], 
                                   NULL [ProcessedDate],
								   BusinessRuleCheck
                            FROM sid.Account_staging a 

							OUTER APPLY (
							SELECT TOP 1 BusinessRuleCheck FROM [sid].[vw_Account_Transformed] tr
                                WHERE [BusinessRuleCheck] LIKE '%error%'
								AND a.[LoadId] =  tr.LoadId
                                AND a.[ID] = tr.ID
								)x

								-- Total Lives is based on total members indicated from the SID form
       OUTER APPLY
       (
         SELECT SUM( CONVERT( INT, xa.CompanyFundedEmployeeCapped )+CONVERT( INT, xa.CompanyFundedDependantCapped )+CONVERT( INT, xa.CompanyFundedEmployeeUnlimited )+CONVERT( INT, xa.CompanyFundedDependantUnlimited )+CONVERT( INT, xa.FlexEmployeeUnlimited )+CONVERT( INT, xa.FlexDependantUnlimited ) ) OverallTotalLives
         FROM sid.Account_staging xa
         WHERE concat( xa.loadid, xa.Id )=concat( a.loadid, a.Id )
       ) xa

                            WHERE concat(loadid, Id) IN
                            (
                                SELECT Concat(loadid, Id)
                                FROM [sid].[vw_Account_Transformed]
                                WHERE [BusinessRuleCheck] LIKE '%error%'
                            );
             END;
     END;