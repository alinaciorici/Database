
CREATE PROCEDURE [veda].[usp_Load]
AS
    INSERT [veda].[ProcessingLog]
	SELECT 'Veda - Updated from DWH / IH', GETDATE()