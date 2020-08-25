using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmartPhoneShopApp.Models
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly AppDbContext context;

        public CategoryRepository(AppDbContext context)
        {
            this.context = context;
        }
        public Category Create(Category cat)
        {
            context.Categories.Add(cat);
            context.SaveChanges();
            return cat;
        }

        public bool Delete(int id)
        {
            var delEmp = context.Products.Find(id);
            if (delEmp != null)
            {
                context.Products.Remove(delEmp);
                return context.SaveChanges() > 0;
            }
            return false;
        }

        public Category Edit(Category category)
        {
            var edit = context.Categories.Attach(category);
            edit.State = EntityState.Modified;
            context.SaveChanges();
            return category;
        }

        public Category Get(int id)
        {
            Category category = context.Categories.Find(id);
            return category;
        }

        public IEnumerable<Category> Gets()
        {
            return context.Categories;
        }
    }
}

