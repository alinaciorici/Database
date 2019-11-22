







CREATE PROC [admin_membership].[usp_Load] 
@FolderPath VARCHAR(MAX)='dummy' , @FileName VARCHAR(500) , @LoadType VARCHAR(50) , @LoadSequenceType VARCHAR(10)

/*
Author:			Collins Emetonjor 
Date:			23/02/2019
Description:	Track load runtimes of data import
Project:


Testing: EXEC [admin].[usp_Load] '','AXA/Downloaded/AXAtoDCA 20190325 1013 87845.csv','DataImport','END'

Change History

Developer:			Date:          Jira:				Description: 


*/

AS
BEGIN


-- Reseed table
  DBCC CHECKIDENT ('[admin_membership].[Load]');

BEGIN TRAN;

DECLARE @Date datetime=dateadd(hour , 1 , getdate());

         /* Track start of data load  */

IF @LoadSequenceType='Start'
BEGIN

IF(SELECT count(*) FROM [admin_membership].[Load])>=1
BEGIN


--BEGIN  

---- Generate load ID
DECLARE @LoadId varchar(1000)=(SELECT concat('Load-' , max(convert(int , (substring(LoadId , 6 , 10))))+1) FROM [admin_membership].[Load])


INSERT INTO [admin_membership].[Load](LoadId , Filename ,FolderPath, Loadtype , Starttime)
SELECT @LoadId , @FileName , @FolderPath ,@LoadType , (@Date);

END;


IF(SELECT count(*) FROM [admin_membership].[Load])<1

BEGIN

INSERT INTO [admin_membership].[Load](LoadId , FolderPath , Filename , Loadtype , Starttime)
SELECT 'Load-1' , @FolderPath , @FileName , @LoadType , (@Date);

END;


END;
COMMIT;


         /* Track end of  data load */

IF @LoadSequenceType='End'

BEGIN


-- Post Update

				 /* Clean Up*/


DECLARE @MaxLoadid int=(SELECT MAX(Id) FROM [admin_membership].[Load] WHERE Filename=@FileName AND Loadtype=@LoadType);

DECLARE @MaxLoadid_char varchar(100)=(SELECT LoadId FROM [admin_membership].[Load] WHERE ID=@MaxLoadid);


SELECT @MaxLoadid , @MaxLoadid_char;

--PRINT 'ALL OK';
UPDATE [admin_membership].[Load] SET Endtime=(@Date) WHERE Loadid=@MaxLoadid_char;

UPDATE [membership].[MembershipList] SET [LoadId]=@MaxLoadid_char WHERE LoadId IS NULL;

UPDATE [admin_membership].[Load] SET [RowCount_Processed]=(SELECT COUNT(*) FROM [membership].[MembershipList] WHERE LoadId=@MaxLoadid_char) WHERE LoadId=@MaxLoadid_char;

UPDATE [admin_membership].[Load]
  SET 
      [TimeStamp] = CASE
                        WHEN ISDATE(SUBSTRING([FileName], 10, 8)) = 1
                        THEN SUBSTRING([FileName], 10, 8)
                        ELSE NULL
                    END
WHERE [TimeStamp] IS NULL;

                 /*Map uploaded data to load ID */


IF EXISTS(SELECT * FROM [admin_membership].[Load] WHERE [Id]=(SELECT MAX([Id]) FROM [admin_membership].[Load] WHERE IsSuccessful=1 AND Filename=@FileName AND Loadtype=@LoadType))

BEGIN

SELECT 'Success' AS Result;

END;




IF NOT EXISTS(SELECT * FROM [admin_membership].[Load] WHERE [Id]=(SELECT MAX([Id]) FROM [admin_membership].[Load] WHERE IsSuccessful=1 AND Filename=@FileName AND Loadtype=@LoadType))

BEGIN

--EXEC [dbo].[usp_Oildex_ImportEmailNotification] 'Failure';
UPDATE [admin_membership].[Load] SET Endtime=(SELECT NULL WHERE id=(SELECT MAX(Id) FROM [admin_membership].[Load] WHERE Filename=@FileName AND Loadtype=@LoadType));
SELECT 'Failure' AS Result;


END;



BEGIN TRY
UPDATE [admin_membership].[Load] SET [RowCount_Expected]=(SELECT replace(SUBSTRING([FileName],24,1000),'.csv','') FROM [admin_membership].[Load] WHERE LoadId=@MaxLoadid_char) WHERE LoadId=@MaxLoadid_char;
END TRY
BEGIN CATCH

SELECT 'Error in extracting expected row count';
END CATCH;


END;
END;