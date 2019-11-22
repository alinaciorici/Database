CREATE TABLE [membership].[MembershipList] (
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


GO
CREATE NONCLUSTERED INDEX [nci_wi_MembershipList_D79D50E6FA8B4923A74D8C8BE7DCFC92]
    ON [membership].[MembershipList]([GroupNumber] ASC, [LoadId] ASC);


GO
CREATE NONCLUSTERED INDEX [nci_wi_MembershipList_CE4B4DD469DCA9442B0F7B808D2A37BC]
    ON [membership].[MembershipList]([Action_AMD_Add_Modify_Delete] ASC, [Relationship] ASC)
    INCLUDE([MembershipNumber]);


GO
CREATE NONCLUSTERED INDEX [idx_membershiplist]
    ON [membership].[MembershipList]([MembershipNumber] ASC, [GroupNumber] ASC, [LoadId] ASC, [Relationship] ASC);

