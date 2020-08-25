using System;
using System.Collections.Generic;

#nullable disable

namespace CUAHANGDIENTU.Models
{
    public partial class Phieuthutien
    {
        public int Sophieu { get; set; }
        public int Sochungtu { get; set; }
        public DateTime Ngaythutien { get; set; }
        public decimal Sotien { get; set; }

        public virtual Chungtu SochungtuNavigation { get; set; }
    }
}
