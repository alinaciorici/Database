



CREATE VIEW [membership].[vw_MembershipList_clean_per_load_Lead]

as

SELECT			 [MembershipNumber], 
                  [Title], 
                  [FirstName], 
                  [LastName], 
                  aml.[FullName], 
                  [DateOfBirth], 
                  [GroupNumber], 
                  [ProductName], 
                  [Relationship], 
                  [AddressLine1], 
                  [AddressLine2], 
                  [AddressLine3], 
                  [AddressLine4], 
                  [PostCode], 
                  [EmailAddress], 
                  [Action_AMD_Add_Modify_Delete], 
                  [LoadId], 
                  Prim.*,
				  dep.*

FROM [Membership].[vw_MembershipList] aml
     OUTER APPLY
(
    SELECT TOP 1 L.ReferenceNumber Lead_ReferenceNumber, 
                 L.AccountId Lead_AccountId, 
                 L.ContactId Lead_ContactId, 
				  L.OriginalContactId Lead_OriginalContactId, 
                 L.IsConverted Lead_IsConverted
    FROM [dw].[Lead] L
    WHERE L.OrganisationMemberId = aml.[MembershipNumber] AND aml.Relationship = 'Policy Holder'
) Prim

OUTER APPLY  

(
    SELECT TOP 1 c.ContactId, c.PrimaryContactId, c.FullName FullName_DCA FROM dw.Contact c  JOIN dw.Account a ON c.AccountId = a.AccountId 
	AND a.ExternalAccountReference = aml.GroupNumber  -- check group number matches 
	WHERE prim.Lead_OriginalContactId = SUBSTRING(c.PrimaryContactId , 1, 36)  -- check primary contact matches, to narrow down to related dependants 
	--AND c.MemberType <> 'Primary'   -- exclude primary contacts
	AND convert(varchar(10),c.BirthDate,103) = aml.DateOfBirth  -- match on DOB
	--AND LEFT(c.FullName,3) = LEFT(aml.axa_FullName,3)
	--AND RIGHT(c.FullName,3) = RIGHT(aml.axa_FullName,3)
	--AND aml.Relationship <> 'Policy Holder'
	
)dep