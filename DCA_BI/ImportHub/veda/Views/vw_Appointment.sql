




CREATE VIEW [veda].[vw_Appointment]
AS
     SELECT 
            a.[ReferenceNumber] AppointmentReferenceNumber, 
            a.ActualStartDate, 
            [PolicyNumber], 
            [PolicyPaymentType], 
            a.ContactId, 
            con.MemberType,
            CASE
                WHEN ISNULL(con.ContactGender, con.LeadGender) NOT IN('Male', 'Female')
                THEN NULL
                ELSE ISNULL(con.ContactGender, con.LeadGender)
            END Gender, 
            ISNULL(con.LeadFullName, ContactFullName) FullName, 
            ISNULL(con.LeadBirthDate, con.ContactBirthDate) BirthDate, 
            con.ContactReferenceNumber, 
			ac.[AccountId], 
            ac.[Accountname], 
			ac.AccountFirstProcessedDate, 
            ac.ExternalAccountReference, 
            axa.*
     FROM [dw].[Appointment] a

          -- Filter agreed 
          CROSS APPLY
     (
         SELECT TOP 1 [Accountname], 
                      ac.[AccountId], 
                      ac.ExternalAccountReference, 
                      va.FirstProcessedDate AccountFirstProcessedDate
         FROM [dw].[Account] ac
              JOIN[membership].reporting_Account_Check va ON ac.ExternalAccountReference = va.[axa_GroupNumber]
         WHERE ac.AccountId = a.AccountId
               -- AND ac.AxaSalesTypeId IS NOT NULL
               AND (AxaSalesTypeId = 827110001				-- Embedded
                    OR [IsAutomaticBillingEnabled] = 1		-- IS Enabled for automated billing
               )

         AND ActualStartDate >= va.[FirstProcessedDate]  -- Only appointments which occured after axa had sent AXA members details. 
     ) ac
          OUTER APPLY
     (
         SELECT TOP 1 c.[ReferenceNumber] ContactReferenceNumber, 
                      MemberType, 
                      c.[Gender] ContactGender, 
                      l.Gender LeadGender, 
                      l.FullName LeadFullName, 
                      l.BirthDate LeadBirthDate, 
                      c.FullName ContactFullName, 
                      c.BirthDate ContactBirthDate
         FROM [dw].[vw_Contact] c
              LEFT JOIN [dw].[vw_lead] l ON c.contactid = l.contactid
         WHERE c.ContactId = a.ContactId
     ) con
          OUTER APPLY
     (
         SELECT TOP 1 [LoadId], 
                      [MembershipNumber], 
                      [Lead_ContactId], 
                      [Relationship]
         -- ContactReferenceNumber
         FROM[membership].[MembershipList_clean_Lead_Primary] pri
         WHERE pri.[Lead_IsConverted] = 1
               AND pri.[Lead_ContactId] = a.ContactId
     ) axa_pri
          OUTER APPLY
     (
         SELECT TOP 1 [LoadId], 
                      [MembershipNumber], 
                      [Lead_ContactId], 
                      [Relationship], 
                      FullName
         -- ContactReferenceNumber
         FROM[membership].[MembershipList_clean_Lead_Dependant] dep
         WHERE dep.contactid = a.ContactId
     ) axa_dep
          OUTER APPLY
     (
         SELECT TOP 1 [MembershipNumber] axa_MembershipNumber, 
                      [FirstName] axa_FirstName, 
                      [LastName] axa_LastName, 
                      [Relationship] axa_Relationship, 
                      [DateOfBirth] axa_DateOfBirth, 
                      [GroupNumber] axa_GroupNumber, 
                      [AddressLine1] axa_AddressLine1, 
                      [AddressLine2] axa_AddressLine2, 
                      AddressLine3 axa_AddressLine3, 
                      AddressLine4 axa_AddressLine4, 
                      [PostCode] axa_PostCode,[Action_AMD_Add_Modify_Delete] CurrentStatus, [SenderProcessedDateTime] [LoadFileTimeStamp]
         FROM[membership].[MembershipList_clean] ph
         WHERE(

         -- match for primary holder 
         (axa_pri.[MembershipNumber] = ph.[MembershipNumber]
          AND ph.[Relationship] LIKE '%Policy%'
          AND ph.loadId = axa_pri.loadId)
         OR -- match for dependant    

         (axa_dep.[MembershipNumber] = ph.[MembershipNumber]
          AND ph.[Relationship] NOT LIKE '%Policy%'
          AND axa_dep.FullName = ph.[FullName]
          AND ph.loadId = axa_dep.loadId))
     ) axa

     -- Only appointments from the 1st of April
     --WHERE a.ActualStartDate >= '2019-04-01';  