-- sequences for ids generating
DECLARE
    seq_names DBMS_SQL.VARCHAR2A;
BEGIN
    seq_names := DBMS_SQL.VARCHAR2A();
	seq_names(1) := 'server';
	seq_names(2) := 'user';
    seq_names(3) := 'channel';
    seq_names(4) := 'role';
    seq_names(5) := 'emoji';
    seq_names(6) := 'message';
    seq_names(7) := 'reaction';
    
    FOR i IN seq_names.FIRST..seq_names.LAST LOOP
        EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_' || seq_names(i) || ' MINVALUE 0 START WITH 0 INCREMENT BY 1 NOCYCLE';
    END LOOP;
END;
/
--

-- insert servers
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'My Awesome Server', 'server-icon.png', 'US');
    
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'The Best Server', 'best-server-icon.png', 'Europe');
    
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'Cool Server', 'cool-server-icon.png', 'Europe');
    
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'My Minecraft Server', 'minecraft-server-icon.png', 'Asia');
    
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'My Discord Server', 'discord-server-icon.png', 'US');
--

-- insert users
INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'LilNachoMan', 'lilnacho@gmail.com', '(654) 312-9009', 'I love nachos!', 'image_of_nachos.png');

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'LlamaMama', 'llama.mama@yahoo.com', NULL, 'On a llama adventure!', NULL);

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'BananaSlammaJamma', 'bananaslam@gmail.com', '(124) 456-7890', NULL, NULL);

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'PandaBearHugs', 'pandahugs@gmail.com', '(987) 654-3210', 'Giving virtual hugs to all pandas!', NULL);

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'PizzaParty123', 'pizzaparty123@hotmail.com', NULL, 'Let''s have a pizza party!', 'pizza_avatar.png');

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'UnicornDreamer', 'unicorn_dreamer@gmail.com', '(555) 123-4567', NULL, 'unicorn_avatar.jpg');

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'CaptainCrunchy', 'captaincrunchy@gmail.com', NULL, NULL, NULL);

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'SassySloth', 'sassysloth@yahoo.com', NULL, 'Slowly slaying the day', NULL);

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'DancingDino', 'dancingdino@gmail.com', '(987) 654-3210', 'Dancing through the day!', 'dino_avatar.jpg');

INSERT INTO discord_user (user_id, user_name, email, phone_num, status, avatar)
    VALUES (seq_user.NEXTVAL, 'JellyfishJive', 'jellyfishjive@hotmail.com', NULL, NULL, 'jellyfish_avatar.png');
--

-- insert roles
INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 0, 'Moderator', 0, '#3f51b5');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 0, 'Member', 1, '#2196f3');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 1, 'Owner', 0, '#ff5722');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 1, 'Admin', 1, '#ff9800');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 1, 'Moderator', 2, '#ffc107');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 2, 'Admin', 0, '#4caf50');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 2, 'Moderator', 1, '#8bc34a');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 3, 'Admin', 0, '#9c27b0');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 3, 'Moderator', 1, '#673ab7');

INSERT INTO user_role (role_id, server_id, role_name, role_priority, color)
    VALUES (seq_role.NEXTVAL, 3, 'Member', 2, '#3f51b5');
--

-- insert emojis
INSERT INTO emoji (emoji_id, server_id, emoji_name, icon)
    VALUES (seq_emoji.NEXTVAL, 3, 'poggers', 'poggers.png');

INSERT INTO emoji (emoji_id, server_id, emoji_name, icon)
    VALUES (seq_emoji.NEXTVAL, 0, 'monkaS', 'monkas.png');

INSERT INTO emoji (emoji_id, server_id, emoji_name, icon)
    VALUES (seq_emoji.NEXTVAL, 1, 'Kappa', 'kappa.png');

INSERT INTO emoji (emoji_id, server_id, emoji_name, icon)
    VALUES (seq_emoji.NEXTVAL, 1, 'FeelsBadMan', 'feelsbadman.png');

INSERT INTO emoji (emoji_id, server_id, emoji_name, icon)
    VALUES (seq_emoji.NEXTVAL, 4, 'PepeHands', 'pepehands.png');
--

