using CrystalDecisions.CrystalReports.Engine;
using Microsoft.Reporting.WebForms;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data.Common;

namespace System_Examination
{
    public partial class frmInstructor : Form
    {
        public frmInstructor()
        {
            InitializeComponent();
        }

        private void frmInstructor_Load(object sender, EventArgs e)
        {

        }


        private void button1_Click(object sender, EventArgs e)
        {

            ReportViewer r;
            try
            {
                if (string.IsNullOrEmpty(textInstructorID.Text))
                    MessageBox.Show("Please Enter Instructor Id");

                else
                {
                    r = new ReportViewer();
                    SqlConnection connection = new SqlConnection("Data Source=.;Initial Catalog=ExaminationSystem;Integrated Security=True");
                    SqlCommand cmd = new SqlCommand("ex.spGetExamById", connection);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@ExamId", textInstructorID.Text));
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    DataTable dtable = new DataTable();
                    dataAdapter.Fill(dtable);



                    ReportDocument rdc = new ReportDocument();
                    rdc.Load(@"Reports\GetExamQuestions.rpt");
                    rdc.SummaryInfo.ReportTitle = "Students Information Report";
                    r.crystalReportViewer1.ReportSource = rdc;
                    rdc.SetDataSource(dtable);



                    r.ShowDialog();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void btnspGetStudentsInDepartment_Click(object sender, EventArgs e)
        {
            ReportViewer r;
           
                if (string.IsNullOrEmpty(txtbspGetStudentsInDepartment.Text))
                    MessageBox.Show("Please Enter Department Id");

                else
                {
                    r = new ReportViewer();
                    SqlConnection connection = new SqlConnection("Data Source=. ;Initial Catalog=ExaminationSystem;Integrated Security=True");
                    SqlCommand cmd = new SqlCommand("dbo.spGetStudentsInDepartment", connection);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@DepartmentId", txtbspGetStudentsInDepartment.Text));
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    DataTable dtable = new DataTable();
                    dataAdapter.Fill(dtable);



                    ReportDocument rdc = new ReportDocument();
                    rdc.Load(@"Reports\StudentInformaionFromDepartment.rpt");
                    rdc.SummaryInfo.ReportTitle = "Students Information Report";
                    r.crystalReportViewer1.ReportSource = rdc;
                    rdc.SetDataSource(dtable);



                    r.ShowDialog();
                }

            
            //catch (Exception ex)
            //{
            //    MessageBox.Show(ex.Message);
            //}



        }

        private void btnspReturnGradesOfStudentInAllCourses_Click(object sender, EventArgs e)
        {
            ReportViewer r;
            try
            {
                if (string.IsNullOrEmpty(txtspReturnGradesOfStudentInAllCourses.Text))
                    MessageBox.Show("Please Enter Department Id");

                else
                {
                    r = new ReportViewer();
                    SqlConnection connection = new SqlConnection("Data Source=.;Initial Catalog=ExaminationSystem;Integrated Security=True");
                    SqlCommand cmd = new SqlCommand("UNI.spReturnGradesOfStudentInAllCourses", connection);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@studentId", txtspReturnGradesOfStudentInAllCourses.Text));
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    DataTable dtable = new DataTable();
                    dataAdapter.Fill(dtable);



                    ReportDocument rdc = new ReportDocument();
                    rdc.Load(@"Reports\CrystalReport2.rpt");
                    rdc.SummaryInfo.ReportTitle = "Students Information Report";
                    r.crystalReportViewer1.ReportSource = rdc;
                    rdc.SetDataSource(dtable);



                    r.ShowDialog();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse_Click(object sender, EventArgs e)
        {
            ReportViewer r;
            try
            {
                if (string.IsNullOrEmpty(txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Text))
                    MessageBox.Show("Please Enter Instructor Id");

                else
                {
                    r = new ReportViewer();
                    SqlConnection connection = new SqlConnection("Data Source=.;Initial Catalog=ExaminationSystem;Integrated Security=True");
                    SqlCommand cmd = new SqlCommand("UNI.spReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse", connection);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@InstructorID",txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Text));
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    DataTable dtable = new DataTable();
                    dataAdapter.Fill(dtable);



                    ReportDocument rdc = new ReportDocument();
                    rdc.Load(@"Reports\CrystalReport1.rpt");
                    rdc.SummaryInfo.ReportTitle = "Students Information Report";
                    r.crystalReportViewer1.ReportSource = rdc;
                    rdc.SetDataSource(dtable);



                    r.ShowDialog();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void button6_Click(object sender, EventArgs e)
        {
            ReportViewer r;
            try
            {
                if (string.IsNullOrEmpty(txtTopic.Text))
                    MessageBox.Show("Please Enter Instructor Id");

                else
                {
                    r = new ReportViewer();
                    SqlConnection connection = new SqlConnection("Data Source=.;Initial Catalog=ExaminationSystem;Integrated Security=True");
                    SqlCommand cmd = new SqlCommand("uni.spTopicGetAllByCourseID", connection);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Crsid",txtTopic.Text));
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    DataTable dtable = new DataTable();
                    dataAdapter.Fill(dtable);



                    ReportDocument rdc = new ReportDocument();
                    rdc.Load(@"Reports\GetTopicByCourseReportId.rpt");
                    rdc.SummaryInfo.ReportTitle = "Students Information Report";
                    r.crystalReportViewer1.ReportSource = rdc;
                    rdc.SetDataSource(dtable);



                    r.ShowDialog();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void btnspRetriveTheExam_Click(object sender, EventArgs e)
        {
            ReportViewer r;
            try
            {
                if (string.IsNullOrEmpty(txtExamNum.Text)  && string.IsNullOrEmpty(txtstudentId.Text))
                    MessageBox.Show("Please Enter Exam number and student id ");

                else
                {
                    r = new ReportViewer();
                    SqlConnection connection = new SqlConnection("Data Source=.;Initial Catalog=ExaminationSystem;Integrated Security=True");
                    SqlCommand cmd = new SqlCommand("ex.spRetriveTheExamQuestionsStudentAnswers", connection);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Exam_id",txtExamNum.Text));
                    cmd.Parameters.Add(new SqlParameter("@Student_id", txtstudentId.Text));

                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    DataTable dtable = new DataTable();
                    dataAdapter.Fill(dtable);



                    ReportDocument rdc = new ReportDocument();
                    rdc.Load(@"Reports\Report4.rpt");
                    rdc.SummaryInfo.ReportTitle = "Question with Answer";
                    r.crystalReportViewer1.ReportSource = rdc;
                    rdc.SetDataSource(dtable);



                    r.ShowDialog();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
