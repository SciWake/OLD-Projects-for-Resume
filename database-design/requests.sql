USE telegram;


-- Выборка трёх групп, которые по всем постам набрали наибольше количество просмотров
SELECT posts.community_id, COUNT(views.user_id) AS count_views_groups
  FROM views
    LEFT JOIN posts
      ON views.post_id = posts.id
GROUP BY posts.community_id
ORDER BY count_views_groups DESC
LIMIT 3;

-- Доработаем запрос, добавив вывод наименования группы
SELECT posts.community_id,
  (SELECT name FROM communities WHERE posts.community_id = communities.id) AS group_name, 
  COUNT(views.user_id) AS count_views_groups
    FROM views
      LEFT JOIN posts
        ON views.post_id = posts.id
GROUP BY posts.community_id
ORDER BY count_views_groups DESC
LIMIT 3;


-- Сообщения от пользователя
SELECT messages.user_id, messages.body, messages_users.target_id
    FROM messages
      INNER JOIN messages_users
        ON messages.id = messages_users.messages_id
	  INNER JOIN target_types
        ON messages_users.target_type_id = target_types.id AND target_types.name = 'users'
	WHERE messages.user_id = 65;

-- Сообщение от пользователя и к пользователю (Переписка пользователя 65)
SELECT messages.user_id, messages.body, messages_users.target_id
    FROM messages
      INNER JOIN messages_users
        ON messages.id = messages_users.messages_id 
	  INNER JOIN target_types
        ON messages_users.target_type_id = target_types.id 
          AND target_types.name = 'users'
	WHERE messages_users.target_id = 65 OR messages.user_id = 65;


-- Выборка самый большой файл пользоватлея и файл, добавленый последним.
SELECT profiles.user_id, 
  CONCAT(profiles.first_name, ' ', profiles.last_name) AS "user name",
  media_big_file.id AS "The heaviest user file",
  media_top_date.id AS "Last user file"
    FROM profiles
	  LEFT JOIN media AS media_big_file
        ON media_big_file.user_id = profiles.user_id
	  LEFT JOIN media AS media_top_date
        ON media_top_date.user_id = profiles.user_id
WHERE profiles.user_id = 90
ORDER BY media_big_file.size DESC, media_top_date.created_at DESC
LIMIT 1;


-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый старший пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах 
-- (общее количество пользователей в группе /  всего пользователей в системе) * 100

SELECT DISTINCT 
  communities.name AS canal_name,
  COUNT(communities_users.user_id) OVER() 
    / (SELECT COUNT(*) FROM communities) AS avg_users_in_groups,
  FIRST_VALUE(CONCAT_WS(" ", profiles.first_name, profiles.last_name)) OVER w_community_birthday_desc AS youngest,
  FIRST_VALUE(CONCAT_WS(" ", profiles.first_name, profiles.last_name)) OVER w_community_birthday_asc AS oldest,
  COUNT(communities_users.user_id) OVER w_community AS users_in_canal,
  (SELECT COUNT(*) FROM users) AS users_total,
  COUNT(communities_users.user_id) OVER w_community / (SELECT COUNT(*) FROM users) * 100 AS '%%'
    FROM communities
      LEFT JOIN communities_users 
        ON communities_users.community_id = communities.id
      LEFT JOIN users 
        ON communities_users.user_id = users.id
      LEFT JOIN profiles 
        ON profiles.user_id = users.id
      WINDOW w_community AS (PARTITION BY communities.id),
             w_community_birthday_desc AS (PARTITION BY communities.id ORDER BY profiles.birthday DESC),
             w_community_birthday_asc AS (PARTITION BY communities.id ORDER BY profiles.birthday);