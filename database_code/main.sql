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