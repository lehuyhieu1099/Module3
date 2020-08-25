using System;
using System.Collections.Generic;

namespace SmartMoblieShopApp.Models
{
    public partial class Product
    {
        public Product()
        {
            ShoppingCarts = new HashSet<ShoppingCarts>();
        }

        public int Id { get; set; }
        public string ProductName { get; set; }
        public int CategoryId { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }
        public string Photo { get; set; }

        public virtual Categories Category { get; set; }
        public virtual ICollection<ShoppingCarts> ShoppingCarts { get; set; }
    }
}
