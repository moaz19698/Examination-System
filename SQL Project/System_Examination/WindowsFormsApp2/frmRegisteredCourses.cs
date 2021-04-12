using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using ExaminationSys;

namespace System_Examination
{
    public partial class frmRegisteredCourses : Form
    {
        public static string CourseName;
        public frmRegisteredCourses()
        {
            InitializeComponent();
        }

        private void frmRegisteredCourses_Load(object sender, EventArgs e)
        {
            List<string> Courses =  Exam.GetCourseList(frmLogin.textInpId);

            foreach (var item in Courses)
            {
                listBox1.Items.Add(item);
            }
        }

        private void btnStartExam_Click(object sender, EventArgs e)
        {
            CourseName = listBox1.SelectedItem.ToString();
            frmQuestion frmQuestions = new frmQuestion();
            this.Hide();
            frmQuestions.ShowDialog();
            this.Close();
        }
    }
}
