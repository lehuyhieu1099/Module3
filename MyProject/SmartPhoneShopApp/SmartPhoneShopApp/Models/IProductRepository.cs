using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.Models
{
    public interface IProductRepository
    {
        IEnumerable<Product> Gets();
        Product Get(int id);
        Product Create(Product Product);
        Product Edit(Product Product);
        bool Delete(int id);
    }
}
