using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RegisterForm.Models
{
    public class RegisterContext : IdentityDbContext
    {
        public RegisterContext(DbContextOptions<RegisterContext> options)
           : base(options)
        {
        }
        public virtual DbSet<ApplycationUser> Categories
        {
            get; set;


        }
    }
}
