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

INSERT INTO users (username)
SELECT DISTINCT(REGEXP_SPLIT_TO_TABLE(upvotes, ',')) AS username
FROM bad_posts
ORDER BY username
ON CONFLICT DO NOTHING;

INSERT INTO users (username)
SELECT DISTINCT(REGEXP_SPLIT_TO_TABLE(downvotes, ',')) AS username
FROM bad_posts
ORDER BY username
ON CONFLICT DO NOTHING;


-- INSERT all topics INTO topic table
INSERT INTO topic (topic)
SELECT DISTINCT(topic)
FROM bad_posts
ORDER BY topic;


-- INSERT title, user_id, topic_id, url, content INTO posts
INSERT INTO post (id, title, user_id, topic_id, url, content)
SELECT bp.id,
       SUBSTR(bp.title, 1, 100) AS title,
       u.id AS user_id,
       t.id AS topic_id,
       bp.url AS url,
       bp.text_content AS content
FROM bad_posts bp
JOIN users u
    ON bp.username = u.username
JOIN topic t
    ON bp.topic = t.topic
ON CONFLICT DO NOTHING;

-- INSERT comments INTO comments table
INSERT INTO comment (id, content, user_id, post_id)
SELECT bc.id, bc.text_content, u.id, bc.post_id
FROM bad_comments bc
JOIN users u
ON bc.username = u.username
ON CONFLICT DO NOTHING;

-- INSERT upvotes INTO vote table
INSERT INTO vote (upvote, user_id, post_id)
WITH upvote AS (
    SELECT id as post_id, REGEXP_SPLIT_TO_TABLE(upvotes, ',') AS voter FROM bad_posts
)
SELECT true, u.id, uv.post_id
FROM upvote uv
JOIN users u
ON uv.voter = u.username
ON CONFLICT DO NOTHING;

-- INSERT downvote INTO vote table
INSERT INTO vote (downvote, user_id, post_id)
WITH downvote AS (
    SELECT id as post_id, REGEXP_SPLIT_TO_TABLE(downvotes, ',') AS voter FROM bad_posts
)
SELECT true, u.id, dv.post_id
FROM downvote dv
JOIN users u
ON dv.voter = u.username
ON CONFLICT DO NOTHING;