﻿using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.ViewModels
{
    public class HomeCreateViewModel
    {
        [Required]
        public string Name { get; set; }
        
        public IFormFile Photo { get; set; }
       
        public string Trademark { get; set; }
        
        public string Description { get; set; }
        [Required]
        public int CategoryId { get; set; }
        [Required]
        public float Price { get; set; }  
    }
}
