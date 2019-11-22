CREATE TABLE [veda].[ProcessingLog] (
    [ID]                INT          IDENTITY (1, 1) NOT NULL,
    [LoadType]          VARCHAR (50) NULL,
    [LastProcessedTime] DATETIME     NULL
);


GO
CREATE CLUSTERED INDEX [idx_veda_ProcessingLog]
    ON [veda].[ProcessingLog]([ID] DESC);

