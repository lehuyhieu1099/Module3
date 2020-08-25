using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using CUAHANGDIENTU.Models;

namespace CUAHANGDIENTU.Controllers
{
    public class ChungtusController : Controller
    {
        private readonly CUAHANGDIENTUContext _context;

        public ChungtusController(CUAHANGDIENTUContext context)
        {
            _context = context;
        }

        // GET: Chungtus
        public async Task<IActionResult> Index()
        {
            var cUAHANGDIENTUContext = _context.Chungtus.Include(c => c.MahangNavigation);
            return View(await cUAHANGDIENTUContext.ToListAsync());
        }

        // GET: Chungtus/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chungtu = await _context.Chungtus
                .Include(c => c.MahangNavigation)
                .FirstOrDefaultAsync(m => m.Sochungtu == id);
            if (chungtu == null)
            {
                return NotFound();
            }

            return View(chungtu);
        }

        // GET: Chungtus/Create
        public IActionResult Create()
        {
            ViewData["Mahang"] = new SelectList(_context.Mathangs, "Mahang", "Chitietmathang");
            return View();
        }

        // POST: Chungtus/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Sochungtu,Ngaylap,Tenkhachhang,Diachikhachhang,Mahang,Soluong,Dongia")] Chungtu chungtu)
        {
            if (ModelState.IsValid)
            {
                _context.Add(chungtu);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["Mahang"] = new SelectList(_context.Mathangs, "Mahang", "Chitietmathang", chungtu.Mahang);
            return View(chungtu);
        }

        // GET: Chungtus/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chungtu = await _context.Chungtus.FindAsync(id);
            if (chungtu == null)
            {
                return NotFound();
            }
            ViewData["Mahang"] = new SelectList(_context.Mathangs, "Mahang", "Chitietmathang", chungtu.Mahang);
            return View(chungtu);
        }

        // POST: Chungtus/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Sochungtu,Ngaylap,Tenkhachhang,Diachikhachhang,Mahang,Soluong,Dongia")] Chungtu chungtu)
        {
            if (id != chungtu.Sochungtu)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(chungtu);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ChungtuExists(chungtu.Sochungtu))
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
            ViewData["Mahang"] = new SelectList(_context.Mathangs, "Mahang", "Chitietmathang", chungtu.Mahang);
            return View(chungtu);
        }

        // GET: Chungtus/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chungtu = await _context.Chungtus
                .Include(c => c.MahangNavigation)
                .FirstOrDefaultAsync(m => m.Sochungtu == id);
            if (chungtu == null)
            {
                return NotFound();
            }

            return View(chungtu);
        }

        // POST: Chungtus/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var chungtu = await _context.Chungtus.FindAsync(id);
            _context.Chungtus.Remove(chungtu);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ChungtuExists(int id)
        {
            return _context.Chungtus.Any(e => e.Sochungtu == id);
        }
    }
}
