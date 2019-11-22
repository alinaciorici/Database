CREATE TABLE [dw].[Appointment] (
    [AppointmentId]          UNIQUEIDENTIFIER NOT NULL,
    [ReferenceNumber]        NVARCHAR (100)   NULL,
    [OriginalContactId]      UNIQUEIDENTIFIER NULL,
    [ContactId]              NVARCHAR (61)    NOT NULL,
    [AccountId]              UNIQUEIDENTIFIER NULL,
    [PolicyId]               UNIQUEIDENTIFIER NULL,
    [PolicyNumber]           NVARCHAR (100)   NULL,
    [PolicyPaymentType]      VARCHAR (100)    NULL,
    [CancellationDate]       DATE             NULL,
    [CancellationTime]       TIME (7)         NULL,
    [ScheduledStartDateTime] DATETIME         NULL,
    [ScheduledEndDateTime]   DATETIME         NULL,
    [ActualStartDate]        DATE             NULL,
    [ActualStartTime]        VARCHAR (8)      NULL,
    [ActualEndDate]          DATE             NULL,
    [ActualEndTime]          VARCHAR (8)      NULL,
    [BookedDate]             DATE             NULL,
    [CreatedDate]            DATETIME         NULL,
    [ModifiedDate]           DATETIME         NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_dw_appointment]
    ON [dw].[Appointment]([ContactId] ASC, [AccountId] ASC, [AppointmentId] ASC);

