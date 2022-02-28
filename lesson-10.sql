DROP DATABASE IF EXISTS kinopoisk;

CREATE DATABASE IF NOT EXISTS kinopoisk /*!40100 DEFAULT CHARACTER SET cp1251 */;

-- используем БД kinopoisk
USE kinopoisk;

-- Создаем таблицу с фильмами
DROP TABLE IF EXISTS films;

CREATE TABLE IF NOT EXISTS films(
	id SERIAL PRIMARY KEY,
	name_film varchar(255) NOT NULL COMMENT 'Название фильма',
	about varchar(4000) NOT NULL COMMENT 'Описание',
	create_at datetime NOT NULL COMMENT 'Год производства',
	limit_age SMALLINT UNSIGNED DEFAULT 0 COMMENT 'Возраст',
	len_time_films SMALLINT UNSIGNED COMMENT 'Время',
	films_budget DECIMAL (11,2) COMMENT 'Бюджет'	
) COMMENT = 'Фильмы';

SELECT * FROM films;