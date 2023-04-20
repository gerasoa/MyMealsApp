namespace MyMealsApp.Models
{
    public class Ingredient
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Amount { get; set; }
        public DateTime CreatedDate { get; set; }

        public Measure Measure { get; set; }
    }
}