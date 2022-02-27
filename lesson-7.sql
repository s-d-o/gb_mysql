/* Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине. */

SELECT u.name 
FROM orders o
	JOIN users u ON u.id  = o.user_id
GROUP BY u.name
ORDER BY u.name;


/* Выведите список товаров products и разделов catalogs, который соответствует товару.*/

SELECT p.id, p.name, p.price, c.name 
FROM products p
	JOIN catalogs c ON c.id = p.catalog_id
ORDER BY c.name, p.name;

/*Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
 Поля from, to и label содержат английские названия городов, поле name — русское. 
 Выведите список рейсов flights с русскими названиями городов.*/

SELECT f.id, c.name, c2.name FROM flights f
	JOIN cities c ON c.label = f._from_
	JOIN cities c2 ON c2.label = f._to_
ORDER  BY f.id;