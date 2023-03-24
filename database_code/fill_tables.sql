-- sequences for ids generating
CREATE SEQUENCE seq_server
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE seq_user
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE seq_channel
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE seq_role
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE seq_emoji
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE seq_reaction
    MINVALUE 0
    START WITH 0
    INCREMENT BY 1
    NOCYCLE;

-- insert servers
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'Minecraft Server', 'MinecraftIconLink', 'Sweden');
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'Amongus Server', 'AmogusIconLink', 'USA');
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'SoccerFans', 'An image of a ball', 'USA');
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'Youtubers', 'Youtube icon', 'USA');
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'Funny Memes Indeed', 'Funny pic', 'UK');
INSERT INTO server (server_id, server_name, icon, region)
    VALUES (seq_server.NEXTVAL, 'Football Fans', 'An image of a ball', 'UK');

-- insert users

-- drop the sequences
DROP SEQUENCE seq_server;
DROP SEQUENCE seq_user;
DROP SEQUENCE seq_channel;
DROP SEQUENCE seq_role;
DROP SEQUENCE seq_emoji;
DROP SEQUENCE seq_reaction;