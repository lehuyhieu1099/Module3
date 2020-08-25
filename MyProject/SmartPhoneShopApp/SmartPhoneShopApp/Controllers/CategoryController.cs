using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using SmartPhoneShopApp.Models;
using SmartPhoneShopApp.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.Controllers
{
    public class CategoryController : Controller
    {
        private readonly IWebHostEnvironment webHostEnvironment;
        private readonly ICategoryRepository categoryRepository;
        public IProductRepository productRepository { get; }
        public CategoryController(IWebHostEnvironment webHostEnvironment,
            IProductRepository productRepository,
            ICategoryRepository categoryRepository)
        {
            this.webHostEnvironment = webHostEnvironment;
            this.productRepository = productRepository;
            this.categoryRepository = categoryRepository;
        }
        public IActionResult Index()
        {
            var Categories = categoryRepository.Gets();
            return View(Categories);
        }
        public ViewResult Create()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Create(CategoryCreateViewModel model)
        {
            if (ModelState.IsValid)
            {
                var category = new Category()
                {
                    CategoryName = model.CategoryName
                };
                var newCat = categoryRepository.Create(category);
                ViewBag.Categories = categoryRepository.Gets();
                return RedirectToAction("Index", "Category");
            }
            ViewBag.Categories = categoryRepository.Gets();
            return View();
        }
        public ViewResult Edit(int id)
        {
            var category = categoryRepository.Get(id);
            if (category == null)
            {
                return View("~/Views/Error/CategoryNotFound.cshtml", id);
            }
            var editCat = new CategoryEditViewModel()
            {
                CategoryName = category.CategoryName
            };
            return View(editCat);
        }
        public IActionResult Delete(int id)
        {
            Category category = categoryRepository.Get(id);
            if (category == null)
            {
                ViewBag.Id = id;
                return View("~/Views/Error/CategoryNotFound.cshtml");
            }
            if (category != null)
            {
                var result = categoryRepository.Delete(id);
                return RedirectToAction("Index", "Category");
            }
            return View();
        }

    }

}
