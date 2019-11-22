


CREATE PROC [admin_sid].[usp_Load] 
@FolderPath VARCHAR(MAX)='dummy' , @FileName VARCHAR(500) , @LoadType VARCHAR(50) , @LoadSequenceType VARCHAR(10)

/*
Author:			Collins Emetonjor 
Date:			23/02/2019
Description:	Track load runtimes of data import (SID account specific)
Project:


Testing: EXEC [admin_sid].[usp_Load] '','AXA/Downloaded/AXAtoDCA 20190325 1013 87845.csv','DataImport','END'

Change History

Developer:			Date:          Jira:				Description: 


*/

AS
BEGIN


-- Reseed table
  DBCC CHECKIDENT ('[admin_sid].[Load]');

BEGIN TRAN;

DECLARE @Date datetime=dateadd(hour , 1 , getdate());

         /* Track start of data load  */

IF @LoadSequenceType='Start'
BEGIN



IF(SELECT count(*) FROM [admin_sid].[Load])>=1
BEGIN


--BEGIN  

---- Generate load ID
DECLARE @LoadId varchar(1000)=(SELECT concat('Load-' , max(convert(int , (substring(LoadId , 6 , 10))))+1) FROM [admin_sid].[Load])

--DECLARE @LoadId varchar(1000)=(SELECT concat('Load-' , max(id)+1) FROM [admin_sid].[Load])


INSERT INTO [admin_sid].[Load](LoadId , Filename ,FolderPath, Loadtype , Starttime)
SELECT @LoadId , @FileName , @FolderPath ,@LoadType , (@Date);

END;


IF(SELECT count(*) FROM [admin_sid].[Load])<1

BEGIN

INSERT INTO [admin_sid].[Load](LoadId , FolderPath , Filename , Loadtype , Starttime)
SELECT 'Load-1' , @FolderPath , @FileName , @LoadType , (@Date);

END;



END;



         /* Track end of  data load */

IF @LoadSequenceType='End'


BEGIN


-- Post Update

				 /* Clean Up*/


DECLARE @MaxLoadid int=(SELECT MAX(Id) FROM [admin_sid].[Load] WHERE Filename=@FileName AND Loadtype=@LoadType);

DECLARE @MaxLoadid_char varchar(100)=(SELECT LoadId FROM [admin_sid].[Load] WHERE ID=@MaxLoadid);


SELECT @MaxLoadid , @MaxLoadid_char;

--PRINT 'ALL OK';
UPDATE [admin_sid].[Load] SET Endtime=(@Date) WHERE Loadid=@MaxLoadid_char;

UPDATE [sid].[Account] SET [LoadId]=@MaxLoadid_char WHERE LoadId IS NULL;

UPDATE [admin_sid].[Load] SET [RowCount_Processed]=(SELECT COUNT(*) FROM [sid].[Account] WHERE LoadId=@MaxLoadid_char) WHERE LoadId=@MaxLoadid_char;

UPDATE [admin_sid].[Load]
  SET 
      [TimeStamp] = CASE
                        WHEN ISDATE(SUBSTRING([FileName], 14, 8)) = 1
                        THEN SUBSTRING([FileName], 14, 8)
                        ELSE NULL
                    END
WHERE [TimeStamp] IS NULL;

                 /*Map uploaded data to load ID */


IF EXISTS(SELECT * FROM [admin_sid].[Load] WHERE [Id]=(SELECT MAX([Id]) FROM [admin_sid].[Load] WHERE IsSuccessful=1 AND Filename=@FileName AND Loadtype=@LoadType))

BEGIN

SELECT 'Success' AS Result;

END;

IF NOT EXISTS(SELECT * FROM [admin_sid].[Load] WHERE [Id]=(SELECT MAX([Id]) FROM [admin_sid].[Load] WHERE IsSuccessful=1 AND Filename=@FileName AND Loadtype=@LoadType))

BEGIN

--EXEC [dbo].[usp_Oildex_ImportEmailNotification] 'Failure';
UPDATE [admin_sid].[Load] SET Endtime=(SELECT NULL WHERE id=(SELECT MAX(Id) FROM [admin_sid].[Load] WHERE Filename=@FileName AND Loadtype=@LoadType));
SELECT 'Failure' AS Result;


END;

WAITFOR DELAY '00:00:05';

BEGIN TRY
--UPDATE [admin_sid].[Load] SET [RowCount_Expected]=(SELECT REVERSE(replace(substring(REVERSE([FileName]) , 1 , patindex('% %' , REVERSE(FileName))) , 'vsc.' , '')) FROM [admin_sid].[Load] WHERE LoadId=@MaxLoadid_char) WHERE LoadId=@MaxLoadid_char;


UPDATE [admin_sid].[Load] SET [RowCount_Expected]=(select REVERSE (SUBSTRING(REVERSE(FileName),5, (PATINDEX('%[_]%',  REVERSE(FileName))-5)))   FROM [admin_sid].[Load] WHERE LoadId=@MaxLoadid_char) WHERE LoadId=@MaxLoadid_char;


END TRY
BEGIN CATCH

SELECT 'Error in extracting expected row count';
END CATCH;


END;

COMMIT;

END;