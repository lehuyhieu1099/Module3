using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeManagement.Models
{
    public class Employee
    {
        public int Id { get; set; }
        [Required(ErrorMessage ="Tên không được để trống")]
        [MaxLength(20, ErrorMessage = "Can not exceed 20 characters")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Email không được để trống")]
        [Display(Name = "Office Email")]
        [RegularExpression(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$", 
            ErrorMessage = "Invalid email format")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Phải chọn ít nhất một loại")]
        public Dept? Department { get; set; }
        public string AvatarPath { get; set; }


        public override string ToString()
        {
            return $"Id : {Id}, Name: {Name}, Email: {Email}, " +
                $"Department: {Department}, AvatarPath: {AvatarPath}";
        }
    }
}
