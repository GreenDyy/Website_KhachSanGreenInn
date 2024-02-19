using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebDatPhongKhachSan.Models;
using WebDatPhongKhachSan.ViewModels;

namespace WebDatPhongKhachSan.Controllers
{
    public class GallaryController : Controller
    {
        // GET: Gallary
        QLKSEntities db = new QLKSEntities();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ThuVienAnh()
        {
            var vm = new GalleryDataView();
            vm.loaiphongs = db.loaiphongs.ToList();
            vm.imgphongs = new Dictionary<int, List<imgphong>>();
            foreach (var loaiphong in vm.loaiphongs)
            {
                vm.imgphongs[loaiphong.id_loaiphong] = db.imgphongs.Where(img => img.id_loaiphong == loaiphong.id_loaiphong).ToList();
            }
            return View(vm);
        }
    }
}