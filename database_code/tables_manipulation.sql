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
        JOIN user_server_map usm ON s.server_id = usm.server_id
        JOIN channel c ON s.server_id = c.server_id
        LEFT JOIN user_role r ON s.server_id = r.server_id
    GROUP BY s.server_id;

-- Non-trivial select #2
-- Here is an avarage number of reactions per message on every server
CREATE VIEW avg_reactions AS
    SELECT
        s.server_id,
        AVG(COUNT(DISTINCT r.reaction_id))
    FROM server s
        JOIN reaction r ON s.server_id = 
            (SELECT c.server_id
            FROM channel c
            WHERE r.message_id = 
                (SELECT m.message_id
                FROM message m
                WHERE m.channel_id = c.channel_id))
    GROUP BY s.server_id;


-- 2x join

-- 3x join

-- Outer join


-- Aggregation

-- Grouping 


-- Set operators


-- Nested select