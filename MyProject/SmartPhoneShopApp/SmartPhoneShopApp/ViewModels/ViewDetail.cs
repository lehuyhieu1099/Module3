using SmartPhoneShopApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.ViewModels
{
    public class ViewDetail : Search
    {
        public List<Product> products { get; set; }
        public Product product { get; set; }
    }
}
