












--/****** Object:  View [sid].[vw_Account_Transformed]    Script Date: 02/11/2019 04:58:06 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


CREATE VIEW [sid].[vw_Account_Processing_DynamicSync]

as

SELECT  [LoadId], 
                  [ID], 
                  [Action], 
				  convert(uniqueidentifier, null) AccountID,
                  [GroupNo] bu_externalaccountreference, 
                  [admin].[fn_ProperCase]([GroupName]) Name, 
                  CONVERT(DATE, concat(SUBSTRING([ContractStartDate], 7, 4), SUBSTRING([ContractStartDate], 4, 2), SUBSTRING([ContractStartDate], 1, 2))) [bu_contractstartdate], 

				  CASE WHEN 
				  -- check if actual numbers can be extracted from the contract lenght data. Eg. 2 Month
				  TRY_CONVERT(int,(replace(ContractLength, 'Month',''))) IS NOT NULL 
				  
				  THEN DATEADD(MONTH, TRY_CONVERT(int,(replace(ContractLength, 'Month',''))),
				  CONVERT(DATE, concat(SUBSTRING([ContractStartDate], 7, 4), SUBSTRING([ContractStartDate], 4, 2), SUBSTRING([ContractStartDate], 1, 2))))
				  END
				  [bu_org_end_of_contract_renewal_date_m],

				  [PMIHelpline] [bu_org_working_body_phone_number],
                  --[ContractStartDate], 
                 -- [Bristolmanaged], 
      
                  CONVERT(INT,bu_axasalestype)bu_axasalestype, 

				  --DependentsPaidFor_Corppaid
				  --DependentsPaidFor_Flex
				  --DependentsPaidFor_No


				  /*
				  Rules for bu_org_dependant_paid_for_already field. 
				  An account must have members on capped or unlimited or flex plans. 
				  
					* Display error when an account have members on more than one type of plan. 
					* we mean any of these senarios 
						1: The account have people on the capped (either employees or dependants) and flex plans (either employees or dependants)
						2: The account have people on the Unlimited (either employees or dependants) and flex plans (either employees or dependants)
   						3: The account have people on the Unlimited (either employees or dependants) and capped (either employees or dependants)
					* Display error if 0 is set across the board. 
				  
				  */

				  CASE 

				   WHEN A.DependantsCovered = 'No' THEN  DependentsPaidFor_No.bu_org_dependant_paid_for_already


				--  WHEN 
				--  ([CompanyFundedEmployeeCapped] is null or [CompanyFundedEmployeeCapped] = 0) AND 
				--    ([CompanyFundedDependantCapped] is null or [CompanyFundedDependantCapped] = 0) AND
				--	  ([CompanyFundedEmployeeUnlimited] is null or [CompanyFundedEmployeeUnlimited] = 0) AND
				--	    ([CompanyFundedDependantUnlimited] is null or [CompanyFundedDependantUnlimited] = 0) AND 
				--		  ([FlexEmployeeUnlimited] is null or [FlexEmployeeUnlimited] = 0) AND 
				--		    ([FlexDependantUnlimited] is null or [FlexDependantUnlimited] = 0)  
				--			THEN 'Error-No Contact in Capped/Unlimited/Flex plans'

				--WHEN 
				--  (
				--  ([CompanyFundedEmployeeCapped] > 0 OR [CompanyFundedDependantCapped] > 0) AND 
				--  ([FlexEmployeeUnlimited] > 0 OR [FlexEmployeeUnlimited] > 0) 
				--  )
				--		THEN 'Error-Contacts in both Capped/Flex plans'

				--WHEN 
				--  (
				--  ([CompanyFundedEmployeeUnlimited] > 0 OR [CompanyFundedDependantUnlimited] > 0) AND 
				--  ([FlexEmployeeUnlimited] > 0 OR [FlexEmployeeUnlimited] > 0) 
				--  )		THEN 'Error-Contacts in both Unlimited/Flex plans'

				--  	WHEN 
				--  (
				--  ([CompanyFundedEmployeeUnlimited] > 0 OR [CompanyFundedDependantUnlimited] > 0) AND 
				--  ([CompanyFundedEmployeeCapped] > 0 OR [CompanyFundedDependantCapped] > 0) 
				--  )		THEN 'Error-Contacts in both Capped/Unlimited plans' 


				 
				  WHEN A.DependantsCovered = 'Yes' AND (a.CompanyFundedDependantCapped > 0 OR a.CompanyFundedDependantUnlimited >0) 
				  THEN DependentsPaidFor_Corppaid.bu_org_dependant_paid_for_already

				  WHEN (a.FlexEmployeeUnlimited > 0 OR a.FlexDependantUnlimited >0) 
				  THEN DependentsPaidFor_Flex.bu_org_dependant_paid_for_already

				  END AS bu_org_dependant_paid_for_already,

				  ISNULL(RelationshipId_d.bu_Relationship, RelationshipId_CP.bu_Relationship)bu_Relationship,
                --  [DependantsCovered], 
                 -- [NewContract], 
                --  [AccountManagerName], 
                --  [AccountManagerEmailAddress], 
                --  [CoordinatorName], 
                --  [CoordinatorEmailAddress], 
                -- -- [FormName], 
                --  [PrimaryCompName], 
                --  [PrimaryCompEmail], 
                --[PrimaryCompTel], 
                --  [IntermediaryContactName], 
                --  [IntermediaryEmail], 
                --  [IntermediaryTel], 
                --  [Intermediary], 
                  --[DirectContactAllowed], 
                  --[CompanyFundedEmployeeCapped], 
                  --[CompanyFundedDependantCapped], 
                  --[CompanyFundedEmployeeUnlimited], 
                  --[CompanyFundedDependantUnlimited], 
                  --[FlexEmployeeUnlimited], 
                  --[FlexDependantUnlimited], 
                  --CONVERT(INT,[OverallTotalLives]) bu_org_approx_number_of_core_lives, 
 ( convert(int,[CompanyFundedEmployeeCapped]) + convert(int,[CompanyFundedDependantCapped])  + convert(int,[CompanyFundedEmployeeUnlimited])  + convert(int,[CompanyFundedDependantUnlimited])  + convert(int,[FlexEmployeeUnlimited])  + convert(int,[FlexDependantUnlimited]) 
				 ) bu_org_approx_number_of_core_lives, 
				  
				  CONVERT(INT,
				  CASE 
				  WHEN ([CompanyFundedEmployeeUnlimited] > 0 AND CompanyFundedEmployeeCapped < 1) THEN CompanyFundedEmployeeUnlimited
				  WHEN ([CompanyFundedEmployeeCapped] > 0 AND CompanyFundedEmployeeUnlimited < 1) THEN CompanyFundedEmployeeCapped
		      END)
