/*Shows all shopping lists with authors.*/

DROP PROCEDURE export_all_lists;
DROP PROCEDURE show_all_lists;


DELIMITER $$
CREATE PROCEDURE export_all_lists ()
BEGIN
	DECLARE counter INT DEFAULT (SELECT MAX(shopping_list_id) FROM shopping_list);
	
	SET @path_to_output_file := "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/";
	SET @output_path_for_subprocedure := CONCAT(@path_to_output_file, REPLACE(NOW(), ':', '-'));
	
	WHILE counter>0 do
		SET @subprocedure_output_into_outfile := CONCAT
			('SELECT
				audience.user_name AS "Автор списка",
				shopping_list.shopping_list_name AS "Название списка",
				purchase.purchase_caption AS "Наименование товара",
				purchase.purchase_quantity AS "Количество товара"
			FROM
				shopping_list
			JOIN audience
				ON audience.user_id = shopping_list.fk_author_user_id
			JOIN purchase
				ON purchase.fk_shopping_list_id = shopping_list.shopping_list_id
			WHERE
				shopping_list.shopping_list_id = ', counter, '
			ORDER BY
				purchase_id
			INTO OUTFILE '
				, '\'', @output_path_for_subprocedure, '_', counter, '.txt\'',
				' FIELDS TERMINATED BY \'|\'
				ENCLOSED BY \'\"\'
				LINES TERMINATED BY \'\\r\\n\';'
			);
		PREPARE subprocedure_for_output FROM @subprocedure_output_into_outfile;
		EXECUTE subprocedure_for_output; DEALLOCATE PREPARE subprocedure_for_output;
		SET counter = counter - 1;
	END WHILE;
	
END
$$


CREATE PROCEDURE show_all_lists ()
BEGIN
	DECLARE counter INT DEFAULT (SELECT MAX(shopping_list_id) FROM shopping_list);
	
	WHILE counter>0 do
		SELECT
			audience.user_name AS "Автор списка",
			shopping_list.shopping_list_name AS "Название списка",
			purchase.purchase_caption AS "Наименование товара",
			purchase.purchase_quantity AS "Количество товара"
		FROM
			shopping_list
		JOIN audience
			ON audience.user_id = shopping_list.fk_author_user_id
		JOIN purchase
			ON purchase.fk_shopping_list_id = shopping_list.shopping_list_id
		WHERE
			shopping_list.shopping_list_id = counter
		ORDER BY
			purchase_id;
		SET counter = counter - 1;
	END WHILE;
	
END
$$

DELIMITER ;