CREATE PROC [veda].[usp_Appointment]

/*
Author:			Collins Emetonjor 
Date:			24/06/2019
Description:	Load Appointment Table for Veda
Project:


Change History

Developer:			Date:          Jira:				Description: 


*/

AS
    BEGIN

        -- check if table exist 
        IF EXISTS
        (
            SELECT *
            FROM sys.tables
            WHERE name = 'Appointment'
                  AND schema_id =
            (
                SELECT TOP 1 schema_id
                FROM sys.schemas
                WHERE name = 'veda'
            )
        )
            BEGIN
                DROP TABLE [veda].[Appointment];
        END;

        -- drop table
        BEGIN
            IF EXISTS
            (
                SELECT TOP 1 *
                FROM [veda].[vw_Appointment]
                WHERE [axa_MembershipNumber] IS NOT NULL
            )
                BEGIN

                    -- re-create table
                    SELECT *
                    INTO [veda].[Appointment]
                    FROM [veda].[vw_Appointment];
            END;
        END;
    END;