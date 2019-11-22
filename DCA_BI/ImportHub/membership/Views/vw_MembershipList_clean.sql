



CREATE VIEW [membership].[vw_MembershipList_clean]
AS
     SELECT [MembershipNumber], 
            [Title], 
            [FirstName], 
            [LastName], 
            [FullName], 
            [DateOfBirth], 
            [GroupNumber], 
            [ProductName], 
            [Relationship], 
            [AddressLine1], 
            [AddressLine2], 
            [AddressLine3], 
            [AddressLine4], 
            [PostCode], 
            [EmailAddress], 
            [Action_AMD_Add_Modify_Delete], 
            [LoadId], 
            SenderProcessedDateTime,
			case when Relationship = 'Policy Holder' THEN 'Primary' WHEN Relationship in ('Adult Dependant','Daughter','Son')   THEN 'Dependant' END AS MemberType


     FROM
     (
         SELECT DISTINCT 
                LTRIM(RTRIM([MembershipNumber])) MembershipNumber, 
                [Title], 
                [admin].[fn_ProperCase]([admin].[fn_StripMultiSpaces]([FirstName])) FirstName, 
                [admin].[fn_ProperCase]([admin].[fn_StripMultiSpaces]([LastName])) LastName, 
                [admin].[fn_ProperCase]([admin].[fn_StripMultiSpaces](concat(FirstName, ' ', [LastName]))) FullName, 
--CONVERT(VARCHAR(10), DateOfBirth) DateOfBirth, 

                CONVERT(VARCHAR(10),
                                  CASE
                                      WHEN LEN(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))) = 10
                                      THEN SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))
                                      WHEN LEN(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))) = 9
                                           AND PATINDEX('%/%', DateOfBirth) = 2
                                      THEN concat('0', SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1)))
                                      WHEN LEN(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))) = 9
                                           AND PATINDEX('%/%', DateOfBirth) = 3
                                      THEN CONCAT('', LEFT((SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))), 3), '0', SUBSTRING(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1)), 4, 8))
                                      WHEN LEN(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))) = 8
                                      THEN CONCAT('0', LEFT((SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1))), 2), '0', SUBSTRING(SUBSTRING((DateOfBirth), 1, (PATINDEX('% %', (DateOfBirth)) - 1)), 3, 7))
                                      ELSE NULL
                                  END) DateOfBirth, 
                GroupNumber, 
                [ProductName], 
                [Relationship], 
                [admin].[fn_ProperCase]([admin].[fn_StripMultiSpaces]([AddressLine1])) AddressLine1, 
                [admin].[fn_ProperCase]([admin].[fn_StripMultiSpaces]([AddressLine2])) AddressLine2, 
                [admin].[fn_ProperCase]([admin].[fn_StripMultiSpaces]([AddressLine3])) AddressLine3, 
                [admin].[fn_ProperCase]([admin].[fn_StripMultiSpaces]([AddressLine4])) AddressLine4, 
                [admin].[fn_UpperCase]([admin].[fn_StripMultiSpaces](PostCode)) PostCode, 
                [EmailAddress], 
                [Action_AMD_Add_Modify_Delete], 

				                ROW_NUMBER() OVER(PARTITION BY MembershipNumber, 
                                              -- Relationship,   cases found where an individual was both a Policy Holder and dependant on the same policy
                                               FirstName, 
                                               LastName


                --ROW_NUMBER() OVER(PARTITION BY MembershipNumber, 
                --                               Relationship, 
                --                               FirstName, 
                --                               LastName
ORDER BY LoadId_Int DESC) rank,
--rank() OVER (partition by MembershipNumber order by LoadId desc) rank,
                [LoadId], 
                SenderProcessedDateTime
         FROM [membership].[MembershipList] m
              OUTER APPLY
         (
             SELECT TOP 1 [TimeStamp] SenderProcessedDateTime, 
                          Id LoadId_Int
             FROM [admin_membership].[Load] l
             WHERE m.LoadId = l.LoadID
         ) al
     ) x
     WHERE x.rank = 1;