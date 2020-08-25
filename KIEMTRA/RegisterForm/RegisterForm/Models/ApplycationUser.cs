using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RegisterForm.Models
{
    public class ApplycationUser : IdentityUser
    {
        [Required]
        public string FullName { get; set; }  
        [Required]
        [DataType(DataType.Password)]
        [MinLength(6)]
        public string Password { get; set; }
        [Required]
        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "Confirm password not match")]
        public string ConfirmPassword { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
    }
}
