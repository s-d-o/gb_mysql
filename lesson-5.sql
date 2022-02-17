/*
* ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными. 
* «аполните их текущими датой и временем.
*/

UPDATE users SET created_at = now(), updated_at = now();
SELECT * FROM users u;

/*
 * “аблица users была неудачно спроектирована. «аписи created_at и updated_at были заданы типом VARCHAR
 * и в них долгое врем€ помещались значени€ в формате "20.10.2017 8:10". Ќеобходимо преобразовать пол€
 * к типу DATETIME, сохранив введеные ранее значени€.
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
 * ¬ таблице складских запасов storehouses_products в поле value могут встречатьс€
 * самые разные цифры: 0, если товар закончилс€ и выше нул€, если на складе имеютс€
 * запасы. Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке
 * увеличени€ значени€ value. ќднако, нулевые запасы должны выводитьс€ в конце, после всех записей.
 */
 SELECT sp2.value 
 FROM (SELECT sp.value, if(sp.value=0,1,2) AS sort_v 
 		FROM storehouses_products sp) AS sp2
 ORDER BY sort_v DESC, value;
 
/*
 * »з таблицы users необходимо извлечь пользователей, родившихс€ в августе и мае.
 *  ћес€цы заданы в виде списка английских названий ('may', 'august')
 */
 
SELECT * FROM users u
WHERE monthname(u.birthday_at) IN ('May', 'August');

/*
 * »з таблицы catalogs извлекаютс€ записи при помощи запроса. 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 * ќтсортируйте записи в пор€дке, заданном в списке IN.
 * */
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY id DESC, name;


/*
 * ѕодсчитайте средний возраст пользователей в таблице users
 * */

SELECT avg(timestampdiff(YEAR,birthday_at,now())) FROM users u; 

/*
 * ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели.
 * —ледует учесть, что необходимы дни недели текущего года, а не года рождени€.
 * */

SELECT CASE weekday(date_add(birthday_at
					, INTERVAL (EXTRACT(YEAR FROM now()) - EXTRACT(YEAR from birthday_at)) YEAR))
			WHEN 0 THEN 'Monday'
			WHEN 1 THEN 'Tuesday'
			WHEN 2 THEN 'Wednesday'
			WHEN 3 THEN 'Thursday'
			WHEN 4 THEN 'Friday'
			WHEN 5 THEN 'Saturday'			
			WHEN 6 THEN 'Sunday'
		END AS week_day
		,count(*)
		,GROUP_CONCAT(name SEPARATOR ', ')
FROM users u
GROUP BY week_day;
