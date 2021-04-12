using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ExaminationSys;

namespace System_Examination
{
    public partial class frmLogin : Form
    {
        public static int textInpId;
        public frmLogin()
        {
            InitializeComponent();

            this.dataGridView1.Rows.Add(1,8184,"instructor");
            this.dataGridView1.Rows.Add(6,1643, "student");
            this.dataGridView1.Rows.Add(7,4911, "student");
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            TxtUsername.Text = "";
            Txtpassword.Text = "";

        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            if (TxtUsername.Text != "" && Txtpassword.Text != "")
            {
                string userType = Logins.CheckUserCredentials(TxtUsername.Text, Txtpassword.Text)?? "";
                if (userType == "instructor")
                {
                    this.Hide();
                    textInpId = Convert.ToInt32(TxtUsername.Text);
                    frmInstructor frmInstructor = new frmInstructor();
                    frmInstructor.ShowDialog();
                    this.Show();
                }
                else if (userType == "student")
                {
                    this.Hide();
                    textInpId = Convert.ToInt32( TxtUsername.Text);
                    frmRegisteredCourses frmStudentCourses = new frmRegisteredCourses();
                    frmStudentCourses.ShowDialog();
                    this.Show();
                }
                else
                    MessageBox.Show("Invalid Username or Password");

            }
        }

        private void btnExist_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }

}