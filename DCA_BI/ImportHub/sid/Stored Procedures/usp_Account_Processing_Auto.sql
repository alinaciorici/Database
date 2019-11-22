


CREATE PROC [sid].[usp_Account_Processing_Auto]
/*
Author:			Collins Emetonjor 
Date:			05/11/2019
Description:	Load SID Account data in auto processing table 
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
  FROM sid.vw_Account_Transformed
  WHERE (BusinessRuleCheck NOT LIKE '%error%' OR BusinessRuleCheck IS NULL)
)
   OR EXISTS
(
  SELECT LoadId, 
         Id
  FROM sid.Account_Processing_Manual
  WHERE IsApproved='yes'
)
BEGIN
IF NOT EXISTS
(
  SELECT *
  FROM sid.Account_Processing_Auto
  WHERE concat( loadid, Id ) IN
  (
    SELECT Concat( loadid, Id )
    FROM sid.vw_Account_Transformed
     WHERE (BusinessRuleCheck NOT LIKE '%error%' OR BusinessRuleCheck IS NULL)
  )
)
BEGIN
INSERT INTO sid.Account_Processing_Auto
(LoadId, 
 ID, 
 [Action], 
 AutoApprove, 
 GroupNo, 
 GroupName, 
 Bristolmanaged, 
 ContractStartDate, 
 PMIHelpline, 
 ContractLength, 
 SalesType, 
 DependantsCovered, 
 NewContract, 
 AccountManagerName, 
 AccountManagerEmailAddress, 
 CoordinatorName, 
 CoordinatorEmailAddress, 
 FormName, 
 PrimaryCompName, 
 PrimaryCompEmail, 
 PrimaryCompTel, 
 IntermediaryContactName, 
 IntermediaryEmail, 
 IntermediaryTel, 
 Intermediary, 
 DirectContactAllowed, 
 CompanyFundedEmployeeCapped, 
 CompanyFundedDependantCapped, 
 CompanyFundedEmployeeUnlimited, 
 CompanyFundedDependantUnlimited, 
 FlexEmployeeUnlimited, 
 FlexDependantUnlimited, 
 OverallTotalLives, 
 NumberOfConsultationsPeremployee3CappedunLimited, 
 NumberofConsultationsperdependant3CappedunLimited, 
 AXAWorkingBody, 
 WorkingBodyExternalProvider, 
 AccesstoFastTrack, 
 AdvanceFastTrack, 
 AXAStrongerMinds, 
 AXAEAP, 
 EAPExternalProvider, 
 Notes, 
 ModifiedBy, 
 ModifiedDate, 
 IsProcessed, 
 ProcessedDate)
       SELECT LoadId, 
              ID, 
              [Action], 
              'Yes'               AutoApprove, 
              GroupNo, 
              GroupName, 
              Bristolmanaged, 
              ContractStartDate, 
              PMIHelpline, 
              ContractLength, 
              SalesType, 
              DependantsCovered, 
              NewContract, 
              AccountManagerName, 
              AccountManagerEmailAddress, 
              CoordinatorName, 
              CoordinatorEmailAddress, 
              FormName, 
              PrimaryCompName, 
              PrimaryCompEmail, 
              PrimaryCompTel, 
              IntermediaryContactName, 
              IntermediaryEmail, 
              IntermediaryTel, 
              Intermediary, 
              DirectContactAllowed, 
              CompanyFundedEmployeeCapped, 
              CompanyFundedDependantCapped, 
              CompanyFundedEmployeeUnlimited, 
              CompanyFundedDependantUnlimited, 
              FlexEmployeeUnlimited, 
              FlexDependantUnlimited, 
              x.OverallTotalLives, 
              NumberOfConsultationsPeremployee3CappedunLimited, 
              NumberofConsultationsperdependant3CappedunLimited, 
              AXAWorkingBody, 
              WorkingBodyExternalProvider, 
              AccesstoFastTrack, 
              AdvanceFastTrack, 
              AXAStrongerMinds, 
              AXAEAP, 
              EAPExternalProvider, 
              Notes, 
              'ADF'               ModifiedBy, 
              (SELECT GETDATE( )) ModifiedDate, 
              0                   IsProcessed, 
              NULL                ProcessedDate
       FROM sid.Account_staging a

	   -- Total Lives is based on total members indicated from the SID form
       OUTER APPLY
       (
         SELECT SUM( CONVERT( INT, xa.CompanyFundedEmployeeCapped )+CONVERT( INT, xa.CompanyFundedDependantCapped )+CONVERT( INT, xa.CompanyFundedEmployeeUnlimited )+CONVERT( INT, xa.CompanyFundedDependantUnlimited )+CONVERT( INT, xa.FlexEmployeeUnlimited )+CONVERT( INT, xa.FlexDependantUnlimited ) ) OverallTotalLives
         FROM sid.Account xa
         WHERE concat( xa.loadid, xa.Id )=concat( a.loadid, a.Id )
       ) x
       WHERE concat( loadid, Id ) IN
       (
         SELECT Concat( loadid, Id )
         FROM sid.vw_Account_Transformed
     WHERE (BusinessRuleCheck NOT LIKE '%error%' OR BusinessRuleCheck IS NULL)
       );
END;
IF NOT EXISTS
(
  SELECT *
  FROM sid.Account_Processing_Auto
  WHERE concat( loadid, Id ) IN
  (
    SELECT Concat( loadid, Id )
    FROM sid.Account_Processing_Manual
    WHERE IsApproved='yes'
  )
)
BEGIN
INSERT INTO sid.Account_Processing_Auto
(LoadId, 
 ID, 
 [Action], 
 AutoApprove, 
 GroupNo, 
 GroupName, 
 Bristolmanaged, 
 ContractStartDate, 
 PMIHelpline, 
 ContractLength, 
 SalesType, 
 DependantsCovered, 
 NewContract, 
 AccountManagerName, 
 AccountManagerEmailAddress, 
 CoordinatorName, 
 CoordinatorEmailAddress, 
 FormName, 
 PrimaryCompName, 
 PrimaryCompEmail, 
 PrimaryCompTel, 
 IntermediaryContactName, 
 IntermediaryEmail, 
 IntermediaryTel, 
 Intermediary, 
 DirectContactAllowed, 
 CompanyFundedEmployeeCapped, 
 CompanyFundedDependantCapped, 
 CompanyFundedEmployeeUnlimited, 
 CompanyFundedDependantUnlimited, 
 FlexEmployeeUnlimited, 
 FlexDependantUnlimited, 
 OverallTotalLives, 
 NumberOfConsultationsPeremployee3CappedunLimited, 
 NumberofConsultationsperdependant3CappedunLimited, 
 AXAWorkingBody, 
 WorkingBodyExternalProvider, 
 AccesstoFastTrack, 
 AdvanceFastTrack, 
 AXAStrongerMinds, 
 AXAEAP, 
 EAPExternalProvider, 
 Notes, 
 ModifiedBy, 
 ModifiedDate, 
 IsProcessed, 
 ProcessedDate)
       SELECT LoadId, 
              ID, 
              [Action], 
              'Yes' AutoApprove, 
              GroupNo, 
              GroupName, 
              Bristolmanaged, 
              ContractStartDate, 
              PMIHelpline, 
              ContractLength, 
              SalesType, 
              DependantsCovered, 
              NewContract, 
              AccountManagerName, 
              AccountManagerEmailAddress, 
              CoordinatorName, 
              CoordinatorEmailAddress, 
              FormName, 
              PrimaryCompName, 
              PrimaryCompEmail, 
              PrimaryCompTel, 
              IntermediaryContactName, 
              IntermediaryEmail, 
              IntermediaryTel, 
              Intermediary, 
              DirectContactAllowed, 
              CompanyFundedEmployeeCapped, 
              CompanyFundedDependantCapped, 
              CompanyFundedEmployeeUnlimited, 
              CompanyFundedDependantUnlimited, 
              FlexEmployeeUnlimited, 
              FlexDependantUnlimited, 
              x.OverallTotalLives, 
              NumberOfConsultationsPeremployee3CappedunLimited, 
              NumberofConsultationsperdependant3CappedunLimited, 
              AXAWorkingBody, 
              WorkingBodyExternalProvider, 
              AccesstoFastTrack, 
              AdvanceFastTrack, 
              AXAStrongerMinds, 
              AXAEAP, 
              EAPExternalProvider, 
              Notes, 
              ModifiedBy, 
              ModifiedDate, 
              0     IsProcessed, 
              NULL  ProcessedDate
       FROM sid.Account_Processing_Manual a

	   -- Total Lives is based on total members indicated from the SID form
       OUTER APPLY
       (
         SELECT SUM( CONVERT( INT, xa.CompanyFundedEmployeeCapped )+CONVERT( INT, xa.CompanyFundedDependantCapped )+CONVERT( INT, xa.CompanyFundedEmployeeUnlimited )+CONVERT( INT, xa.CompanyFundedDependantUnlimited )+CONVERT( INT, xa.FlexEmployeeUnlimited )+CONVERT( INT, xa.FlexDependantUnlimited ) ) OverallTotalLives
         FROM sid.Account xa
         WHERE concat( xa.loadid, xa.Id )=concat( a.loadid, a.Id )
       ) x
       WHERE concat( loadid, Id ) IN
       (
         SELECT Concat( loadid, Id )
         FROM sid.Account_Processing_Manual
         WHERE IsApproved='yes'
       );
END;
END;