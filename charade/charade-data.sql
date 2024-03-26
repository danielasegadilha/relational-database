CREATE TABLE charade (
    charadeID INT PRIMARY KEY,
    charadeType VARCHAR(1) NOT NULL CHECK (charadeType IN ('m', 's')), 
    difficulty VARCHAR(10) NOT NULL CHECK (difficulty IN ('easy', 'medium', 'hard')),
    origin VARCHAR(50),
    description VARCHAR(255) NOT NULL,
    answer VARCHAR(50) NOT NULL
);


CREATE TABLE multipleChoice (
    multipleChoiceID INT PRIMARY KEY,
    charadeID INT NOT NULL,
    optionText VARCHAR(50) NOT NULL,
    isCorrect BIT NOT NULL,
    FOREIGN KEY (charadeID) REFERENCES charade(charadeID) 

);

CREATE TABLE tag (
    tagName VARCHAR(50) PRIMARY KEY CHECK(tagName IN ('movie', 'funny', 'logic', 'science', 'classic'))
);


CREATE TABLE charadeTag (
    charadeTagID INT PRIMARY KEY,
    charadeID INT NOT NULL,
    tagID VARCHAR(50) NOT NULL,
    FOREIGN KEY (charadeID) REFERENCES charade(charadeID),
    FOREIGN KEY (tagID) REFERENCES tag(tagName)
);
