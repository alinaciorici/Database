CREATE TABLE [membership].[reporting_Account_Check] (
    [axa_GroupNumber]              NVARCHAR (300)   NULL,
    [dca_ExternalAccountReference] NVARCHAR (255)   NULL,
    [dca_Accountname_Rpt]          NVARCHAR (500)   NULL,
    [dca_AccountId]                UNIQUEIDENTIFIER NULL,
    [AxaSalesType]                 VARCHAR (10)     NULL,
    [FirstProcessedDate]           DATETIME         NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_Account_Check]
    ON [membership].[reporting_Account_Check]([axa_GroupNumber] ASC, [FirstProcessedDate] ASC);

