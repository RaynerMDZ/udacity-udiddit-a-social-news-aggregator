/*

 Author: Rayner Mendez
 Udacity Web Developer Nanodegree
 Udiddit, Social News Aggregator

 I like to use singulars to name tables.
 This case is an exception because user is a reserved
 keyword within the postgresql space.
 */

-- DML Queries

-- INSERT all usernames INTO users table
INSERT INTO users (username)
SELECT DISTINCT(username)
FROM bad_posts
ORDER BY username
ON CONFLICT DO NOTHING;

INSERT INTO users (username)
SELECT DISTINCT(username)
FROM bad_comments
ORDER BY username
ON CONFLICT DO NOTHING;

-- INSERT all topics INTO topic table
INSERT INTO topic (topic)
SELECT DISTINCT(topic)
FROM bad_posts
ORDER BY topic;

-- INSERT title, user_id, topic_id, url, content INTO posts
INSERT INTO post (title, user_id, topic_id, url, content)
SELECT SUBSTR(bp.title, 1, 100) AS title,
       u.id AS user_id,
       t.id AS topic_id,
       bp.url AS url,
       bp.text_content AS content
FROM bad_posts bp
JOIN users u
    ON bp.username = u.username
JOIN topic t
    ON bp.topic = t.topic;