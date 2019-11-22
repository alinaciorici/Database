
CREATE PROC [membership].[usp_reporting_Account_Check]

/*
Author:			Collins Emetonjor 
Date:			12/06/2019
Description:	Load Account_Check Table
Project:


Change History

Developer:			Date:          Jira:				Description: 


*/

AS
    BEGIN
        IF EXISTS
        (
            SELECT *
            FROM sys.tables
            WHERE name = 'reporting_Account_Check'
                  AND schema_id =
            (
                SELECT TOP 1 schema_id
                FROM sys.schemas
                WHERE name = 'membership'
            )
        )
            BEGIN
                DROP TABLE [membership].[reporting_Account_Check];
        END;
        SELECT *
        INTO [membership].[reporting_Account_Check]
        FROM [membership].[vw_reporting_Account_Check];
    END;
        CREATE INDEX idx_Account_Check ON [membership].[reporting_Account_Check]([axa_GroupNumber], [FirstProcessedDate]);