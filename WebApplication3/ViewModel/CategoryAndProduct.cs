using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using WebApplication3.Models;

namespace WebApplication3.ViewModel
{
    public class CategoryAndProduct
    {
        public IEnumerable<Category> categories { get; set; }
        public IEnumerable<SubCategory> subCategories { get; set; }
        public IEnumerable<Product> products { get; set; }
        public string UserId { get; set; }
        public DateTime OrderDate { get; set; }
        public Decimal Total { get; set; }
        public int TotalQunt { get; set; }
        public string CustomerName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string PhoneNumber { get; set; }
        public List<OrderProduct> OrderProducts { get; set; }
    }
}