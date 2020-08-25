using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.ViewModels
{
    public class CategoryEditViewModel
    {
        public int CategoryId { get; set; }
        [Required]
        public string CategoryName { get; set; }
        public IFormFile Photo { get; set; }
    }
}
