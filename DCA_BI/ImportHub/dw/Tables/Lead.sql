CREATE TABLE [dw].[Lead] (
    [LeadId]                 UNIQUEIDENTIFIER NULL,
    [AccountPlanId]          UNIQUEIDENTIFIER NULL,
    [OriginalContactId]      UNIQUEIDENTIFIER NULL,
    [ContactId]              VARCHAR (200)    NULL,
    [AccountId]              UNIQUEIDENTIFIER NULL,
    [IsConverted]            INT              NOT NULL,
    [AccountPlanPaymentType] NVARCHAR (50)    NULL,
    [ReferenceNumber]        NVARCHAR (100)   NULL,
    [Token]                  NVARCHAR (100)   NULL,
    [FullName]               NVARCHAR (200)   NULL,
    [BirthDate]              DATE             NULL,
    [Gender]                 NVARCHAR (50)    NULL,
    [CreateDate]             DATE             NULL,
    [ExpiryDate]             DATE             NULL,
    [IsVoucherNoLead]        SMALLINT         NULL,
    [OrganisationMemberId]   NCHAR (100)      NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_dw_lead_IsConverted]
    ON [dw].[Lead]([IsConverted] DESC, [CreateDate] DESC);


GO
CREATE NONCLUSTERED INDEX [idx_dw_lead]
    ON [dw].[Lead]([OriginalContactId] ASC, [ContactId] ASC, [OrganisationMemberId] ASC, [CreateDate] DESC, [IsConverted] DESC);

