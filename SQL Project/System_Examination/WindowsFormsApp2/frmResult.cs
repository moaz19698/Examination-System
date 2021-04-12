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
    public partial class frmResult : Form
    {
        public frmResult()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
            //frmLogin frmLogin = new frmLogin();
           // frmLogin.Show();           
        }

        private void frmResult_Load(object sender, EventArgs e)
        {
            Exam.InsertExamAnswers(frmQuestion.answers);
            lblGrade.Text =  Exam.CorrectLastExam();
        }
    }
}
