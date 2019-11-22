CREATE TABLE [admin_membership].[Load] (
    [ID]                 INT            IDENTITY (1, 1) NOT NULL,
    [LoadID]             VARCHAR (1000) NOT NULL,
    [LoadType]           VARCHAR (50)   NULL,
    [FolderPath]         VARCHAR (MAX)  NULL,
    [FileName]           VARCHAR (500)  NULL,
    [RowCount_Processed] INT            NULL,
    [RowCount_Expected]  INT            NULL,
    [RowCount_Error]     AS             (case when [RowCount_Processed] IS NOT NULL AND [RowCount_Expected] IS NOT NULL AND [RowCount_Expected]=[RowCount_Processed] then (0) else (1) end),
    [TimeStamp]          DATETIME       NULL,
    [StartTime]          DATETIME       NULL,
    [EndTime]            DATETIME       NULL,
    [Duration_mm]        AS             (datediff(minute,[StartTime],[EndTime])),
    [IsSuccessful]       AS             (case when [Endtime] IS NOT NULL then (1) else (0) end) PERSISTED NOT NULL,
    [IsDeleted]          SMALLINT       CONSTRAINT [DF_Load_IsDeleted] DEFAULT ((0)) NULL,
    [IsFuzzyMatched]     BIT            NULL
);

