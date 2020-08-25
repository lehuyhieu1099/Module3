using System;
using System.Collections.Generic;

namespace SmartMoblieShopApp.Models
{
    public partial class Clients
    {
        public Clients()
        {
            ShoppingCarts = new HashSet<ShoppingCarts>();
        }

        public int Id { get; set; }
        public string ClientName { get; set; }
        public int UserId { get; set; }

        public virtual ICollection<ShoppingCarts> ShoppingCarts { get; set; }
    }
}
