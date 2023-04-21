namespace MyMealsApp.Models
{
    public class Recipe
    {
        public int Id { get; set; }
        public Category Category { get; set; }
        public string Name { get; set; }
        public int ReadyInMinutes { get; set; }
        public int Servings { get; set; }
        public string? Image { get; set; }
        public Difficulty Difficulty { get; set; }
        public string? Summary { get; set; }
        public DateTime CreatedDate { get; set; }

        public List<Preparation> Preparations { get; set; } = new List<Preparation>();
        public List<Ingredient> Ingredients { get; set; } = new List<Ingredient>();
        
    }
}
