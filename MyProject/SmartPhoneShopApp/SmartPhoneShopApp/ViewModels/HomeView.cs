using SmartPhoneShopApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.ViewModels
{
    public class HomeView : Search
    {
        public Product product { get; set; }
        public List<Product> products { get; set; }
    }
}
