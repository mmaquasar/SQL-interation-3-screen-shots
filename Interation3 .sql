-- Video Categories
CREATE TABLE VideoCategories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255)
);

-- Keywords
CREATE TABLE Keywords (
    KeywordID INT PRIMARY KEY,
    KeywordName VARCHAR(255)
);

-- Content Creators
CREATE TABLE ContentCreators (
    CreatorID INT PRIMARY KEY,
    CreatorName VARCHAR(255),
    FollowersCount INT CHECK (FollowersCount >= 0),
    TotalVideosPublished INT CHECK (TotalVideosPublished >= 0),
    CreatorType VARCHAR(50) CHECK (CreatorType IN ('Independent', 'OfficialBrand'))
);

-- Independent Creators
CREATE TABLE IndependentCreators (
    CreatorID INT FOREIGN KEY REFERENCES ContentCreators(CreatorID),
    IndependentChannelName VARCHAR(255),
    PersonalBackground TEXT
);

-- Official Brand Channels
CREATE TABLE OfficialBrandChannels (
    CreatorID INT FOREIGN KEY REFERENCES ContentCreators(CreatorID),
    BrandName VARCHAR(255),
    OfficialContactInformation VARCHAR(255)
);

-- Videos
CREATE TABLE Videos (
    VideoID INT PRIMARY KEY,
    VideoTitle VARCHAR(255),
    Description TEXT,
    PublishTime DATETIME DEFAULT GETDATE(),
    Views INT CHECK (Views >= 0),
    Likes INT CHECK (Likes >= 0),
    CreatorID INT FOREIGN KEY REFERENCES ContentCreators(CreatorID),
    CategoryID INT FOREIGN KEY REFERENCES VideoCategories(CategoryID)
);

-- Video-Keyword Association
CREATE TABLE VideoKeywordAssociation (
    VideoID INT FOREIGN KEY REFERENCES Videos(VideoID),
    KeywordID INT FOREIGN KEY REFERENCES Keywords(KeywordID),
    PRIMARY KEY (VideoID, KeywordID)
);

-- Comments
CREATE TABLE Comments (
    CommentID INT PRIMARY KEY,
    VideoID INT FOREIGN KEY REFERENCES Videos(VideoID),
    CommentText TEXT,
    CommentTime DATETIME DEFAULT GETDATE()
);

-- Indices for frequently queried columns
CREATE INDEX idx_videoTitle ON Videos(VideoTitle);
CREATE INDEX idx_keywordName ON Keywords(KeywordName);
CREATE INDEX idx_creatorName ON ContentCreators(CreatorName);

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE, COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'VideoCategories';

-- For listing all the tables:
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

EXEC sp_helpindex 'Videos';

EXEC sp_helpindex 'ContentCreators';


