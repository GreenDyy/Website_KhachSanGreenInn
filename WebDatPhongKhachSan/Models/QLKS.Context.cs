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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class QLKSEntities : DbContext
    {
        public QLKSEntities()
            : base("name=QLKSEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<chitietsudungdv> chitietsudungdvs { get; set; }
        public virtual DbSet<chitietsudungtb> chitietsudungtbs { get; set; }
        public virtual DbSet<datphong> datphongs { get; set; }
        public virtual DbSet<datphongonline> datphongonlines { get; set; }
        public virtual DbSet<dichvu> dichvus { get; set; }
        public virtual DbSet<imgphong> imgphongs { get; set; }
        public virtual DbSet<khachhang> khachhangs { get; set; }
        public virtual DbSet<khachsan> khachsans { get; set; }
        public virtual DbSet<loaiphong> loaiphongs { get; set; }
        public virtual DbSet<nhanvien> nhanviens { get; set; }
        public virtual DbSet<phong> phongs { get; set; }
        public virtual DbSet<taikhoan> taikhoans { get; set; }
        public virtual DbSet<tang> tangs { get; set; }
        public virtual DbSet<thietbi> thietbis { get; set; }
    }
}
