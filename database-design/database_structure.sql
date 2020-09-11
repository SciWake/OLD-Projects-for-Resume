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
  `user_description` VARCHAR(255) COMMENT 'Описание пользователя',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Профиль пользователя';


-- Таблица контактов (Дружбы)
CREATE TABLE `contacts` (
  `user_id` INT UNSIGNED NOT NULL,
  `friend_id` INT UNSIGNED NOT NULL,
  `status_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `friend_id`)
) COMMENT 'Контакты';

-- Таблица статусов контактов
CREATE TABLE `contacts_statuses` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL UNIQUE
) COMMENT 'Тип статуса';


-- Таблица групп
CREATE TABLE `groups` (
  `id` SERIAL PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `link` VARCHAR(128) NOT NULL UNIQUE,
  `photo_id` INT UNSIGNED,
  `description` VARCHAR(255),
  `is_open` BOOLEAN NOT NULL COMMENT 'Тип канала {0 : Закрытый, 1 : Открытый}',
  `chat_history` BOOLEAN NOT NULL COMMENT 'Видна ли история чата',
  `user_permissions_id` INT UNSIGNED
) COMMENT 'Группа';

-- Таблица устанавливает разрешения пользователей
CREATE TABLE `user_permissions_id` (
  `group_id` SERIAL PRIMARY KEY,
  `can_send_massages` BOOLEAN,
  `can_send_media` BOOLEAN,
  `can_send_sticers_gif` BOOLEAN,
  `can_preciew_links` BOOLEAN,
  `can_creating_posts` BOOLEAN,
  `can_creating_surveys` BOOLEAN,
  `can_adding_person` BOOLEAN
);

-- Таблица связи пользователей и групп
CREATE TABLE `groups_membership` (
  `group_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `user_type_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`group_id`, `user_id`)
);
