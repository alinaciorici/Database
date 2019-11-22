




CREATE VIEW [dw].[vw_Contact] AS

SELECT [OriginalContactId]
      ,[ContactId]
	  ,[PrimaryContactId]
      ,[ReferenceNumber]
      ,[FullName]
      ,[FirstPaymentType]
      ,[CurrentPaymentType]
      ,[MemberType]
      ,[Gender]
      ,[HasLeadRecord]
      ,[AccountId]
      ,[SrcAccountId]
      ,convert(varchar(10),FORMAT(BirthDate, 'dd/MM/yyyy', 'en-US' )) BirthDate
      ,[Address1_PostCode]
      ,[Address1]
      ,[CreateDate]
      ,[ModifiedDate]
      ,[ExternalAccountReferenceId] 
	  ,le.LeadReferenceNumber
	  ,le.OrganisationMemberId

	  FROM [dw].[Contact] c
OUTER APPLY 
(SELECT TOP 1 ExternalAccountReference ExternalAccountReferenceId FROM [dw].[Account] a WHERE a.AccountId = c.accountid)x

OUTER APPLY 
(SELECT TOP 1 ReferenceNumber LeadReferenceNumber, OrganisationMemberId FROM dw.vw_lead l WHERE l.ContactId = c.PrimaryContactId and c.AccountId = l.AccountId)le