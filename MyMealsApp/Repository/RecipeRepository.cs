using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;
using MyMealsApp.Context;
using MyMealsApp.Contract;
using MyMealsApp.Models;
using System.ComponentModel;
using System.Diagnostics;
using System.Diagnostics.Metrics;
using System.Net.Mail;
using System.Security.Cryptography;

namespace MyMealsApp.Repository
{
    public class RecipeRepository : IRecipeRepository
    {
        private readonly DapperContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public RecipeRepository(DapperContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<IEnumerable<Recipe>> GetRecipes(int quantity)
        {
            var query = @"SELECT TOP (@quantity) *	                    
                        FROM recipe r
                        INNER JOIN category c ON r.categoryID = c.ID
                        INNER JOIN difficulty d ON r.difficultyID = d.ID";
            var recipeDict = new Dictionary<int, Recipe>();
            using (var connection = _context.CreateConnection())
            {
                var recipes = await connection.QueryAsync<Recipe, Category, Difficulty, Recipe>(
                    query, (recipe, category, difficult) =>                        
                    {
                        var img = GetHost() + recipe.Image;
                        recipe.Image = img;

                        if (!recipeDict.TryGetValue(recipe.Id, out var currentRecipe))
                        {
                            currentRecipe = recipe;
                            currentRecipe.Category = new Category();
                            currentRecipe.Difficulty = new Difficulty();
                            recipeDict.Add(currentRecipe.Id, currentRecipe);
                        }
                        currentRecipe.Category = category;
                        currentRecipe.Difficulty = difficult;

                        return currentRecipe;
                    }, 
                    new { quantity });

                return recipes.ToList();
            }
        }
        
        public async Task<Recipe> GetFullRecipe(int id)
        {
            var query = @"SELECT * FROM recipe r WHERE id = @Id";
            var recipeDict = new Dictionary<int, Recipe>();
            using (var connection = _context.CreateConnection())
            {
                var recipe = await connection.QueryFirstAsync<Recipe>(query, new { id });

                var img = GetHost() + recipe.Image;
                recipe.Image = img;

                recipe.Preparations.AddRange(await GetPreparation(id));
                recipe.Ingredients.AddRange(await GetIngredients(id));
                recipe.Category =  await GetCategory(id);
                recipe.Difficulty = await GetDifficulty(id);

                return recipe;
            }
        }

        //todo: check the best way to create this host and apply this method
        private string GetHost()
        {            
            var host = _httpContextAccessor.HttpContext?.Request.Host;
            string imageHost = "https://" + host + "/images/";

            return imageHost; 
        }

        private async Task<Category> GetCategory(int recipeId)
        {
            var query = @"SELECT c.* FROM recipe r 
                        INNER JOIN category c ON r.CategoryId = c.ID 
                        WHERE r.Id = @recipeId ";
            using (var connection = _context.CreateConnection())
            {
                var category = await connection.QueryFirstAsync<Category>(query, new { recipeId });

                return category;
            }            
        }

        private async Task<Difficulty> GetDifficulty(int recipeId)
        {
            var query = @"SELECT d.* FROM recipe r 
                        INNER JOIN difficulty d ON r.difficultyId = d.ID 
                        WHERE r.Id = @recipeId ";
            using (var connection = _context.CreateConnection())
            {
                var difficulty = await connection.QueryFirstAsync<Difficulty>(query, new { recipeId });

                return difficulty;
            }
        }

        private async Task<List<Preparation>> GetPreparation(int recipeId)
        {
            var query = "SELECT * FROM preparation WHERE recipeId = @recipeId";

            using (var connection = _context.CreateConnection())
            {
                var steps = await connection.QueryAsync<Preparation>(query, new { recipeId });

                return steps.ToList();
            }           
        }

        private async Task<List<Ingredient>> GetIngredients(int recipeId)
        {
            var query = @"SELECT * FROM ingredient i
                          INNER JOIN recipe r ON r.Id = i.recipeId 
                          WHERE r.Id = @recipeId";

            using (var connection = _context.CreateConnection())
            {
                var steps = await connection.QueryAsync<Ingredient>(query, new { recipeId });

                return steps.ToList();
            }
        }
                

        //todo: tem que refazer isso aqui
        public async Task<List<Recipe>> GetRecipePreparationMultipleResults(int id)
        {
            throw new Exception("This feature is currently under development and will be available soon.");

            var query = "SELECT rmi.recipeid, rmi.ingredientId, r.*, i.* " +
                        "FROM  recipe_ingredient rmi  " +
                        "INNER JOIN recipe r ON r.id = rmi.recipeid " +
                        "INNER JOIN ingredient i ON rmi.ingredientId = i.id " +
                        "WHERE r.id = @Id";

            //using (var connection = _context.CreateConnection())
            //{
            //    var recipe = await connection.QueryAsync<Recipe, Ingredient, Measure, Recipe>(query, (recipe, ingredient, measure) =>
            //    {

            //        ingredient.Measure = measure;
            //        recipe.Ingredients.Add(ingredient);

            //        return recipe;
            //    },
            //    new { id }
            //    ); ;

            //    return recipe.Distinct().ToList();
            //}



            using (var connection = _context.CreateConnection())
            {
                var recipeDict = new Dictionary<int, Recipe>();
                var ingredientDict = new Dictionary<int, Ingredient>();
               // var measureDict = new Dictionary<int, Measure>();

                var recipes = await connection.QueryAsync<Recipe, Ingredient, Measure, Recipe>(
                    query, (recipe, ingredient, measure) =>
                    {
                        if (!recipeDict.TryGetValue(recipe.Id, out var currentRecipe))
                        {
                            currentRecipe = recipe;
                            currentRecipe.Ingredients = new List<Ingredient>();
                            recipeDict.Add(currentRecipe.Id, currentRecipe);
                        }

                        if (!ingredientDict.TryGetValue(ingredient.Id, out var currentIngredient))
                        {
                            currentIngredient = ingredient;
                            //currentIngredient.Measure = new Measure();
                            ingredientDict.Add(currentIngredient.Id, currentIngredient);
                        }

                        //if (!measureDict.TryGetValue(measure.Id, out var currentMeasure))
                        //{
                        //    currentMeasure = measure;
                        //    measureDict.Add(currentMeasure.Id, currentMeasure);
                        //}
                        //currentIngredient.Measure = currentMeasure;
                        currentRecipe.Ingredients.Add(currentIngredient);

                        return currentRecipe;
                    },
                    new { id },
                    splitOn: "ingredientId");

                return recipes.Distinct().ToList();
            }
        }

    }
}
