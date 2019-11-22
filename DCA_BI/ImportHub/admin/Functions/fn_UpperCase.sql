


CREATE FUNCTION [admin].[fn_UpperCase]
(@InputString VARCHAR(4000)
)
RETURNS VARCHAR(4000)
AS
     BEGIN
         DECLARE @OutputString VARCHAR(2000);
         SET @OutputString = UPPER(@InputString);
         RETURN @OutputString;
     END;