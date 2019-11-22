CREATE TABLE [sid].[Account_Processing_DynamicSync] (
    [LoadId]                                VARCHAR (1000)   NULL,
    [ID]                                    INT              NOT NULL,
    [Action]                                NVARCHAR (5)     NOT NULL,
    [AccountID]                             UNIQUEIDENTIFIER NULL,
    [bu_externalaccountreference]           NVARCHAR (50)    NOT NULL,
    [Name]                                  VARCHAR (4000)   NULL,
    [bu_contractstartdate]                  DATE             NULL,
    [bu_org_end_of_contract_renewal_date_m] DATE             NULL,
    [bu_org_working_body_phone_number]      NVARCHAR (50)    NOT NULL,
    [bu_axasalestype]                       INT              NULL,
    [bu_org_dependant_paid_for_already]     INT              NULL,
    [bu_Relationship]                       INT              NULL,
    [bu_org_approx_number_of_core_lives]    INT              NULL,
    [bu_Openingpopulationforemployees]      INT              NULL,
    [bu_Openingpopulationfordependants]     INT              NULL,
    [bu_org_capped_unlimited_appointments]  INT              NULL,
    [bu_migrationkey]                       VARCHAR (7)      NULL,
    [Notes]                                 NVARCHAR (4000)  NULL
);

