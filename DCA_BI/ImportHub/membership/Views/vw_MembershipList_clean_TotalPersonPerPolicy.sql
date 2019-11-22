



CREATE VIEW [membership].[vw_MembershipList_clean_TotalPersonPerPolicy]
AS
SELECT DISTINCT [LoadId], 
       [MembershipNumber], 
       x_p.*, 
       x.*, 
       x_d.*, 
       x_da.*, 
       x_dd.*, 
       x_ds.*
FROM [membership].[MembershipList_clean] a
     OUTER APPLY
(
    SELECT ISNULL(COUNT(*),0) TotalPolicyHolder_InPolicy
    FROM [membership].[MembershipList_clean] ph
    WHERE a.[MembershipNumber] = ph.[MembershipNumber]
          AND a.LoadId = ph.LoadId
          AND ph.[Relationship] = 'Policy Holder'
    GROUP BY [MembershipNumber], 
             [LoadId]
) x
     OUTER APPLY
(
    SELECT ISNULL(COUNT(*),0) TotalDependantAdult_InPolicy
    FROM [membership].[MembershipList_clean] ph
    WHERE a.[MembershipNumber] = ph.[MembershipNumber]
          AND a.LoadId = ph.LoadId
          AND ph.[Relationship] IN('Adult Dependant', 'E')
    GROUP BY [MembershipNumber], 
             [LoadId]
) x_da
     OUTER APPLY
(
    SELECT ISNULL(COUNT(*),0) TotalDependantDaughter_InPolicy
    FROM [membership].[MembershipList_clean] ph
    WHERE a.[MembershipNumber] = ph.[MembershipNumber]
          AND a.LoadId = ph.LoadId
          AND ph.[Relationship] = 'Daughter'
    GROUP BY [MembershipNumber], 
             [LoadId]
) x_dd
     OUTER APPLY
(
    SELECT ISNULL(COUNT(*),0) TotalDependantSon_InPolicy
    FROM [membership].[MembershipList_clean] ph
    WHERE a.[MembershipNumber] = ph.[MembershipNumber]
          AND a.LoadId = ph.LoadId
          AND ph.[Relationship] = 'Son'
    GROUP BY [MembershipNumber], 
             [LoadId]
) x_ds
     OUTER APPLY
(
    SELECT ISNULL(COUNT(*),0) TotalDependant_InPolicy
    FROM [membership].[MembershipList_clean] ph
    WHERE a.[MembershipNumber] = ph.[MembershipNumber]
          AND a.LoadId = ph.LoadId
          AND ph.[Relationship] <> 'Policy Holder'
    GROUP BY [MembershipNumber], 
             [LoadId]
) x_d
     OUTER APPLY
(
    SELECT ISNULL(COUNT(*),0) TotalPersonInPolicy
    FROM [membership].[MembershipList_clean] ph
    WHERE a.[MembershipNumber] = ph.[MembershipNumber]
          AND a.LoadId = ph.LoadId
    GROUP BY [MembershipNumber], 
             [LoadId]
) x_p;