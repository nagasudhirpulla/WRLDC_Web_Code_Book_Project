START TRANSACTION;
SELECT * FROM codes FOR UPDATE;
SET @asd = (SELECT MAX(code) FROM codes WHERE time = (SELECT IFNULL(MAX(time),-1) FROM codes));
INSERT INTO codes(code, category_id, description, element_id) VALUES (@asd+1,1,null,1);
COMMIT;