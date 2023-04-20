---CREATE DATABASE MyMeals;

use MyMeals;

CREATE TABLE dbo.Category
(
	ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] varchar(100) NOT NULL,
    CreatedDate DATE 
);

CREATE TABLE dbo.Recipe
(  
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	CategoryID INTEGER,
    [Name] varchar(100) NOT NULL,  
	ReadyInMinutes INTEGER,
	Servings INTEGER,
	Image varchar(5000),
	Difficulty INTEGER,
	Summary VARCHAR(1000),
	CreatedDate DATE,
	CONSTRAINT FK_Category FOREIGN KEY (CategoryID)
    REFERENCES Category(ID)
);

CREATE TABLE dbo.Measure (
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
    UnitShort VARCHAR(10),
    UnitLong VARCHAR(50),
    CreatedDate DATE
);

CREATE TABLE dbo.Ingredient
(  
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
	UnitShort VARCHAR(20) NOT NULL,
	UnitLong VARCHAR (50) NOT NULL,
	Amount DECIMAL,
	created_date DATE,
);

CREATE TABLE dbo.Recipe_Measure_Ingredient (
    RecipeID INT,
	IngredientID INT,
    MeasureID INT,    
    Amount DECIMAL,
    CreatedDate DATE,	
	CONSTRAINT FK_Recipe FOREIGN KEY (RecipeID)
    REFERENCES Recipe(ID),
	CONSTRAINT FK_Ingredient FOREIGN KEY (IngredientID)
    REFERENCES Ingredient(ID),
	CONSTRAINT FK_Measure FOREIGN KEY (MeasureID)
    REFERENCES Measure(ID)
);

CREATE TABLE dbo.Preparation
(
	ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	RecipeID INTEGER,
	OrderNumber INTEGER,
	Step VARCHAR(7000),
	--TimeNumber INTEGER,-- tempo em unidades: 1, 2, 3 (horas/minutos)
	--TimeUnit VARCHAR(50), -- unidade de medida de tempo - horas, minutos, segundos...
	CreatedDate DATE,
	CONSTRAINT FK_Recipe_Preparation FOREIGN KEY (RecipeID)
    REFERENCES Recipe(ID),
);

CREATE TABLE dbo.Equipment
(
	ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200),
	Image varchar(5000),
	CreatedDate DATE
);

CREATE TABLE dbo.Recipe_Equipment
(
	ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	RecipeID INTEGER,
	EquipmentID INTEGER,
	CreatedDate DATE,	
	CONSTRAINT FK_Recipe_Equipment FOREIGN KEY (RecipeID)
    REFERENCES Recipe(ID),
	CONSTRAINT FK_Equipment_Recipe FOREIGN KEY (EquipmentID)
    REFERENCES Equipment(ID)
);





INSERT INTO  dbo.Measure (UnitShort, UnitLong, CreatedDate)
VALUES
('teaspoon'	, 'tsp', GETDATE()),
('units'	, 'un', GETDATE()),
('tablespoon', 'tbsp', GETDATE()),
('cup', 'c', GETDATE()),
('pint', 'pt', GETDATE()),
('pinch ','pnch ', GETDATE()),
('minute','min', GETDATE()),
('grams','gr', GETDATE()),
('Fahrenheit', 'F', GETDATE()),
('Celsius', 'C',GETDATE())


INSERT INTO dbo.Equipment
([Name],CreatedDate)
VALUES
('frying pan',GETDATE()),
('oven',GETDATE()),
('bowl',GETDATE()),
('pie form',GETDATE()),
('Cutting Board',GETDATE()),
('Can Opener',GETDATE())
;

INSERT INTO [dbo].[Category]
           ([Name]
           ,[CreatedDate])
     VALUES
           ('Breakfast',GETDATE())
		   ,('Brunch',GETDATE())
		   ,('Lunch',GETDATE())
		   ,('Snack',GETDATE())
		   ,('Dinner',GETDATE())
		   ,('Dessert',GETDATE())
		   ,('Appetizer',GETDATE())
		   ,('Side dish',GETDATE())
		   ,('Main course',GETDATE())

GO

