using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDatPhongKhachSan.Models;

namespace WebDatPhongKhachSan.ViewModels
{
    public class PhongListPhongDataView
    {
        public List<phong> PhongS {  get; set; }
        public string TenLoaiPhong { get;set; }
        public string MoTaLoaiPhong { get;set; }
        public int SoNguoi {  get;set; }
        public int SoNgay {  get;set; }
    }
}