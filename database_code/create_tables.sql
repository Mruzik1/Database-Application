-- creating main tables
CREATE TABLE server (
    server_id INT NOT NULL PRIMARY KEY,
    server_name VARCHAR2(32) NOT NULL,
    icon VARCHAR2(32) NOT NULL,
    region VARCHAR2(32) NOT NULL
);

CREATE TABLE discord_user (
    user_id INT NOT NULL PRIMARY KEY,
    user_name VARCHAR2(32) NOT NULL,
    email VARCHAR2(32) NOT NULL,
    phone_num VARCHAR2(32),
    status VARCHAR2(255),
    avatar VARCHAR2(32)
);

CREATE TABLE user_role (
    role_id INT NOT NULL PRIMARY KEY,
    server_id INT NOT NULL,
    role_name VARCHAR2(32) NOT NULL,
    role_priority INT NOT NULL,
    color VARCHAR2(7) NOT NULL
);

CREATE TABLE emoji (
    emoji_id INT NOT NULL PRIMARY KEY,
    server_id INT NOT NULL,
    emoji_name VARCHAR2(32) NOT NULL,
    icon VARCHAR2(32) NOT NULL
);

CREATE TABLE channel (
    channel_id INT NOT NULL PRIMARY KEY,
    server_id INT NOT NULL,
    channel_name VARCHAR2(32) NOT NULL,
    channel_type INT NOT NULL
);

CREATE TABLE message (
    message_id INT NOT NULL PRIMARY KEY,
    channel_id INT NOT NULL,
    user_id INT NOT NULL,
    text VARCHAR2(1024) NOT NULL,
    msg_date TIMESTAMP NOT NULL
);

CREATE TABLE reaction (
    reaction_id INT NOT NULL PRIMARY KEY,
    message_id INT NOT NULL,
    emoji_id INT NOT NULL
);
--

-- adding foreign keys: 1-to-1 and 1-to-M
ALTER TABLE user_role
    ADD FOREIGN KEY (server_id) REFERENCES server(server_id);

ALTER TABLE emoji
    ADD FOREIGN KEY (server_id) REFERENCES server(server_id);

ALTER TABLE channel
    ADD FOREIGN KEY (server_id) REFERENCES server(server_id);

ALTER TABLE message
    ADD FOREIGN KEY (channel_id) REFERENCES channel(channel_id)
    ADD FOREIGN KEY (user_id) REFERENCES discord_user(user_id);

ALTER TABLE reaction
    ADD FOREIGN KEY (emoji_id) REFERENCES emoji(emoji_id)
    ADD FOREIGN KEY (message_id) REFERENCES message(message_id);
--

-- creating junction tables for M-to-N relationships
CREATE TABLE user_server_map (
    user_id INT REFERENCES discord_user(user_id),
    server_id INT REFERENCES server(server_id),
    PRIMARY KEY (user_id, server_id)
);

CREATE TABLE user_friend_map (
    user_id INT REFERENCES discord_user(user_id),
    friend_id INT REFERENCES discord_user(user_id),
    PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE user_reaction_map (
    user_id INT NOT NULL REFERENCES discord_user(user_id),
    reaction_id INT NOT NULL REFERENCES reaction(reaction_id),
    PRIMARY KEY (user_id, reaction_id)
);

CREATE TABLE user_role_map (
    user_id INT NOT NULL REFERENCES discord_user(user_id),
    role_id INT REFERENCES user_role(role_id),
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE message_emoji_map (
    message_id INT NOT NULL REFERENCES message(message_id),
    emoji_id INT REFERENCES emoji(emoji_id),
    PRIMARY KEY (message_id, emoji_id)
);
--

-- adding needed constraints (using triggers because it's not working with CHECK due to the nested selects)
-- message constraints
CREATE TRIGGER trg_message_con
    BEFORE INSERT OR UPDATE ON message
    FOR EACH ROW
    DECLARE
        channel_type INT;
        channel_server_id INT;
		user_server_count INT;
    BEGIN
        -- get all channel types and server_ids
        SELECT c.channel_type, c.server_id INTO channel_type, channel_server_id
        FROM channel c
        WHERE c.channel_id = :new.channel_id;

		-- get the count of rows with a user's connection to the certain server from the user-server mapping table
		SELECT COUNT(*) INTO user_server_count
        FROM user_server_map usm
        WHERE usm.user_id = :new.user_id AND usm.server_id = channel_server_id;

        -- sending messages to the right channel
        IF channel_type != 0 THEN 
            RAISE_APPLICATION_ERROR(-20001, 'Cannot send a message to a voice channel.');
        END IF;

        -- the message's author is the server's member
        IF user_server_count <= 0 THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The message author is not a member of a server where the message was sent.');
        END IF;
    END;
/
--

-- reaction constraint
CREATE TRIGGER trg_reaction_con
    BEFORE INSERT OR UPDATE ON reaction
    FOR EACH ROW
    DECLARE
        channel_server_id INT;
        emoji_server_id INT;
    BEGIN
        -- getting a server id from the message's channel
        SELECT c.server_id INTO channel_server_id
        FROM channel c
        JOIN message m ON m.channel_id = c.channel_id
        WHERE m.message_id = :new.message_id;
        
        -- getting a server id of the emoji
        SELECT e.server_id INTO emoji_server_id
        FROM emoji e
        WHERE e.emoji_id = :new.emoji_id;

        -- checking if the reaction's emoji is on the same server as the message
        IF channel_server_id != emoji_server_id THEN 
            RAISE_APPLICATION_ERROR(-20001, 'Wrond server_id for an emoji and/or a message.');
        END IF;
    END;
/
--