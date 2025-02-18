SELECT
	id AS value,
	padname AS label
FROM pads
WHERE assetId = :asset OR :asset = -1
ORDER BY padname