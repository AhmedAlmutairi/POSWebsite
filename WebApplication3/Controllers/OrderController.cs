using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication3.Models;
using WebApplication3.ViewModel;

namespace WebApplication3.Controllers
{
    public class OrderController : Controller
    {

        private RotanaContext db = new RotanaContext();

        // GET: Order
        public ActionResult Index()
        {
            CategoryAndProduct catAndProduct = new CategoryAndProduct();

            catAndProduct.categories = db.Categories.ToList();
            return View(catAndProduct);
        }

       // [HttpGet]
        public ActionResult GetSubCategory(int data)
        {
            CategoryAndProduct subcat = new CategoryAndProduct();
            subcat.subCategories = db.SubCategories.Where(x => x.CatId == data).ToList(); 

            return PartialView("_GetSubCategory", subcat);
        }

        public ActionResult GetProduct(int data)
        {
            CategoryAndProduct prod = new CategoryAndProduct();
            prod.products = db.Products.Where(x => x.SubCatId == data).ToList();

            return PartialView("_GetProduct", prod);
        }

        public JsonResult GetData(int id)
        {
            // This returned data is a sample. You should get it using some logic
            // This can be an object or an anonymous object like this:
            var returnedData = db.Products.Select(x => new {Id = x.Id, Price= x.Price, Name = x.Name }).Where(x => x.Id == id);

            return Json(returnedData, JsonRequestBehavior.AllowGet);
        }


    }
}