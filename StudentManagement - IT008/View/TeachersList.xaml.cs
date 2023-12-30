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
    /// Interaction logic for TeachersList.xaml
    /// </summary>
    public partial class TeachersList : UserControl
    {
        ObservableCollection<TAIKHOAN> taikhoanList = new ObservableCollection<TAIKHOAN>();
        public TeachersList()
        {
            InitializeComponent();
            foreach (TAIKHOAN tk in Entity.ins.TAIKHOANs.ToList())
            {
                if (tk.ISDELETED == false && tk.VAITRO == "GV")
                    taikhoanList.Add(tk);
            }
            Data.ItemsSource = taikhoanList;
        }

        private void AddTeacherButton(object sender, RoutedEventArgs e)
        {
            AddTeacher addTeacher = new AddTeacher();
            addTeacher.ShowDialog();
        }
        private void CheckTeacherClick(object sender, RoutedEventArgs e)
        {

        }
        private void CheckAllTeachersClick(object sender, RoutedEventArgs e) 
        {
            foreach (var item in Data.Items)
            {
                var row = Data.ItemContainerGenerator.ContainerFromItem(item) as DataGridRow;

                if (row != null)
                {
                    CheckBox checkBox = FindVisualChild<CheckBox>(row);

                    if (checkBox != null)
                    {
                        checkBox.IsChecked = true;
                    }
                }
            }
        }
        private void UncheckAllTeachersClick(object sender, RoutedEventArgs e) 
        {
            foreach (var item in Data.Items)
            {
                var row = Data.ItemContainerGenerator.ContainerFromItem(item) as DataGridRow;

                if (row != null)
                {
                    CheckBox checkBox = FindVisualChild<CheckBox>(row);

                    if (checkBox != null)
                    {
                        checkBox.IsChecked = false;
                    }
                }
            }
        }
        private static T FindVisualChild<T>(DependencyObject parent) where T : DependencyObject
        {
            for (int i = 0; i < VisualTreeHelper.GetChildrenCount(parent); i++)
            {
                DependencyObject child = VisualTreeHelper.GetChild(parent, i);

                if (child != null && child is T)
                {
                    return (T)child;
                }
                else
                {
                    T childOfChild = FindVisualChild<T>(child);

                    if (childOfChild != null)
                    {
                        return childOfChild;
                    }
                }
            }
            return null;
        }
        private void ChangeTTGiaoVien(object sender, RoutedEventArgs e) 
        {
            var button = (Button)sender;
            TAIKHOAN dataItem = (TAIKHOAN)button.DataContext;
            AddTeacher changeTTStudent = new AddTeacher(dataItem);
            changeTTStudent.ShowDialog();
            Data.ItemsSource = null;
            Data.ItemsSource = taikhoanList;
        }
    }
}
