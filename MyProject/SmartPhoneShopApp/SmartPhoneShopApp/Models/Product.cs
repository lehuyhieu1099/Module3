using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.Models
{
    public class Product
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string Photo { get; set; }
        [Required]
        public string Trademark { get; set; }
        [Required]
        public string Description { get; set; }
        public int CategoryId { get; set; }
        public Category Category { get; set; }
        [Required]
        public float Sale { get; set; }
        [Required]
        public float Price { get; set; }
        public string KeySearch { get; set; }

    }
}