-- insert channels
-- text channels
INSERT INTO channel (channel_id, server_id, channel_name, channel_type)
    VALUES (seq_channel.NEXTVAL, 4, 'general-chat', 0);

INSERT INTO channel (channel_id, server_id, channel_name, channel_type)
    VALUES (seq_channel.NEXTVAL, 2, 'announcements', 0);

INSERT INTO channel (channel_id, server_id, channel_name, channel_type)
    VALUES (seq_channel.NEXTVAL, 0, 'news', 0);

INSERT INTO channel (channel_id, server_id, channel_name, channel_type)
    VALUES (seq_channel.NEXTVAL, 3, 'public-chat', 0);

-- voice channels
INSERT INTO channel (channel_id, server_id, channel_name, channel_type)
    VALUES (seq_channel.NEXTVAL, 1, 'music-room', 1);

INSERT INTO channel (channel_id, server_id, channel_name, channel_type)
    VALUES (seq_channel.NEXTVAL, 4, 'voice-chat', 1);

INSERT INTO channel (channel_id, server_id, channel_name, channel_type)
    VALUES (seq_channel.NEXTVAL, 2, 'voice-channel', 1);
--

-- filling the user-server junction table, since it's needed to prevent the constraint errors while inserting messages
INSERT INTO user_server_map (user_id, server_id)
SELECT DISTINCT
    mod(level - 1, 10) AS user_id,
    mod(level - 1, 5) AS server_id
FROM dual
CONNECT BY level <= 10
ORDER BY user_id, server_id;
--

-- insert messages
INSERT INTO message (message_id, channel_id, user_id, text, msg_date)
    VALUES (seq_message.NEXTVAL, 2, 0, 'Hello world!', TIMESTAMP '2023-03-23 12:34:56.789');

INSERT INTO message (message_id, channel_id, user_id, text, msg_date)
    VALUES (seq_message.NEXTVAL, 1, 2, 'How are you?', TIMESTAMP '2023-03-23 12:35:00.123');

INSERT INTO message (message_id, channel_id, user_id, text, msg_date)
    VALUES (seq_message.NEXTVAL, 3, 3, 'I am doing well, thanks for asking!', TIMESTAMP '2023-03-23 12:35:04.567');

INSERT INTO message (message_id, channel_id, user_id, text, msg_date)
    VALUES (seq_message.NEXTVAL, 0, 4, 'Hey guys, check out this meme!', TIMESTAMP '2023-03-23 12:35:08.901');

INSERT INTO message (message_id, channel_id, user_id, text, msg_date)
    VALUES (seq_message.NEXTVAL, 2, 5, 'LOL, that is hilarious!', TIMESTAMP '2023-03-23 12:35:12.345');

INSERT INTO message (message_id, channel_id, user_id, text, msg_date)
    VALUES (seq_message.NEXTVAL, 1, 7, 'What are you all up to today?', TIMESTAMP '2023-03-23 12:35:16.789');

INSERT INTO message (message_id, channel_id, user_id, text, msg_date)
    VALUES (seq_message.NEXTVAL, 3, 8, 'Just hanging out with some friends!', TIMESTAMP '2023-03-23 12:35:20.123');

INSERT INTO message (message_id, channel_id, user_id, text, msg_date)
    VALUES (seq_message.NEXTVAL, 0, 9, 'I am studying for a test, wish me luck!', TIMESTAMP '2023-03-23 12:35:24.567');
--

-- insert reactions
INSERT INTO reaction (reaction_id, message_id, emoji_id)
    VALUES (seq_reaction.NEXTVAL, 0, 1);

INSERT INTO reaction (reaction_id, message_id, emoji_id)
    VALUES (seq_reaction.NEXTVAL, 2, 0);

INSERT INTO reaction (reaction_id, message_id, emoji_id)
    VALUES (seq_reaction.NEXTVAL, 7, 4);

INSERT INTO reaction (reaction_id, message_id, emoji_id)
    VALUES (seq_reaction.NEXTVAL, 6, 0);

INSERT INTO reaction (reaction_id, message_id, emoji_id)
    VALUES (seq_reaction.NEXTVAL, 4, 1);
--