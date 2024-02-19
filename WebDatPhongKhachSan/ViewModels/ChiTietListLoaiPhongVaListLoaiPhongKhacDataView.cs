using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatPhongKhachSan.Models;

namespace WebDatPhongKhachSan.ViewModels
{
    public class ChiTietListLoaiPhongVaListLoaiPhongKhacDataView
    {
        public loaiphong loaiPhong { get; set; }
        public List<loaiphong> loaiPhongs { get; set;}
    }
}