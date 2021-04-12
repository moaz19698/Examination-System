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
    public partial class frmQuestion : Form
    {
        List<Question> questions;

        public static List<char> answers;
        public int CurrentQuestionNumber = 0;
        public frmQuestion()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            DisplayQuestion(--CurrentQuestionNumber);
            foreach (Control c in this.Controls)
            {
                if (c is RadioButton)
                {
                    if (((RadioButton)c).Checked)
                        answers.Add(c.Text.ToCharArray()[0]);
                }
            }
            btnNext.Enabled = true;
            if (CurrentQuestionNumber == 0)
                btnPrev.Enabled = false;
            else
                btnPrev.Enabled = true;
        }

        private void btnFinish_Click(object sender, EventArgs e)
        {
            this.Hide();
            frmResult frmResult = new frmResult();
            frmResult.ShowDialog();
            this.Close();
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            if (radioButtonAnswer1.Checked)
                answers.Add(radioButtonAnswer1.Text.ToCharArray()[0]);
            else if (radioButtonAnswer2.Checked)
                answers.Add(radioButtonAnswer2.Text.ToCharArray()[0]);
            else if (radioButtonAnswer3.Checked)
                answers.Add(radioButtonAnswer3.Text.ToCharArray()[0]);
            else if (radioButtonAnswer4.Checked)
                answers.Add(radioButtonAnswer4.Text.ToCharArray()[0]);

            DisplayQuestion(++CurrentQuestionNumber);
            btnPrev.Enabled = true;
            if (CurrentQuestionNumber == questions.Count - 1)
                btnNext.Enabled = false;
            else
                btnNext.Enabled = true;


        }
        public void DisplayQuestion(int QuestionNumber)
        {
            lblQuestionBody.Text = questions[QuestionNumber].Body;
            if (questions[QuestionNumber].ListOfChoices.Count == 2)
            {
                gBoxquestioncontianer.Text = "True | False Question";
                radioButtonAnswer1.Text = "A) " + questions[QuestionNumber].ListOfChoices[0];
                radioButtonAnswer2.Text = "B) " + questions[QuestionNumber].ListOfChoices[1];
                radioButtonAnswer3.Hide();
                radioButtonAnswer4.Hide();

            }
            else
            {
                gBoxquestioncontianer.Text = "MCQ  Question";
                radioButtonAnswer3.Show();
                radioButtonAnswer4.Show();
                radioButtonAnswer1.Text = "A) " + questions[QuestionNumber].ListOfChoices[0];
                radioButtonAnswer2.Text = "B) " + questions[QuestionNumber].ListOfChoices[1];
                radioButtonAnswer3.Text = "C) " + questions[QuestionNumber].ListOfChoices[2];
                radioButtonAnswer4.Text = "D) " + questions[QuestionNumber].ListOfChoices[3];

            }
        }



        private void frmQuestion_Load(object sender, EventArgs e)
        {

            questions = Exam.GenerateEaxm(frmRegisteredCourses.CourseName, frmLogin.textInpId.ToString(), "Final");
            answers = new List<char>();
            btnPrev.Enabled = false;
            lbwelcome.Text = string.Format($"Welcome {frmRegisteredCourses.CourseName} Exam");
            DisplayQuestion(CurrentQuestionNumber);

        }
    }
    }
