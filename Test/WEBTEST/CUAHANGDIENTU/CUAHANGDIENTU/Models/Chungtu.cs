﻿using System;
using System.Collections.Generic;

#nullable disable

namespace CUAHANGDIENTU.Models
{
    public partial class Chungtu
    {
        public Chungtu()
        {
            Phieuthutiens = new HashSet<Phieuthutien>();
        }

        public int Sochungtu { get; set; }
        public DateTime Ngaylap { get; set; }
        public string Tenkhachhang { get; set; }
        public string Diachikhachhang { get; set; }
        public int Mahang { get; set; }
        public int Soluong { get; set; }
        public decimal Dongia { get; set; }

        public virtual Mathang MahangNavigation { get; set; }
        public virtual ICollection<Phieuthutien> Phieuthutiens { get; set; }
    }
}
