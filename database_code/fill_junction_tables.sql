-- friends filling
INSERT INTO user_friend_map (user_id, friend_id)
SELECT DISTINCT
    mod(level - 1, 10) AS user_id,
    mod(level - 1, 10) AS friend_id
FROM dual
CONNECT BY level <= 10
ORDER BY user_id, friend_id;
--

-- reactions filling
INSERT INTO user_reaction_map (user_id, reaction_id)
SELECT DISTINCT
    mod(level - 1, 10) AS user_id,
    mod(level - 1, 5) AS reaction_id
FROM dual
CONNECT BY level <= 10
ORDER BY user_id, reaction_id;
--

-- roles filling
INSERT INTO user_role_map (user_id, role_id)
SELECT DISTINCT
    mod(level - 1, 10) AS user_id,
    mod(level - 1, 10) AS role_id
FROM dual
CONNECT BY level <= 10
ORDER BY user_id, role_id;
--

-- emojis filling
INSERT INTO message_emoji_map (message_id, emoji_id)
SELECT DISTINCT
    mod(level - 1, 8) AS message_id,
    mod(level - 1, 5) AS emoji_id
FROM dual
CONNECT BY level <= 10
ORDER BY message_id, emoji_id;
--