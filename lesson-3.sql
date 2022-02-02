CREATE DATABASE IF NOT EXISTS vk;

USE vk;

SHOW tables;

DROP TABLE IF EXISTS  ads;
DROP TABLE IF EXISTS media;
DROP TABLE IF EXISTS media_types;
DROP TABLE IF EXISTS communities_users;
DROP TABLE IF EXISTS communities;
DROP TABLE IF EXISTS friend_requests;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS county;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY,
	first_name varchar(150) NOT NULL,
	last_name varchar(150) NOT NULL,
	email varchar(150) UNIQUE NOT NULL,
	phone char(11) UNIQUE NOT NULL,
	password_hash char(65) DEFAULT NULL,
	created_at datetime NOT NULL DEFAULT current_timestamp
	);
	
INSERT INTO users VALUES (1, 'Petya', 'Petukhov', 'p@mail.ru', '79221234455', 'ald3h7hjsd7823hj', DEFAULT);
INSERT INTO users VALUES (DEFAULT, 'Vasya', 'Vasilkov', 'v@mail.ru', '79221237766', 'al32453d3h7hjsd7823hj', DEFAULT);

-- SELECT * FROM users;

DESCRIBE users;

-- Справочник городов
CREATE TABLE IF NOT EXISTS city(
	id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_city varchar(255) UNIQUE NOT NULL	
);

INSERT INTO city VALUES (1, 'Moscow');
INSERT INTO city VALUES (DEFAULT, 'Surgut');

-- Справочник стран
CREATE TABLE IF NOT EXISTS county(
	id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_county varchar(255) UNIQUE NOT NULL	
);

INSERT INTO county VALUES (1, 'RU');
INSERT INTO county VALUES (DEFAULT, 'USA');

CREATE TABLE IF NOT EXISTS profiles(
	user_id SERIAL PRIMARY key,
	gender enum('f','m','x') NOT NULL,
	birtday date NOT NULL,
	photo_id bigint UNSIGNED,
	-- city varchar(130),
	city_id int UNSIGNED NOT NULL,
	country_id int UNSIGNED NOT NULL,
	-- country varchar(130),
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY(city_id) REFERENCES  city (id),
	FOREIGN KEY(country_id) REFERENCES  county (id)
);

INSERT INTO profiles VALUES (1, 'm', '1997-12-01', 1, 1 /*'Moscow'*/, 1 /*'RU'*/); -- профиль Пети
INSERT INTO profiles VALUES (2, 'm', '1988-11-01', 5, 1 /*'Moscow'*/, 1 /*'RU'*/ ); -- Профиль Васи

-- SELECT * FROM profiles;


CREATE TABLE IF NOT EXISTS messages(
	id serial PRIMARY KEY,
	from_user_id bigint UNSIGNED NOT NULL,
	to_user_id bigint UNSIGNED NOT NULL,
	body text,
	created_at datetime DEFAULT current_timestamp,
	updated_at datetime DEFAULT current_timestamp ON UPDATE current_timestamp,
	is_delivered boolean DEFAULT FALSE,
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Hi!', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Vasya!', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO messages VALUES (DEFAULT, 2, 1, 'Hi!, Petya', DEFAULT, DEFAULT, DEFAULT);

-- SELECT * FROM messages;

CREATE TABLE IF NOT EXISTS friend_requests(
	from_user_id bigint UNSIGNED NOT NULL,
	to_user_id bigint UNSIGNED NOT NULL,
	accepted bool DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT INTO friend_requests VALUES (1, 2, 1);

-- SELECT * FROM friend_requests;

CREATE TABLE IF NOT EXISTS communities(
	id serial PRIMARY KEY,
	name varchar(150) NOT NULL,
	description varchar(255),
	admin_id bigint UNSIGNED NOT NULL,
	INDEX (name),
	FOREIGN KEY (admin_id) REFERENCES users (id)
); 

INSERT INTO communities VALUES (DEFAULT, 'Number1', 'I am number one', 1);

-- SELECT * FROM communities;

CREATE TABLE IF NOT EXISTS communities_users(
	community_id bigint UNSIGNED NOT NULL,
	user_id bigint UNSIGNED NOT NULL,
	PRIMARY KEY (community_id, user_id),
	FOREIGN KEY (community_id) REFERENCES communities (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);


INSERT INTO communities_users VALUES (1,2);

CREATE TABLE IF NOT EXISTS media_types(
	id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name varchar(50) UNIQUE NOT NULL	
);

INSERT INTO media_types VALUES (DEFAULT, 'image');
INSERT INTO media_types VALUES (DEFAULT, 'music');
INSERT INTO media_types VALUES (DEFAULT, 'document');

-- SELECT * FROM media_types;

CREATE TABLE IF NOT EXISTS media(
	id serial PRIMARY KEY,
	user_id bigint UNSIGNED NOT NULL,
	media_types_id int UNSIGNED NOT NULL,
	file_name varchar(255),
	file_size bigint UNSIGNED,
	created_at datetime NOT NULL DEFAULT now(),
	FOREIGN KEY (media_types_id) REFERENCES media_types (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO media VALUES (DEFAULT, 1, 1, 'img.jpg', 100, default);
INSERT INTO media VALUES (DEFAULT, 1, 1, 'img1.jpg', 78, default);

INSERT INTO media VALUES (DEFAULT, 2, 3, 'doc.docx', 1024, default);

-- SELECT * FROM media;


ALTER TABLE users ADD INDEX (last_name);

ALTER TABLE users ADD INDEX phone_idx (phone);

-- Объявления
CREATE TABLE IF NOT EXISTS ads(
	id serial PRIMARY KEY,
	user_id bigint UNSIGNED NOT NULL,
	catalog_ads varchar(30) NOT NULL,
	title_ads varchar(50) NOT NULL,
	disription_ads varchar(255),
	media_id bigint UNSIGNED NOT NULL,
	price_ads decimal(8,2) NOT null,
	created_at datetime NOT NULL DEFAULT now(),
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (media_id) REFERENCES media (id)
);