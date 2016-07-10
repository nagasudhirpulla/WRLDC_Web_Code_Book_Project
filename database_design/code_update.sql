UPDATE codes SET time=?,category_id=?,description=?,element_id=?,is_cancelled=? WHERE id=?

DELETE FROM code_requests WHERE code_id=?
INSERT INTO code_requests(entity_id, code_id) VALUES (?,?)

DELETE FROM optional_codes WHERE code_id=?
INSERT INTO optional_codes(code_id, rldc_id, code) VALUES (?,?,?)

START TRANSACTION READ WRITE;
DELETE FROM times WHERE code_id = 131;
INSERT INTO times (code_id, time) VALUES (131, CURRENT_TIMESTAMP);
COMMIT;
SELECT LAST_INSERT_ID() AS new_code;