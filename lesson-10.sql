DROP DATABASE IF EXISTS kinopoisk;

CREATE DATABASE IF NOT EXISTS kinopoisk /*!40100 DEFAULT CHARACTER SET cp1251 */;

-- ���������� �� kinopoisk
USE kinopoisk;

-- ������� ������� � ��������
DROP TABLE IF EXISTS films;

CREATE TABLE IF NOT EXISTS films(
	id SERIAL PRIMARY KEY,
	name_film varchar(255) NOT NULL COMMENT '�������� ������',
	about varchar(4000) NOT NULL COMMENT '��������',
	create_at datetime NOT NULL COMMENT '��� ������������',
	limit_age SMALLINT UNSIGNED DEFAULT 0 COMMENT '�������',
	len_time_films SMALLINT UNSIGNED COMMENT '�����',
	films_budget DECIMAL (11,2) COMMENT '������'	
) COMMENT = '������';

SELECT * FROM films;