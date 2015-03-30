CREATE TYPE restaurant_type as ENUM ('fast food', 'mexican', 'italian', 'german', 'canadian', 'taco', 'steakhouse', 'casual dining', 'family style', 'trendy', 'hippy trash');
CREATE TYPE rater_type as ENUM ('blogger', 'professional critic', 'filthy casual', 'n00b b*tch', 'fat ass', 'unhappy hipster', 'kind of a douche', 'vegan', 'lacto-ovo-pescatarian vegan');
CREATE TYPE item_type as ENUM ('food', 'beverage');
CREATE TYPE item_category as ENUM ('cocktail', 'martini', 'mixed drink', 'beer', 'liquor', 'breakfast', 'lunch', 'dinner', 'dessert', 'coffee', 'appetizer', 'main', 'entree', 'digestif');

CREATE TABLE Restaurant
(
RestaurantID INTEGER NOT NULL CHECK (RestaurantID > 0),
Name VARCHAR(20) NOT NULL, 
Type restaurant_type NOT NULL,
URL VARCHAR(30), 
PRIMARY KEY (RestaurantID)
);

CREATE TABLE Location 
(
LocationID INTEGER NOT NULL CHECK (LocationID > 0),
First_Open_Date DATE, 
Manager VARCHAR(20), 
Phone_Number VARCHAR(20),
Street_Address VARCHAR(20) NOT NULL,
Hour_Open VARCHAR(20),
Hour_Close VARCHAR(20),
RestaurantID INTEGER NOT NULL, 
FOREIGN KEY (RestaurantID) REFERENCES Restaurant ON DELETE CASCADE,
PRIMARY KEY (LocationID)
);

CREATE TABLE Rating 
(
UserID INTEGER NOT NULL , 
Date_Submitted Date NOT NULL, 
Price INTEGER DEFAULT 3 CHECK (Price >= 1 AND Price <= 5), 
Food INTEGER DEFAULT 3 CHECK (Food >= 1 AND Food <= 5), 
Mood INTEGER DEFAULT 3 CHECK (Mood >= 1 AND Mood <= 5), 
Staff INTEGER DEFAULT 3 CHECK (Staff >= 1 AND Staff <= 5), 
Overall INTEGER DEFAULT 3 CHECK (Overall >= 1 AND Overall <= 5),
Comments TEXT, 
RestaurantID INTEGER NOT NULL, 
FOREIGN KEY (RestaurantID) REFERENCES Restaurant ON DELETE CASCADE, 
FOREIGN KEY (UserID) REFERENCES Rater ON DELETE CASCADE
);

CREATE TABLE Rater 
(
UserID INTEGER NOT NULL,
Email VARCHAR(20), 
Name VARCHAR(20) NOT NULL, 
Join_Date DATE, 
Type rater_type, 
Reputation INTEGER DEFAULT 1 CHECK (Reputation >= 1 AND Reputation <= 5), 
PRIMARY KEY (UserID)
);

CREATE TABLE MenuItems
(
ItemID INTEGER NOT NULL, 
Name VARCHAR(20) NOT NULL, 
Type item_type, 
Category item_category, 
Description TEXT NOT NULL, 
Price NUMERIC(3,2), 
RestaurantID INTEGER NOT NULL, 
FOREIGN KEY (RestaurantID) REFERENCES Restaurant ON DELETE CASCADE, 
PRIMARY KEY (ItemID)
);

CREATE TABLE RatingItem 
(
	UserID INTEGER NOT NULL, 
	Rating_Date Date, 
	ItemID INTEGER NOT NULL, 
	Rating INTEGER DEFAULT 3 CHECK (Rating >= 1 AND Rating <= 5), 
	Comment TEXT, 
	FOREIGN KEY (UserID) REFERENCES Rater ON DELETE CASCADE, 
	FOREIGN KEY (ItemID) REFERENCES MenuItems ON DELETE CASCADE
);
