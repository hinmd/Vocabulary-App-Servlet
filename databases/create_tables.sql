USE `vocabulary-app-servlet`;



-- Role table
CREATE TABLE Roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255)
);



-- User table
CREATE TABLE Users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255),
  password VARCHAR(255),
  role_id INT,
  telegram_id VARCHAR(255),
  avatar VARCHAR(255)
);
-- ==============================================Users (n:1) Roles==============================================
ALTER TABLE Users ADD CONSTRAINT FK_Users_Roles FOREIGN KEY (role_id) REFERENCES Roles(id); -- side n (Users) will contain FOREIGN KEY



-- Telegram Bot table
CREATE TABLE TelegramBots (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  token VARCHAR(255)
);
-- ==============================================TelegramBots (n:1) Users==============================================
ALTER TABLE TelegramBots ADD CONSTRAINT FK_TelegramBots_Users FOREIGN KEY (user_id) REFERENCES Users(id); -- side n (TelegramBots) will contain FOREIGN KEY



-- Tạo bảng Vocabulary
CREATE TABLE Vocabulary (
  id INT PRIMARY KEY AUTO_INCREMENT,
  word VARCHAR(255) NOT NULL,
  translate VARCHAR(255) NOT NULL,
  example TEXT NOT NULL
);



-- Tạo bảng UserVocabulary (bảng trung gian)
CREATE TABLE UserVocabulary (
  user_id INT,
  vocabulary_id INT,
  is_forgot INT NOT NULL DEFAULT 0,
  study_count INT NOT NULL DEFAULT 0,
  PRIMARY KEY (user_id, vocabulary_id)
);
-- ==============================================UserVocabulary (n:1) Users==============================================
ALTER TABLE UserVocabulary ADD CONSTRAINT FK_UserVocabulary_Users FOREIGN KEY (user_id) REFERENCES Users(id); -- side n (UserVocabulary) will contain FOREIGN KEY
-- ==============================================UserVocabulary (n:1) Vocabulary==============================================
ALTER TABLE UserVocabulary ADD CONSTRAINT FK_UserVocabulary_Vocabulary FOREIGN KEY (vocabulary_id) REFERENCES Vocabulary(id); -- side n (UserVocabulary) will contain FOREIGN KEY