

CREATE VIEW [membership].[vw_MembershipList_clean_Lead_Primary]

as

SELECT		 aml.[MembershipNumber], 
                  [Title], 
                  [FirstName], 
                  [LastName], 
                  [FullName], 
                  [DateOfBirth], 
                  [GroupNumber], 
                  [ProductName], 
                  [Relationship], 
                  --[AddressLine1], 
                  --[AddressLine2], 
                  --[AddressLine3], 
                  --[AddressLine4], 
                  --[PostCode], 
                  [EmailAddress], 
                  [Action_AMD_Add_Modify_Delete], 
                  [LoadId], 
                  Prim.*

FROM [Membership].[MembershipList_clean] aml
     OUTER APPLY
(
    SELECT TOP 1 L.ReferenceNumber Lead_ReferenceNumber, 
                 L.AccountId Lead_AccountId, 
                 L.ContactId Lead_ContactId, 
				 c.[ReferenceNumber] ContactReferenceNumber,
				 L.OriginalContactId Lead_OriginalContactId, 
                 L.IsConverted Lead_IsConverted,
				 L.FullName Lead_FullName

    FROM [dw].[Lead] L JOIN  [Membership].[MembershipList_clean] ax  ON L.OrganisationMemberId = aml.[MembershipNumber] 
	LEFT JOIN [dw].[Contact] c on L.ContactId = c.ContactId
    WHERE L.OrganisationMemberId = aml.[MembershipNumber] AND aml.Relationship = 'Policy Holder'

	ORDER BY L.IsConverted desc  -- added, there are cases of two or leads with the same Org member ID where only one lead is converted. eg. 4989553M
	,
	l.[CreateDate] desc
) Prim

--OUTER APPLY (SELECT TOP 1 [ReferenceNumber] ContactReferenceNumber FROM [dw].[vw_Contact] c WHERE c.[ContactId] = Prim.Lead_ContactId) con

WHERE aml.Relationship = 'Policy Holder'