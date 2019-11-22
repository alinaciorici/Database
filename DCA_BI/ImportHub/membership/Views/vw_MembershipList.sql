




CREATE VIEW [membership].[vw_MembershipList]
AS

SELECT 

[MembershipNumber]
      ,[Title]
      ,[FirstName]
      ,[LastName]
      ,[FullName]
      ,[DateOfBirth]
      ,[GroupNumber]
      ,[ProductName]
      ,[Relationship]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[AddressLine4]
      ,[PostCode]
      ,[EmailAddress]
      ,[Action_AMD_Add_Modify_Delete]
      ,[LoadId]

 FROM (

     SELECT DISTINCT 
            [MembershipNumber], 
            [Title], 
            FirstName, 
            LastName, 
            concat(FirstName, ' ', [LastName]) FullName, 
            --CONVERT(VARCHAR(10), DateOfBirth) DateOfBirth, 

            CONVERT(VARCHAR(10),
                              CASE
                                  WHEN LEN(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))) = 10
                                  THEN SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))
                                  
								  WHEN LEN(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))) = 9 AND PATINDEX('%/%',DateOfBirth) = 2
                                  THEN concat('0', SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1)))

								  WHEN LEN(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))) = 9 AND PATINDEX('%/%',DateOfBirth) = 3
                                  THEN 
								  CONCAT('', LEFT((SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))), 3), '0', SUBSTRING(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1)), 4, 8))

                                  WHEN LEN(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))) = 8
                                  THEN CONCAT('0', LEFT((SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))), 2), '0', SUBSTRING(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1)), 3, 7))
                                  ELSE NULL
                              END) DateOfBirth, 
            GroupNumber, 
            [ProductName], 
            [Relationship], 
            [AddressLine1], 
            [AddressLine2], 
            [AddressLine3], 
            [AddressLine4], 
            PostCode, 
            [EmailAddress], 
            [Action_AMD_Add_Modify_Delete], 
			row_number() OVER (partition by MembershipNumber, Relationship, FirstName, LastName,Action_AMD_Add_Modify_Delete order by MembershipNumber desc) rank,
            [LoadId]
     FROM [Membership].[MembershipList]
	 )x

	 WHERE x.rank = 1