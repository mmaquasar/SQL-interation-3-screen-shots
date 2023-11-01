# Database Overview

## Screenshots:

### 1. Videos Table - Primary and Foreign Key Constraints 
![Videos Table PK and FK Constraints](https://cdn.discordapp.com/attachments/1136758352274260142/1169388506976620644/image.png)

### 2. Listing All Tables 
![List of All Tables](https://cdn.discordapp.com/attachments/1136758352274260142/1169389691473236038/image.png)

### 3. Videos Table Indices 
![Videos Table Indices](https://cdn.discordapp.com/attachments/1136758352274260142/1169389803108839565/image.png)

### 4. ContentCreators Table Indices 
![ContentCreators Table Indices](https://cdn.discordapp.com/attachments/1136758352274260142/1169389907677024327/image.png)

## SQL Table Definitions:

```sql
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
