CREATE TABLE [dw].[Account] (
    [AccountId]                 UNIQUEIDENTIFIER NOT NULL,
    [AccountNumber]             NVARCHAR (20)    NULL,
    [AccountName]               NVARCHAR (160)   NULL,
    [Accountname_Rpt]           NVARCHAR (500)   NULL,
    [ParentAccountId]           UNIQUEIDENTIFIER NULL,
    [ParentAccountName]         NVARCHAR (160)   NULL,
    [AccountGoLive]             DATETIME         NULL,
    [Createdate]                DATETIME         NULL,
    [Modifieddate]              DATETIME         NOT NULL,
    [InUseInAxaMI]              INT              NOT NULL,
    [MarketingAccountName]      NVARCHAR (255)   NULL,
    [PartnerReferenceNumber]    NVARCHAR (100)   NULL,
    [IsAutomaticBillingEnabled] BIT              NULL,
    [AxaSalesTypeId]            INT              NULL,
    [ExternalAccountReference]  NVARCHAR (255)   NULL
);

