using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using EmployeeManagement.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.VisualBasic;

namespace EmployeeManagement.ViewModels
{
    public class HomeCreateViewModel
    {
        [Required(ErrorMessage ="Tên không được để trống")]
        [MaxLength(20, ErrorMessage = "Can not exceed 20 characters")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Email không được để trống")]
        [Display(Name = "Office Email")]
        [RegularExpression(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$",
            ErrorMessage = "Invalid email format")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Không được để trống")]
        public Dept? Department { get; set; }
        public IFormFile Avatar { get; set; }
    }
}
