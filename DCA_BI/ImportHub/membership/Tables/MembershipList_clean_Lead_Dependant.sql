CREATE TABLE [membership].[MembershipList_clean_Lead_Dependant] (
    [MembershipNumber]             NVARCHAR (300)   NULL,
    [Title]                        NVARCHAR (300)   NULL,
    [FirstName]                    VARCHAR (4000)   NULL,
    [LastName]                     VARCHAR (4000)   NULL,
    [FullName]                     VARCHAR (4000)   NULL,
    [DateOfBirth]                  VARCHAR (10)     NULL,
    [GroupNumber]                  NVARCHAR (300)   NULL,
    [ProductName]                  NVARCHAR (300)   NULL,
    [Relationship]                 NVARCHAR (500)   NULL,
    [Action_AMD_Add_Modify_Delete] NVARCHAR (30)    NULL,
    [LoadId]                       VARCHAR (100)    NULL,
    [Lead_ReferenceNumber]         NVARCHAR (100)   NULL,
    [PrimaryContactId]             VARCHAR (200)    NULL,
    [PrimaryOriginalContactId]     UNIQUEIDENTIFIER NULL,
    [Lead_IsConverted]             INT              NULL,
    [ContactId]                    NVARCHAR (61)    NULL,
    [OriginalContactId]            UNIQUEIDENTIFIER NULL,
    [ReferenceNumber]              NVARCHAR (100)   NULL,
    [FullName_DCA]                 NVARCHAR (200)   NULL,
    [BirthDate]                    VARCHAR (10)     NULL
);

