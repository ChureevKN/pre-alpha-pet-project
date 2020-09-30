DROP DATABASE shopping_list_db;

CREATE DATABASE shopping_list_db CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE shopping_list_db;


CREATE TABLE audience (
	user_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	
	user_name VARCHAR(155) NOT NULL DEFAULT '(empty)',
	user_password VARCHAR(355) NOT NULL DEFAULT '(empty)',
	creation_time DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP
	
	/*Starts trigger on a row deletion.*/
);


CREATE TABLE shopping_list (
	shopping_list_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	
	shopping_list_name VARCHAR(355) NOT NULL DEFAULT '(empty)',
	
	fk_author_user_id INT UNSIGNED NOT NULL DEFAULT 0,
	FOREIGN KEY (fk_author_user_id) REFERENCES audience (user_id) ON UPDATE CASCADE /*Is modified by trigger on delete from audience, set to 0.*/
);


CREATE TABLE purchase (
	purchase_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	
	purchase_caption VARCHAR(355) NOT NULL DEFAULT '(empty)',
	purchase_quantity INT UNSIGNED NOT NULL DEFAULT 0,
	
	fk_shopping_list_id INT UNSIGNED NOT NULL DEFAULT 0,
	FOREIGN KEY (fk_shopping_list_id) REFERENCES shopping_list (shopping_list_id) ON DELETE CASCADE
);


CREATE TABLE allowances (
	allow_read BOOLEAN NOT NULL DEFAULT 0,
	allow_modify BOOLEAN NOT NULL DEFAULT 0,
	allow_delete BOOLEAN NOT NULL DEFAULT 0,
	
	fk_shopping_list_id INT UNSIGNED NOT NULL DEFAULT 0,
	FOREIGN KEY (fk_shopping_list_id) REFERENCES shopping_list (shopping_list_id) ON UPDATE CASCADE ON DELETE CASCADE,
	
	fk_user_id INT UNSIGNED NOT NULL DEFAULT 0,
	FOREIGN KEY (fk_user_id) REFERENCES audience (user_id) ON UPDATE CASCADE
	
	/*See triggers.*/
);



DELIMITER $$
CREATE TRIGGER `zero_the_user_id_in_shopping_list_on_user_deletion` AFTER DELETE ON `audience`
FOR EACH ROW
BEGIN
	UPDATE shopping_list
	SET fk_author_user_id = 0
	WHERE fk_author_user_id = OLD.user_id;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `grant_full_rights_on_list_for_author` AFTER INSERT ON `shopping_list`
FOR EACH ROW
BEGIN
	INSERT allowances(allow_read, allow_modify, allow_delete, fk_shopping_list_id, fk_user_id)
	VALUES (1, 1, 1, NEW.shopping_list_id, NEW.fk_author_user_id);
END$$
DELIMITER ;