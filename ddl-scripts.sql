/*

 Author: Rayner Mendez
 Udacity Web Developer Nanodegree
 Udiddit, Social News Aggregator

 I like to use singulars to name tables.
 This case is an exception because user is a reserved
 keyword within the postgresql space.
 */

-- DDL Queries

DROP TABLE IF EXISTS
    users,
    topic,
    post,
    comment,
    vote;

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(25) UNIQUE NOT NULL,
    last_login TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX ON users (username);

CREATE TABLE vote (
    id BIGSERIAL PRIMARY KEY,
    upvote BOOLEAN,
    downvote BOOLEAN,
    user_id BIGINT,
    CONSTRAINT fk_user_id
        FOREIGN KEY (user_id)
            REFERENCES users ON DELETE SET NULL,
    CONSTRAINT upvote_or_downvote
        CHECK ((vote.upvote IS NOT NULL AND vote.downvote IS NULL)
        OR (vote.downvote IS NOT NULL AND vote.upvote IS NULL))
);

CREATE TABLE topic (
    id SERIAL PRIMARY KEY,
    topic VARCHAR(30) UNIQUE NOT NULL,
    description VARCHAR(500)
);

CREATE INDEX ON topic (topic);

CREATE TABLE post (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    url VARCHAR(4000),
    content TEXT,
    user_id BIGINT,
    topic_id INTEGER,
    vote_id BIGINT,
    CONSTRAINT fk_user_id
        FOREIGN KEY (user_id)
            REFERENCES users ON DELETE SET NULL,
    CONSTRAINT fk_topic_id
        FOREIGN KEY (topic_id)
            REFERENCES topic ON DELETE CASCADE,
    CONSTRAINT fk_vote_id
        FOREIGN KEY (vote_id)
            REFERENCES vote ON DELETE CASCADE,
    CONSTRAINT url_or_content
        CHECK ((post.url IS NOT NULL AND post.content IS NULL)
        OR (post.content IS NOT NULL AND post.url IS NULL))
);

CREATE TABLE comment (
    id BIGSERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    user_id BIGINT,
    post_id BIGINT,
    comment_id BIGINT,
    CONSTRAINT fk_user_id
        FOREIGN KEY (user_id)
            REFERENCES users ON DELETE SET NULL,
    CONSTRAINT fk_post_id
        FOREIGN KEY (post_id)
            REFERENCES post ON DELETE CASCADE,
    CONSTRAINT fk_comment_id
        FOREIGN KEY (comment_id)
            REFERENCES comment ON DELETE CASCADE
);