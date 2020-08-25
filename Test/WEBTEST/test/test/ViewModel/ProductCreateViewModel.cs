using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using test.Models;

namespace test.ViewModel
{
    public class ProductCreateViewModel : Product
    {
        public IFormFile Image { get; set; }
    }
}
