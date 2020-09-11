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


-- Таблица профилей
CREATE TABLE `profiles` (
  `user_id` SERIAL PRIMARY KEY,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255),
  `nick_name` VARCHAR(32) UNIQUE,
  `gender` BOOLEAN NOT NULL COMMENT '{0 : Мужской, 1 : Женский}',
  `birthday` DATE NOT NULL COMMENT 'Дата рождения',
  `country` VARCHAR(255) NOT NULL COMMENT 'Страна проживания',
  `photo_id` INT UNSIGNED,
  `user_description` VARCHAR(255) COMMENT 'Описание( О себе )',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
);