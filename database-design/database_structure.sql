-- Создаём базу данных
CREATE DATABASE telegram;

USE telegram;

-- Таблица пользователей
CREATE TABLE `users` (
  `id` SERIAL PRIMARY KEY,
  `phone` VARCHAR(128) NOT NULL UNIQUE,
  `pin_code` SMALLINT(4) UNSIGNED NOT NULL,
  `created_at` DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  `updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Время обновления строки'
) COMMENT 'Пользователи';
