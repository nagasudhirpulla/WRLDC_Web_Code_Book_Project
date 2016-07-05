CREATE DEFINER=`root`@`localhost` PROCEDURE `addcode`(IN `cat` INT, IN `des` VARCHAR(250), IN `el` INT)
    MODIFIES SQL DATA
BEGIN
	DECLARE newcode INT;
    SET newcode = -1;
	START TRANSACTION READ WRITE;
    SET newcode = (SELECT IFNULL(MAX(code),-1) FROM wrldc_web_code_book_project.codes WHERE time = (SELECT MAX(time) FROM wrldc_web_code_book_project.codes));
    INSERT INTO wrldc_web_code_book_project.codes(code, category_id, description, element_id) VALUES (newcode + 1, cat, des, el);
    IF ROW_COUNT() > 0 THEN
   		SET newcode = LAST_INSERT_ID();
    END IF;
    COMMIT;
    SELECT newcode AS 'newcode';
END

CALL addcode(8, "dsfsdfsd", 1);