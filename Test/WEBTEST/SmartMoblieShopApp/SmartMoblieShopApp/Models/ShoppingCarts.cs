using System;
using System.Collections.Generic;

namespace SmartMoblieShopApp.Models
{
    public partial class ShoppingCarts
    {
        public int Id { get; set; }
        public int ClientId { get; set; }
        public int ProductId { get; set; }
        public decimal Amount { get; set; }
        public DateTime DateOrder { get; set; }
        public bool IsInCart { get; set; }

        public virtual Clients Client { get; set; }
        public virtual Product Product { get; set; }
    }
}
