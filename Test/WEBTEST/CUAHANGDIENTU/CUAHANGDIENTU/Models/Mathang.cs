using System;
using System.Collections.Generic;

#nullable disable

namespace CUAHANGDIENTU.Models
{
    public partial class Mathang
    {
        public Mathang()
        {
            Chungtus = new HashSet<Chungtu>();
        }

        public int Mahang { get; set; }
        public string Tenhang { get; set; }
        public string Chitietmathang { get; set; }
        public decimal Giaban { get; set; }
        public int Soluong { get; set; }

        public virtual ICollection<Chungtu> Chungtus { get; set; }
    }
}
