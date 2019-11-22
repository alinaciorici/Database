

CREATE view [membership].[vw_reporting_NoRelationship]

as


SELECT a.*, x.FileName
FROM [membership].[MembershipList] AS a

outer apply (select top 1 FileName from [admin_membership].[Load] l where a.LoadId = l.LoadID) x
WHERE [Relationship] IS null