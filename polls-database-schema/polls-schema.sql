CREATE DATABASE  poll ;

CREATE SEQUENCE users_seq;

CREATE TABLE users (
  id BIGINT NOT NULL DEFAULT NEXTVAL ('users_seq'),
  firstName VARCHAR(50) NULL DEFAULT NULL,
  lastName VARCHAR(50) NULL DEFAULT NULL,
  email VARCHAR(50) NULL,
  passwordHash VARCHAR(32) NOT NULL,
  host SMALLINT NOT NULL DEFAULT 0,
  registeredAt TIMESTAMP(0) NOT NULL,
  lastLogin TIMESTAMP(0) NULL DEFAULT NULL,
  intro TEXT NULL DEFAULT NULL,
  displayName TEXT NULL DEFAULT NULL,
  PRIMARY KEY (id));

CREATE SEQUENCE poll_seq;

CREATE TABLE poll (
  id BIGINT NOT NULL DEFAULT NEXTVAL ('poll_seq'),
  surveyHostId BIGINT NOT NULL,
  title VARCHAR(75) NOT NULL,
  metaTitle VARCHAR(100) NULL,
  summary TEXT NULL,
  type SMALLINT NOT NULL DEFAULT 0,
  published SMALLINT NOT NULL DEFAULT 0,
  createdAt TIMESTAMP(0) NOT NULL,
  updatedAt TIMESTAMP(0) NULL DEFAULT NULL,
  publishedAt TIMESTAMP(0) NULL DEFAULT NULL,
  startsAt TIMESTAMP(0) NULL DEFAULT NULL,
  endsAt TIMESTAMP(0) NULL DEFAULT NULL,
  content TEXT NULL DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_poll_host
    FOREIGN KEY (surveyHostId)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE SEQUENCE poll_meta_seq;

CREATE TABLE poll_meta (
  id BIGINT NOT NULL DEFAULT NEXTVAL ('poll_meta_seq'),
  pollId BIGINT NOT NULL,
  key VARCHAR(50) NOT NULL,
  content TEXT NULL DEFAULT NULL,
  PRIMARY KEY (id)
 ,
  CONSTRAINT uq_poll_meta UNIQUE (pollId, key),
  CONSTRAINT fk_meta_poll
    FOREIGN KEY (pollId)
    REFERENCES poll (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_meta_poll ON poll_meta (pollId ASC);


CREATE SEQUENCE poll_question_seq;

CREATE TABLE poll_question (
  id BIGINT NOT NULL DEFAULT NEXTVAL ('poll_question_seq'),
  pollId BIGINT NOT NULL,
  type VARCHAR(50) NOT NULL,
  active SMALLINT NOT NULL DEFAULT 0,
  createdAt TIMESTAMP(0) NOT NULL,
  updatedAt TIMESTAMP(0) NULL DEFAULT NULL,
  content TEXT NULL DEFAULT NULL,
  PRIMARY KEY (id)
 ,
  CONSTRAINT fk_question_poll
    FOREIGN KEY (pollId)
    REFERENCES poll (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_question_poll ON poll_question (pollId ASC);

CREATE SEQUENCE poll_answer_seq;

CREATE TABLE poll_answer (
  id BIGINT NOT NULL DEFAULT NEXTVAL ('poll_answer_seq'),
  pollId BIGINT NOT NULL,
  questionId BIGINT NOT NULL,
  active SMALLINT NOT NULL DEFAULT 0,
  createdAt TIMESTAMP(0) NOT NULL,
  updatedAt TIMESTAMP(0) NULL DEFAULT NULL,
  content TEXT NULL DEFAULT NULL,
  PRIMARY KEY (id) ,
  CONSTRAINT fk_answer_poll
    FOREIGN KEY (pollId)
    REFERENCES poll (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_answer_question
    FOREIGN KEY (questionId)
    REFERENCES poll_question (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_answer_poll ON poll_answer (pollId ASC);
CREATE INDEX idx_answer_question ON poll_answer (questionId ASC);
