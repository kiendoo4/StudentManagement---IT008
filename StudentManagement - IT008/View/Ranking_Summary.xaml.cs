﻿using StudentManagement___IT008.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace StudentManagement___IT008.View
{
    /// <summary>
    /// Interaction logic for Ranking_Summary.xaml
    /// </summary>
    public partial class Ranking_Summary : UserControl
    {
        string className;
        public Ranking_Summary(string className)
        {
            InitializeComponent();
            this.className = className;
            tb_HK.Text = className;
            LoadData();
        }

        ObservableCollection<KQNAMHOC> kq_chosen = new ObservableCollection<KQNAMHOC>();
        public void LoadData()
        {
            foreach (KQNAMHOC kq in Entity.ins.KQNAMHOCs.ToList())
            {
                HOCSINH hs = new HOCSINH();
                foreach (HOCSINH hs2 in Entity.ins.HOCSINHs)
                {
                    if (hs2.MAHS == kq.MAHS) { hs = hs2; break; }
                }
                LOPHOCTHUCTE lhtt = new LOPHOCTHUCTE();
                foreach (LOPHOCTHUCTE lh in Entity.ins.LOPHOCTHUCTEs.ToList())
                {
                    if (lh.HOCSINHs.Contains(hs)) { lhtt = lh; break; }
                }
                if (lhtt != null)
                {
                    string temp = lhtt.MALOP;
                    if (temp == null) continue;
                    if (temp.Contains(className)) kq_chosen.Add(kq);
                }
            }
            Ranking.ItemsSource = kq_chosen;
        }

        private void LoadSelection(object sender, SelectionChangedEventArgs e)
        {
            if (Ranking.SelectedItem != null)
            {
                KQNAMHOC obj = kq_chosen[Ranking.SelectedIndex];
                ObservableCollection<DIEMTRUNGBINHMONHOCNAMHOC> kq_hs = new ObservableCollection<DIEMTRUNGBINHMONHOCNAMHOC>();
                foreach (DIEMTRUNGBINHMONHOCNAMHOC kq in Entity.ins.DIEMTRUNGBINHMONHOCNAMHOCs.ToList())
                {
                    if (kq.MAHS == obj.MAHS)
                    {
                        kq_hs.Add(kq);
                    }
                }
                RankCuThe.ItemsSource = kq_hs;
            }
        }
    }
}