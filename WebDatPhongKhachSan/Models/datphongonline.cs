﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebDatPhongKhachSan.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class datphongonline
    {
        public int id_datphong { get; set; }
        public string id_phong { get; set; }
        public System.DateTime check_in { get; set; }
        public System.DateTime check_out { get; set; }
        public double tong_tien { get; set; }
        public int so_nguoi_o { get; set; }
        public string trang_thai { get; set; }
        [Required(ErrorMessage = "Tên không được bỏ trống")]
        public string ten_khachhang { get; set; }
        [Required(ErrorMessage = "Ngày sinh không được bỏ trống")]
        public System.DateTime ngay_sinh { get; set; }
        [Required(ErrorMessage = "Địa chỉ không được bỏ trống")]
        public string dia_chi { get; set; }
        [Required(ErrorMessage = "Số điện thoại không được bỏ trống")]
        public string sdt { get; set; }
        [Required(ErrorMessage = "CMND/CCCD không được bỏ trống")]
        public string cmnd { get; set; }
        [Required(ErrorMessage = "Giới tính không được bỏ trống")]
        public string gioi_tinh { get; set; }

        public virtual phong phong { get; set; }
    }
}
