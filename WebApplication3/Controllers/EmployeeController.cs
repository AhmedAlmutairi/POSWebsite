using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication3.Models;

namespace WebApplication3.Controllers
{
    public class EmployeeController : Controller
    {
        private RotanaContext db = new RotanaContext();

        // GET: Employee
        public ActionResult Index()
        {
            return View();
        }

        
        public ActionResult Create()
        {

            PopulateBranchesDropDownList();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,BranchId,DateStart,DateEnd,Name,Address,City,PhoneNumber")]Employee employee)
        {
            PopulateBranchesDropDownList(employee.BranchId);
            try
            {
            if (ModelState.IsValid)
             {
            db.Employees.Add(employee);
                    db.SaveChanges();
                    return RedirectToAction("Create");
                }
            }
            catch
            {
                ModelState.AddModelError("", "Unable to save changes. Try again, and if the problem persists, see your system administrator.");
            }
            
            return View(employee);
        }

        private void PopulateBranchesDropDownList(object selectedBranch = null)
        {
            var branchQuery = from w in db.Branches
                              orderby w.Name
                              select w;
            ViewBag.BranchId = new SelectList(branchQuery, "Id", "Name", selectedBranch);
        }


    }
}