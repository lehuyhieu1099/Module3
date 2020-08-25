using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.Models
{
    public interface ICategoryRepository
    {
        IEnumerable<Category> Gets();
        Category Get(int id);
        Category Edit(Category category);
        Category Create(Category cate);
        bool Delete(int id);
    }
}
