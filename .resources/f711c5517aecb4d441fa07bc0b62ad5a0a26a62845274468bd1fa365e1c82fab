SELECT
	id AS value,
	wellname AS label
FROM wellsites
WHERE (padId = :pad OR :pad = -1)
ORDER BY wellname