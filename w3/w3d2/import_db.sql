CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR(255) NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('John', 'Smith'), ('Jimmy', 'Dean'), ('Paul','Newman'), 
  ('Bruce','Wayne'), ('Barack', 'Obama'), ('Chuck','Norris');
  
INSERT INTO 
  questions (title, body, author_id)
VALUES
  ("A legitimate question", "Where can I buy some smallpox blankets?", 1),
  ("A legitimate dropkick to the face", "Does somebody need a whippin?", 6),
  ("URGENT!", "Where's Rachel!", 4),
  ("MORE URGENT!", "Where's Harvey Dent!!",4),
  ("My Face..", "Have you seen my face?", 3);
INSERT INTO 
  question_likes (user_id, question_id)
VALUES
  (2,1),
  (1,2),
  (2,2),
  (3,2),
  (4,2),
  (5,2),
  (6,2);
  
INSERT INTO 
  question_followers (user_id, question_id)
VALUES
  (2,1),
  (1,1),
  (2,3),
  (3,3),
  (4,3),
  (5,3),
  (6,3);
  
INSERT INTO
  replies (body, question_id, parent_id, author_id)
VALUES
  ('I hear they have some at the general store.', 1, NULL, 2),
  ("You're a liar! That storekeep stole my wallet!", 1, 1, 1),
  ("I am!!", 2, NULL, 3);
  