bu_Openingpopulationforemployees,
 CONVERT(INT,
				  CASE 
				  WHEN ([CompanyFundedDependantUnlimited] > 0 AND CompanyFundedDependantCapped < 1) THEN CompanyFundedDependantUnlimited
				  WHEN ([CompanyFundedDependantCapped] > 0 AND CompanyFundedDependantUnlimited < 1) THEN CompanyFundedDependantCapped
		      END
			  )

bu_Openingpopulationfordependants,

                  --[NumberOfConsultationsPeremployee3CappedunLimited], 
                  --[NumberofConsultationsperdependant3CappedunLimited], 

				  CONVERT(INT, Isnull(Unlimited.bu_org_capped_unlimited_appointments,Capped.bu_org_capped_unlimited_appointments))bu_org_capped_unlimited_appointments,
                  --[AXAWorkingBody], 
                  --[WorkingBodyExternalProvider], 
                  --[AccesstoFastTrack], 
                  --[AdvanceFastTrack], 
                  --[AXAStrongerMinds], 
                  --[AXAEAP], 
                  --[EAPExternalProvider], 
				  
				  CASE 
				  WHEN AccesstoFastTrack = 'yes' AND AXAWorkingBody = 'yes' AND AXAStrongerMinds = 'no' THEN 'AxaA'
				  WHEN AccesstoFastTrack = 'no' AND AXAWorkingBody = 'yes' AND AXAStrongerMinds = 'yes' THEN 'AxaB'
				  WHEN AccesstoFastTrack = 'yes' AND AXAWorkingBody = 'yes' AND AXAStrongerMinds = 'yes' THEN 'AxaC'
				  WHEN AccesstoFastTrack = 'yes' AND AXAWorkingBody = 'no' AND AXAStrongerMinds = 'yes' THEN 'AxaE'
				  WHEN AccesstoFastTrack = 'no' AND AXAWorkingBody = 'yes' AND AXAStrongerMinds = 'no' THEN 'AxaF'
				  WHEN AccesstoFastTrack = 'no' AND AXAWorkingBody = 'no' AND AXAStrongerMinds = 'no' THEN 'NoBenfs'
				  ELSE NULL END
				
				  bu_migrationkey,
                  [Notes]
FROM [sid].[Account_Processing_Auto]   A

OUTER APPLY -- AXA sales Type

(
SELECT TOP 1 s.id bu_axasalestype, s.[Name] bu_axasalestypename
FROM [sid].[Ref_Account_AXASalesType] s
WHERE a.[SalesType] = s.name
)bu_axasalestype


