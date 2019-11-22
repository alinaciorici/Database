CREATE TABLE [membership].[MembershipList_full] (
    [Id]                           INT            IDENTITY (1, 1) NOT NULL,
    [RowId]                        INT            NULL,
    [MembershipNumber]             NVARCHAR (300) NULL,
    [Title]                        NVARCHAR (300) NULL,
    [FirstName]                    NVARCHAR (300) NULL,
    [LastName]                     NVARCHAR (300) NULL,
    [DateOfBirth]                  NVARCHAR (300) NULL,
    [GroupNumber]                  NVARCHAR (300) NULL,
    [ProductName]                  NVARCHAR (300) NULL,
    [Relationship]                 NVARCHAR (500) NULL,
    [AddressLine1]                 NVARCHAR (500) NULL,
    [AddressLine2]                 NVARCHAR (500) NULL,
    [AddressLine3]                 NVARCHAR (500) NULL,
    [AddressLine4]                 NVARCHAR (500) NULL,
    [PostCode]                     NVARCHAR (300) NULL,
    [EmailAddress]                 NVARCHAR (500) NULL,
    [Action_AMD_Add_Modify_Delete] NVARCHAR (30)  NULL,
    [LoadId]                       VARCHAR (100)  NULL
);

