using Dapper;
using Microsoft.Extensions.Hosting;
using MyMealsApp.Context;
using MyMealsApp.Contract;
using MyMealsApp.Models;
using System.Diagnostics.Metrics;
using System.Net.Mail;

namespace MyMealsApp.Repository
{
    public class RecipeRepository : IRecipeRepository
    {
        private readonly DapperContext _context;
        public RecipeRepository(DapperContext context) => _context = context;       

        public async Task<IEnumerable<Recipe>> GetRecipes(int quantity)
        {
            var query = "SELECT TOP (@quantity) id, name, difficulty, categoryID, readyInMinutes FROM recipe";

            using (var connection = _context.CreateConnection())
            {
                var recipes = await connection.QueryAsync<Recipe>(query, new { quantity });

                return recipes.ToList();
            }
        }
        
        public async Task<Recipe> GetFullRecipe(int id)
        {
            var query = "SELECT * FROM recipe WHERE id = @Id";

            using (var connection = _context.CreateConnection())
            {
                var recipe = await connection.QuerySingleOrDefaultAsync<Recipe>(query, new { id });

                recipe.Preparations.AddRange(await GetPreparation(id));
                recipe.Ingredients.AddRange(await GetIngredients(id));

                return recipe;
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
            var query = @"SELECT * FROM recipe_measure_ingredient rmi
                            INNER JOIN ingredient i ON rmi.ingredientId = i.id 
                            INNER JOIN measure m ON rmi.measureId = m.id 
                            WHERE rmi.RecipeID = @recipeId";
            
            using (var connection = _context.CreateConnection())
            {
                //comeca aqui
                var ingredientDict = new Dictionary<int, Ingredient>();

                var ingredients = await connection.QueryAsync<Ingredient, Measure, Ingredient>(query,(ingredient, measure) => { 
                    if(!ingredientDict.TryGetValue(ingredient.Id, out var currentIngredient))
                    {
                        currentIngredient = ingredient;
                        ingredientDict.Add(currentIngredient.Id, currentIngredient);
                    }
                    currentIngredient.Measure = measure;
                    return currentIngredient;

                }, new { recipeId });

                return ingredients.ToList();
            }
        }

        //todo: tem que refazer isso aqui
        public async Task<List<Recipe>> GetRecipePreparationMultipleResults(int id)
        {
            var query = "SELECT rmi.recipeid, rmi.ingredientId, rmi.measureId , r.*, i.*, m.* " +
                        "FROM  recipe_measure_ingredient rmi  " +
                        "INNER JOIN recipe r ON r.id = rmi.recipeid " +
                        "INNER JOIN ingredient i ON rmi.ingredientId = i.id " +
                        "INNER JOIN measure m ON rmi.measureId = m.id " +
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
                var measureDict = new Dictionary<int, Measure>();

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
                            currentIngredient.Measure = new Measure();
                            ingredientDict.Add(currentIngredient.Id, currentIngredient);
                        }

                        if (!measureDict.TryGetValue(measure.Id, out var currentMeasure))
                        {
                            currentMeasure = measure;
                            measureDict.Add(currentMeasure.Id, currentMeasure);
                        }
                        currentIngredient.Measure = currentMeasure;
                        currentRecipe.Ingredients.Add(currentIngredient);

                        return currentRecipe;
                    },
                    new { id },
                    splitOn: "name, amount");

                return recipes.Distinct().ToList();
            }
        }

    }
}
