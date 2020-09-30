/*Just a script of a data filling.*/

INSERT audience(user_name, user_password)
VALUES
	('listener_1', '12345678910'),
	('кодер_два', 'ASDASDf');
	
INSERT shopping_list(shopping_list_name, fk_author_user_id)
VALUES
	('Auchan', 1),
	('Детский мир', 2);
	
INSERT purchase(purchase_caption, purchase_quantity, fk_shopping_list_id)
VALUES
	('Хлеб', 2, 1),
	('Milk', 3, 1),
	('Подгузоны pants 7 большая пачка', 2, 2);