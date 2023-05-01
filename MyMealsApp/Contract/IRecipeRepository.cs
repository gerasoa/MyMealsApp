using MyMealsApp.Models;
using System.Net.Mail;

namespace MyMealsApp.Contract
{
    public interface IRecipeRepository
    {
        public Task<IEnumerable<Recipe>> GetRecipes(int quantity, string? category);
        public Task<Recipe> GetFullRecipe(int id);

        public Task<List<Recipe>> GetRecipePreparationMultipleResults(int id);

        public Task<IEnumerable<Category>> GetCategories();
    }
}
