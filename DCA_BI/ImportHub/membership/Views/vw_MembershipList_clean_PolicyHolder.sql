




CREATE view [membership].[vw_MembershipList_clean_PolicyHolder]

as


SELECT a.*
FROM [membership].[MembershipList_clean] a
     CROSS APPLY
(
    SELECT rt.RelationshipType
    FROM [membership].[vw_RelationshipType] rt
    WHERE rt.[RelationshipType] LIKE '%Policy%'
          AND a.[Relationship] = rt.[RelationshipType]
) x