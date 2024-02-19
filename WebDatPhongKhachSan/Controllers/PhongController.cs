using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebDatPhongKhachSan.Models;
using System.Reflection;
using System.IO;
using WebDatPhongKhachSan.ViewModels;
using System.Globalization;
using System.Text.RegularExpressions;

namespace WebDatPhongKhachSan.Controllers
{
    public class PhongController : Controller
    {
        QLKSEntities db = new QLKSEntities();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ListLoaiPhong()
        {
            var data = db.loaiphongs.ToList();
            ViewBag.ListLoaiPhong = data;
            return View(data);
        }

        public ActionResult ListPhong(int? id_loaiphong)
        {
            if (!id_loaiphong.HasValue)
            {
                id_loaiphong = db.loaiphongs.FirstOrDefault().id_loaiphong;
            }

            PhongListPhongDataView vm = new PhongListPhongDataView();
            vm.PhongS = db.phongs.Where(p => p.id_loaiphong == id_loaiphong && p.trang_thai == "Còn trống").ToList();
            vm.TenLoaiPhong = db.loaiphongs.FirstOrDefault(lp => lp.id_loaiphong == id_loaiphong).ten_loai;
            vm.MoTaLoaiPhong = db.loaiphongs.FirstOrDefault(lp => lp.id_loaiphong == id_loaiphong).mota;
            vm.SoNguoi = db.loaiphongs.FirstOrDefault(lp => lp.id_loaiphong == id_loaiphong).so_luong_nguoi;

            List<imgphong> listImg = (from hinh in db.imgphongs where hinh.id_loaiphong == id_loaiphong select hinh).ToList();
            ViewBag.ImgPhong = listImg;

            return View(vm);
        }

        public ActionResult ChiTietMotLoaiPhong(int? id_loaiphong)
        {
            if (!id_loaiphong.HasValue)
            {
                id_loaiphong = db.loaiphongs.FirstOrDefault().id_loaiphong;
            }
            var vm = new ChiTietListLoaiPhongVaListLoaiPhongKhacDataView();
            vm.loaiPhong = db.loaiphongs.FirstOrDefault(lp => lp.id_loaiphong == id_loaiphong);
            vm.loaiPhongs = db.loaiphongs.Where(x => x.id_loaiphong != id_loaiphong).Take(3).ToList();
            List<imgphong> danhSachAnh = db.imgphongs.Where(a => a.id_loaiphong == id_loaiphong).ToList();
            ViewBag.ListImage = danhSachAnh;

            return View(vm);
        }
        public ActionResult ChiTietMotPhong(string id_phong)
        {
            if (id_phong == null)
            {
                id_phong = db.phongs.FirstOrDefault().id_phong;
            }
            phong data = db.phongs.Find(id_phong);
            return View(data);
        }

        [HttpPost]
        public ActionResult LayThongTinDatPhong(string idPhong, string checkin, string checkout, double giaPhong, int soNguoi, string idHinh, string tenPhong, string tenLoaiPhong)
        {
            Session["IdPhong"] = idPhong;
            Session["Checkin"] = checkin;
            Session["Checkout"] = checkout;
            Session["GiaPhong"] = giaPhong;
            Session["SoNguoi"] = soNguoi;
            Session["IdHinh"] = idHinh;
            Session["TenPhong"] = tenPhong;
            Session["TenLoaiPhong"] = tenLoaiPhong;

            DateTime checkinDate = DateTime.ParseExact(checkin, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            DateTime checkoutDate = DateTime.ParseExact(checkout, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            int soNgay = (int)(checkoutDate - checkinDate).TotalDays;

            Session["SoNgay"] = soNgay;
            return View("ChiTietDatPhong");
        }

        public bool IsValidCMND(string cmnd)
        {
            if (cmnd.Length != 12)
            {
                return false;
            }

            if (!Regex.IsMatch(cmnd, @"^\d+$"))
            {
                return false;
            }
            return true;
        }

        public bool IsValidSDT(string cmnd)
        {
            if (cmnd.Length != 10)
            {
                return false;
            }

            if (!Regex.IsMatch(cmnd, @"^\d+$"))
            {
                return false;
            }
            return true;
        }

        public bool IsValidTen(string ten)
        {
            if (ten.Length > 50)
                return false;
            if (!Regex.IsMatch(ten, @"^[\p{L} ]+$")) //chữ có dấu và space
                return false;
            return true;
        }

        public bool IsValidDiaChi(string diachi)
        {
            if (diachi.Length > 255)
                return false;
            return true;
        }

        public static bool IsValidNgaySinh(DateTime ngaySinh)
        {
            DateTime ngaySinhMin = new DateTime(1900, 1, 1);
            DateTime ngaySinhMax = DateTime.Now.AddYears(-18); //18 tuổi

            if (ngaySinh < ngaySinhMin || ngaySinh > ngaySinhMax)
            {
                return false;
            }

            return true;
        }

        [HttpPost]
        public ActionResult ChiTietDatPhong(datphongonline datphong, string idPhong, string checkin, string checkout, string giaPhong, string soNguoi)
        {

            if (string.IsNullOrEmpty(idPhong) || string.IsNullOrEmpty(checkin) || string.IsNullOrEmpty(checkout) || string.IsNullOrEmpty(giaPhong) || string.IsNullOrEmpty(soNguoi))
            {
                return RedirectToAction("Index", "Home");
            }

            if (!ModelState.IsValid)
            {
                return View(datphong);
            }
            else //nếu các trường đã nhập đủ
            {
                // nếu cả 4 thằng đều sai thì báo lỗi mỗi thằng
                if (!IsValidNgaySinh(datphong.ngay_sinh) || !IsValidCMND(datphong.cmnd) || !IsValidSDT(datphong.sdt) || !IsValidTen(datphong.ten_khachhang) || !IsValidDiaChi(datphong.dia_chi))
                {
                    if (!IsValidNgaySinh(datphong.ngay_sinh))
                    {
                        ModelState.AddModelError("ngay_sinh", "Ngày sinh không hợp lệ.");
                    }

                    if (!IsValidCMND(datphong.cmnd))
                    {
                        ModelState.AddModelError("cmnd", "CMND không hợp lệ.");
                    }

                    if (!IsValidSDT(datphong.sdt))
                    {
                        ModelState.AddModelError("sdt", "Số điện thoại không hợp lệ.");
                    }

                    if (!IsValidTen(datphong.ten_khachhang))
                    {
                        ModelState.AddModelError("ten", "Tên không hợp lệ.");
                    }

                    if (!IsValidDiaChi(datphong.dia_chi))
                    {
                        ModelState.AddModelError("dia_chi", "Địa chỉ không hợp lệ.");
                    }
                    return View(datphong);
                }
                else
                {
                    datphong.id_phong = idPhong;
                    datphong.check_in = DateTime.Parse(checkin);
                    datphong.check_out = DateTime.Parse(checkout);
                    TimeSpan khoangthoigian = (TimeSpan)(datphong.check_out - datphong.check_in);
                    int songay = (int)khoangthoigian.TotalDays;
                    datphong.tong_tien = float.Parse(giaPhong) * songay;
                    datphong.so_nguoi_o = int.Parse(soNguoi);
                    datphong.trang_thai = "Chưa thanh toán";

                    db.datphongonlines.Add(datphong);
                    db.SaveChanges();
                    return RedirectToAction("DatPhongThanhCong");
                }
                
            }
        }
        public ActionResult DatPhongThanhCong()
        {
            return View();
        }
    }
}