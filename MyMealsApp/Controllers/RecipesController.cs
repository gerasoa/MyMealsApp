﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MyMealsApp.Contract;

namespace MyMealsApp.Controllers
{
    [Route("api/Recipes")]
    [ApiController]
    public class RecipesController : ControllerBase
    {
        private readonly IRecipeRepository _recipeRepository;
        public RecipesController(IRecipeRepository recipeRepository) => _recipeRepository = recipeRepository;

        [HttpGet]
        public async Task<IActionResult> GetCompanies(int quantity, string? category)
        {
            var recipes = await _recipeRepository.GetRecipes(quantity, category);

            return Ok(recipes);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetFullRecipe(int id)
        {
            var recipes = await _recipeRepository.GetFullRecipe(id);

            return Ok(recipes);
        }

        [HttpGet("Categories")]
        public async Task<IActionResult> GetCategories()
        {
            var categories = await _recipeRepository.GetCategories();

            return Ok(categories);
        }

        [HttpGet("{id}/MultipleResult")]
        public async Task<IActionResult> GetCompanyEmployeesMultipleResult(int id)
        {
            try
            {
                var recipe = await _recipeRepository.GetRecipePreparationMultipleResults(id);
                if (recipe == null)
                    return NotFound();
                return Ok(recipe);
            }
            catch (Exception ex)
            {
                //log error
                return StatusCode(500, ex.Message);
            }
        }
    }
}
