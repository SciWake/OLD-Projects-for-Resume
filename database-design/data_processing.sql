-- ОБРАБОТКА ТАБЛИЦ И ДАННЫХ

-- Смотрим все таблицы
SHOW TABLES;

USE telegram;


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



-- MEDIA_TYPES

-- Смотрим структуру таблицы
DESCRIBE media_types;

-- Анализируем данные
SELECT * FROM media_types LIMIT 10;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM media_types WHERE updated_at < created_at;
-- 2

-- Заменяем строки местами, где updated_at меньше чем created_at
INSERT INTO `media_types` SELECT * FROM `media_types` `t2` 
  WHERE `updated_at` < `created_at` 
    ON DUPLICATE KEY UPDATE `created_at` = `t2`.`updated_at`, `updated_at` = `t2`.`created_at`;

-- Проверка строк даты, где updated_at меньше чем created_at
SELECT COUNT(*) FROM media_types WHERE updated_at < created_at;
-- 0

-- Исправим значения name в таблице
UPDATE media_types SET name = 'photo' WHERE id = 1;
UPDATE media_types SET name = 'video' WHERE id = 2;
UPDATE media_types SET name = 'text' WHERE id = 3;
UPDATE media_types SET name = 'audio' WHERE id = 4;
UPDATE media_types SET name = 'archive' WHERE id = 5;

-- Анализируем конечные данные пользователей
SELECT * FROM media_types LIMIT 10;