/* bu_org_dependant_paid_for_already  rules
"* Display Corporate fund  on the deps paid by corporate field on the CRM, If dependants covered on the sid form = yes and the  SID Form Company Funded  Dependant - Capped or Company Funded  Dependant - Unlimited <> 0 or blank 
* If dependants covered = No, then dependants on crm = No
* Display Flex on the deps paid by corporate field on the CRM  if on the SID Form Flex Employee - Unlimited or Flex Dependant - Unlimited <>0 or blank
* Display error displayed if both are populated
* By Both, we mean any of these senarios 
	1: The account have people on the capped (either employees or dependants) and flex plans (either employees or dependants)
	2: The account have people on the Unlimited (either employees or dependants) and flex plans (either employees or dependants)
   	3: The account have people on the Unlimited (either employees or dependants) and capped (either employees or dependants)
* Display error if all set to 0"
*/

OUTER APPLY 

(
SELECT TOP 1 CONVERT(INT,[DependentsPaidForId]) bu_org_dependant_paid_for_already  
FROM sid.Ref_Account_DependentsPaidFor s
WHERE A.DependantsCovered = 'Yes' AND (a.CompanyFundedDependantCapped > 0 OR a.CompanyFundedDependantUnlimited >0)
AND s.DependentsPaidFor = '02 Yes - Corppaid'
)DependentsPaidFor_Corppaid

OUTER APPLY 

(
SELECT TOP 1 CONVERT(INT,[DependentsPaidForId]) bu_org_dependant_paid_for_already  
FROM sid.Ref_Account_DependentsPaidFor s
WHERE  (a.FlexEmployeeUnlimited > 0 OR a.FlexDependantUnlimited >0)
AND s.DependentsPaidFor = '01 Yes - Flexpaid'
)DependentsPaidFor_Flex

OUTER APPLY 

(
SELECT TOP 1 CONVERT(INT,[DependentsPaidForId]) bu_org_dependant_paid_for_already  
FROM sid.Ref_Account_DependentsPaidFor s
WHERE s.DependentsPaidFor = '00 No'
)DependentsPaidFor_No


/*
* Direct is displayed in the Relationship field on the crm if yes is selected on the  Direct Contact Allowed field on the sid form
* Channel partner is displayed in the Relationship field on the crm if No is selected on the  Direct Contact Allowed field on the sid form
*/

OUTER APPLY 

(
SELECT TOP 1 CONVERT(INT,[RelationshipId]) [bu_Relationship] 
FROM [sid].[Ref_Account_Relationship] s
WHERE a.DirectContactAllowed = 'Yes' AND s.Relationship = 'Direct'
)RelationshipId_d



OUTER APPLY 

(
SELECT TOP 1 CONVERT(INT,[RelationshipId])  [bu_Relationship] 
FROM [sid].[Ref_Account_Relationship] s
WHERE a.DirectContactAllowed = 'No' AND s.Relationship LIKE '%Channel%'
)RelationshipId_cp



/* bu_org_capped_unlimited_appointments
"* 
Unlimited: 
		   [NumberOfConsultationsPeremployee3CappedunLimited] must be 'Unlimited'   &
		   [CompanyFundedEmployeeUnlimited] or [CompanyFundedDependantUnlimited] must be greater than 0
		   [CompanyFundedEmployeeCapped], [CompanyFundedDependantCapped],[FlexEmployeeUnlimited],[FlexDependantUnlimited] must be 0
		
Cap of 3/ 3-Capped:
		   [NumberOfConsultationsPeremployee3CappedunLimited] must be '3-Capped'   &
		   [CompanyFundedEmployeeCapped] or [CompanyFundedDependantCapped] must be greater than 0
		   [CompanyFundedEmployeeUnlimited], [CompanyFundedDependantUnlimited],[FlexEmployeeUnlimited],[FlexDependantUnlimited] must be 0


Error must be raised in other senarios for the details to be reviewed by the business


*/



OUTER APPLY 

(
SELECT TOP 1 CONVERT(INT,[CappedOrUnlimitedId]) bu_org_capped_unlimited_appointments
FROM [sid].[Ref_Account_CappedOrUnlimited] s
WHERE A.[NumberOfConsultationsPeremployee3CappedunLimited] = 'Unlimited' AND (a.CompanyFundedEmployeeUnlimited > 0 OR a.CompanyFundedDependantUnlimited >0)
AND (CompanyFundedEmployeeCapped < 1 AND CompanyFundedDependantCapped <1)
AND s.CappedOrUnlimited = 'Unlimited'
)Unlimited


OUTER APPLY 

(
SELECT TOP 1 CONVERT(INT,[CappedOrUnlimitedId]) bu_org_capped_unlimited_appointments
FROM [sid].[Ref_Account_CappedOrUnlimited] s
WHERE A.[NumberOfConsultationsPeremployee3CappedunLimited] = '3-Capped' AND (a.CompanyFundedEmployeeCapped > 0 OR a.CompanyFundedDependantCapped >0)
AND (CompanyFundedEmployeeUnlimited < 1 AND CompanyFundedDependantUnlimited <1)
AND s.CappedOrUnlimited = 'Cap of 3'
)Capped


WHERE (a.IsProcessed IS NULL OR a.IsProcessed = 0)