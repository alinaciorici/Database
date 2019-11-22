
CREATE VIEW veda.vw_VedaAnalyticsExport 

as

SELECT  *
FROM VedaImport.Analytics an
     OUTER APPLY
(
    SELECT TOP 1 IsAutomaticBillingEnabled,
                 CASE
                     WHEN AxaSalesTypeId = 827110000
                     THEN 'Standalone'
                     WHEN AxaSalesTypeId = 827110001
                     THEN 'Embedded'
                     WHEN AxaSalesTypeId = 827110002
                     THEN 'Mixed'
                     ELSE NULL
                 END AxaSalesType, 
                 AxaSalesTypeId, 
                 ExternalAccountReference, 
                 AccountName
    FROM dw.Account a
    WHERE a.AccountId = an.AccountId
) z
     OUTER APPLY
(
    SELECT TOP 1 c.FirstProcessedDate
    FROM [axa].[reporting_Account_Check] c
    WHERE c.axa_GroupNumber = z.ExternalAccountReference
) x

OUTER APPLY 
(SELECT TOP 1 c.FullName, MemberType, c.Gender, c.PrimaryContactId, c.BirthDate, LeadReferenceNumber, OrganisationMemberId FROM dw.vw_Contact  c WHERE c.ContactId = an.ContactId)cc

OUTER APPLY 
(SELECT TOP 1 c.AppointmentReferenceNumber, c.axa_MembershipNumber FROM veda.Appointment  c WHERE c.ContactId = an.ContactId)cv


WHERE [Validated] = 0
      AND ([IsArchived] IS NULL
           OR [IsArchived] = 0);