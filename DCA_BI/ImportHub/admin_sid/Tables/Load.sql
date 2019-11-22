CREATE TABLE [admin_sid].[Load] (
    [ID]                      INT            IDENTITY (1, 1) NOT NULL,
    [LoadID]                  VARCHAR (1000) NOT NULL,
    [LoadType]                VARCHAR (50)   NULL,
    [FolderPath]              VARCHAR (MAX)  NULL,
    [FileName]                VARCHAR (500)  NULL,
    [RowCount_Processed]      INT            NULL,
    [RowCount_Expected]       INT            NULL,
    [RowCount_Error]          INT            NULL,
    [TimeStamp]               DATETIME       NULL,
    [StartTime]               DATETIME       NULL,
    [EndTime]                 DATETIME       NULL,
    [Duration_mm]             INT            NULL,
    [IsSuccessful]            INT            NULL,
    [IsDeleted]               SMALLINT       NULL,
    [PostProcessingCompleted] BIT            NULL,
    [NotificationSent]        BIT            NULL,
    [IsAutoApprove]           BIT            NULL,
    [IsReviewedByBusiness]    BIT            NULL
);

