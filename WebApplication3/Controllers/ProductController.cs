using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication3.Models;

namespace WebApplication3.Controllers
{
    public class ProductController : Controller
    {

        private RotanaContext db = new RotanaContext();

        // GET: Product
        public ActionResult Index()
        {
            return View();
        }

        //GET add product
        public ActionResult Add()
        {
            
            PopulateSubCategoriesDropDownList();
            return View();
        }

        //Add Product
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Add([Bind(Include = "Id,SubCatId,Name,Price,Quantity,Other,Description,Image,BarCode")]Product product)
        {

            PopulateSubCategoriesDropDownList(product.SubCatId);
            HttpPostedFileBase file = Request.Files["ImageData"];
            try
            {
                int i = myProduct(file, product);
                if (i == 1)
                {

                    return RedirectToAction("Add");
                }

            }
            catch
            {
                ModelState.AddModelError("", "Unable to add product. Try again, and if the problem persists, see your system administrator.");
            }
            return View(product);
        }

        public int myProduct(HttpPostedFileBase file, Product product)
        {
            

                product.Image = ConvertToBytes(file);
                //contentViewModel.UserId = User.Identity.GetUserId();
                
                var Product = new Product
                {

                    
                    SubCatId = product.SubCatId,
                    Name = product.Name,
                    Price = product.Price,
                    Quantity = product.Quantity,
                    Other = product.Other,
                    Description = product.Description,
                    Image = product.Image,
                    BarCode = product.BarCode
                };


                db.Products.Add(Product);
                int i = db.SaveChanges();


                if (i == 1)
                {
                    return Product.Id;
                }
                else
                {
                    return 0;
                }
           

            return 0;

        }

        public byte[] ConvertToBytes(HttpPostedFileBase image)
        {
            byte[] imageBytes = null;
            BinaryReader reader = new BinaryReader(image.InputStream);
            imageBytes = reader.ReadBytes((int)image.ContentLength);
            return imageBytes;
        }

        [HttpGet]
        public ActionResult AddCategory()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddCategory([Bind(Include = "Id,Name,Description")]Category category)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.Categories.Add(category);
                    db.SaveChanges();
                    return RedirectToAction("AddCategory");
                }
            }
            catch
            {
                ModelState.AddModelError("", "Unable to add category. Try again, and if the problem persists, see your system administrator.");
            }


            return View(category);
        }

        public ActionResult AddSubCategory()
        {

            PopulateCategoriesDropDownList();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddSubCategory([Bind(Include = "Id,CatId,Name,Description")]SubCategory subCat)
        {
            PopulateCategoriesDropDownList(subCat.CatId);
            try
            {
                if (ModelState.IsValid)
                {
                    db.SubCategories.Add(subCat);
                    db.SaveChanges();
                    return RedirectToAction("AddSubCategory");
                }
            }
            catch
            {
                ModelState.AddModelError("", "Unable to add subcategory. Try again, and if the problem persists, see your system administrator.");
            }

            return View(subCat);
        }

        private void PopulateCategoriesDropDownList(object selectedCategory = null)
        {
            var categoryQuery = from w in db.Categories
                              orderby w.Name
                              select w;
            ViewBag.CatId = new SelectList(categoryQuery, "Id", "Name", selectedCategory);
        }

        private void PopulateSubCategoriesDropDownList(object selectedSubCat = null)
        {
            var subCatQuery = from w in db.SubCategories
                              orderby w.Name
                              select w;
            ViewBag.SubCatId = new SelectList(subCatQuery, "Id", "Name", selectedSubCat);
        }
    }
}