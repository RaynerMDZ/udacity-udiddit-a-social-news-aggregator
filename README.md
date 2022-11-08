# Udacity - Udiddit A Social News Aggregator

Udiddit is a social news aggregator, content rating, and discussions website. On Udiddit, registered users are able to link to external content or post their own text content about various topics, ranging from common topics such as photography and food, to more arcane ones such as horse masks or birds with arms. In turn, other users can comment on these posts, and each user is allowed to cast a vote about each post, either in an up (like) or down (dislike) direction.

Unfortunately, due to some time constraints before the initial launch of the site, the data model stored in Postgres hasn’t been well thought out, and is starting to show its flaws. You’ve been brought in for two reasons: first, to make an assessment of the situation and take steps to fix all the issues with the current data model, and then, once successful, to improve the current system by making it more robust and adding some web analytics.

The schema allows posts to be created by registered users on certain topics, and can include a URL or a text content. It also allows registered users to cast an upvote (like) or downvote (dislike) for any forum post that has been created. In addition to this, the schema also allows registered users to add comments on posts.

## Schema
```
CREATE TABLE bad_posts (
	id SERIAL PRIMARY KEY,
	topic VARCHAR(50),
	username VARCHAR(50),
	title VARCHAR(150),
	url VARCHAR(4000) DEFAULT NULL,
	text_content TEXT DEFAULT NULL,
	upvotes TEXT,
	downvotes TEXT
);

CREATE TABLE bad_comments (
	id SERIAL PRIMARY KEY,
	username VARCHAR(50),
	post_id BIGINT,
	text_content TEXT
);

```

Having done this initial investigation, the next goal is to dive deep into the heart of the problem and create a new schema for Udiddit. Your new schema should at least reflect fixes to the shortcomings you pointed to in the previous exercise.

# Business Requirements

1. Allow new users to register:
   1. Each username has to be unique
   2. Usernames can be composed of at most 25 characters
   3. Usernames can’t be empty
   4. We won’t worry about user passwords for this project

2. Allow registered users to create new topics:
   1. Topic names have to be unique.
   2. The topic’s name is at most 30 characters
   3. The topic’s name can’t be empty
   4. Topics can have an optional description of at most 500 characters.

3. Allow registered users to comment on existing posts:
   1. Posts have a required title of at most 100 characters
   2. The title of a post can’t be empty.
   3. Posts should contain either a URL or a text content, but not both.
   4. If a topic gets deleted, all the posts associated with it should be automatically deleted too.
   5. If the user who created the post gets deleted, then the post will remain, but it will become dissociated from that user.
   
4. Allo
