CREATE TABLE [membership].[MembershipList_clean] (
    [MembershipNumber]             NVARCHAR (300) NULL,
    [Title]                        NVARCHAR (300) NULL,
    [FirstName]                    VARCHAR (4000) NULL,
    [LastName]                     VARCHAR (4000) NULL,
    [FullName]                     VARCHAR (4000) NULL,
    [DateOfBirth]                  VARCHAR (10)   NULL,
    [GroupNumber]                  NVARCHAR (300) NULL,
    [ProductName]                  NVARCHAR (300) NULL,
    [Relationship]                 NVARCHAR (500) NULL,
    [AddressLine1]                 VARCHAR (4000) NULL,
    [AddressLine2]                 VARCHAR (4000) NULL,
    [AddressLine3]                 VARCHAR (4000) NULL,
    [AddressLine4]                 VARCHAR (4000) NULL,
    [PostCode]                     VARCHAR (4000) NULL,
    [EmailAddress]                 NVARCHAR (500) NULL,
    [Action_AMD_Add_Modify_Delete] NVARCHAR (30)  NULL,
    [LoadId]                       VARCHAR (100)  NULL,
    [SenderProcessedDateTime]      DATETIME       NULL,
    [MemberType]                   VARCHAR (9)    NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_MembershipList_clean_2]
    ON [membership].[MembershipList_clean]([GroupNumber] ASC, [FullName] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_MembershipList_clean]
    ON [membership].[MembershipList_clean]([MembershipNumber] ASC, [Relationship] ASC);

