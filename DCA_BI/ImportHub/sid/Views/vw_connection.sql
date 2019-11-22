CREATE VIEW sid.vw_connection 
as
SELECT convert(uniqueidentifier,null) connectionid,
'Xyz' name, 
convert(uniqueidentifier,'55226CAD-9802-EA11-A811-000D3A20F8DE') record1id, -- account id
1 record1objecttypecode, -- objectype account
convert(uniqueidentifier,'C7B57E94-CA03-EA11-A811-000D3A20F3F8') record2id, -- contact id
2 record2objecttypecode, -- objectype contact
convert(uniqueidentifier,'83D29CDF-9C39-E811-8125-5065F38BD4E1') record2roleid