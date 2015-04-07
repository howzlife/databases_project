-- ===========================================================================
-- Drop tables
-- ===========================================================================
DROP TABLE IF EXISTS Restaurant, Location, Rating, Rater, MenuItem, RatingItem;

-- ===========================================================================
-- Drop types
-- ===========================================================================
DROP TYPE IF EXISTS restaurant_type, rater_type, item_type, item_category;

-- ===========================================================================
-- Enums
-- ===========================================================================
CREATE TYPE restaurant_type as ENUM (
		'sports bar', 
		'fast food', 
		'mexican', 
		'italian', 
		'taco', 
		'steakhouse', 
		'casual dining', 
		'family style', 
		'trendy', 
		'hippy trash', 
		'fine dining',
		'irish pub'
		);

CREATE TYPE rater_type as ENUM (
		'blogger', 
		'professional critic', 
		'regular dude', 
		'filthy casual', 
		'unhappy hipster', 
		'kind of a douche', 
		'vegan', 
		'lacto-ovo-pescatarian vegan'
		);

CREATE TYPE item_type as ENUM (
		'food', 
		'beverage'
		);

CREATE TYPE item_category as ENUM (
		'cocktail', 
		'salad', 
		'martini', 
		'mixed drink', 
		'beer', 
		'liquor', 
		'breakfast', 
		'lunch', 
		'dinner', 
		'dessert', 
		'coffee', 
		'appetizer', 
		'main', 
		'entree', 
		'sandwich', 
		'pizza'
		);

-- ===========================================================================
-- Create Tables
-- ===========================================================================
CREATE TABLE Restaurant (
	RestaurantID 	INTEGER 		NOT NULL CHECK (RestaurantID > 0),
	Name 			VARCHAR(35) 	NOT NULL, 
	Type 			restaurant_type NOT NULL,
	URL 			VARCHAR(35), 
	PRIMARY KEY (RestaurantID)
);

CREATE TABLE Location (
	LocationID 			INTEGER 		NOT NULL CHECK (LocationID > 0),
	First_Open_Date 	DATE, 
	Manager 			VARCHAR(20), 
	Phone_Number 		VARCHAR(20),
	Street_Address 		VARCHAR(30) 	NOT NULL,
	Hour_Open 			VARCHAR(20),
	Hour_Close 			VARCHAR(20),
	RestaurantID 		INTEGER 		NOT NULL, 
	FOREIGN KEY (RestaurantID) REFERENCES Restaurant 
								ON DELETE CASCADE,
	PRIMARY KEY (LocationID)
);

CREATE TABLE Rater (
	UserID 				INTEGER 		NOT NULL,
	Email 				VARCHAR(30), 
	Name 				VARCHAR(20) 	NOT NULL, 
	Join_Date 			DATE, 
	Type 				rater_type, 
	Reputation 			INTEGER 		DEFAULT 1 CHECK (Reputation >= 1 AND Reputation <= 5), 
	PRIMARY KEY (UserID)
);

CREATE TABLE Rating (
	UserID 				INTEGER 	NOT NULL , 
	Date_Submitted 		Date 		NOT NULL, 
	Price 				INTEGER 	DEFAULT 3 CHECK (Price >= 1 AND Price <= 5), 
	Food 				INTEGER 	DEFAULT 3 CHECK (Food >= 1 AND Food <= 5), 
	Mood 				INTEGER 	DEFAULT 3 CHECK (Mood >= 1 AND Mood <= 5), 
	Staff 				INTEGER 	DEFAULT 3 CHECK (Staff >= 1 AND Staff <= 5), 
	Overall 			INTEGER 	DEFAULT 3 CHECK (Overall >= 1 AND Overall <= 5),
	Comments 			TEXT, 
	Helpful 			INTEGER 	DEFAULT 0 CHECK (Helpful >= 0),
	RestaurantID 		INTEGER 	NOT NULL, 
	FOREIGN KEY (RestaurantID) REFERENCES Restaurant 
								ON DELETE CASCADE, 
	FOREIGN KEY (UserID) REFERENCES Rater 
								ON DELETE CASCADE
);

CREATE TABLE MenuItem (
	ItemID 				INTEGER 		NOT NULL, 
	Name 				VARCHAR(35) 	NOT NULL, 
	Type 				item_type, 
	Category 			item_category, 
	Description 		TEXT 			NOT NULL, 
	Price 				NUMERIC(5,2), 
	RestaurantID 		INTEGER 		NOT NULL, 
	FOREIGN KEY (RestaurantID) REFERENCES Restaurant 
						ON DELETE CASCADE, 
	PRIMARY KEY (ItemID)
);

CREATE TABLE RatingItem (
	UserID 				INTEGER 	NOT NULL, 
	Rating_Date 		Date, 
	ItemID 				INTEGER 	NOT NULL, 
	Rating 				INTEGER 	DEFAULT 3 CHECK (Rating >= 1 AND Rating <= 5), 
	Comment 			TEXT, 
	FOREIGN KEY (UserID) REFERENCES Rater 
							ON DELETE CASCADE, 
	FOREIGN KEY (ItemID) REFERENCES MenuItem 
							ON DELETE CASCADE
);

