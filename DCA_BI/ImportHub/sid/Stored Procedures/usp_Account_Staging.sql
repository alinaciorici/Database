CREATE PROC [sid].[usp_Account_Staging]

/*
Author:			Collins Emetonjor 
Date:			05/11/2019
Description:	Load SID Account data into staging table 
Project:


Testing: 
Change History

Developer:			Date:          Jira:				Description: 


*/

AS
    BEGIN
        INSERT INTO [sid].[Account_Staging]
        ([LoadId], 
         [ID], 
         [Action], 
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
         [IsProcessed], 
         [ProcessedDate]
        )
               SELECT [LoadId], 
                      [ID], 
                      [Action], 
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
                      [IsProcessed], 
                      ProcessedDate

               -- bring through all 
               FROM sid.Account a
               WHERE(a.[InStaging] IS NULL
                     OR a.[InStaging] = 0);
        UPDATE sid.Account
          SET 
              [InStaging] = 1
        WHERE concat(loadid, Id) IN
        (
            SELECT Concat(loadid, Id)
            FROM sid.Account_Staging
        )
              AND ([InStaging] IS NULL
                   OR [InStaging] = 0);
    END;
        UPDATE A
          SET 
              A.GroupNo = B.GroupNo, 
              A.GroupName = B.GroupName, 
              A.Bristolmanaged = B.Bristolmanaged, 
              A.ContractStartDate = B.ContractStartDate, 
              A.PMIHelpline = B.PMIHelpline, 
              A.ContractLength = B.ContractLength, 
              A.SalesType = B.SalesType, 
              A.DependantsCovered = B.DependantsCovered, 
              A.NewContract = B.NewContract, 
              A.AccountManagerName = B.AccountManagerName, 
              A.AccountManagerEmailAddress = B.AccountManagerEmailAddress, 
              A.CoordinatorName = B.CoordinatorName, 
              A.CoordinatorEmailAddress = B.CoordinatorEmailAddress, 
              A.FormName = B.FormName, 
              A.PrimaryCompName = B.PrimaryCompName, 
              A.PrimaryCompEmail = B.PrimaryCompEmail, 
              A.PrimaryCompTel = B.PrimaryCompTel, 
              A.IntermediaryContactName = B.IntermediaryContactName, 
              A.IntermediaryEmail = B.IntermediaryEmail, 
              A.IntermediaryTel = B.IntermediaryTel, 
              A.Intermediary = B.Intermediary, 
              A.DirectContactAllowed = B.DirectContactAllowed, 
              A.CompanyFundedEmployeeCapped = B.CompanyFundedEmployeeCapped, 
              A.CompanyFundedDependantCapped = B.CompanyFundedDependantCapped, 
              A.CompanyFundedEmployeeUnlimited = B.CompanyFundedEmployeeUnlimited, 
              A.CompanyFundedDependantUnlimited = B.CompanyFundedDependantUnlimited, 
              A.FlexEmployeeUnlimited = B.FlexEmployeeUnlimited, 
              A.FlexDependantUnlimited = B.FlexDependantUnlimited, 
              A.OverallTotalLives = B.OverallTotalLives, 
              A.NumberOfConsultationsPeremployee3CappedunLimited = B.NumberOfConsultationsPeremployee3CappedunLimited, 
              A.NumberofConsultationsperdependant3CappedunLimited = B.NumberofConsultationsperdependant3CappedunLimited, 
              A.AXAWorkingBody = B.AXAWorkingBody, 
              A.WorkingBodyExternalProvider = B.WorkingBodyExternalProvider, 
              A.AccesstoFastTrack = B.AccesstoFastTrack, 
              A.AXAStrongerMinds = B.AXAStrongerMinds, 
              A.AXAEAP = B.AXAEAP, 
              A.EAPExternalProvider = B.EAPExternalProvider, 
              A.Notes = B.Notes
        FROM [sid].[Account_Staging] A
             JOIN [sid].[Account_Processing_Manual] B ON concat(a.loadid, a.Id) = concat(b.loadid, b.Id)
        WHERE [IsApproved] = 'Yes';

        -- Changes applied to staging. Safe to Delete
        DELETE FROM [sid].[Account_Processing_Manual]
        WHERE [IsApproved] = 'Yes';