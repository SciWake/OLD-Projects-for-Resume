-- ТРИГГЕРЫ

/* Создание триггера для обработки target_id. Тригер будет работать аналогично тому, как СУБД проверяет допустимость значений внешнего ключа, 
например для столбца user_id и ссылку на id из таблицы users.
Триггер будет работать на вставку/обновление строки таблицы messages_users, который будет проверять по введённым значениям target_id и target_type_id, существует ли
в соответствующей таблице запись с представленным id. Если в соответствующей таблице, которая задана ссылкой в target_type_id нет идентификатора,
который задан  в target_id, то будет генерироваться ошибка. Ошибка сообщает о том, что не ссылочной целостности (Попытка вставки данных, которых 
нет в связанных на ЛОГИЧЕСКОМ уровне таблицах).
Сначала создадим функцию для проверки существования строки. Причиной этого служит, что тригеры проверяют данные по очень простым критериям,
поэтому в триггерах не работают некоторые управляющие структуры, которые мы можем использовать в функциях или процедурах. Вся логика проверки 
будет вынесена в функцию.
*/

USE telegram;

-- Просмотр структуры таблицы
DESC messages_users;

-- Выведем данные
SELECT * FROM messages_users LIMIT 10;



DROP FUNCTION IF EXISTS is_row_exists;
DELIMITER //

CREATE FUNCTION is_row_exists (target_id INT, target_type_id INT)
RETURNS BOOLEAN READS SQL DATA

BEGIN
  DECLARE table_name VARCHAR(50);
  SELECT name FROM target_types WHERE id = target_type_id INTO table_name; -- Помещаем запрос в таблицу table_name
  
  CASE table_name
    WHEN 'groups' THEN
      RETURN EXISTS(SELECT 1 FROM `groups` WHERE id = target_id);
    WHEN 'users' THEN 
      RETURN EXISTS(SELECT 1 FROM users WHERE id = target_id);
    ELSE 
      RETURN FALSE;
  END CASE;
  
END//

DELIMITER ;

-- Выведем типы таблицы, которые у нас есть
SELECT * FROM target_types;
-- id = 1, name = users

-- Тестирование функции (300 - id сущности | 1 - тип, куда установлен лайк)
SELECT is_row_exists(300, 1);
-- 1 Так как пользователь (1) с идентификатором 300 существует

SELECT is_row_exists(301, 1);
-- 0
-- Мы знаем, что в таблице пользователей, их всего 300



-- Создадим триггер для проверки валидности target_id и target_type_id для вставки
DROP TRIGGER IF EXISTS messages_users_insert;
DELIMITER //

CREATE TRIGGER messages_users_insert BEFORE INSERT ON messages_users

FOR EACH ROW BEGIN
  IF NOT is_row_exists(NEW.target_id, NEW.target_type_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided!";
  END IF;
  
END//

DELIMITER ;


-- Проверка работы триггера (Сообщение 1 существует, пользователь 300 существует, тип 1 существует, стутус 1 существует)
INSERT INTO messages_users(messages_id, target_id, target_type_id, status_id) VALUES (1, 300, 1, 1);
-- Вставка прошла успешно

-- Изменим target_type_id на другое значение
INSERT INTO messages_users(messages_id, target_id, target_type_id, status_id) VALUES (1, 300, 3, 1);
-- Такого id в таблице target_types нет, поэтому триггер сообщает нам об ошибке


-- Просмотр функций и процедур
SHOW FUNCTION STATUS LIKE 'is_row_exists';
SHOW CREATE FUNCTION is_row_exists;