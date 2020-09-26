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

-- Анализируем данные
SELECT * FROM media LIMIT 10;


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
-- 37

-- Заменяем строки местами, де аккаунт был создан быстрее, чем родился пользователь
INSERT INTO `profiles` SELECT * FROM `profiles` `t2` 
  WHERE `created_at` < `birthday` 
    ON DUPLICATE KEY UPDATE `birthday` = `t2`.`created_at`, `created_at` = `t2`.`birthday`;

-- Проверка данных, где аккаунт был создан быстрее, чем родился пользователь
SELECT COUNT(*) FROM profiles WHERE created_at < birthday;
-- 0


-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM profiles WHERE updated_at < created_at;
-- 139

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