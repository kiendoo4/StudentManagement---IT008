namespace StudentManagement___IT008.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
    using System.Linq;

    [Table("KQNAMHOC")]
    public partial class KQNAMHOC
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(7)]
        public string MAHS { get; set; }

        public string HOTEN
        {
            get
            {
                return HOCSINH.HOTENHS;
            }
        }

        [Key]
        [Column(Order = 1)]
        [StringLength(7)]
        public string MANH { get; set; }

        [StringLength(7)]
        public string MaHocLuc { get; set; }

        public string tenHL
        {
            get
            {
                return HOCLUC.TenHocLuc;
            }
        }

        [StringLength(7)]
        public string MaHanhKiem { get; set; }

        public string tenHKiem
        {
            get
            {
                return HANHKIEM.TenHanhKiem;
            }
        }

        public string STT
        {
            get
            {
                HOCSINH hs = HOCSINH;
                string lopss = hs.LOP;
                int count = 1;
                foreach (HOCSINH myhs in Entity.ins.HOCSINHs)
                {
                    if (myhs.LOP == lopss)
                    {
                        if (myhs == hs) break;
                        else count++;
                    }
                    else continue;
                }
                return count.ToString();
            }
        }

        [StringLength(7)]
        public string MaKetQua { get; set; }

        public double DTBNamHoc { get; set; }

        public virtual HANHKIEM HANHKIEM { get; set; }

        public virtual HOCLUC HOCLUC { get; set; }

        public virtual HOCSINH HOCSINH { get; set; }

        public virtual KETQUA KETQUA { get; set; }

        public virtual NAMHOC NAMHOC { get; set; }
    }
}
