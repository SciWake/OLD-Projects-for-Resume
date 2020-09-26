-- ОБРАБОТКА ТАБЛИЦ И ДАННЫХ

-- Смотрим все таблицы
SHOW TABLES;

USE telegram;

-- ____________________________________________________________________________________
-- USERS

-- Смотрим структуру таблицы 
DESCRIBE users;

-- Анализируем данные
SELECT * FROM users LIMIT 10;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM users WHERE updated_at < created_at;
-- 152

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `users` SELECT * FROM `users` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM users WHERE updated_at < created_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM users LIMIT 10;


-- ____________________________________________________________________________________
-- MEDIA_TYPES

-- Смотрим структуру таблицы
DESCRIBE media_types;

-- Анализируем данные
SELECT * FROM media_types LIMIT 10;

-- Исправим значения name в таблице
UPDATE media_types SET name = 'photo' WHERE id = 1;
UPDATE media_types SET name = 'video' WHERE id = 2;
UPDATE media_types SET name = 'text' WHERE id = 3;
UPDATE media_types SET name = 'audio' WHERE id = 4;
UPDATE media_types SET name = 'archive' WHERE id = 5;

-- Анализируем конечные данные
SELECT * FROM media_types LIMIT 10;


-- ____________________________________________________________________________________
-- MEDIA

-- Смотрим структуру таблицы
DESCRIBE media;

-- Возвращаем столбцу метеданных исходный тип данных
ALTER TABLE media MODIFY COLUMN metadata JSON;


-- Анализируем данные
SELECT * FROM media LIMIT 10;

-- Создаём временную таблицу форматов медиафайлов
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- Заполняем значениями
INSERT INTO extensions VALUES ('jpeg'), ('mp3'), ('txt'), ('ogg'), ('zip');

-- Переименуем столбец пути к файлу 
ALTER TABLE media RENAME COLUMN filename TO filepath;

-- Обновляем ссылку на файл
UPDATE media SET filepath = CONCAT(
  'https://',
  filepath,
  (SELECT last_name FROM profiles ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- Анализируем данные
SELECT * FROM media LIMIT 10;


-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM profiles WHERE media.user_id = profiles.user_id),
  '"}');

-- Анализируем данные
SELECT * FROM media LIMIT 10;


-- Исправим значения в столбце media_type_id, установим соответствие jpeg - photo, txt - text...
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'photo') WHERE filepath LIKE '%jpeg';
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'video') WHERE filepath LIKE '%ogg';
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'text') WHERE filepath LIKE '%txt';
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'audio') WHERE filepath LIKE '%mp3';
UPDATE media SET media_type_id = (SELECT id FROM media_types WHERE name = 'archive') WHERE filepath LIKE '%zip';

-- Анализируем конечные данные
SELECT * FROM media LIMIT 10;


-- ____________________________________________________________________________________
-- PROFILES

-- Смотрим структуру таблицы
DESC profiles;

-- Анализируем данные
SELECT * FROM profiles LIMIT 10;

  
-- Данные, где аккаунт был создан быстрее, чем родился пользователь
SELECT COUNT(*) FROM profiles WHERE created_at < birthday;
-- 30

-- Заменяем строки местами, де аккаунт был создан быстрее, чем родился пользователь
INSERT INTO `profiles` SELECT * FROM `profiles` `t2` 
  WHERE `created_at` < `birthday` 
    ON DUPLICATE KEY UPDATE `birthday` = `t2`.`created_at`, `created_at` = `t2`.`birthday`;

-- Проверка данных, где аккаунт был создан быстрее, чем родился пользователь
SELECT COUNT(*) FROM profiles WHERE created_at < birthday;
-- 0


-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM profiles WHERE updated_at < created_at;
-- 131

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `profiles` SELECT * FROM `profiles` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM profiles WHERE updated_at < created_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM profiles LIMIT 10;



-- ____________________________________________________________________________________
-- MESSAGES

-- Смотрим структуру таблицы
DESC messages;

-- Анализируем данные
SELECT * FROM messages LIMIT 10;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM messages WHERE updated_at < created_at;
-- 382

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `messages` SELECT * FROM `messages` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM messages WHERE updated_at < created_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM messages LIMIT 10;



-- ____________________________________________________________________________________
-- MESSAGES_STATUSES

-- Смотрим структуру таблицы
DESC messages_statuses;

-- Анализируем данные
SELECT * FROM messages_statuses LIMIT 10;

-- Исправим значения name в таблице
UPDATE messages_statuses SET name = 'shipped' WHERE id = 1;  -- Отправлено
UPDATE messages_statuses SET name = 'delivered' WHERE id = 2;  -- Доставлено
UPDATE messages_statuses SET name = 'read' WHERE id = 3;  -- Прочитано
UPDATE messages_statuses SET name = 'сhanged' WHERE id = 4;  -- Изменено
UPDATE messages_statuses SET name = 'deleted' WHERE id = 5;  -- Удалено

-- Анализируем конечные данные
SELECT * FROM messages_statuses LIMIT 10;



-- ____________________________________________________________________________________
-- TARGET_TYPES

-- Смотрим структуру таблицы
DESC target_types;

-- Анализируем данные
SELECT * FROM target_types LIMIT 10;

-- Исправим значения name в таблице
UPDATE target_types SET name = 'users' WHERE id = 1;  -- Сообщение пользователям
UPDATE target_types SET name = 'groups' WHERE id = 2;  -- Сообщение в группу

-- Анализируем конечные данные
SELECT * FROM target_types LIMIT 10;



