CREATE TABLE [admin_membership].[ProcessingLog] (
    [ID]           INT          IDENTITY (1, 1) NOT NULL,
    [LoadType]     VARCHAR (50) NULL,
    [StartTime]    DATETIME     NULL,
    [EndTime]      DATETIME     NULL,
    [Duration_mm]  AS           (datediff(minute,[StartTime],[EndTime])),
    [IsSuccessful] AS           (case when [Endtime] IS NOT NULL then (1) else (0) end) PERSISTED NOT NULL
);

