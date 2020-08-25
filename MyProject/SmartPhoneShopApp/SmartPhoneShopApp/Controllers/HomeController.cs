using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SmartPhoneShopApp.Models;
using SmartPhoneShopApp.ViewModels;

namespace SmartPhoneShopApp.Controllers
{
    public class HomeController : Controller
    {
        private IProductRepository productRepository;
        private readonly IWebHostEnvironment webHostEnvironment;

        public HomeController(IProductRepository productRepository,
                            IWebHostEnvironment webHostEnvironment)
        {
            this.productRepository = productRepository;
            this.webHostEnvironment = webHostEnvironment;
        }
        public IActionResult Index()
        {
            var products = productRepository.Gets();
            return View(products);
        }
        public IActionResult Details(int? id)
        {
            try
            {
                int.Parse(id.Value.ToString());
                var product = productRepository.Get(id.Value);
                if (product == null)
                {
                    return View("~/Views/Error/EmployeeNotFound.cshtml", id.Value);
                }
                var detailViewModel = new HomeView()
                {
                    product = productRepository.Get(id ?? 1),
                };
                return View(detailViewModel);
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        [HttpPost]
        public IActionResult Search(HomeView model)
        {
            if (model.key == null)
            {
                return RedirectToAction("Index", "Home");
            }
            List<Product> _products = (from pd in productRepository.Gets() where pd.KeySearch.Contains(model.key.ToLower()) select pd).ToList();
            
            var _model = new HomeView()
            {
                products = _products,
            };
            return View(_model);
        }



    }
}
