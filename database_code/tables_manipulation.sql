-- You can find sequences and triggers for generating primary keys in "fill_tables.sql" at the very beginning of the file.
-- Other triggers (responsible for the constraints) are implemented at the end of "create_tables.sql".
-- P.S. I created only two, but there should be more triggers to handle constraints ragarding different cases. It's just too many of those...


-- Non-trivial select #1
-- Here I'm getting a view of server stats (number of users, channels, roles)
CREATE VIEW server_stats AS
    SELECT 
        s.server_id, 
        COUNT(DISTINCT usm.discord_user_id) users, 
        COUNT(DISTINCT c.channel_id) channels, 
        COUNT(DISTINCT r.user_role_id) roles
    FROM server s
    INNER JOIN user_server_map usm ON s.server_id = usm.server_id
    INNER JOIN channel c ON s.server_id = c.server_id
    LEFT OUTER JOIN user_role r ON s.server_id = r.server_id
    GROUP BY s.server_id;

-- Non-trivial select #2
-- I am getting messages that contain a question mark at the end (i.e. are questions), their and servers ids, plus the content
CREATE VIEW msg_questions AS
    SELECT
        s.server_id,
        m.message_id,
        m.text
    FROM server s
    INNER JOIN channel c ON s.server_id = c.server_id
    INNER JOIN message m ON c.channel_id = m.channel_id
    WHERE REGEXP_LIKE(m.text, '\?\s*$');

-- 2 tables join
-- Getting all emojis (ids and names) that were used in messages and how many times.
-- In our case we used every emoji, but it's possible to check the view by deleting one or several rows in the message_emoji_map table:
-- DELETE message_emoji_map mem WHERE mem.message_id = 1;
CREATE VIEW msg_used_emojis AS
    SELECT DISTINCT
        e.emoji_id,
        e.emoji_name,
        COUNT(e.emoji_id) times
    FROM emoji e
    INNER JOIN message_emoji_map mem ON e.emoji_id = mem.emoji_id
    GROUP BY e.emoji_id, e.emoji_name;

-- 3 tables join
-- Making a view of some info about the reaction's emoji and a message content
CREATE VIEW reaction_info AS
    SELECT
        m.message_id,
        r.reaction_id,
        m.text,
        e.emoji_name
    FROM reaction r
    INNER JOIN message m ON r.message_id = m.message_id
    INNER JOIN emoji e ON r.emoji_id = e.emoji_id;

-- Outer join
-- A view with numbers of reactions from every user
-- You can check the view by removing a pair of rows:
-- DELETE user_reaction_map urm WHERE urm.reaction_id = 0;
CREATE VIEW reacted_users AS
    SELECT
        du.discord_user_id,
        COUNT(urm.discord_user_id) reactions_count
    FROM discord_user du
    LEFT OUTER JOIN user_reaction_map urm ON urm.discord_user_id = du.discord_user_id
    GROUP BY du.discord_user_id;

-- Aggregation #1
-- Just getting an average number of text and voice channels on all servers
CREATE VIEW avg_text_voice AS
    SELECT
        ROUND(AVG(c.channel_type), 4) avg_voice_channels,
        1-ROUND(AVG(c.channel_type), 4) avg_text_channels
    FROM channel c;

-- Aggregation #2 
-- A view with a count of every role's priority
CREATE VIEW role_priorities_count AS
    SELECT
        ur.role_priority,
        COUNT(ur.user_role_id) number_of_roles
    FROM user_role ur
    GROUP BY ur.role_priority
    ORDER BY ur.role_priority;

-- Set operators
-- Get emojis that weren't used in reactions
CREATE VIEW unused_emojis AS
    SELECT 
        e.emoji_id,
        e.server_id,
        e.emoji_name
    FROM (
        SELECT e.emoji_id e_id FROM emoji e
        MINUS
        SELECT r.emoji_id FROM reaction r
    )
    INNER JOIN emoji e ON e_id = e.emoji_id;

-- Nested select #1
-- Getting servers where reactions belong to
-- Note: it would be better to use tables joining here, but as an example I think it's ok
CREATE VIEW reactions_servers_map AS
    SELECT
        r.reaction_id,
        (
            SELECT s.server_id
            FROM server s
            WHERE s.server_id = (
                SELECT c.server_id
                FROM channel c
                WHERE c.channel_id = (
                    SELECT m.channel_id
                    FROM message m
                    WHERE m.message_id = r.reaction_id
                )
            )
        ) server_id
    FROM reaction r;

-- Nested select #2
-- Users with high priority roles (> 1)
CREATE VIEW high_priority_users AS
    SELECT
        du.discord_user_id high_priority_users
    FROM discord_user du
    WHERE du.discord_user_id IN (
        SELECT urm.discord_user_id
        FROM user_role_map urm
        WHERE urm.user_role_id IN (
            SELECT r.user_role_id
            FROM user_role r
            WHERE r.role_priority > 1
        )
    );