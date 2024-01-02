﻿using CommunityToolkit.Mvvm.Input;
using StudentManagement___IT008.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Linq;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace StudentManagement___IT008.View
{
    /// <summary>
    /// Interaction logic for Home.xaml
    /// </summary>
    public partial class Home : UserControl
    {
        ObservableCollection<LOP> lhtt = new ObservableCollection<LOP>();
        public Home()
        {
            InitializeComponent();
            foreach (LOP item in Entity.ins.LOPs)
            {
                if(item.ISDELETED == false && item.LOPHOCTHUCTEs.Count > 0)
                {
                    lhtt.Add(item);
                }    
            }    
            Data.ItemsSource = lhtt;
        }


        private void VaoLop(object sender, EventArgs e)
        {
            Home1 home1 = new Home1();        
            currentUC.Children.Clear();
            currentUC.Children.Add(home1);
        }
        
    }
}
