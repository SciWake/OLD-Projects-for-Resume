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