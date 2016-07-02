SELECT codes.id, codes.code, codes.time, codes.description, codes.is_cancelled, cats.name AS category, elems.name AS element, GROUP_CONCAT(DISTINCT CONCAT(oc.name, ' ', oc.code) SEPARATOR ', ') AS othercodes, GROUP_CONCAT(DISTINCT crs.name SEPARATOR ', ') AS requestedby, times.time AS codetime
FROM codes
LEFT OUTER JOIN (SELECT optional_codes.id, optional_codes.code_id, optional_codes.code, rldcs.name FROM optional_codes INNER JOIN rldcs ON rldcs.id = optional_codes.rldc_id) AS oc ON codes.id = oc.code_id
LEFT OUTER JOIN (SELECT code_requests.code_id, entities.name FROM code_requests INNER JOIN entities ON code_requests.entity_id = entities.id) AS crs ON codes.id = crs.code_id
LEFT OUTER JOIN categories AS cats ON codes.category_id = cats.id
LEFT OUTER JOIN elements AS elems ON codes.element_id = elems.id
LEFT OUTER JOIN times ON codes.id = times.code_id
GROUP BY codes.id
ORDER BY codes.time DESC