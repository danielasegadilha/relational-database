-- Tabela typeCharade
CREATE TABLE typeCharade (
    typeCharadeID INT PRIMARY KEY,
    type VARCHAR(50) NOT NULL
);

-- Tabela charade
CREATE TABLE charade (
    charadeID INT PRIMARY KEY,
    typeCharadeID INT REFERENCES typeCharade(typeCharadeID) not null,
    difficulty VARCHAR(10) NOT NULL CHECK (difficulty IN ('easy', 'medium', 'hard')),
	origin VARCHAR(50),
    description VARCHAR(255) NOT NULL,
    answer VARCHAR(50) NOT NULL,
	constraint charade_altPK unique (charadeID,typeCharadeID)

);


-- Tabela multipleChoice
CREATE TABLE multipleChoice (
	multipleChoiceID INT PRIMARY KEY,
    charadeID INT,
    typeCharadeID INT,
    optionText VARCHAR(50) NOT NULL,
    isCorrect BIT NOT NULL,
    FOREIGN KEY (charadeID, typeCharadeID) REFERENCES charade(charadeID, typeCharadeID),
	CHECK (typeCharadeID = 1)
);

-- Tabela tag
CREATE TABLE tag (
    tagID INT PRIMARY KEY,
    tagName VARCHAR(50) NOT NULL CHECK(tagName IN ('movie', 'funny', 'logic', 'science', 'classic'))
);

-- Tabela charadeTag
CREATE TABLE charadeTag (
    charadeTagID INT PRIMARY KEY,
    charadeID INT,
    tagID INT,
    FOREIGN KEY (charadeID) REFERENCES charade(charadeID),
    FOREIGN KEY (tagID) REFERENCES tag(tagID)
);

INSERT INTO typeCharade(typeCharadeID, type) VALUES
	(1, 'multiple choice'),
	(2, 'short answer');

INSERT INTO tag (tagID, tagName) VALUES
    (1, 'movie'),
    (2, 'funny'),
    (3, 'logic'),
    (4, 'science'),
    (5, 'classic');

INSERT INTO charade (charadeID, typeCharadeID , difficulty, origin, description, answer) VALUES
    (1, 2, 'medium', NULL, 'I speak without a mouth and hear without ears. I have no body, but I come alive with wind. What am I?', 'An Echo');

INSERT INTO charade (charadeID, typeCharadeID , difficulty, origin, description, answer) VALUES
    (2, 1, 'medium', NULL, 'What is as light as a feather, yet the strongest person can''t hold it for more than a few minutes?', 'Breath');

INSERT INTO multipleChoice (multipleChoiceID, charadeID, typeCharadeID, optionText, isCorrect) VALUES
    (1, 2, 1, 'Breath', 1),
    (2, 2, 1, 'A bubble', 0),
    (3, 2, 1, 'A thought', 0),
    (4, 2, 1, 'A cloud', 0);
