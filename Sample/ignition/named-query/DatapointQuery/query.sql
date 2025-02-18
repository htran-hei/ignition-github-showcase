SELECT DISTINCT 
	datapoint AS value,
	CASE WHEN datapoint = 'WellHead' THEN 'Completion' ELSE datapoint END AS label
FROM external_reference
WHERE (pad_id = :pad OR :pad = -1)
AND (wellsite_id = :well OR :well = -1)
AND external_ref_id IS NOT NULL
UNION ALL
SELECT DISTINCT
	'Gas Meter - ' + gt.type AS value,
	'Gas Meter - ' + gt.type AS label
FROM gasmeters gm
LEFT JOIN gasmeter_types gt ON gm.gmTypeId = gt.id
WHERE (PadId = :pad OR :pad = -1)
AND (wellSiteId = :well OR :well = -1)
AND gm.external_reference_id IS NOT NULL
ORDER BY label