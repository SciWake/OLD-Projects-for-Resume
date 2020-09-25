-- ОБРАБОТКА ТАБЛИЦ И ДАННЫХ

-- Смотрим все таблицы
SHOW TABLES;

USE telegram;


-- USERS

-- Смотрим структуру таблицы пользователей
DESCRIBE users;

-- Анализируем данные пользователей
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

-- Анализируем конечные данные пользователей
SELECT * FROM users LIMIT 10;
