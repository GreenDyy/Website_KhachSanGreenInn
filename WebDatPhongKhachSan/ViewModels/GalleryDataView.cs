using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatPhongKhachSan.Models;

namespace WebDatPhongKhachSan.ViewModels
{
    public class GalleryDataView
    {
        public List<loaiphong> loaiphongs { get; set; }
        public Dictionary<int, List<imgphong>> imgphongs { get; set; }
    }
}