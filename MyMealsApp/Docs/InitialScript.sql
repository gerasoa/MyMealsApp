use MyMeals1;

CREATE TABLE dbo.Category
(
	ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] varchar(100) NOT NULL,
    CreatedDate DATE 
);

CREATE TABLE dbo.Difficulty
(
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
    [Name] VARCHAR(500),    
    [Description]  VARCHAR(5000),
    [CreatedDate] DATE
);

CREATE TABLE dbo.Recipe
(  
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	CategoryID INTEGER,
    [Name] varchar(100) NOT NULL,  
	ReadyInMinutes INTEGER,
	Servings INTEGER,
	Image varchar(5000),
	[DifficultyID] INTEGER,
	Summary VARCHAR(1000),
	CreatedDate DATE,
	CONSTRAINT FK_Category FOREIGN KEY (CategoryID)
    REFERENCES Category(ID),
    CONSTRAINT FK_Difficulty FOREIGN KEY (DifficultyID)
    REFERENCES Difficulty(ID)
);

--CREATE TABLE dbo.Measure (
--    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
--    UnitShort VARCHAR(10),
--    UnitLong VARCHAR(50),
--    CreatedDate DATE
--);

CREATE TABLE dbo.Ingredient
(  
    ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	RecipeID INTEGER,
    Name VARCHAR(100) NOT NULL,
	createdDate DATE,
	CONSTRAINT FK_Recipe FOREIGN KEY (RecipeID)
    REFERENCES Recipe(ID),
);

--CREATE TABLE dbo.Recipe_Ingredient (
--    RecipeID INT,
--	IngredientID INT,
--    --MeasureID INT,    
--    --Amount DECIMAL,
--    CreatedDate DATE,	
--	CONSTRAINT FK_Recipe FOREIGN KEY (RecipeID)
--    REFERENCES Recipe(ID),
--	CONSTRAINT FK_Ingredient FOREIGN KEY (IngredientID)
--    REFERENCES Ingredient(ID),
--	--CONSTRAINT FK_Measure FOREIGN KEY (MeasureID)
--    --REFERENCES Measure(ID)
--);

