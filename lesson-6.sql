/*
 * ����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������, ������� ������ ���� �������
 * � ��������� ������������� (������� ��� ���������).
 */

SELECT * FROM users u WHERE u.id = 11;

SELECT U.*
FROM users u,
	(SELECT from_user_id, count(*) AS totalmsg FROM messages m 
		WHERE to_user_id  = 11
		GROUP BY from_user_id 
		ORDER BY totalmsg DESC
		LIMIT 1) AS FU
WHERE U.ID = FU.from_user_id;

/*
 * ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..
 * 
 */

SELECT * FROM profiles p WHERE p.birthday > date_add(now(),INTERVAL -10 year);

SELECT * FROM posts p WHERE p.user_id IN (7,9);

-- ������������ ������ 10 ��� �� ������ �����, ������� ������ ��� �� ��������.

-- ���� ������ ���������� ���-�� ������ � ������ �� �������� � ��������.
SELECT post_id, count(*) AS totallike  FROM posts_likes pl
GROUP BY  post_id
ORDER BY totallike desc;

-- ����� ���������� ������, ������� �������� ������������ ������ 20 ���
SELECT u.id, u.firstname, u.lastname, pf.birthday
	, count(pl.like_type) FROM users u, profiles pf, posts p, posts_likes pl 
WHERE u.id = pf.user_id 
	AND u.id = p.user_id 
	AND p.id = pl.post_id 
	AND pf.birthday > date_add(now(),INTERVAL -20 year)
GROUP BY u.id, u.firstname, u.lastname, pf.birthday;

/*
���������� ��� ������ �������� ������ (�����): ������� ��� �������.
*/

SELECT CASE(pf.gender)
			WHEN 'f' THEN 'female'
			WHEN 'm' THEN 'male'
			WHEN 'x' THEN 'not defined'
		END AS gender
	,count(*) AS total_like
FROM profiles pf
	,posts_likes pl 
WHERE pf.user_id = pl.user_id
	AND pf.gender  IN ('m','f')
GROUP BY pf.gender
ORDER BY total_like DESC
LIMIT 1;
