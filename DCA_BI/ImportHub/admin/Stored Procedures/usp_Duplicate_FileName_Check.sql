

CREATE PROC [admin].[usp_Duplicate_FileName_Check] @FileNameFound NVARCHAR(MAX)

/*
Author:			Collins Emetonjor 
Date:			23/02/2019
Description:	Stored procedure to detect duplicate files sent 
Project:

Change History

Developer:			Date:          Jira:				Description: 



*/

AS
    BEGIN
        --declare @FileNameFound nvarchar(max) = ?

        IF EXISTS
        (
            SELECT *
            FROM [admin].[Load] oil
            WHERE IsSuccessful = 1
                  AND oil.FileName = @FileNameFound
        )
            BEGIN
            
                SELECT 1 DuplicateCheck;
        END;
        IF NOT EXISTS
        (
            SELECT *
            FROM [admin].[Load] oil
            WHERE IsSuccessful = 1
                  AND oil.FileName = @FileNameFound
        )
            BEGIN
                SELECT 0 DuplicateCheck;
        END
    END