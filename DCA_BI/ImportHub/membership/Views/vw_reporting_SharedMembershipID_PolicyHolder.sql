




CREATE view [membership].[vw_reporting_SharedMembershipID_PolicyHolder]

as


SELECT
       a.MembershipNumber,
       COUNT(*) AS DuplicateCount
FROM [membership].[vw_MembershipList_clean_PolicyHolder] AS a

GROUP BY a.MembershipNumber
HAVING COUNT(*) > 1;