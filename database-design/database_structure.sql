-- Создаём базу данных
CREATE DATABASE telegram;

USE telegram;

-- Таблица пользователей
CREATE TABLE `users` (
  `id` SERIAL PRIMARY KEY,
  `phone` VARCHAR(128) NOT NULL UNIQUE,
  `pin_code` SMALLINT(4) UNSIGNED NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
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
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`user_id`, `friend_id`)
) COMMENT 'Контакты';

-- Таблица статусов контактов
CREATE TABLE `contacts_statuses` (
  `id` SERIAL PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL UNIQUE,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Тип статуса контактов';


-- Таблица групп
CREATE TABLE `groups` (
  `id` SERIAL PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `link` VARCHAR(128) NOT NULL UNIQUE,
  `photo_id` INT UNSIGNED,
  `description` VARCHAR(255),
  `is_open` BOOLEAN NOT NULL COMMENT 'Тип канала {0 : Закрытый, 1 : Открытый}',
  `chat_history` BOOLEAN NOT NULL COMMENT 'Видна ли история чата другим пользователям',
  `can_send_massages` BOOLEAN COMMENT 'Разрешение на отправку сооющений',
  `can_send_media` BOOLEAN COMMENT 'Разрешение на отправку медиафайлов',
  `can_send_sticers_gif` BOOLEAN COMMENT 'Разрешение на отправку gif',
  `can_preciew_links` BOOLEAN COMMENT 'Разрешение на предпросмотор ссылок',
  `can_creating_surveys` BOOLEAN COMMENT 'Разрешение на создание опросов',
  `can_adding_person` BOOLEAN COMMENT 'Разрешение на добавление участников',
  `can_pinning_messages` BOOLEAN COMMENT 'Разрешение на закрепление сообщений',
  `changing_group_profile` BOOLEAN COMMENT 'Разрешение на изменения профиля группы',
  `time_limit` SMALLINT UNSIGNED COMMENT 'Ограничение времени отправки сообщений',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Группа';

-- Таблица связи пользователей и групп
CREATE TABLE `groups_users` (
  `group_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `user_type_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`group_id`, `user_id`)
) COMMENT 'Участники групп, связь между пользователями и группами';


-- Таблица канала
CREATE TABLE `communities` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `link` VARCHAR(128) NOT NULL UNIQUE,
  `photo_id` INT UNSIGNED,
  `description` VARCHAR(255),
  `is_open` BOOLEAN NOT NULL COMMENT 'Тип канала {0 : Закрытый, 1 : Открытый}',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Канал';

-- Таблица связи пользователей и каналов
CREATE TABLE `communities_users` (
  `community_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `user_type_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`community_id`, `user_id`)
) COMMENT 'Участники каналов, связь между пользователями и каналами';

-- Таблица постов канала
CREATE TABLE `posts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  `user_id` INT UNSIGNED NOT NULL COMMENT 'Создатель поста',
  `community_id` INT UNSIGNED NOT NULL COMMENT 'Канал, в котором создан пост',
  `title` VARCHAR(255) NOT NULL,
  `body` TEXT NOT NULL,
  `media_id` INT UNSIGNED,
  `delivered` BOOLEAN NOT NULL COMMENT 'Статус поста',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Посты каналов';

-- Таблица типов пользователей в группах и каналах (Админ, пользователь...)
CREATE TABLE `user_types` (
  `id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(32) NOT NULL UNIQUE,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Типы пользователей'; 


-- Таблица медиафайлов
CREATE TABLE `media` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `media_type_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `filename` VARCHAR(255) NOT NULL UNIQUE,
  `size` INT NOT NULL,
  `metadata` JSON,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Медиафайлы';

-- Таблица типов медиафайлов
CREATE TABLE `media_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL UNIQUE,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Тип медаифайла';


-- Таблица просмотров постов
CREATE TABLE `views` (
  `user_id` INT UNSIGNED NOT NULL,
  `post_id` INT UNSIGNED NOT NULL COMMENT 'Какая запись получила просмотр',
  PRIMARY KEY (`user_id`, `post_id`)
) COMMENT 'Просмотры постов';


-- Таблица связи сообщений пользователей
CREATE TABLE `messages` (
  `id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, 
  `user_id` INT UNSIGNED NOT NULL,
  `body` TEXT NOT NULL,
  `media_id` INT UNSIGNED,
  `delivered` BOOLEAN NOT NULL COMMENT 'Статус сообщения',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Связь пользователей и сооющений';

-- Таблица связи сообщений пользователей
CREATE TABLE `messages_users` (
  `id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  `messages_id` INT UNSIGNED NOT NULL COMMENT 'Текст сообщения',
  `target_id` INT UNSIGNED NOT NULL COMMENT 'id записи в таблице',
  `target_type_id` INT UNSIGNED NOT NULL COMMENT 'Сообщение пользователю или в группу'
) COMMENT 'Связь пользователей и сооющений';

-- Таблица типа сообщения (Пользователю в личные соообщения либо в группу)
CREATE TABLE `target_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL UNIQUE,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Адресация сообщения';