








CREATE VIEW [membership].[vw_reporting_Account_Check]
AS
     SELECT DISTINCT 
            [GroupNumber] axa_GroupNumber, 
            x.*, ml.*
     FROM [membership].[MembershipList_clean] AS a
          OUTER APPLY
     (
         SELECT ExternalAccountReference dca_ExternalAccountReference, 
                a2.Accountname_Rpt dca_Accountname_Rpt, AccountId dca_AccountId, 
				CASE 
				WHEN a2.[AxaSalesTypeId] = '827110000' THEN 'Standalone'
				WHEN a2.[AxaSalesTypeId] = '827110001' THEN 'Embedded'
				WHEN a2.[AxaSalesTypeId] = '827110002' THEN 'Mixed'
				ELSE NULL END AS AxaSalesType

         FROM dw.Account a2
         WHERE --LEN(ExternalAccountReference) < 7    AND
             (a2.ExternalAccountReference = a.GroupNumber)
     ) x

	 OUTER APPLY (SELECT TOP 1 l.TimeStamp FirstProcessedDate  FROM [membership].[MembershipList] ml join [admin_membership].[Load] l on ml.[LoadId] = l.[LoadId] 
	 
	 WHERE (a.GroupNumber = ml.GroupNumber and a.GroupNumber is not null)
	 order by TimeStamp asc)ml