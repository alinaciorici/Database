CREATE TABLE [dw].[Contact] (
    [OriginalContactId]        UNIQUEIDENTIFIER NOT NULL,
    [ContactId]                NVARCHAR (61)    NOT NULL,
    [ReferenceNumber]          NVARCHAR (100)   NULL,
    [FullName]                 NVARCHAR (200)   NULL,
    [FirstPaymentType]         VARCHAR (50)     NULL,
    [CurrentPaymentType]       VARCHAR (50)     NULL,
    [MemberType]               VARCHAR (50)     NULL,
    [Gender]                   NVARCHAR (50)    NULL,
    [PrimaryContactId]         NVARCHAR (65)    NULL,
    [HasLeadRecord]            INT              NULL,
    [AccountId]                UNIQUEIDENTIFIER NULL,
    [SrcAccountId]             UNIQUEIDENTIFIER NULL,
    [BirthDate]                DATETIME         NULL,
    [Address1_PostCode]        NVARCHAR (20)    NULL,
    [Address1]                 NVARCHAR (MAX)   NULL,
    [CreateDate]               DATE             NULL,
    [ModifiedDate]             DATETIME         NOT NULL,
    [OriginalPrimaryContactId] UNIQUEIDENTIFIER NULL,
    [BirthDate_Modified]       VARCHAR (10)     NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_dw_contact]
    ON [dw].[Contact]([ContactId] ASC, [AccountId] ASC, [HasLeadRecord] DESC);

