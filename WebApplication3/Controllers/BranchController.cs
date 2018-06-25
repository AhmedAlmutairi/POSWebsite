using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication3.Models;

namespace WebApplication3.Controllers
{
    public class BranchController : Controller
    {

        private RotanaContext db = new RotanaContext();

        // GET: Branch
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name,Address,City,PhoneNumber")]Branch branch)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.Branches.Add(branch);
                    db.SaveChanges();
                    return RedirectToAction("Create");
                }
            }
            catch
            {
                ModelState.AddModelError("", "Unable to save changes. Try again, and if the problem persists, see your system administrator.");
            }
        

            return View(branch);
        }
    }
}