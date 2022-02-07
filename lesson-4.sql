/*Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке*/
SELECT DISTINCT first_name FROM users
ORDER BY first_name;

/*Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
 * Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)*/

ALTER TABLE profiles ADD COLUMN is_active boolean DEFAULT true;

UPDATE profiles SET is_active = FALSE 
	WHERE birtday > date_add(now(),INTERVAL -18 year);

-- Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)

DELETE FROM messages WHERE created_at > now()
