using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SmartMoblieShopApp.Models;

namespace SmartMoblieShopApp.Controllers
{
    public class ShoppingCartsController : Controller
    {
        private readonly SmartMobileShopContext _context;

        public ShoppingCartsController(SmartMobileShopContext context)
        {
            _context = context;
        }

        // GET: ShoppingCarts
        public async Task<IActionResult> Index()
        {
            var smartMobileShopContext = _context.ShoppingCarts.Include(s => s.Client).Include(s => s.Product);
            return View(await smartMobileShopContext.ToListAsync());
        }

        // GET: ShoppingCarts/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var shoppingCarts = await _context.ShoppingCarts
                .Include(s => s.Client)
                .Include(s => s.Product)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (shoppingCarts == null)
            {
                return NotFound();
            }

            return View(shoppingCarts);
        }

        // GET: ShoppingCarts/Create
        public IActionResult Create()
        {
            ViewData["ClientId"] = new SelectList(_context.Clients, "Id", "ClientName");
            ViewData["ProductId"] = new SelectList(_context.Product, "Id", "ProductName");
            return View();
        }

        // POST: ShoppingCarts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,ClientId,ProductId,Amount,DateOrder,IsInCart")] ShoppingCarts shoppingCarts)
        {
            if (ModelState.IsValid)
            {
                _context.Add(shoppingCarts);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["ClientId"] = new SelectList(_context.Clients, "Id", "ClientName", shoppingCarts.ClientId);
            ViewData["ProductId"] = new SelectList(_context.Product, "Id", "ProductName", shoppingCarts.ProductId);
            return View(shoppingCarts);
        }

        // GET: ShoppingCarts/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var shoppingCarts = await _context.ShoppingCarts.FindAsync(id);
            if (shoppingCarts == null)
            {
                return NotFound();
            }
            ViewData["ClientId"] = new SelectList(_context.Clients, "Id", "ClientName", shoppingCarts.ClientId);
            ViewData["ProductId"] = new SelectList(_context.Product, "Id", "ProductName", shoppingCarts.ProductId);
            return View(shoppingCarts);
        }

        // POST: ShoppingCarts/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,ClientId,ProductId,Amount,DateOrder,IsInCart")] ShoppingCarts shoppingCarts)
        {
            if (id != shoppingCarts.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(shoppingCarts);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ShoppingCartsExists(shoppingCarts.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["ClientId"] = new SelectList(_context.Clients, "Id", "ClientName", shoppingCarts.ClientId);
            ViewData["ProductId"] = new SelectList(_context.Product, "Id", "ProductName", shoppingCarts.ProductId);
            return View(shoppingCarts);
        }

        // GET: ShoppingCarts/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var shoppingCarts = await _context.ShoppingCarts
                .Include(s => s.Client)
                .Include(s => s.Product)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (shoppingCarts == null)
            {
                return NotFound();
            }

            return View(shoppingCarts);
        }

        // POST: ShoppingCarts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var shoppingCarts = await _context.ShoppingCarts.FindAsync(id);
            _context.ShoppingCarts.Remove(shoppingCarts);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ShoppingCartsExists(int id)
        {
            return _context.ShoppingCarts.Any(e => e.Id == id);
        }
    }
}
