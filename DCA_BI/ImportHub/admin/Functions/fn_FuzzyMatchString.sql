


 CREATE FUNCTION [admin].[fn_FuzzyMatchString] (@s1 varchar(500), @s2 varchar(500))
RETURNS int
AS
BEGIN
    -- written by William Talada for SqlServerCentral
    DECLARE @i int, @j int;
    SET @i = 1;
    SET @j = 0;
    WHILE @i < LEN(@s1)
    BEGIN
        IF CHARINDEX(SUBSTRING(@s1,@i,2), @s2) > 0 SET @j=@j+1;
        SET @i=@i+1;
    END
    RETURN @j;
END