SELECT
	raw.id,
	raw.pad_id,
	pads.padname,
	raw.wellsite_id,
	CASE
		WHEN raw.wellsite_id = 0 OR raw.wellsite_id IS NULL THEN pads.padname +'/PadData' ELSE ws.wellname
	END AS wellname,
	raw.datapoint,
	raw.external_ref_id
FROM (
	SELECT 
		id,
		pad_id,
		wellsite_id,
		CASE
			WHEN datapoint = 'WellHead' THEN 'Completion' ELSE datapoint
		END AS datapoint,
		external_ref_id
	FROM external_reference
	WHERE 
		external_ref_id IS NOT NULL
	AND	(pad_id = :pid OR :pid = -1)
	AND (wellsite_id = :wid OR :wid = -1)
	AND (datapoint = :datapoint OR :datapoint = 'None')
	UNION ALL
	SELECT gm.id, PadId AS pad_id, wellSiteId AS wellsite_id, gt.type + ' Gas - ' + name  AS datapoint, external_reference_id AS external_ref_id
	FROM gasmeters gm
	LEFT JOIN gasmeter_types gt ON gt.id = gm.gmTypeId
	WHERE external_reference_id IS NOT NULL
	AND (PadId = :pid OR :pid = -1)
	AND (wellSiteId = :wid OR :wid = -1)
	AND (gt.type = :datapoint OR :datapoint = 'None')
) raw
LEFT JOIN pads ON pads.id = raw.pad_id
LEFT JOIN wellsites ws ON ws.padId = raw.pad_id AND (ws.id = raw.wellsite_id OR (ws.id IS NULL AND raw.wellsite_id = 0))
ORDER BY padname, wellname