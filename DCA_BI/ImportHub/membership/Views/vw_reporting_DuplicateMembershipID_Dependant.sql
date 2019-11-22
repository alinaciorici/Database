


CREATE view [membership].[vw_reporting_DuplicateMembershipID_Dependant]

as


SELECT [LoadId], 
       a.MembershipNumber,[FirstName],LastName,
       RelationshipType Relationship, 
       COUNT(*) AS DuplicateCount
FROM [membership].[MembershipList] AS a
     CROSS APPLY
(
    SELECT rt.RelationshipType
    FROM [membership].[vw_RelationshipType] rt
    WHERE rt.[RelationshipType] NOT LIKE '%Policy%'
          AND a.[Relationship] = rt.[RelationshipType]
) x
GROUP BY a.MembershipNumber, RelationshipType,[FirstName],LastName,
         [LoadId]
HAVING COUNT(*) > 1;