CREATE TABLE dbo.Preparation
(
	ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	RecipeID INTEGER,
	OrderNumber INTEGER,
	Step VARCHAR(7000),
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


INSERT INTO category ([Name], [CreatedDate]) VALUES
('Tart', GETDATE()),
('Bread', GETDATE()),
('Slow cooking', GETDATE()),
('Cake', GETDATE()),
('Pasta', GETDATE()),
('healthy', GETDATE()),
('Dessert', GETDATE())

INSERT INTO difficulty ([Name], [Description], [CreatedDate]) VALUES
('Easy', 'These recipes usually require minimal cooking skills and can be prepared quickly. They often have fewer ingredients and basic cooking techniques.', GETDATE()),
('Intermediate', 'These recipes may require more advanced techniques or additional preparation time. They may have more ingredients, require more steps, or involve more complex cooking methods.', GETDATE()),
('Difficult', 'These recipes are the most complex and time-consuming. They may require specialized equipment or advanced cooking techniques. They may also have more ingredients and require multiple steps and stages to prepare.', GETDATE())



INSERT INTO recipe ([CategoryID], [Name], [ReadyInMinutes], [Servings], [Image], [DifficultyID], [Summary], [CreatedDate]) VALUES
(1, 'Cheese & bacon quiche', 25, 8, 'BB683030-D253-4972-9C77-575C132D9E94.webp', 1, 'Make quiche Lorraine to perfection every time with this easy recipe for a crisp pastry base and rich smoked bacon, cheese and thyme filling',  GETDATE()),
(2, 'Cornbread', 15, 6, '8C50402F-96F5-4CB5-AEDD-F7B4B6A556BB.webp', 1, 'Our easy cornbread recipe is a great accompaniment for spicy stews and chillies, or just with a salad for lunch', GETDATE()),
(3, 'Spring salmon with minty veg', 10, 4, '2DFF8AA2-009F-4E1B-8E80-B5B899C1E1D4.webp', 1, 'An easy-to-prepare healthy meal which counts for two of your five-a-day', GETDATE()),
(4, 'Lighter lemon drizzle cake', 65, 12,'8C2F83B4-23AD-4B78-912E-88DBBB1B917D.webp', 1, 'Angela Nilsen gives one of our sites most popular cakes the ultimate healthy makeover by reducing fat', GETDATE()),
(4, 'Rhubarb & custard cake', 20, 16, '64FB50D3-3088-4B85-92B8-9FE7DF53E278.webp', 1, 'his recipe tastes even better with homegrown rhubarb', GETDATE()),
(1, 'Italian broccoli & salmon bake', 30, 4, '1E4DC9C1-0B50-4AE6-B6A3-EF89E759EFF9.webp', 1, 'Take a fresh look at broccoli with this creamy pasta bake', GETDATE()),
(6,'Healthy pesto eggs on toast', 20, 2, 'FDE6A597-27BF-491E-BABC-7B965BFB9AFE.webp', 2, 'Try a speedy, low-fat pesto as a delicious alternative to oil for frying eggs - it adds great flavour to the dish, too, to make a perfect brunch or lunch', GETDATE()),
(7,'Chocolate & orange rice pudding', 40, 6, '853C6C2D-5FBA-47C9-911E-3C7C52749333.webp', 2, 'Treat dinner guests to an indulgent chocolate and orange rice pudding for dessert. Warming and comforting, its a perfect pudding on cold winter days', GETDATE()),
(7, 'Strawberry pavlova', 85, 8, 'DCA526FC-B376-44A6-A050-728EE8BAA925.webp', 1, 'When you find a punnet of perfectly ripe strawberries, showcase them in this irresistible summer pavlova', GETDATE()),
(6, 'Next level scotch eggs', 60, 6, '806D5F36-98A5-4BB8-B909-62E0FB21EC7D.webp', 3, 'Enjoy our next level version of scotch eggs. Forget service station versions – with some tweaks, we ve transformed them into one of the finest portable foods', GETDATE())

INSERT INTO preparation ([RecipeID], [OrderNumber], [Step], [CreatedDate]) VALUES
(1, 1, 'Melt the butter in a large non-stick frying pan, add the onions and cook for 20 mins, stirring now and then, until they are soft and golden brown. Season, stir in the thyme leaves, then transfer to a plate to cool.', GETDATE()),
(1, 2, 'Heat oven to 200C/180C fan/gas 6 with a large baking sheet inside. Roll out the pastry on a lightly floured surface until large enough to line a 25cm loose-bottomed tart tin, with a little overhang of pastry all the way round the top. This will stop the pastry shrinking in the oven later. If there is more overhang than you need, trim off the excess with scissors. Gently press the pastry into the sides of the tin and prick the base with a fork. Chill for 15 mins.', GETDATE()),
(1, 3, 'Line the pastry case with a sheet of baking parchment and fill with ceramic baking beans. Bake for 15 mins on the hot baking sheet (this helps to prevent a soggy bottom). Carefully remove the parchment and beans, then return to the oven for 10 mins more until the pastry looks cooked like shortbread, but is not too brown.', GETDATE()),
(1, 4, 'Meanwhile, put the bacon in the pan you cooked the onions in (there’s no need to wash it first or add any oil) and fry for 10 mins until golden. Lift from the pan onto kitchen paper to remove any excess fat. Beat the cream, milk and eggs with seasoning and nutmeg, then stir in the bacon and half the cheese.', GETDATE()),
(1, 5, 'Remove the pastry case from the oven and reduce heat to 190C/170C fan/gas 5. Spoon the caramelised onions evenly over the base of the pastry case. Pour in the bacon mixture, then scatter with the remaining cheese, the thyme sprigs and a little nutmeg. Bake for 25-30 mins until golden and the filling is just set with a slight wobble in the centre.', GETDATE()),
(1, 6, 'Trim the excess pastry and leave to settle for 10 mins, then remove from the tin and slice.', GETDATE()),
(2, 1, 'Heat oven to 230C/fan 210C/gas 8. Smear some butter all over a 23cm cake tin or ovenproof frying pan. Melt the butter in a separate pan. Tip in the onion and cook over a gentle heat for 5 mins until softened.', GETDATE()),
(2, 2, 'Meanwhile tip all the dry ingredients into a large mixing bowl. Beat together the buttermilk and eggs in a separate bowl, then stir in the buttery onions. Pour over the dry ingredients and mix together until just combined and you have a batter.', GETDATE()),
(2, 3, 'Pour the batter into the cake tin or frying pan and smooth the top with a knife. Bake for 25 mins until golden and a skewer inserted in the centre comes out clean. Cool in the pan for 10 mins, then turn out, cut into wedges and serve. You can make up to 2 days ahead and store in an airtight container, or freeze for up to 1 month.', GETDATE()),
(3, 1,'Boil the potatoes in a large pan for 4 mins. Tip in the peas and beans, bring back up to a boil, then carry on cooking for another 3 mins until the potatoes and beans are tender. Whizz the olive oil, lemon zest and juice and mint in a blender to make a dressing(or finely chop the mint and whisk into the oil and lemon).', GETDATE()),
(3, 2,'Put the salmon in a microwave-proof dish, season, then pour the dressing over. Cover with cling film, pierce, then microwave on High for 4-5 mins until cooked through. Drain the veg, then mix with the hot dressing and cooking juices from the fish. Serve the fish on top of the vegetables.', GETDATE()),
(4, 1, 'Heat oven to 180C/160C fan/gas 4. Lightly oil a 20cm round x 5cm deep cake tin and line the base with baking parchment. For the cake, put the flour, baking powder, ground almonds and polenta in a large mixing bowl. Stir in the lemon zest and sugar, then make a dip in the centre. Beat the eggs in a bowl, then stir in the yogurt. Tip this mixture along with the oil into the dip (see step-by-step number 1), then briefly and gently stir with a large metal spoon so everything is just combined, without overmixing.', GETDATE()),
(4, 2, 'Spoon the mixture into the tin and level the top (step 2). Bake for 40 mins or until a skewer inserted into the centre of the cake comes out clean. Cover loosely with foil for the final 5-10 mins if it starts to brown too quickly.', GETDATE()),
(4, 3, 'While the cake cooks, make the lemon syrup. Tip the caster sugar into a small saucepan with the lemon juice and 75ml water. Heat over a medium heat, stirring occasionally, until the sugar has dissolved. Raise the heat, boil for 4 mins until slightly reduced and syrupy, then remove from the heat.', GETDATE()),
(4, 4, 'Remove the cake from the oven and let it cool briefly in the tin. While it is still warm, turn it out of the tin, peel off the lining paper and sit the cake on a wire rack set over a baking tray or similar. Use a skewer to make lots of small holes all over the top of the cake (step 3). Slowly spoon over half the lemon syrup (step 4) and let it soak in. Spoon over the rest in the same way, brushing the edges and sides of the cake too with the last of the syrup.', GETDATE()),
(5, 1, 'Make the roasted rhubarb first, carefully draining off the juices before you let it cool. Butter and line a 23cm loose-bottomed or springform cake tin. Heat oven to 180C/fan 160C/gas 4', GETDATE()),
(5, 1, 'Reserve 3 tbsp of the custard in a bowl. Beat the rest of the custard together with the butter, flour, baking powder, eggs, vanilla and sugar until creamy and smooth. Spoon one-third of the mix into the tin, add some of the rhubarb, then dot with one-third more cake mix and spread it out as well as you can. Top with some more rhubarb, then spoon over the remaining cake mix, leaving it in rough mounds and dips rather than being too neat about it. Scatter the rest of the rhubarb over the batter, then dot the remaining custard over. Bake for 40 mins until risen and golden, then cover with foil and bake for 15-20 mins more. It’s ready when a skewer inserted into the middle comes out clean. Cool in the tin, then dredge with icing sugar when cool.', GETDATE()),
(6, 1, 'Preheat the oven to 190C/gas 5/fan 170C and get out an ovenproof dish (measuring 20 by 30cm, and about 5cm deep). Meanwhile, put a large pan of water on to boil for the pasta. When it is boiling rapidly, tip in the pasta with a generous sprinkling of salt. Give it a stir, return to the boil and cook for 6 minutes. Add the broccoli, then return the water to the boil and cook for 4 minutes more, until the broccoli is on the firm side of just tender. Drain well.', GETDATE()),
(6, 2, 'While the pasta is cooking, put the butter, flour and milk in a large pan and heat, whisking or stirring continuously, until it thickens to make a smooth sauce. Remove from the heat and stir in the mascarpone, sun-dried tomatoes, capers (if using), anchovies (if using) and basil, then add the pasta and broccoli and season well.', GETDATE()),
(6, 3, 'Halve the salmon fillets widthways (you will see that there is an obvious divide on each fillet) then place the pieces in a single layer on the base of the ovenproof dish. Spoon the broccoli mixture on top, then scatter with the grated cheddar. (You can chill this for up to 4 hours if you want to get ahead.)', GETDATE()),
(6, 3, 'Bake for 30 minutes until the mixture is just starting to bubble round the edges and the mixture is pale golden – don’t let it go too dark or the fish will overcook.', GETDATE()),
(7, 1, 'To make the pesto, peel the garlic clove and put in a small food processor along with the basil, pine nuts, oil and 2 tbsp water. Blitz until smooth, then stir in the cheese. Or, blitz using a hand blender.', GETDATE()),
(7, 2, 'Toast the bread and divide between two plates. Cook the pesto in a frying pan over a medium heat for 30 seconds, stirring. Crack the eggs into one side of the pan, put the tomatoes in the other, and fry in the pesto until the eggs are cooked to your liking.', GETDATE()),
(7, 3, 'Lift out the eggs and put each one on a slice of toast. Add the spinach to the pan with the tomatoes, turn the heat up to high and cook until wilted, about 2-3 mins. The tomatoes should be soft. Spoon the veg onto the other toast slice and sprinkle with the chilli flakes, if you like.', GETDATE()),
(8, 1, 'Put all of the ingredients in a saucepan and bring to a gentle simmer, stirring well to avoid clumping. Cook for 30-40 mins, stirring regularly to avoid burning, until the rice is tender.', GETDATE()),
(8, 2, 'Add a splash more milk and serve hot. Sprinkle with more chocolate and orange zest, if you like.', GETDATE()),
(9, 1, 'Heat oven to 150C/130C fan/gas 2', GETDATE()),
(9, 2, 'Using a pencil, mark out the circumference of a dinner plate on baking parchment.', GETDATE()),
(9, 3, 'Whisk 4 egg whites with a hand mixer until they form stiff peaks, then whisk in 250g caster sugar, 1 tbsp at a time, until the meringue looks glossy.', GETDATE()),
(9, 4, 'Whisk in 1 tsp white wine vinegar, 1 tsp cornflour and 1 tsp vanilla extract.', GETDATE()),
(9, 5, 'Spread the meringue inside the circle, creating a crater by making the sides a little higher than the middle.', GETDATE()),
(9, 6, 'Bake for 1 hr, then turn off the heat and let the Pavlova cool completely inside the oven.', GETDATE()),
(9, 7, 'When the meringue is cool, chop 100g of the hulled strawberries. Mix them with 100g of the redcurrants and 2 tbsp icing sugar.', GETDATE()),
(9, 8, 'Place in a food processor, blitz until smooth, then push the fruit mixture through a sieve.', GETDATE()),
(9, 9, 'Whip 350ml double cream with the remaining 1 tbsp icing sugar and spread it over the meringue. Put the remaining 400g hulled and halved strawberries and 100g redcurrants on the cream and finally pour the sauce over the whole lot.', GETDATE()),
(10, 1, 'Bring a pan of salted water to the boil, carefully drop in the eggs and set a timer for 7 mins. After 7 mins, immediately scoop out the eggs using a slotted spoon and transfer to a bowl of iced water, cracking the shells a little with the spoon as you do (this makes them easier to peel later). Leave to cool completely, then peel and set aside.', GETDATE()),
(10, 2, 'Squeeze the sausagemeat from the skins into a small bowl, add the bacon and mix to combine. For the coating, tip the beaten egg into a shallow container. Combine the flour and mustard powder in a second, and stir together the crushed crisps and panko breadcrumbs in a third.', GETDATE()),
(10, 3, 'Divide the sausage mixture into six rough portions. Lay a sheet of baking parchment on the work surface, then drop a portion of the meat into the middle of the parchment. Top with a second sheet of baking parchment and flatten the meat into a disc using your palm. Remove the top sheet of parchment. Roll one of the eggs in the flour mix, then place in the middle of the sausagemeat disc. Use the parchment to help you wrap the meat around the egg so it’s completely encased, trimming any excess from the top and bottom. Repeat with the rest of the eggs and meat. Dip the sausage-coated eggs back in the flour mix, then the egg, then the crumbs, back into the egg, then finally, in the crumbs again. Can be prepared up to a few hours ahead and chilled until ready to fry.', GETDATE()),
(10, 4, 'Heat a 5cm depth of oil in a wok, wide saucepan or deep-fat fryer until it reaches 160C or until a cube of bread dropped in turns golden in 10 seconds. Lower in as many eggs as you can, being careful not to overcrowd the pan, and fry for 6-8 mins, gently turning until golden and crisp on all sides. Drain on kitchen paper, leave to cool a little, then serve.', GETDATE())

INSERT INTO equipment ([Name], [Image], [CreatedDate]) VALUES
('rolling pin', 'rolling.png', GETDATE()),
('kitchen knife', 'french-knife.png', GETDATE()),
('cutting board', 'cutting-board.png', GETDATE()),
('frying pan', 'frying-pan.png', GETDATE()),
('spatula', 'spatula.png', GETDATE()),
('bowl', 'bowl.png', GETDATE()),
('whisk', 'mixer.png', GETDATE()),
('cutlery', 'cutlery.png', GETDATE()),
('grater', 'grater.png', GETDATE())



INSERT INTO recipe_equipment ([RecipeID], [EquipmentID], [CreatedDate]) VALUES
(1, 1, GETDATE()),
(1, 2, GETDATE()),
(1, 3, GETDATE()),
(1, 4, GETDATE()),
(1, 5, GETDATE()),
(2, 6, GETDATE()),
(2, 5, GETDATE()),
(2, 4, GETDATE()),
(3, 6, GETDATE()),
(3, 8, GETDATE()),
(3, 3, GETDATE()),
(3, 2, GETDATE()),
(4, 6, GETDATE()),
(4, 5, GETDATE()),
(4, 4, GETDATE()),
(5, 5, GETDATE()),
(5, 6, GETDATE()),
(5, 7, GETDATE()),
(5, 8, GETDATE()),
(6, 3, GETDATE()),
(6, 4, GETDATE()),
(6, 5, GETDATE()),
(7, 2, GETDATE()),
(7, 9, GETDATE()),
(7, 6, GETDATE()),
(8, 5, GETDATE()),
(8, 6, GETDATE()),
(9, 3, GETDATE()),
(9, 4, GETDATE()),
(9, 5, GETDATE()),
(10, 3, GETDATE()),
(10, 4, GETDATE()),
(10, 5, GETDATE())

INSERT INTO ingredient ([RecipeID], [Name], [createdDate]) VALUES
(1,'25g butter', GETDATE()),
(1,'2 large onions, halved and thinly sliced', GETDATE()),
(1,'1 tbsp fresh thyme leaves, plus a few sprigs', GETDATE()),
(1,'350g shop-bought shortcrust pastry', GETDATE()),
(1,'plain flour, for dusting', GETDATE()),
(1,'200g pack smoked bacon lardons', GETDATE()),
(1,'300g pot double cream', GETDATE()),
(1,'100ml milk', GETDATE()),
(1,'3 large eggs', GETDATE()),
(1,'2-3 pinches of nutmeg, plus extra for the top', GETDATE()),
(1,'140g mature cheddar, grated', GETDATE()),
(2,'50g butter, plus extra for greasing', GETDATE()),
(2,'1 small onion, finely chopped', GETDATE()),
(2,'225g fine cornmeal', GETDATE()),
(2,'140g plain flour', GETDATE()),
(2,'1 tbsp sugar', GETDATE()),
(2,'2 tsp baking powder', GETDATE()),
(2,'1 ½ tsp salt', GETDATE()),
(2,'2 x 284ml cartons buttermilk (or same quantity semi-skimmed milk with a squeeze of lemon juice)', GETDATE()),
(2,'2 eggs', GETDATE()),
(3,'750g small new potato, thickly sliced', GETDATE()),
(3,'750g frozen pea and beans (we used Waitrose pea and bean mix, £2.29/1kg)', GETDATE()),
(3,'3 tbsp olive oil', GETDATE()),
(3,'zest and juice of 1 lemon', GETDATE()),
(3,'small pack mint, leaves only', GETDATE()),
(3,'4 salmon fillets about 140g/5oz each', GETDATE()),
(4,'75ml rapeseed oil, plus extra for the tin', GETDATE()),
(4,'175g self-raising flour', GETDATE()),
(4,'1 ½ tsp baking powder', GETDATE()),
(4,'50g ground almond', GETDATE()),
(4,'50g polenta', GETDATE()),
(4,'finely grated zest 2 lemons', GETDATE()),
(4,'140g golden caster sugar', GETDATE()),
(4,'2 large eggs', GETDATE()),
(4,'225g natural yogurt', GETDATE()),
(4,'For the lemon syrup', GETDATE()),
(4,'85g caster sugar', GETDATE()),
(4,'juice 2 lemon (about 5 tbsp)', GETDATE()),
(5,'quantity Barneys roasted rhubarb (see recipe, below method)', GETDATE()),
(5,'250g pack butter, softened, plus extra for greasing', GETDATE()),
(5,'150g ready-made custard', GETDATE()),
(5,'250g self-raising flour', GETDATE()),
(5,'½ tsp baking powder', GETDATE()),
(5,'4 large eggs', GETDATE()),
(5,'1 tsp vanilla extract', GETDATE()),
(5,'250g golden caster sugar', GETDATE()),
(5,'icing sugar, for dusting', GETDATE()),
(6, '250g penne', GETDATE()),
(6, '300g broccoli, cut into large florets', GETDATE()),
(6, '25g butter', GETDATE()),
(6, '25g plain flour', GETDATE()),
(6, '600ml milk', GETDATE()),
(6, '100g mascarpone', GETDATE()),
(6, '8 sundried tomatoes (preserved in olive oil), drained and thickly sliced', GETDATE()),
(6, '2 tbsp small capers (optional) rinsed to remove excess salt or vinegar', GETDATE()),
(6, '8 anchovy fillets, halved (optional)', GETDATE()),
(6, '10 large fresh basil leaves, roughly torn', GETDATE()),
(6, '4 fresh skinless salmon fillets', GETDATE()),
(6, '50g mature cheddar, finely grated', GETDATE()),
(7, '2-4 thin slices rye sourdough (about 70g total, depending on the size of the loaf)', GETDATE()),
(7, '2 eggs', GETDATE()),
(7, '170g tomatoes on-the-vine', GETDATE()),
(7, '160g baby spinach', GETDATE()),
(7, 'pinch of chilli flakes (optional)', GETDATE()),
(7, '1 garlic clove (For the pesto)', GETDATE()),
(7, '10g basil (For the pesto)', GETDATE()),
(7, '1 tbsp pine nuts (For the pesto)', GETDATE()),
(7, '1 tbsp rapeseed oil (For the pesto)', GETDATE()),
(7, '1 tbsp finely grated parmesan or vegetarian alternative (For the pesto)', GETDATE()),
(8, '200g short-grain pudding rice', GETDATE()),
(8, '1.4 litres semi-skimmed milk, plus a splash', GETDATE()),
(8, '100g 70% dark chocolate chunks, plus extra to serve', GETDATE()),
(8, '4 tbsp caster sugar', GETDATE()),
(8, '1 tsp orange extract', GETDATE()),
(8, '1 tsp vanilla extract', GETDATE()),
(8, '1 tsp ground cinnamon', GETDATE()),
(8, '1 unwaxed orange, zested, plus extra to serve', GETDATE()),
(9, '4 egg whites (For the meringue)', GETDATE()),
(9, '250g caster sugar (For the meringue)', GETDATE()),
(9, '1 tsp white wine vinegar (For the meringue)', GETDATE()),
(9, '1 tsp cornflour (For the meringue)', GETDATE()),
(9, '1 tsp vanilla extract (For the meringue)', GETDATE()),
(9, '500g strawberries, hulled and halved (For the topping)', GETDATE()),
(9, '200g redcurrants, stalks removed (For the topping)', GETDATE()),
(9, '3 tbsp icing sugar (For the topping)', GETDATE()),
(9, '350ml double cream (For the topping)', GETDATE()),
(10, '6 eggs, at room temperature', GETDATE()),
(10, '5 Cumberland sausages (about 350g)', GETDATE()),
(10, '2 rashers smoked streaky bacon, finely chopped or minced', GETDATE()),
(10, '1 litre sunflower oil, for frying', GETDATE()),
(10, '2 eggs, beaten (For the coating)', GETDATE()),
(10, '100g plain flour (For the coating)', GETDATE()),
(10, '2 tsp English mustard powder (For the coating)', GETDATE()),
(10, '50g packet of salt and vinegar crisps, crushed (For the coating)', GETDATE()),
(10, '100g panko breadcrumbs (For the coating)', GETDATE())


--INSERT INTO recipe_ingredient ([RecipeID], [IngredientID], [CreatedDate]) VALUES
--(1,1, GETDATE()),
--(1,2, GETDATE()),
--(1,3, GETDATE()),
--(1,4, GETDATE()),
--(1,5, GETDATE()),
--(1,6, GETDATE()),
--(1,7, GETDATE()),
--(1,8, GETDATE()),
--(1,9, GETDATE()),
--(1,10,GETDATE()),
--(1,11,GETDATE()),
--(2,12,GETDATE()),
--(2,13,GETDATE()),
--(2,14,GETDATE()),
--(2,15,GETDATE()),
--(2,16,GETDATE()),
--(2,17,GETDATE()),
--(2,18,GETDATE()),
--(2,19,GETDATE()),
--(2,20,GETDATE()),
--(3,21,GETDATE()),
--(3,22,GETDATE()),
--(3,23,GETDATE()),
--(3,24,GETDATE()),
--(3,25,GETDATE()),
--(3,26,GETDATE()),
--(4,27,GETDATE()),
--(4,28,GETDATE()),
--(4,29,GETDATE()),
--(4,30,GETDATE()),
--(4,31,GETDATE()),
--(4,32,GETDATE()),
--(4,33,GETDATE()),
--(4,34,GETDATE()),
--(4,35,GETDATE()),
--(4,36,GETDATE()),
--(4,37,GETDATE()),
--(4,38,GETDATE())