-- ____________________________________________________________________________________
-- MESSAGES_USERS

-- Смотрим структуру таблицы
DESC messages_users;

-- Анализируем данные
SELECT * FROM messages_users LIMIT 10;


-- Для users

-- Выбираем сообщения, которые отправлены пользователям
SELECT * 
  FROM messages_users
    INNER JOIN target_types
	  ON messages_users.target_type_id = target_types.id AND target_types.name = 'users';

-- Выбираем id пользователей из таблицы users
SELECT id FROM users;

-- Выбираем сообщения, которые отправлены пользователям, где такого пользователя не существует в таблице users
SELECT COUNT(*)
    FROM messages_users
      INNER JOIN target_types
        ON messages_users.target_type_id = target_types.id AND target_types.name = 'users'
	WHERE target_id NOT IN (SELECT id FROM users);
-- 0
-- Значит данные с пользователями корректные


-- Для groups запускаем файл procedure_messages_users



-- ____________________________________________________________________________________
-- CONTACTS

-- Смотрим структуру таблицы
DESC contacts;

-- Анализируем данные
SELECT * FROM contacts LIMIT 10;

-- Поиск необычных друзей, где пользователь сам себе друг
SELECT COUNT(*) FROM contacts WHERE friend_id = user_id;
-- 1

-- Исправляем случай когда user_id = friend_id
UPDATE contacts SET friend_id = friend_id + 1 WHERE user_id = friend_id;

-- Поиск необычных друзей, где пользователь сам себе друг
SELECT COUNT(*) FROM contacts WHERE friend_id = user_id;
-- 0


-- Анализируем данные
SELECT * FROM contacts LIMIT 10;

-- Проверка строк даты, где requested_at больше чем confirmed_at
SELECT COUNT(*) FROM contacts WHERE requested_at > confirmed_at;
-- 396

-- Заменяем строки местами, где requested_at больше чем confirmed_at
INSERT INTO `contacts` SELECT * FROM `contacts` `t2` 
  WHERE `requested_at` > `confirmed_at` 
    ON DUPLICATE KEY UPDATE `confirmed_at` = `t2`.`requested_at`, `requested_at` = `t2`.`confirmed_at`;

-- Проверка строк даты, где requested_at больше чем confirmed_at
SELECT COUNT(*) FROM contacts WHERE requested_at > confirmed_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM contacts LIMIT 10;



-- ____________________________________________________________________________________
-- CONTACTS_STATUSES

-- Смотрим структуру таблицы
DESC contacts_statuses;

-- Анализируем данные
SELECT * FROM contacts_statuses LIMIT 10;

-- Исправим значения name в таблице
UPDATE contacts_statuses SET name = 'friend' WHERE id = 1;  -- Пользователь находится в контактах
UPDATE contacts_statuses SET name = 'removed' WHERE id = 2;  -- Пользователь удалён из контактов

-- Анализируем конечные данные
SELECT * FROM contacts_statuses LIMIT 10;



-- ____________________________________________________________________________________
-- GROUPS

-- Смотрим структуру таблицы
DESC `groups`;

-- Анализируем данные
SELECT * FROM `groups` LIMIT 10;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM `groups` WHERE updated_at < created_at;
-- 9

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `groups` SELECT * FROM `groups` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM `groups` WHERE updated_at < created_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM `groups` LIMIT 10;



-- ____________________________________________________________________________________
-- GROUPS_USERS

-- Смотрим структуру таблицы
DESC groups_users;

-- Анализируем данные
SELECT * FROM groups_users LIMIT 10;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM groups_users WHERE updated_at < created_at;
-- 1509

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `groups_users` SELECT * FROM `groups_users` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM groups_users WHERE updated_at < created_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM groups_users LIMIT 10;



-- ____________________________________________________________________________________
-- COMMUNITIES

-- Смотрим структуру таблицы
DESC communities;

-- Анализируем данные
SELECT * FROM communities LIMIT 10;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM communities WHERE updated_at < created_at;
-- 13

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `communities` SELECT * FROM `communities` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM communities WHERE updated_at < created_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM communities LIMIT 10;



-- ____________________________________________________________________________________
-- COMMUNITIES_USERS

-- Смотрим структуру таблицы
DESC communities_users;

-- Анализируем данные
SELECT * FROM communities_users LIMIT 10;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM communities_users WHERE updated_at < created_at;
-- 2141

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `communities_users` SELECT * FROM `communities_users` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM communities_users WHERE updated_at < created_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM communities_users LIMIT 10;



-- ____________________________________________________________________________________
-- USER_TYPES

-- Смотрим структуру таблицы
DESC user_types;

-- Анализируем данные
SELECT * FROM user_types LIMIT 10;

-- Исправим значения name в таблице
UPDATE user_types SET name = 'creator' WHERE id = 1;  
UPDATE user_types SET name = 'administrator' WHERE id = 2; 
UPDATE user_types SET name = 'moderator' WHERE id = 3; 
UPDATE user_types SET name = 'user' WHERE id = 4; 
UPDATE user_types SET name = 'banned' WHERE id = 5; 

-- Анализируем конечные данные
SELECT * FROM user_types LIMIT 10;



-- ____________________________________________________________________________________
-- POSTS

-- Смотрим структуру таблицы
DESC posts;

-- Анализируем данные
SELECT * FROM posts LIMIT 10;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM posts WHERE updated_at < created_at;
-- 672

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `posts` SELECT * FROM `posts` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM posts WHERE updated_at < created_at;
-- 0

-- Анализируем конечные данные
SELECT * FROM posts LIMIT 10;