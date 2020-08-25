using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using test.Models;
using test.ViewModel;

namespace test.Controllers
{
    public class ProductController : Controller
    {
        private readonly IWebHostEnvironment webHostEnvironment;
        private readonly TestContext appDbContext;

        public ProductController(
                               IWebHostEnvironment webHostEnvironment,
                               TestContext appDbContext)
        { 
            this.webHostEnvironment = webHostEnvironment;
            this.appDbContext = appDbContext;
        }
        public IActionResult Index()
        {
            List<Product> products = appDbContext.Products.ToList();
            return View(products);
        }
        [Authorize]
        [HttpGet]
        public ViewResult Create()
        {
            return View();
        }
        [Authorize]
        [HttpPost]
        public async Task<IActionResult> Create(ProductCreateViewModel model)
        {
            if (ModelState.IsValid)
            {
                var product = new Product()
                {
                    ProductName = model.ProductName,
                    Price = model.Price,
                    CategoryId = model.CategoryId,
                };
                product.Photo = UploadedFile(model);
                appDbContext.Add(product);
                await appDbContext.SaveChangesAsync();
            }
            return View();
        }
        private string UploadedFile(ProductCreateViewModel model)
        {
            string uniqueFileName = null;

            if (model.Image != null)
            {
                string uploadsFolder = Path.Combine(webHostEnvironment.WebRootPath, "images");
                uniqueFileName = Guid.NewGuid().ToString() + "_" + model.Image.FileName;
                string filePath = Path.Combine(uploadsFolder, uniqueFileName);
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    model.Image.CopyTo(fileStream);
                }
            }
            return uniqueFileName;
        }
    }
}
