using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.ViewModels
{
    public class CategoryCreateViewModel
    {
        [Required]
        public string CategoryName { get; set; }
        [Required]
        public IFormFile Photo { get; set; }
    }
}