-- ===========================================================================
-- Restaurant Data
-- ===========================================================================
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (1, 'Sens House Sports Bar & Grill', 'sports bar', 'www.thesenshouse.ca');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (2, 'Real Sports Bar & Grill', 'sports bar', 'www.realsports.ca');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (3, 'Boston Pizza', 'sports bar', 'www.bostonpizza.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (4, 'The Senate Sports Tavern and Eatery', 'sports bar', 'www.thesenate.ca');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (5, 'Johnny Farina Restaurant', 'italian', 'www.johnnyfarina.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (6, 'Stella Osteria', 'italian', 'www.stellaosteria.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (7, 'Steak & Sushi', 'steakhouse', 'www.steakottawa.ca');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (8, 'Patty Boland''s', 'irish pub', 'www.pattybolands.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (9, 'Heart & Crown', 'irish pub', 'www.heartandcrown.ca');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (10, 'Aulde Dubliner & Pour House', 'irish pub', 'www.heartandcrown.ca/dubliner.aspx');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (11, 'Mamma Grazzi''s', 'italian', 'www.mammagrazzis.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (12, 'Blue Cactus Bar and Grill', 'fine dining', 'www.bluecactusbarandgrill.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (13, 'Ace Mercado', 'mexican', 'www.acemercado.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (14, 'Ahora', 'mexican', 'www.ahora.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (15, 'Play food & wine', 'fine dining', 'www.playrestaurant.com');
INSERT INTO Restaurant(RestaurantID, Name, Type, URL) 
	VALUES (16, 'Restaurant 18', 'fine dining', 'www.restaurant18.com');

-- ===========================================================================
-- Rater Data
-- ===========================================================================
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (1, 'nico.dubus17@gmail.com', 'howzlife', '2015-03-22', 'blogger', 1);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (2, 'jeff_bezos@gmail.com', 'amazing_amazon', '2015-03-22', 'blogger', 1);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (3, 'larry_page@gmail.com', 'google_emp_0', '2015-03-22', 'professional critic', 4);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (4, 'sergey_brin@gmail.com', 'google_emp_1', '2015-03-22', 'regular dude', 3);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (5, 'steve_jobs@gmail.com', 'apple_luvr', '2015-03-22', 'professional critic', 5);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (6, 'steve_wozniak@gmail.com', 'apple_brain', '2015-03-22', 'blogger', 1);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (7, 'steve_ballmer@gmail.com', 'ballmer_curve', '2015-03-22', 'regular dude', 3);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (8, 'elon_musk@gmail.com', 'tesla_kewl', '2015-03-22', 'regular dude', 3);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (9, 'tony_stark@gmail.com', 'realIronMan', '2015-03-22', 'professional critic', 3);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (10, 'steve_rogers@gmail.com', 'capnMurrica', '2015-03-22', 'regular dude', 4);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (11, 'bruce_banner@gmail.com', 'green_machine', '2015-03-22', 'blogger', 1);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES(12, 'thor@gmail.com', 'hammertime', '2015-03-22', 'regular dude', 2);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (13, 'loki@gmail.com', 'mewlingQuim', '2015-03-22', 'vegan', 4);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (14, 'peter_parker@gmail.com', 'spiderdude', '2015-03-22', 'professional critic', 5);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (15, 'james_howlett@gmail.com', 'logan', '2015-03-22', 'regular dude', 3);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (16, 'charles_xavier@gmail.com', 'dontThinkThat', '2015-03-22', 'blogger', 1);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (17, 'erik_lensherr@gmail.com', 'chickMagneto', '2015-03-22', 'regular dude', 4);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (18, 'peter_quill@gmail.com', 'Starlord_Man', '2015-03-22', 'professional critic', 4);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (19, 'gamora@gmail.com', 'heygurl', '2015-03-22', 'regular dude', 3);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (20, 'iamgroot@gmail.com', 'iamgroot', '2015-03-22', 'regular dude', 4);
INSERT INTO Rater(UserID, Email, Name, Join_Date, Type, Reputation) 
	VALUES (21, 'batman@batman.com', 'batman', '2015-04-01', 'professional critic', 5);

-- ===========================================================================
-- Menu Items
-- ===========================================================================
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (1, 'Spinach Dip', 'food', 'appetizer', 'hand-torn locally made bread', '10.99', 1);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (2, 'Sens House Nacho', 'food', 'appetizer', 'smoked brisket / house-blend cheese / pickled jalapeño / pico de gallo / cumin crema', '12.99', 1);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (3, 'Chicken Parm Grilled Cheese', 'food', 'sandwich', 'sautéed sweet peppers & onions / mozzarella / provolone / marinara', '15.99', 1);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (4, 'Copper Kettle Mussels', 'food', 'appetizer', 'Sports bar food at its best. A pound of fresh mussels, steamed with onions, garlic leeks, chopped tomato, fresh herbs and Rickards Red. Served with lots of garlic bread for dipping', '11.99', 2);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (5, 'Chicken Stir Fry', 'food', 'entree', 'COCONUT JASMINE RICE, WOK-FRIED VEGETABLES, CRISP BEAN SPROUTS', '15.99', 2);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (6, 'Double Bacon BBQ Burger', 'food', 'sandwich', '100% Canadian beef. Our half-pound prime rib beef burger is loaded with bacon and smothered in our Jack Daniel’s® BBQ sauce.', '13.99', 3);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (7, 'Chocolate DoughCano', 'food', 'dessert', 'Sweet perfection – creamy chocolate mousse with chunks of cheesecake, caramel, toffee, pecans and almonds wrapped in our signature pizza dough and baked to perfection, then topped with icing sugar, whipped cream and chocolate sauce', '7.99', 3);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (8, 'Haddock Teasers', 'food', 'appetizer', 'Bite sized beer battered haddock rolled in sea salt & malt vinegar potato chips', '11', 4);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (9, 'Turduken Sandwich or Wrap', 'food', 'sandwich', 'Not for the meek, a triple decker sandwich piled high with turkey, duck, chicken, bacon, cranberry mayo, lettuce, tomato and if that wasnt enough a layer of stuffing in the middle to make this a seasonal favourite. “Brett Favre eats five turduckens a day!” John Madden', '14.99', 4);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (10, 'Scallop + Bacon Pizza', 'food', 'pizza', 'Alfredo Pesto Sauce | Mozzarella | Scallop | Bacon | Caramelized Onion | Potato | Smoked Gouda', '17.25', 5);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (11, 'Kitchessippi Beer Pie', 'food', 'pizza', '“Kichesippi 1855 BBQ Sauce” | Mozzarella | Potato | Cheddar | Red Onions | Jalapeno Bacon | Grilled Chicken', '16.95', 5);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (12, 'Agnello', 'food', 'entree', 'chianti braised lamb shank // rapini celeriac & pecorino polenta ', '28', 6);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (13, 'Bistecca', 'food', 'entree', 'herb rubbed striploin // rapini // brown butter fingerling potatoes', '34', 6);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (14, 'potato gnocchi', 'food', 'entree', 'grape tomato, asparagus, eggplant, tomato basil sauce', '25', 7);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	 VALUES (15, 'Steak Frites', 'food', 'entree', 'soy & star anise marinated flat iron, frites, garlic aioli', '25', 7);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (16, 'Bacon Avocado Chicken Sandwich', 'food', 'sandwich', 'Freshly grilled chicken breast, bacon strips, melted cheddar cheese, lettuce, Pico de Gallo, chipotle sour cream & slices of fresh avocado all served on an original Kaiser bun', '15', 8);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (17, 'Chicken & Brie Sandwich', 'food', 'sandwich', 'Freshly grilled chicken breast, caramelized onions & apples, melted brie, lettuce, sun-dried tomato pesto mayo all served on a freshly baked Artisan baguette.', '15', 8);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (18, 'Roasted Chicken & Apricot Salad', 'food', 'salad', 'Shaved Marinated Chicken | Fresh Baby Spinah | Romaine | Apricot | Soft Goat Cheese | Pecans | Sesame-Soy Dressing', '18.99', 14);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (19, 'Canadian Bison Burger', 'food', 'sandwich', 'Fresh Alberta Bison Patty | Caramelized Onions | Arugula | Herbed Black Pepper Mayo | Canadian Cheddar | Vine Tomato | Toasted Brioche Bun', '17', 9);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES(20, 'Bytown Breakfast', 'food', 'breakfast', 'Two eggs with your choice of bacon, ham or sausage served with home fries and toast', '9', 10);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (21, 'Traditional Eggs Benedict', 'food', 'breakfast', 'Delicately poached eggs on top of grilled ham and a toasted english muffin topped with hollandaise served with home fries, and smoked salmon', '12', 10);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (22, 'Speck', 'food', 'appetizer', 'Cured and smoked speck ham, white beans, green peppercorns, olive oil, lemon and basil', '10', 11);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (23, 'Sauteed Scallops', 'food', 'appetizer', 'Pan-seared scallops on a bed of arugula with pancetta and citrus vinaigrette | Pétoncles poeles avec pancetta et vinaigrette au citron', '18', 11);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (24, 'Clyde Burrito', 'food', 'sandwich', 'Named after the founder of Mexicali Rosas, this burrito has chili con carne, texas red hot chili, taco beef, fiesta rice and sante fe beans. This huge burrito is topped with Rosas red sauce, sour cream sauce and green onions.', '15.99', 12);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES(25, 'Carne Asada Burrito', 'food', 'sandwich', 'Grilled sirloin, sour cream sauce, fiesta rice and Sante Fe beans rolled in your choice of flour or whole wheat tortilla topped with Monterey Jack cheese and Rosas red sauce', '14.99', 12);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (26, 'Crispy Pig Cheek', 'food', 'entree', 'Mexican dirty rice + house made chorizo + pickled cabbage + agave glaze', '24', 13);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (27, 'The Duck Duo', 'food', 'entree', 'Duck confit enchilada + coriander crema + lime roasted peanuts + pickled pineapple + crispy mariposa duck breast + tamarind & coffee reduction + drunken mushrooms', '28', 13);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (28, 'Burrito de Pollo', 'food', 'sandwich', 'Chicken, cheese, salsa gringa and guacamole', '8.50', 14);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (29, 'Burrito Grande', 'food', 'sandwich', 'Chicken or steak, cheese, black beans, rice, salsa gringa, lettuce, guacamole and sour cream', '9.25', 14);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (30, 'MeatBall Hoagie', 'food', 'sandwich', 'meatball hoagie / pork / beef / artichoke / halloumi / tomato', '14', 15);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (31, 'Pork Belly', 'food', 'appetizer', '/ hoisin / orange / bok choy / star anise / peanut', '15', 15);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (32, 'Quebec Fois Gras', 'food', 'appetizer', 'seasonal accompaniments | Foie Gras du Québec garnitures saisonnière', '24', 16);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (33, 'Rack of Lamb', 'food', 'entree', 'polenta, tamarind jus, orange gremolade | Carré d’Agneau polenta, jus aux tamarins, gremolade à l’orange', '44', 16);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (34, 'Alexander Keiths IPA', 'beverage', 'beer', 'Alexander Keiths IPA', '6.99', 4);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (35, 'Smoked Caesar', 'beverage', 'cocktail', 'Smoked Caesar', '8.99', 1);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (36, 'Blue Martini', 'beverage', 'cocktail', 'Blue Martini', '6.99', 2);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (37, 'Beaus Lug Tread', 'beverage', 'beer', 'Beaus Lug Tread', '7.99', 4);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (38, 'White Russian', 'beverage', 'cocktail', 'White Russian', '5.99', 10);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (39, 'Black Russian', 'beverage', 'cocktail', 'Black Russian', '6.99', 16);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (40, 'Lady on the Rocks', 'beverage', 'cocktail', 'Lady on the Rocks', '5.99', 13);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (41, 'Dirty Martini', 'beverage', 'martini', 'Dirty Martini', '8.99', 14);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (42, 'Clocktower Brown Ale', 'beverage', 'beer', 'Clocktower Brown Ale', '9.99', 5);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (43, 'Macallans 18', 'beverage', 'liquor', 'Macallans 18', '7.99', 3);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (44, 'Spiced Rum Mojito', 'beverage', 'mixed drink', 'Spiced Rum Mojito', '5.99', 2);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (45, 'Captain Morgan Black Rum', 'beverage', 'liquor', 'Captain Morgan Black Rum', '6.99', 1);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (46, 'Twice As Mad Tom', 'beverage', 'beer', 'Twice As Mad Tom', '10.99', 2);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (47, 'Surfers on Acid', 'beverage', 'cocktail', 'Surfers on Acid', '12.99', 16);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (48, 'Grey Goose Martini', 'beverage', 'liquor', 'Grey Goose Martini', '7.99', 5);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES(49, 'Stella Artois', 'beverage', 'beer', 'Stella Artois', '8.99', 8);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES (50, 'Red Headed Slut', 'beverage', 'cocktail', 'Red Headed Slut', '6.99', 9);
INSERT INTO MenuItem(ItemID, Name, Type, Category, Description, Price, RestaurantID) 
	VALUES(51, 'Guiness', 'beverage', 'beer', 'Guiness', '6.99', 11);

-- ===========================================================================
-- (1) Sens House Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (10, '2014-09-21', 1, 1, 1, 1, 1, 'Went here with my friends and was expecting something that would blow us out of the water and boy were we soooo disappointed. Our poor server seemed overwhelmed and took over 10 mins to bring us our waters and then once at the table he didnt have enough waters for all of us so that took another 10 min. Then the menu was very underwhelming and our food was tasteless and bland. Oh ya and did i mention there''s only 3 stalls in the womens washroom, wouldnt want to be there on a busy night..You''ll catch me watching sens games over at Real Sports where they do it right', 1, 1);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (11, '2014-08-30', 1, 1, 1, 1, 1, 'Chicken Parm Grilled Cheese - Two of my favourite sandwiches in one! Ask for hot peppers though!', 1, 1);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (12, '2014-09-09', 5, 5, 5, 5, 5, 'I absolutely loved sens house and will definitely be back! I had the chicken parm grilled cheese and my partner had the mushroom burger - both amazing!! Service was great and the food came out quickly. Can''t wait to go watch a sens game!', 1, 1);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (13, '2014-09-09', 1, 5, 1, 1, 5, 'Beautiful place. Bad service. $10 for a handful of poutine? And it came out cold. The Senate is a real sports bar.', 1, 1);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (14, '2014-08-16', 5, 1, 5, 5, 5, 'Service 5 out of 5 had egg roll way to dry no good then had Cajun wings again wat to dry then we tried the spinach cheese dip that was the best. The wine decent and well price. We will go back and try the sandwitch. The menu should be reviewed', 1, 1);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (15, '2014-08-28', 1, 1, 1, 1, 1, 'Fries were just not good and tasted re-heated', 1, 1);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (16, '2015-04-01', 3, 3, 3, 3, 3, 'Meh!', 1, 1);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (17, '2014-07-30', 4, 4, 4, 4, 4, 'As a Sens I''ve been waiting for the Sens House to open and now it is finally here, I must say, I think it''s pretty cool.', 1, 1);

-- ===========================================================================
-- (2) Real Sports Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (18, '2014-02-15', 4, 4, 4, 4, 4, 'It''s okay. Watching the game is awesome and if you are just snacking on okay food - go for it. Nothing incredibly gastronomically pleasing, just the average pub fair. DO NOT get the loaded potato ""dip""... It''s mashed potato that you dip bread into and is so carbo loaded. The cheeseburger spring rolls are not good for you but DELICIOUS. Service is decent.', 0, 2);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (19, '2014-12-03', 1, 1, 1, 1, 1, 'Abysmally slow. Expect your time to disappear into a vortex. All flash, no substance.', 0, 2);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (20, '2014-04-20', 2, 2, 2, 2, 2, 'This place is good to watch a game but terrible for eating. The service is very poor. Food arrives after long delays and often cold. Also, the food is overpriced pub fare. If you''re coming here to watch a game, eat before you come.', 0, 2);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (21, '2014-07-30', 3, 3, 3, 3, 3, 'Had the cheeseburger sliders and onion rings. Burgers were simulated patties (not hand made) and were horrible. Onion rings were 5% onions 95% deep fried greasy fat. Horrible. Guest ordered veggie burger and it was OK. Another guest ordered a regular burger with fries and that was OK. 4 drinks and bar-food dinner were $120. Go for the good selection of beer and all the televisions. Be careful of what you order. The wings at the next table looked great and quite big.', 0, 2);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (1, '2014-07-30', 4, 4, 4, 4, 4, 'I''m not sure what everyone is complaining about but prices are about the same as every other bar, pub and restaurant. We came in the afternoon to watch the game and the food was good and the service was really attentive (Amazing server Derek!!) even though the place was filled to the brim. If you want to watch the game, this is about as nice and as good as it gets.', 0, 2);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (2, '2014-05-17', 5, 5, 5, 5, 5, 'Nice, upscale-feeling bar without the upscale prices. Happy hour deals are great and the waitresses are very friendly and professional. Would go here a lot more often if I lived close to the market.', 0, 2);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (3, '2014-01-29', 4, 4, 4, 4, 4, 'I like this place. Yes, it is a little pricy, but it''s got some class to it and isn''t a dive. They always have decent drink specials and the food is pretty tasty. Love the atmosphere, can''t go wrong with the beer options and huge screen TV. I''ve had a few of the burger options and apps. Always a good place to go for the game if you don''t mind spending the extra buck, but $10 for a liter of Canadian ain''t bad.', 0, 2);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (4, '2013-12-16', 5, 5, 5, 5, 5, 'SWow! The wings rock. So what if they''re fattening. They''re worth a few hours at the gym. When you go to the market location, ask for Brit. Aside from the fact the she''s cute, she was a fantastic server. Very attentive.', 0, 2);

-- ===========================================================================
-- (3) Boston Pizza Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (5, '2015-03-13', 1, 1, 1, 1, 1, 'Stopped in for a beer and lunch,The bar side was empty and the server was attentive..the owners however need a serious lesson in customer service..was so bad we left before we ordered food and will not return.It is unbelievable that a chain as big and usually respected has owners as visible as these.Obviously not trained and won''t last long.', 0, 3);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (6, '2014-01-15', 5, 5, 5, 5, 5, 'We went to dine in with our 2 little ones. Our son was not having a good day. Our server was very pleasant and looked after us. The food came out quickly , the kids were happy and so were we. Good food, good value, definitely going back.', 0, 3);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (7, '2014-01-01', 5, 5, 5, 5, 5, 'I would like to thank the staff of Boston Pizza on St Laurent for accommodating my group of 25. We had made a reservation at another restaurant, to our disappointment they could not accommodate us. Went to Boston Pizza on St Laurent they were busy I explained my situation It was my Grand Mothers Birthday and they looked after us, good food good service. Customer for life. Thank you.', 0, 3);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (8, '2014-10-01', 5, 5, 5, 5, 5, 'We have been at this location several times and the food is always delicious. The Staff are friendly and the atmosphere is great. Great service!', 0, 3);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (9, '2013-10-26', 5, 5, 5, 5, 5, 'It was our first time at Boston Pizza St.Laurent. Excellent service,the server explained how the ''Appy Hour'' works, enjoyed the appetizer good deals, the food came out on time. Had a good time.', 0, 3);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (10, '2013-09-23', 5, 5, 5, 5, 5, 'I love the new lunch menu. Good value and very quick service. The server asked if I wanted Starbucks coffee to go. Amazing, I will definitely be back.', 0, 3);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (11, '2013-12-16', 3, 3, 3, 3, 3, 'Service was ok but not terribly attentive. My personal pizza was ok. The dessert was very good. Overall, for the price, I''d say ""meh""', 0, 3);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (12, '2012-07-12', 1, 1, 1, 1, 1, 'WORST service! We sat in the bar section for dinner. After about 15-20 minutes of waiting, no server had even come to take our drink order.... We got up and left.', 0, 3);

-- ===========================================================================
-- (4) Senate Tavern Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (13, '2015-03-03', 5, 5, 5, 5, 5, 'Wonderful service, lot''s of selection, and very good food. The club was excellent.', 0, 4);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (14, '2015-01-18', 5, 5, 5, 5, 5, 'My husband, I, and our friends stopped in for a quick lunch on our way home from Mont-Tremblant. After having left the first pub we stopped in at after being greeted by a waitress who told us how hungover she was, it was a relief to be greeted by a friendly and enthusiastic bartended who welcomed us warmly. Each of us had a different type of burger, and all were delicious! Portions were generous, fresh fries, and amazing service! We could not have asked for anything better. Thanks for the great experience, we will make the trip back just to come to The Senate Sports Tavern again!', 0, 4);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (15, '2014-12-31', 3, 3, 3, 3, 3, 'We were drawn into this place by a sign in front of the restaurant advertising 1/2 price nachos during the Canada world junior hockey game. We went in and ordered the nachos and drinks. When the bill came it had the nachos for full price (14+ tax). When we asked about the 1/2 price nachos the waitress told us that the owner changed his mind, but when we left the sign was still out front advertising 1/2 price nachos. Disappointing that they use this type of false advertising to lure people. Beware', 0, 4);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (16, '2014-03-12', 5, 5, 5, 5, 5, 'Fish chips was great. Good service. Hockey on the French channel for Habs bruins game - good atmosphere.', 0, 4);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (17, '2014-02-21', 5, 5, 5, 5, 5, 'Been a loyal customer on a regular basis. Excellent food, fantastic friendliness, beautiful servers always impressed. Owners are fantastic and I will miss when I leave Ottawa.', 0, 4);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (18, '2014-01-09', 5, 5, 5, 5, 5, 'One of our favourite spots in the market. Fun environment, (covered patio in the summer rules!) tastey food and ice cold beers. What else could you want?!', 0, 4);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (19, '2012-07-12', 5, 5, 5, 5, 5, 'Popped in here for lunch and was pleasantly surprised! Great food, quick and very friendly service!', 0, 4);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (20, '2013-06-29', 5, 5, 5, 5, 5, 'Loved it. Yummy food! Fun staff.', 0, 4);

-- ===========================================================================
-- (5) Johnny Farinas Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (21, '2015-02-17', 5, 5, 5, 5, 5, 'Great restaurant!! Some of the best and friendliest service I have ever received. Really good drink menu and an extremely long wine menu as well. Food was also delicious! Great atmosphere! I would definitely recommend this place!', 0, 5);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (1, '2014-02-14', 5, 5, 5, 5, 5, 'I went here recently with my boyfriend & family members. The service was excellent! Our waiter was a really nice guy who joked around with us. Also, the food was fantastic. Their calamari is delicious. I would definitely go back & recommend it.', 0, 5);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (2, '2014-12-14', 4, 4, 4, 4, 4, 'Long wait to be seated but the host and the server were equally pleasant. The food was good and I liked the building/atmosphere. It was however very busy which made the experience less enjoyable. Our servers kept switching tables which was slightly annoying. Should be 1 server per table to keep things less confusing. Overall good time.', 0, 5);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (3, '2014-06-29', 5, 5, 5, 5, 5, 'Great Pasta!!! All home made sauces and pastas - service not so great though, constantly waiting on our girl, drinks were forgotten, dishes left there too long.', 0, 5);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (4, '2014-02-11', 4, 4, 4, 4, 4, 'Try the ""Johnny Farina"" pasta with a glass of white wine.... you won''t regret it!', 0, 5);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (5, '2014-02-02', 3, 3, 3, 3, 3, 'Mediocre at best- didn''t find anything that fantastic about the food and the waitress we had seemed a little patronizing and phony- wouldn''t go again', 0, 5);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (6, '2013-10-07', 5, 5, 5, 5, 5, 'Although a large resto, staff is welcoming and friendly, not to mention the complimentary fresh baked bread loaf! Quality trumps quanity at Farina''s, was a perfect portion size with the richness of the pasta. I had the Johnny Farina pasta and was not disappointed, especially with fresh parm on-top. YUM!', 0, 5);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (7, '2013-01-17', 5, 5, 5, 5, 5, 'Great service, great food, great beer every time! One of my favourite spots in Ottawa!', 0, 5);

-- ===========================================================================
-- (6) Stella Osteri Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (8, '2013-10-31', 5, 5, 5, 5, 5, 'The braised short ribs are to die for and their pizzas are so good!', 0, 6);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (9, '2013-12-16', 5, 5, 5, 4, 5, 'A friend convinced me to join her at Stella for lunch yesterday. I was pleasantly surprised. The food we ordered was quite good- Caesar salads and pizzas topped off by freshly-brewed coffee, Sure I''ve read the previous reviews but, based on my experience, I will be back. My only quibble was the long wait for our food, but one it arrived all was good.', 0, 6);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (10, '2014-07-16', 5, 5, 5, 5, 5, 'Nice place and they have a very good pizza (smoked salmon) I liked everything about their pizza and it was spot on, but the food is overpriced.', 0, 6);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (11, '2014-02-05', 3, 3, 3, 3, 3, ' had the braised short rib gnocchi. The gnocchi was terrible. The consistency was bad, like it was the store bought brand and the short rib was tough and flavorless. The red wine was served very warm.
The prices were good and others at my table had a good experience. The service was ok.
Probably won''t go back for dinner.', 0, 6);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (12, '2013-06-10', 1, 1, 1, 1, 1, 'The first time we attempted the Stella patio we left as we sat there for 10 minutes without a single server acknowledging us. Tonight we thought we would try again. Wrong move. Once again we sat there for 15 minutes with no service, even after making eye contact with a server. What is the problem Stella? Being a server of 15+ years I know it is not hard to acknowledge guests in your section. I truly wanted to eat there as the food is usually good, however the complete lack of service and the complete lack of care when we told the hostess why we were leaving is exactly why we will NEVER go back to this restaurant. Epic fail Stella.....EPIC!!!', 0, 6);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (13, '2013-12-16', 3, 3, 3, 3, 3, 'Went for dinner and had the Herb Rubbed Filet Mignon
which came with broccolini and herb roasted potatoes. Food was okay but expected more from the hype I got from this place. I am a steak fan and wouldnt say i would return again for a red meat craving. Also had the Layered Chocolate Cake for dessert which again was just mediocre. Service was minimal and tended to disappear. Cant say i was impressed especially for the price points. Sorry folks.', 0, 6);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (14, '2013-12-16', 2, 2, 2, 2, 2, 'I''ve been to Stella twice and both times the service was terrible. The waiter argued with me and seemed to go on break while waiting on us. Food is not bad but still not worth the prices they charge. As a local I would not recommend this restaurant.', 0, 6);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (15, '2013-12-16', 1, 3, 3, 2, 2, 'Been there a few times to eat and always find it expensive for what you`re getting. I shared a salad and a margherita pizza with my friend at lunch and it cost almost 40 bones + 2 soft drinks. Menu never changes, only good thing is the patio.', 0, 6);

-- ===========================================================================
-- (7) Steak Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (16, '2014-10-26', 1, 1, 1, 1, 1, 'Overprice. Our server was arrogant and doing an attitude (I think her name was Taylor ???). Worst experience ever. So many better restaurants by the market...', 0, 7);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (17, '2014-08-20', 2, 2, 2, 2, 2, 'small portions for the price of the food service was ok ... we never got the coffee we ordered go somewhere else in the market instead', 0, 7);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (18, '2013-12-05', 1, 5, 5, 5, 5, 'Good food, great wine selection, but still a bit expensive among the other byward restaurant.', 0, 7);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (19, '2011-08-07', 5, 3, 5, 5, 5, 'Small serving but good food.', 0, 7);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (20, '2012-10-12', 1, 1, 3, 5, 5, 'Came in with a party of friends for dinner, the food was okay, save a few steaks that were really overcooked. Our server Kevin was really accomodating and made us all happy, the only reason i would go back is for that kind of service. But if you want a steak cooked right the first time, go to the Keg.', 0, 7);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (21, '2013-12-16', 5, 5, 5, 5, 5, 'We had a late supper at 11pm and had the. chicken and Steak Frites. Both were great. Service was superb they turned up the A/C when we asked and even lowered the live DJ music. Thanks to great service!', 0, 7);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (1, '2013-12-16', 2, 2, 2, 2, 2, 'What a terrible restaurant. The steak was tough, extremely chewy and half of it was fat. One of my friends ordered a steak medium well which came out more red than my medium rare steak. Another friend of mine ordered a medium rare steak which came out dry, when he sent it back the chef returned it to him and said it was fine. Fourthly (for those who are counting) another friend ordered one of the meals that are set by the chef (rather than one you assemble on your own) and they forgot the peppercorn sauce that it comes with. She waited about 10 minutes for the sauce and by the time she started most of us were half way through our meals. We left very dissatisfied, if you''re going to call yourself ""steak"" you should be able to grill a steak properly and get proper cuts of beef. This place doesn''t deserve to be in business.', 0, 7);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (2, '2013-12-16', 2, 2, 2, 2, 2, 'Terrible cuts of meat, no consistency with cooking - many steaks were undercooked. As a previous review stated: if you are going to call your restaurant "Steak", you should at least do that one thing well. I dined with a group of 20 individuals and we were completely underwhelmed. Next time trust the solid slate of negative reviews.', 0, 7);

-- ===========================================================================
-- (8) Patty Bolands Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (5, '2015-04-01', 5, 5, 5, 5, 5, 'This place is good for only one reason 5$ pints and Apps on Friday!!! The price did go up 1$ (use to be 4$). If it goes up any higher you wont see me here. The place still looks the same after 12 years.', 1, 8);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (2, '2015-04-01', 1, 1, 1, 1, 1, 'The food was not very good at all. I ordered the peanut stir fry with beef. The rice noodles hadnt been properly drained, and thus watered down my meal. The beef was chewy and stringy. Some of the veggies were overcooked, while others were undercooked. Service wasnt great. I dont think Ill be going there for food again.', 0, 8);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (3, '2015-04-01', 3, 3, 3, 3, 3, 'While this bar was never that bad (average food) apparently the night staff thinks pretty highly of themselves. Mandatory $7 coat check and of you want fresh air you can only go out with the smokers. The DJ seems to think it is still 1988. There are way better place to spend your time in the market', 1, 8);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (4, '2015-04-01', 5, 5, 5, 5, 5, 'Fantastic place. Wonderful wood burning fireplace in the winter.. Good bands.. And the best wings in Ottawa', 1, 8);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (6, '2015-04-01', 4, 4, 4, 4, 4, 'Walking around Bytown Market Saturday night, all restaurants very busy. Dropped in here, due to extensive menu compared to others. Food was very good, service was very good. Value was good. Had a very enjoyable time. Owner/Manager seemed genuinely concerned that we were looked after and everything was going well. Highly , recommend to others. Even my teenage daughters were happy, which is saying some.', 1, 8);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (7, '2015-11-29', 5, 5, 5, 5, 5, 'Amazing atmosphere, personable and friendly staff and incredible food. Our servers were amazing. The owner went out of his way to make sure we had a great evening. Even sending us food to try. The $4 dollar apps were gourmet and the mains were delicious', 1, 8);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (8, '2009-10-04', 1, 1, 1, 1, 1, 'I was not impressed with Pattys at all. The bar staff have a huge ego and the food is not the greatest. Before deciding where to eat or go out, I would recommend walking right past this place and heading to the Heart and Crown.', 1, 8);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (9, '2010-11-23', 5, 5, 5, 5, 5, 'This place is amazing! Great food, great staff, great atmosphere.', 1, 8);

-- ===========================================================================
-- (9) Heart and Crown Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (10, '2014-12-29', 1, 1, 1, 1, 1, 'The manager woman/banshee is off her damn rocker. She''s extremely abrupt and should learn to treat her customers like actual customers. She is extremely rude and hasn''t clearly the slightest clue how to hire competent staff. Get a clue moron.', 0, 9);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (11, '2014-03-29', 5, 5, 5, 5, 5, 'Best deep fried pickles, fish & chips, and shepherd''s pie on earth!', 0, 9);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (12, '2014-02-22', 3, 3, 3, 3, 3, 'Had dinner with a friend of mine here tonight. It was very busy for a Saturday night. A large pub with a strange layout. The service was good but the food was just your regular pub food. Nothing special or a must go and visit.', 0, 9);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (13, '2013-12-28', 1, 1, 1, 1, 1, 'Title says all. The prices aren''t very good too. Pub food is pub food.', 0, 9);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (14, '2014-07-26', 5, 5, 5, 5, 5, 'Food is typical frozen crap. Serving sizes are not worth the price you pay. Many other options in the local area', 0, 9);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (15, '2013-07-06', 4, 4, 4, 4, 4, 'Great atmosphere, excellent location average service. Small portions for bar food. Wouldn''t recommend the wings although the sauce is decent. The beef stew was lacking in beef and substance. Small selection of beer', 0, 9);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (16, '2013-12-16', 5, 5, 5, 5, 5, 'Great area of downtown. Just a typical pub with pub food. Quite large as well.', 0, 9);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (17, '2013-12-16', 5, 5, 5, 5, 5, 'Super fun in the summer. Park your car, go for dinner and then make your way to the H&C for some serious fun. :-)', 0, 9);

-- ===========================================================================
-- (10) Aulde Dubliner Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (18, '2014-11-18', 5, 5, 5, 5, 5, 'My dad & I from Calgary had lunch. Stephanie was great & burger was tasty.', 0, 10);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (19, '2014-11-09', 1, 5, 1, 1, 1, 'Decor was nice when walking in, but the service and the food were both TERRIBLE. I wouldn''t feed that food to my dog', 0, 10);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (20, '2014-06-30', 1, 1, 1, 1, 1, 'You would think sitting on the patio would be great, but think again. Smells like dity diapers. Makes you want to puke. The poopy aroma is overwhelming. Recommend elsewhere.', 0, 10);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (21, '2014-07-15', 1, 5, 1, 1, 1, 'Don''t let the nice hanging flower baskets fool you! We waited forever to be served by a cold and unfriendly waitress. Food took a long whole to arrive and it was mediocre at best. This place is on a prime location and the unknowing tourists must keep it alive. Give this one a miss.', 0, 10);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (1, '2013-12-16', 3, 3, 3, 3, 3, 'Pub food all right, and that''s about it. It''s a tourist trap in the market, so there isn''t much to expect.', 0, 10);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (2, '2013-12-16', 3, 3, 3, 3, 3, 'This place was sort of mediocre. The atmosphere is good, but the food is run-of-the-mill.', 0, 10);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (3, '2013-12-16', 2, 2, 2, 2, 2, 'Just pub food. Not that impressive. Service lacks', 0, 10);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (4, '2013-12-16', 5, 5, 5, 5, 5, 'The poutinne was soooooooo good and the view of the market is just amazing ! Would go again just for a beer and poutine anytime!!', 0, 10);

-- ===========================================================================
-- (11) Mamma Grazzis Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (5, '2014-10-10', 2, 2, 2, 2, 2, 'We went there yesterday for a friend''s birthday there were 8 of us and what a disappointment, after a very long wait 2 returned their plates which were cold, I had the linguini with porcini, the lukewarm homemade pasta was very thick & al dente just like cardboard, and the porcini (having a very powerful taste) were just covering the pasta just tooo much...good thing their bread was wonderfull it''s what I finished my meal with, definitely not going back!', 0, 11);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (6, '2014-08-07', 5, 5, 5, 5, 5, 'Had dinner on the terasse yesterday. Very nice atmosphere, I liked the small restaurant feel to it. Small menu but hard to choose, everything sounded delicious. All 4 of us ordered something different 3 of them being pizzas and myself ordering fresh and perfectly cooked pasta. It was all wonderful and light. The bread as started was very good too and we also had bruscetta that were divine. Service was as good as the food. Looking forward to going back.', 0, 11);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (7, '2010-07-06', 5, 5, 2, 5, 5, 'Great patio dining. The pasta were good, the pizza''s had crispy,crunchy crust and great flavor. The service was slow, but impecable when at your table side.', 0, 11);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (8, '2013-07-25', 2, 2, 1, 1, 1, 'I base my reviews on if I would go back to a restaurant. the food was not very good. my wife got a "Maguarita" pizza and it was just a plain cheese pizza. My meal was with green spinach noodles that were too large and I had about 12 pieces of garlic in it. not returning.', 0, 11);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (9, '2013-02-15', 5, 5, 5, 5, 5, 'Fantastic food, super fresh and the home made pasta was amazing. Would go back any day.', 0, 11);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (10, '2012-12-14', 1, 1, 1, 1, 1, 'The waiter had an attitude and the food was horrible.', 0, 11);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (11, '2011-05-12', 3, 3, 3, 3, 3, 'I really like the Brado, I have it everytime. Seems though like everything else I`ve tried or the peeps I am with have tried has been meh. It''s hit or miss, but the service and staff are nice.', 0, 11);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (12, '2009-08-28', 2, 2, 2, 2, 2, 'Only 1 good thing on the menu- spinich pasta w/ prawns and it is only nice to eat outside.', 0, 11);

-- ===========================================================================
-- (13) Ace Mercado Reviews = (8)
-- ===========================================================================
INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (13, '2015-03-29', 5, 5, 5, 5, 5, 'Food was awesome. Staff was extremely knowledgeable. One of the guests at our table had a lot of questions and our waitress was able to answer every single one. She knew every item on the menu as well as the drink menu. Very impressed. As we were eating, there was always someone going by to make sure we were taken care of, and this was a busy Saturday night. Once again, great food and excellent service. Definitely going back.', 0, 13);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (14, '2015-01-19', 5, 5, 5, 5, 5, 'My wife and I live nearby and decicded to stop in for a late Sunday supper. We were treated to outstanding service, a BBQ plate that was amazing and excellent cocktails ! Ace is now on our favorite list and we are looking forward to going back.', 0, 13);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (15, '2015-01-15', 1, 1, 1, 1, 1, 'must be getting old found the place noisy, uncomfortable seats, and 5 at a table made for max 4, very cramped. We made the reservations in December for January 10th but that does not guarantee a comfortable seat or decent size table. The saving grace was the food, it was delicious. Thinking we may try a week night not a weekend and do an earlier seating not 7:30 pm. What with all those restrictions won''t be going back soon.', 0, 13);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (16, '2014-10-05', 5, 5, 5, 5, 5, 'The tacos were good, the atmosphere was nice and the service was attentive, which considering the surrounding hell holes, is a big plus. Prices are more or less same as similar restaurants in the market', 0, 13);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (17, '2014-09-17', 5, 5, 5, 5, 5, 'Exceptional cocktail menu!', 0, 13);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (18, '2014-11-08', 5, 5, 5, 5, 5, 'Lovely atmosphere, great tacos and guacamole!!! Victor the waiter was so helpful and knowledgeable when it came to recommending one or two of their fabulous cocktails. Will be going again and again to try more on the menu.', 0, 13);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (19, '2014-09-06', 3, 3, 3, 3, 3, 'Went to Ace last night. The place looks great, service is very good. The food was good not wow but good. The drinks are tasty but expensive - cut back on the ice. Suggestions - for a Mexican restaurant of this price point, in house made nacho chips is expect - not commercial bought. Overall we had a nice evening .. we''ll wait a bit before returning.', 0, 13);

INSERT INTO Rating(UserID, Date_Submitted, Price, Food, Mood, Staff, Overall, Comments, Helpful, RestaurantID)
	VALUES (20, '2014-09-08', 3, 3, 3, 3, 3, 'Food was just ok. Taco tasty with flavour . Main course was very dry the pork and same for the rice no taste in this meal. Now wine list horrible. OMG they need some one to help then with the wine list', 0, 13);

-- ===========================================================================
-- Location Data
-- ===========================================================================

-- ===========================================================================
-- Sens House Sports Bar & Grill
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (1, NULL, NULL, '(613) 241-5434', '73 York St.', '1100', '0200', 1);

-- ===========================================================================
-- Real Sports Bar & Grill
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (2, NULL, NULL, '(613) 680-7325', '90 George St.', '1130', '0200', 2);

-- ===========================================================================
-- Boston Pizza
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (3, NULL, NULL, '(613) 746-1039', '1055 St Laurent Blvd', '1100', '0100', 3);

-- ===========================================================================
-- The Senate Sports Tavern and Eatery
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (4, NULL, NULL, '(613) 695-5523', '33 Clarence St.', '1130', '0200', 4);

-- ===========================================================================
-- Johnny Farina Restaurant
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (5, NULL, NULL, '(613) 565-5155', '216 Elgin St.', '1130', '2200', 5);

-- ===========================================================================
-- Stella Osteria
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (6, NULL, NULL, '(613) 241-2200', '81 Clarence St.', '1130', '0200', 6);

-- ===========================================================================
-- Steak & Sushi
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (7, NULL, NULL, '(613) 695-8787', '87 Clarence St.', '1630', '2300', 7);

-- ===========================================================================
-- Patty Boland''s
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (8, NULL, NULL, '(613) 789-7822', '101 Clarence St.', '1100', '0200', 8);

-- ===========================================================================
-- Heart & Crown
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (9, NULL, NULL, '(613) 562-0674', '67 Clarence St.', '1100', '0200', 9);

-- ===========================================================================
-- Aulde Dubliner & Pour House
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (10, NULL, NULL, '(613) 241-0066', '62 William St.', '1100', '0200', 10);

-- ===========================================================================
-- Mamma Grazzi''s
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (11, NULL, NULL, '(613) 241-8656', '25 George St.', '1130', '2100', 11);

-- ===========================================================================
-- Blue Cactus Bar and Grill
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (12, NULL, NULL, '(613) 241-7061', '2 ByWard Market Square', '1130', '2330', 12);

-- ===========================================================================
-- Ace Mercado
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (13, NULL, NULL, '(613) 627-2353', '121 Clarence St.', '1700', '2400', 13);

-- ===========================================================================
-- Ahora
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (14, NULL, NULL, '(613) 562-2081', '307 Dalhousie St.', '1130', '2200', 14);

-- ===========================================================================
-- Play food & wine
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (15, NULL, NULL, '(613) 667-9207', '1 York St.', '1200', '1400', 15);

-- ===========================================================================
-- Play food & wine
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (16, NULL, NULL, '(613) 667-9207', '1 York St.', '1730', '2300', 15);

-- ===========================================================================
-- Restaurant 18
-- ===========================================================================
INSERT INTO Location(LocationID, First_Open_Date, Manager, Phone_Number, Street_Address, Hour_Open, Hour_Close, RestaurantID) 
	VALUES (17, NULL, NULL, '(613) 244-1188', '18 York St.', '1630', '2400', 16);

-- ==========================================================================
-- TO DO: add constraint upon insertion with the highest number of rating by a specific rater around 10.
-- ==========================================================================