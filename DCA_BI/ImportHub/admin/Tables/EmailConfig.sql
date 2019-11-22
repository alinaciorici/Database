CREATE TABLE [admin].[EmailConfig] (
    [ConfigId]         INT            IDENTITY (1, 1) NOT NULL,
    [EmailType]        VARCHAR (30)   NULL,
    [IsEnabled]        BIT            NULL,
    [MailProfile]      NVARCHAR (100) NULL,
    [NotificationList] VARCHAR (MAX)  NULL,
    [EmailContent]     VARCHAR (MAX)  NULL,
    [ReportAttached]   BIT            NULL
);

