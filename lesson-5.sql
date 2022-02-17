/*
* Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
* Заполните их текущими датой и временем.
*/

UPDATE users SET created_at = now(), updated_at = now();
SELECT * FROM users u;

/*
 * Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
 * и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля
 * к типу DATETIME, сохранив введеные ранее значения.
 * */

ALTER TABLE users ADD c_at varchar(16);
ALTER TABLE users ADD u_at varchar(16);

UPDATE users SET c_at = '20.10.2017 8:10', u_at = '20.10.2017 8:10';

ALTER TABLE users ADD c_at_tmp datetime;
ALTER TABLE users ADD u_at_tmp datetime;

UPDATE users 
SET c_at_tmp = CAST(concat(substr(c_at,7,4)
		,'-'
		,substr(c_at,4,2)
		,'-'
		,substr(c_at,1,2)
		,' '
		,substr(c_at,12,5)) AS datetime)
	,u_at_tmp = CAST(concat(substr(u_at,7,4)
		,'-'
		,substr(u_at,4,2)
		,'-'
		,substr(u_at,1,2)
		,' '
		,substr(u_at,12,5)) AS datetime);

ALTER TABLE users DROP c_at;
ALTER TABLE users DROP u_at;

ALTER TABLE users CHANGE c_at_tmp c_at datetime;
ALTER TABLE users CHANGE u_at_tmp u_at datetime;

SELECT * FROM users u;

/*
 * В таблице складских запасов storehouses_products в поле value могут встречаться
 * самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются
 * запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
 * увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
 */
 SELECT sp2.value 
 FROM (SELECT sp.value, if(sp.value=0,1,2) AS sort_v 
 		FROM storehouses_products sp) AS sp2
 ORDER BY sort_v DESC, value;
 
/*
 * Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
 *  Месяцы заданы в виде списка английских названий ('may', 'august')
 */
 
SELECT * FROM users u
WHERE monthname(u.birthday_at) IN ('May', 'August');

