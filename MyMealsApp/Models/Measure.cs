namespace MyMealsApp.Models
{
    public class Measure
    {
        public int Id { get; set; }
        public string? UnitShort { get; set; }
        public string? UnitLong { get; set; }
        public DateTime CreatedDate { get; set; }
      }
}