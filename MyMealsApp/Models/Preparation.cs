namespace MyMealsApp.Models
{
    public class Preparation
    {
        public int Id { get; set; }
        public int RecipeID { get; set; }
        public int OrderNumber { get; set; }
        public String Step { get; set; }
        public DateTime CreatedDate { get; set; }

    }
}


