




CREATE VIEW [dw].[vw_Lead] AS

SELECT [LeadId]
      ,[AccountPlanId]
      ,[OriginalContactId]
      ,[ContactId]
      ,[AccountId]
      ,[IsConverted]
      ,[AccountPlanPaymentType]
      ,[ReferenceNumber]
      ,[Token]
      ,[FullName]
		  ,convert(varchar(10),FORMAT(BirthDate, 'dd/MM/yyyy', 'en-US' )) BirthDate
      ,[Gender]
      ,[CreateDate]
      ,[ExpiryDate]
      ,[IsVoucherNoLead]
	  ,OrganisationMemberId
      ,[ExternalAccountReferenceId] FROM [dw].[Lead] c
OUTER APPLY 

(SELECT TOP 1 ISNULL(ExternalAccountReference,PartnerReferenceNumber) ExternalAccountReferenceId FROM [dw].[Account] a WHERE a.AccountId = c.accountid)x