using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProductManagement.Models
{
    public class Product
    {
        public int ProductID { get; set; }

        public string NameOfProduct { get; set; }

        public int CategoryOfProductID { get; set; }
    }
}
