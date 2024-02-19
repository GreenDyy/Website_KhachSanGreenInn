using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Accord.MachineLearning;
using Accord.MachineLearning.DecisionTrees;
using Accord.MachineLearning.DecisionTrees.Learning;
using Accord.Math;
using Accord.Math.Optimization.Losses;
using Accord.Statistics.Filters;
using WebDatPhongKhachSan.Models;
using WebDatPhongKhachSan.ViewModels;

namespace WebDatPhongKhachSan.Controllers
{
    public class GoiYDatPhongController : Controller
    {
        // GET: GoiYDatPhong
        QLKSEntities db = new QLKSEntities();
        public ActionResult Index()
        {
            return View();
        }

        [Obsolete]
        public string GoiYPhongID3(string songuoio, string gioitinh)
        {
            DataTable data = new DataTable("DatPhongOnline");
            //header
            data.Columns.Add("id_datphong");
            data.Columns.Add("so_nguoi_o");
            data.Columns.Add("gioi_tinh");
            data.Columns.Add("id_phong");
            //data
            foreach (var datphong in db.datphongs.ToList())
            {
                DataRow row = data.NewRow();
                row["id_datphong"] = datphong.id_datphong;
                row["so_nguoi_o"] = datphong.so_nguoi_o;
                row["gioi_tinh"] = datphong.khachhang.gioi_tinh;
                row["id_phong"] = datphong.id_phong;
                data.Rows.Add(row);
            }

            var codebook = new Codification(data);

            DataTable symbols = codebook.Apply(data);
            // Chọn các cột cần chuyển đổi thành mảng
            int[][] inputs = symbols.ToArray<int>("so_nguoi_o", "gioi_tinh");
            int[] outputs = symbols.ToArray<int>("id_phong");
            var id3learning = new ID3Learning
            {

                new DecisionVariable("so_nguoi_o", 2), //2 giá trị 1 và 2
                new DecisionVariable("gioi_tinh", 2), // 2 giá trị (nam/nu)

            };

            // train nó
            DecisionTree tree = id3learning.Learn(inputs, outputs);

            // Tính sai số huấn luyện khi dự đoán các trường hợp huấn luyện
            double error = new ZeroOneLoss(outputs).Loss(tree.Decide(inputs));

            int[] query = codebook.Transform(new[,]
            {
                { "so_nguoi_o", songuoio },
                { "gioi_tinh", gioitinh }
            }); // trong dữ liệu train phải có đầy đủ giá trị của cà 2 cột điều kiện đó, nếu k thì sẽ bị lỗi k tìm thấy do dữ liệu lạ

            int predicted = tree.Decide(query);

            string result = codebook.Revert("id_phong", predicted);
            return result;
        }

        [Obsolete]
        [HttpPost]
        public ActionResult GoiYDatPhong(string soNguoi, string gioiTinh)
        {

            int idLoaiPhongGoiY = 2;

            if (ModelState.IsValid)
            {
                string maPhongGoiY = GoiYPhongID3(soNguoi, gioiTinh);
                idLoaiPhongGoiY = db.phongs.FirstOrDefault(p => p.id_phong == maPhongGoiY).id_loaiphong;
                ViewBag.ThongBaoGoiYPhong = "Phòng " + maPhongGoiY + " có vẻ phù hợp với bạn!";
                return RedirectToAction("ChiTietMotLoaiPhong", "Phong", new { id_loaiphong = idLoaiPhongGoiY });
            }
            return View();
        }

        public ActionResult PhongGoiY()
        {
            return View();
        }
    }
}