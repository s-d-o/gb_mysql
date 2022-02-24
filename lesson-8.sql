/*
 * Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался
 * с выбранным пользователем (написал ему сообщений).
 */

SELECT m2.from_user_id, count(*) AS totalmsg 
	FROM users u 
	JOIN messages m2 
	  ON u.id = m2.to_user_id 
	WHERE u.id = 11
	GROUP BY m2.from_user_id
	ORDER BY totalmsg DESC
	LIMIT 1;


-- общее количество лайков, которые получили пользователи младше 20 лет, в БД нет младше 10 лет
SELECT  u.id, u.firstname, u.lastname, pf.birthday
		, count(pl.like_type)
	FROM posts_likes pl
	JOIN posts p 
	  ON pl.post_id = p.id 
	JOIN users u 
	  ON p.user_id = u.id
	JOIN profiles pf 
	  ON pf.user_id  = u.id 
	  	AND pf.birthday > date_add(now(),INTERVAL -20 year) 
	GROUP BY u.id, u.firstname, u.lastname, pf.birthday;

/*
Определить кто больше поставил лайков (всего): мужчины или женщины.
*/
SELECT CASE(pf.gender)
			WHEN 'f' THEN 'female'
			WHEN 'm' THEN 'male'
			WHEN 'x' THEN 'not defined'
		END AS gender
		,count(*) AS total_like
	FROM profiles pf
	JOIN posts_likes pl 
	  ON pf.user_id = pl.user_id
	WHERE pf.gender  IN ('m','f')
	GROUP BY pf.gender
	ORDER BY total_like DESC
	LIMIT 1;
