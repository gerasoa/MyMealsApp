using MyMealsApp.Models;
using System.Net.Mail;

namespace MyMealsApp.Contract
{
    public interface IRecipeRepository
    {
        public Task<IEnumerable<Recipe>> GetRecipes(int quantity);
        public Task<Recipe> GetFullRecipe(int quantiidty);

        public Task<List<Recipe>> GetRecipePreparationMultipleResults(int id);
    }
}
