CREATE SCHEMA friends;
USE friends;

SELECT u.first_name, u.last_name, us.first_name AS 'friend_first_name', us.last_name AS 'friend_last_name' FROM friends.users u
INNER JOIN friends.friendships f
ON u.id = f.user_id
INNER JOIN friends.users us
ON f.friend_id = us.id;

-- EJERCICIO ADICIONAL
-- Devuelva a todos los usuarios que son amigos de Kermit, asegúrese de que sus nombres se muestren en los resultados.
SELECT us.first_name, us.last_name FROM friends.users u
INNER JOIN friends.friendships f
ON u.id = f.user_id
INNER JOIN friends.users us
ON f.friend_id = us.id
WHERE u.first_name = 'Kermit'
UNION ALL
SELECT u.first_name, u.last_name FROM friends.users u
INNER JOIN friends.friendships f
ON u.id = f.user_id
INNER JOIN friends.users us
ON f.friend_id = us.id
WHERE us.first_name = 'Kermit'
;

-- Devuelve el recuento de todas las amistades.
SELECT COUNT(*) FROM friends.friendships;

-- Descubre quién tiene más amigos y devuelve el recuento de sus amigos.
SELECT u.first_name, COUNT(*) AS Friendships FROM friends.friendships f
INNER JOIN friends.users u
ON f.user_id = u.id
GROUP BY f.user_id
ORDER BY Friendships DESC
LIMIT 1;

-- Crea un nuevo usuario y hazlos amigos de Eli Byers, Kermit The Frog y Marky Mark.
INSERT INTO friends.users (first_name, last_name, created_at) VALUES (
'Jane', 'Doe', now()
);

INSERT INTO friends.friendships (user_id, friend_id, created_at) VALUES (
(SELECT id FROM friends.users WHERE UPPER(CONCAT(first_name, ' ', last_name)) = 'JANE DOE'),
(SELECT id FROM friends.users WHERE UPPER(CONCAT(first_name, ' ', last_name)) = 'ELI BYERS'),
NOW()
);

INSERT INTO friends.friendships (user_id, friend_id, created_at) VALUES (
(SELECT id FROM friends.users WHERE UPPER(CONCAT(first_name, ' ', last_name)) = 'JANE DOE'),
(SELECT id FROM friends.users WHERE UPPER(CONCAT(first_name, ' ', last_name)) = 'KERMIT THE FROG'),
NOW()
);

INSERT INTO friends.friendships (user_id, friend_id, created_at) VALUES (
(SELECT id FROM friends.users WHERE UPPER(CONCAT(first_name, ' ', last_name)) = 'JANE DOE'),
(SELECT id FROM friends.users WHERE UPPER(CONCAT(first_name, ' ', last_name)) = 'MARKY MARK'),
NOW()
);

-- Devuelve a los amigos de Eli en orden alfabético.
SELECT us.first_name, us.last_name FROM friends.users u
INNER JOIN friends.friendships f
ON u.id = f.user_id
INNER JOIN friends.users us
ON f.friend_id = us.id
WHERE u.first_name = 'Eli'
ORDER BY us.first_name ASC;

-- Eliminar a Marky Mark de los amigos de Eli.
DELETE FROM friends.friendships
WHERE friend_id = (
SELECT id FROM users WHERE UPPER(CONCAT(first_name, ' ', last_name)) = 'MARKY MARK'
) AND user_id = (
SELECT id FROM users WHERE UPPER(first_name) = 'ELI'
);

-- Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos
SELECT u.first_name, u.last_name, us.first_name AS 'friend_first_name', us.last_name AS 'friend_last_name' FROM friends.users u
INNER JOIN friends.friendships f
ON u.id = f.user_id
INNER JOIN friends.users us
ON f.friend_id = us.id;