INSERT INTO [dbo].[Recipe]
           ([CategoryID]
           ,[Name]
           ,[ReadyInMinutes]
           ,[Servings]
           ,[Image]
           ,[Difficulty]
           ,[Summary]
           ,[CreatedDate])
     VALUES
           (2
           ,'Eggs Benedict'
           ,5
           ,1
           ,'https://marleysmenu.com/wp-content/uploads/2020/07/Smoked-Salmon-Eggs-Benedict-Featured-Image-2.jpg'
           ,1
           ,'Eggs Benedict is a classic American breakfast or brunch dish that consists of two halves of an English muffin, each of which is topped with Canadian bacon or ham, a poached egg, and hollandaise sauce. The dish was popularized in New York City in the late 19th century and is now a staple in many brunch menus.'
           ,GETDATE())
GO

INSERT INTO [dbo].[Ingredient]
           ([Name]
           ,[UnitShort]
           ,[UnitLong]
           ,[Amount]
           ,[created_date])
     VALUES
           ('de vinager', 'tbsp', 'tablespoon', 1, GETDATE())
		   ,('yolks', 'un', 'unit', 2, GETDATE())
		   ,('of water', 'tbsp', 'tablespoons ', 2, GETDATE())
		   ,('of melted butter', 'gr', 'grams', 200, GETDATE())
		   ,('of salt', 'pnch', 'pinch', 1, GETDATE())
		   ,('of black pepper', 'pnch', 'pinch', 2, GETDATE())
		   ,('lemon juice', 'tsp', 'tsp', 2, GETDATE())
GO


INSERT INTO [dbo].[Recipe_Measure_Ingredient]
           ([RecipeID]
           ,[IngredientID]
           ,[MeasureID]
           ,[Amount]
           ,[CreatedDate])
     VALUES
            (1, 1, 1, 1, GETDATE())
		   ,(1, 2, 2, 2, GETDATE())
		   ,(1, 3, 2, 2, GETDATE())
		   ,(1, 4, 8, 200, GETDATE())
		   ,(1, 5, 6, 1, GETDATE())
		   ,(1, 6, 6, 1, GETDATE())
		   ,(1, 7, 1, 1, GETDATE())

GO

INSERT INTO [dbo].[Preparation]
           ([RecipeID]
           ,[OrderNumber]
           ,[Step]
           ,[CreatedDate])
     VALUES
           (1
           ,1
           ,'Em um recipiente, coloque o vinagre com as gemas e a água e bata com um batedor de arame por cerca de 3 minutos, até espumar.'
           ,GETDATE()),

		   (1
           ,2
           ,'In a saucepan, put water for a water bath. As soon as it boils leave the heat low and the steam that drops put the bowl of the yolk mixture and continue beating vigorously.'
           ,GETDATE()),

		   (1
           ,3
           ,'Add the butter in the string. Beat until the sauce thickens. Season with salt, pepper and lemon juice.'
           ,GETDATE()),

		   	(1
           ,4
           ,'In a container, break the egg and set aside.'
           ,GETDATE()),

		   (1
           ,5
           ,'In a saucepan, put 1 liter of water and vinegar and boil.'
           ,GETDATE()),

		   (1
           ,6
           ,'Lower the heat, stir the water until it forms a "swirl" and place the egg in the middle.'
           ,GETDATE()),

		   (1
           ,7
           ,'Cook for 3 minutes. Repeat with the other eggs.'
           ,GETDATE()),

		   (1
           ,8
           ,'On each slice of bread, place a slice of ham, a poché egg and cover with the hollandaise sauce. Serve garnished with parsley and accompanied by salad.'
           ,GETDATE())


GO



INSERT INTO [dbo].[Equipment]
           ([Name]
           ,[Image]
           ,[CreatedDate])
     VALUES
           ('Bowl'
           ,'https://www.receitasnestle.com.br/sites/default/files/srh_recipes/4da63a2205edf324009891b0108fcd82.svg'
           ,GETDATE())

		   ,('Pot'
           ,'https://www.receitasnestle.com.br/sites/default/files/srh_recipes/54c2fea9f8713d9ffa473fe938d278dd.svg'
           ,GETDATE())

		   ,('Wooden spoon'
           ,''
           ,GETDATE())
GO

INSERT INTO [dbo].[Recipe_Equipment]
           ([RecipeID]
           ,[EquipmentID]
           ,[CreatedDate])
     VALUES
           (1, 1 ,GETDATE())
		   ,(1, 2 ,GETDATE())
		   ,(1, 3 ,GETDATE())
GO