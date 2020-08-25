using System;
using System.Collections.Generic;

namespace SmartMoblieShopApp.Models
{
    public partial class Categories
    {
        public int Id { get; set; }
        public string CategoryName { get; set; }

        public virtual List<Product> Product { get; set; }
    }
}
