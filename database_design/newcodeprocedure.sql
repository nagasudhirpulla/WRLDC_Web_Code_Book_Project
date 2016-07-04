BEGIN
    SELECT * FROM codes FOR UPDATE;
    SET newcode = (SELECT MAX(code) FROM codes WHERE time = (SELECT IFNULL(MAX(time),-1) FROM codes));
    INSERT INTO codes(code, category_id, description, element_id) VALUES (newcode + 1, cat, des, el);
    IF ROW_COUNT() > 0 THEN
   		SET newcode = LAST_INSERT_ID();
    ELSE
    	SET newcode = -1; 
    END IF;
END

CALL addcode(8, "dsfsdfsd", 1, @p1); SELECT @p1 AS `newrev`;