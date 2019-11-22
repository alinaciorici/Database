CREATE TABLE [membership].[MembershipList_clean_Lead_Primary] (
    [MembershipNumber]             NVARCHAR (300)   NULL,
    [Title]                        NVARCHAR (300)   NULL,
    [FirstName]                    VARCHAR (4000)   NULL,
    [LastName]                     VARCHAR (4000)   NULL,
    [FullName]                     VARCHAR (4000)   NULL,
    [DateOfBirth]                  VARCHAR (10)     NULL,
    [GroupNumber]                  NVARCHAR (300)   NULL,
    [ProductName]                  NVARCHAR (300)   NULL,
    [Relationship]                 NVARCHAR (500)   NULL,
    [EmailAddress]                 NVARCHAR (500)   NULL,
    [Action_AMD_Add_Modify_Delete] NVARCHAR (30)    NULL,
    [LoadId]                       VARCHAR (100)    NULL,
    [Lead_ReferenceNumber]         NVARCHAR (100)   NULL,
    [Lead_AccountId]               UNIQUEIDENTIFIER NULL,
    [Lead_ContactId]               VARCHAR (200)    NULL,
    [ContactReferenceNumber]       NVARCHAR (100)   NULL,
    [Lead_OriginalContactId]       UNIQUEIDENTIFIER NULL,
    [Lead_IsConverted]             INT              NULL,
    [Lead_FullName]                NVARCHAR (200)   NULL,
    [OrganisationMemberId]         NCHAR (100)      NULL,
    [CreateDate]                   DATE             NULL,
    [LoadFileTimeStamp]            DATETIME         NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_MembershipList_clean_Lead_Primary]
    ON [membership].[MembershipList_clean_Lead_Primary]([Lead_ContactId] ASC);

