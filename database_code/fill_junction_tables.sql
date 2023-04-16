-- friends filling
INSERT INTO user_friend_map (discord_user_id, friend_id)
SELECT DISTINCT
    mod(level - 1, 10) AS discord_user_id,
    mod(level - 1, 10) AS friend_id
FROM dual
CONNECT BY level <= 10
ORDER BY discord_user_id, friend_id;
--

-- reactions filling
INSERT INTO user_reaction_map (discord_user_id, reaction_id)
SELECT DISTINCT
    mod(level - 1, 10) AS discord_user_id,
    mod(level - 1, 5) AS reaction_id
FROM dual
CONNECT BY level <= 10
ORDER BY discord_user_id, reaction_id;
--

-- roles filling
INSERT INTO user_role_map (discord_user_id, user_role_id)
SELECT DISTINCT
    mod(level - 1, 10) AS discord_user_id,
    mod(level - 1, 10) AS user_role_id
FROM dual
CONNECT BY level <= 10
ORDER BY discord_user_id, user_role_id;
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