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

    }
}