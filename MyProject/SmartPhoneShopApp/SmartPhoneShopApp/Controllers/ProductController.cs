using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using SmartPhoneShopApp.Models;
using SmartPhoneShopApp.ViewModels;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.Controllers
{
    public class ProductController : Controller
    {
        private readonly IProductRepository productRepository;
        private readonly ICategoryRepository categoryRepository;
        private readonly IWebHostEnvironment webHostEnvironment;
        private readonly AppDbContext appDbContext;

        public ProductController(IProductRepository productRepository,
                               IWebHostEnvironment webHostEnvironment,
                               AppDbContext appDbContext)
        {
            this.productRepository = productRepository;
            this.webHostEnvironment = webHostEnvironment;
            this.appDbContext = appDbContext;
        }
        public IActionResult Index()
        {
            List<Product> products = productRepository.Gets().ToList();
            return View(products);
        }

        [HttpGet]
        public ViewResult Create()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create(HomeCreateViewModel model)
        {
            if (ModelState.IsValid)
            {
                var product = new Product()
                {
                    Name = model.Name,
                    Price = model.Price,
                    CategoryId = model.CategoryId,
         
                };
                appDbContext.Add(product);
                await appDbContext.SaveChangesAsync();
                //var fileName = string.Empty;
                //if (model.Photo != null)
                //{
                //    string uploadFolder = Path.Combine(webHostEnvironment.WebRootPath, "images");
                //    fileName = $"{Guid.NewGuid()}_{model.Photo.FileName}";
                //    var filePath = Path.Combine(uploadFolder, fileName);
                //    using (var fs = new FileStream(filePath, FileMode.Create))
                //    {
                //        model.Photo.CopyTo(fs);
                //    }
                //}
                //product.Photo = fileName;
                //var newPro = productRepository.Create(product);
                //return RedirectToAction("Index", new { id = newPro.Id });
            }
            return View();
        }

        [HttpGet]
        public IActionResult Edit(int id)
        {
            var product = productRepository.Get(id);
            if (product == null)
            {
                ViewBag.Id = id;
                return View("~/Views/Error/ProductNotFound.cshtml");
            }
            if (product != null)
            {
                var editPro = new HomeEditViewModel()
                {
                    Name = product.Name,
                    Trademark = product.Trademark,
                    Description = product.Description,
                    Price = product.Price,
                    CategoryId = product.CategoryId,
                    PhotoPath = product.Photo
                };
                return View(editPro);
            }
            return View();
        }


        [HttpPost]
        public IActionResult Edit(HomeEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                var product = new Product()
                {
                    Name = model.Name,
                    Trademark = model.Trademark,
                    Description = model.Description,
                    Price = model.Price,
                    CategoryId = model.CategoryId,
                    KeySearch = $"{model.Name.ToLower()} {model.Description.ToLower()} {model.Trademark.ToLower()}" +
                    $" {categoryRepository.Get(model.CategoryId).CategoryName.ToLower()}"
                };
                var fileName = string.Empty;
                if (model.Photo != null)
                {
                    string uploadFolder = Path.Combine(webHostEnvironment.WebRootPath, "images/balos");
                    fileName = $"{Guid.NewGuid()}_{model.Photo.FileName}";
                    var filePath = Path.Combine(uploadFolder, fileName);
                    using (var fs = new FileStream(filePath, FileMode.Create))
                    {
                        model.Photo.CopyTo(fs);
                    }
                    product.Photo = fileName;
                    if (!string.IsNullOrEmpty(model.PhotoPath))
                    {
                        string delFile = Path.Combine(webHostEnvironment.WebRootPath,
                                            "images/balos", model.PhotoPath);
                        System.IO.File.Delete(delFile);
                    }
                }
                else
                {
                    fileName = model.PhotoPath;
                }
                product.Photo = fileName;
                var editPro = productRepository.Edit(product);
                if (editPro != null)
                {
                    return RedirectToAction("Details", new { id = product.Id });
                }

            }
            return View();
        }
        public IActionResult Delete(int id)
        {
            var product = productRepository.Get(id);
            if (product == null)
            {
                ViewBag.Id = id;
                return View("~/Views/Error/ProductNotFound.cshtml");
            }
            if (product != null)
            {
                productRepository.Delete(id);
                string delFile = Path.Combine(webHostEnvironment.WebRootPath,
                                           "images/balos", product.Photo);
                System.IO.File.Delete(delFile);
                return RedirectToAction("Index", "ProductsManage");
            }
            return View();
        }

    }
}
