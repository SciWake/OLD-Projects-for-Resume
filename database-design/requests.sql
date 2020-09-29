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