



CREATE VIEW [membership].[vw_MembershipList_clean_Lead_Dependant]
AS
     SELECT aml.[MembershipNumber], 
            [Title], 
            [FirstName], 
            [LastName], 
            aml.[FullName], 
            [DateOfBirth], 
            [GroupNumber], 
            [ProductName], 
            [Relationship], 
            --[AddressLine1], 
            --[AddressLine2], 
            --[AddressLine3], 
            --[AddressLine4], 
            --[PostCode], 
            --[EmailAddress], 
            [Action_AMD_Add_Modify_Delete], 
            [LoadId], 
            Pri.*, 
            dep.[ContactId], 
            dep.[OriginalContactId], 
            dep.[ReferenceNumber], 
            dep.[FullName] FullName_DCA, 
            dep.[BirthDate]
     FROM [membership].[MembershipList_clean] aml
          OUTER APPLY
     (
         SELECT TOP 1 [Lead_ReferenceNumber], 
                      [Lead_ContactId] PrimaryContactId, 
                      [Lead_OriginalContactId] PrimaryOriginalContactId, 
                      [Lead_IsConverted]
         FROM [membership].[MembershipList_clean_Lead_Primary] pr
         WHERE aml.MembershipNumber = pr.MembershipNumber
              -- AND pr.LoadId = aml.LoadId
     ) Pri
          OUTER APPLY
     (
         SELECT DISTINCT TOP (1) [ContactId], 
                                 [OriginalContactId], 
                                 [ReferenceNumber], 
                                 [FullName], 
                                 [BirthDate], 
                                 fms.score
         FROM dw.vw_contact c
              CROSS APPLY
         (
             SELECT admin.fn_FuzzyMatchString(concat(aml.FullName, aml.DateOfBirth), concat(c.fullname, c.BirthDate)) AS score
         ) AS fms
         WHERE pri.[PrimaryContactId] = c.[PrimaryContactId]
               AND c.[MemberType] <> 'Primary'   -- exclude primary from cohort
               AND aml.DateOfBirth = c.BirthDate -- ensure DOB matches
               AND fms.score > LEN(concat([FullName], [DateOfBirth])) / 1.9  -- Ensure over 60% match in name
         ORDER BY fms.score DESC
     ) dep
     WHERE aml.Relationship NOT LIKE '%Policy%';