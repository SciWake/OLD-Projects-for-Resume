USE telegram;

-- Для таблицы profiles

-- Смотрим структуру таблицы
DESC profiles;

-- profiles_user_id_fk - При удалении строки в таблице users, будет ошибка, так как пользователь связан с профилем.
-- profiles_user_id_fk - При обновлении строки в таблице users, ссылка на пользователя будет обновлена в столбце user_id.

-- profiles_photo_id_fk - При удалении строки в таблице media, заместо фотографии будет установлено NULL значение.
-- profiles_photo_id_fk - При обновлении строки в таблице media, ссылка на фотографию будет обновлена в столбце photo_id.

-- Добавляем внешине ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON UPDATE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL
      ON UPDATE CASCADE;


-- Для таблицы messages

-- Смотрим структуру таблицы
DESC messages;

-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
	  ON UPDATE CASCADE,
  ADD CONSTRAINT messages_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
      ON UPDATE CASCADE;


-- Для таблицы posts

-- Смотрим структуру таблицы
DESC posts;

-- Добавляем внешние ключи
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
	  ON UPDATE CASCADE,
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
      ON UPDATE CASCADE;


-- Для таблицы media

-- Смотрим структуру таблицы
DESC media;

-- Добавляем внешние ключи
ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
	  ON UPDATE CASCADE,
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
      ON UPDATE CASCADE;