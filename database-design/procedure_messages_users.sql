-- Выбор базы данных
USE telegram;



-- ___________________________________________________________
-- ЗАПРОСЫ, КОТОРЫЕ БУДУТ ИСПОЛЬЗОВАНЫ В ПРОЦЕДУРЕ

-- Выбираем сообщения, которые отправлены в группу
SELECT * 
  FROM messages_users 
    WHERE target_type_id IN (SELECT id FROM target_types WHERE name = 'groups');

-- Выбираем id групп из таблицы groups
SELECT id FROM `groups`;

-- Выбираем сообщения отправленны в группу (target_type_id), где идентификатор группы (target_id) не присутсвует в таблице goups
SELECT COUNT(*)
  FROM messages_users 
    WHERE target_type_id IN (SELECT id FROM target_types WHERE name = 'groups')
      AND target_id NOT IN (SELECT id FROM `groups`);
-- 243

-- Вариант с JOIN
SELECT COUNT(*)
    FROM messages_users
      INNER JOIN target_types
        ON messages_users.target_type_id = target_types.id AND target_types.name = 'groups'
	WHERE target_id NOT IN (SELECT id FROM `groups`);
-- 243


-- Выполняем обновление данных

-- Генерируем id группы в столбце target_id из таблицы groups (это нужно для согласованности данных), где цель (target_type_id) groups
UPDATE messages_users 
  SET target_id = (SELECT id FROM `groups` ORDER BY RAND() LIMIT 1)
  WHERE target_type_id IN (SELECT id FROM target_types WHERE name = 'groups')
    AND target_id NOT IN (SELECT id FROM `groups`);
    
/* Error Code: 1062. Duplicate entry '4-17-2' for key 'messages_users.PRIMARY' 
Чтобы изавиться от данной ошибки, требуется установить лимит обновления записей LIMIT 1, тогда обновление будет успешным.

Так как количество обновлений составит 1615, 1615 запускать данное обновление будет трудоёмкой задачей. Решить проблему можно использованием,
процедуры, которая при запуске выполнить обновление данных.*/


DELIMITER //

-- Функция возвращает TRUE, если есть данные для обновления, иначе FALSE
DROP FUNCTION IF EXISTS update_groups//
CREATE FUNCTION update_groups()
RETURNS INT DETERMINISTIC
BEGIN

  DECLARE count_update INT;
  
  SELECT COUNT(*)
    FROM messages_users
      INNER JOIN target_types
        ON messages_users.target_type_id = target_types.id AND target_types.name = 'groups'
	WHERE target_id NOT IN (SELECT id FROM `groups`) INTO count_update;
    
	IF(count_update > 0) THEN
      RETURN TRUE;
	ELSE 
      RETURN FALSE;
	END IF;
    
END//

DELIMITER ;

-- Проверяем работу функции
SELECT update_groups();
-- 1


/* Данная процедура будет выполнять обновление записей по циклу, цикл работает до тех пор, пока функция  update_groups возвращает 
TRUE, если функция вернула FALSE, значит все данные были обновлены. */
DELIMITER //

DROP PROCEDURE IF EXISTS update_messages_users_in_group//
CREATE PROCEDURE update_messages_users_in_group()
BEGIN

  DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
  
  cycle: WHILE update_groups() DO
	UPDATE messages_users
	  SET target_id = (SELECT id FROM `groups` ORDER BY RAND() LIMIT 1)
      WHERE target_type_id IN (SELECT id FROM target_types WHERE name = 'groups')
        AND target_id NOT IN (SELECT id FROM `groups`) LIMIT 15;
        
	IF @error IS NOT NULL THEN ITERATE cycle;
    END IF;
    
  END WHILE;
  
END//


DELIMITER ;

-- Запускаем процедуру
CALL update_messages_users_in_group;


-- С помощью функции проверяем, есть ли данные для обновления
SELECT update_groups();
-- 0


-- Анализ итоговых данных

-- Выбираем сообщения, которые отправлены в группу
SELECT * 
  FROM messages_users 
    WHERE target_type_id IN (SELECT id FROM target_types WHERE name = 'groups');

-- Так как групп всего 20, то targer_id после обновления не должен быть больше 20, что показывает вывод запроса выше