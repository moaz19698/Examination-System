
namespace System_Examination
{
    partial class frmInstructor
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmInstructor));
            this.btnspGetExambyID = new System.Windows.Forms.Button();
            this.textInstructorID = new System.Windows.Forms.TextBox();
            this.btnspGetStudentsInDepartment = new System.Windows.Forms.Button();
            this.btnspReturnGradesOfStudentInAllCourses = new System.Windows.Forms.Button();
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse = new System.Windows.Forms.Button();
            this.btnspRetriveTheExam = new System.Windows.Forms.Button();
            this.button6 = new System.Windows.Forms.Button();
            this.txtbspGetStudentsInDepartment = new System.Windows.Forms.TextBox();
            this.txtspReturnGradesOfStudentInAllCourses = new System.Windows.Forms.TextBox();
            this.txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse = new System.Windows.Forms.TextBox();
            this.txtExamNum = new System.Windows.Forms.TextBox();
            this.txtTopic = new System.Windows.Forms.TextBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.Reports = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.txtstudentId = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // btnspGetExambyID
            // 
            this.btnspGetExambyID.BackColor = System.Drawing.SystemColors.Highlight;
            this.btnspGetExambyID.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnspGetExambyID.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.btnspGetExambyID.Location = new System.Drawing.Point(419, 196);
            this.btnspGetExambyID.Margin = new System.Windows.Forms.Padding(2);
            this.btnspGetExambyID.Name = "btnspGetExambyID";
            this.btnspGetExambyID.Size = new System.Drawing.Size(140, 39);
            this.btnspGetExambyID.TabIndex = 0;
            this.btnspGetExambyID.Text = "Question in Exam ";
            this.btnspGetExambyID.UseVisualStyleBackColor = false;
            this.btnspGetExambyID.Click += new System.EventHandler(this.button1_Click);
            // 
            // textInstructorID
            // 
            this.textInstructorID.Location = new System.Drawing.Point(579, 203);
            this.textInstructorID.Margin = new System.Windows.Forms.Padding(2);
            this.textInstructorID.Name = "textInstructorID";
            this.textInstructorID.Size = new System.Drawing.Size(88, 20);
            this.textInstructorID.TabIndex = 1;
            this.textInstructorID.Text = "Exam ID";
            // 
            // btnspGetStudentsInDepartment
            // 
            this.btnspGetStudentsInDepartment.BackColor = System.Drawing.SystemColors.Highlight;
            this.btnspGetStudentsInDepartment.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnspGetStudentsInDepartment.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.btnspGetStudentsInDepartment.Location = new System.Drawing.Point(172, 146);
            this.btnspGetStudentsInDepartment.Name = "btnspGetStudentsInDepartment";
            this.btnspGetStudentsInDepartment.Size = new System.Drawing.Size(140, 39);
            this.btnspGetStudentsInDepartment.TabIndex = 2;
            this.btnspGetStudentsInDepartment.Text = "Department Students";
            this.btnspGetStudentsInDepartment.UseVisualStyleBackColor = false;
            this.btnspGetStudentsInDepartment.Click += new System.EventHandler(this.btnspGetStudentsInDepartment_Click);
            // 
            // btnspReturnGradesOfStudentInAllCourses
            // 
            this.btnspReturnGradesOfStudentInAllCourses.BackColor = System.Drawing.SystemColors.Highlight;
            this.btnspReturnGradesOfStudentInAllCourses.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnspReturnGradesOfStudentInAllCourses.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.btnspReturnGradesOfStudentInAllCourses.Location = new System.Drawing.Point(419, 146);
            this.btnspReturnGradesOfStudentInAllCourses.Name = "btnspReturnGradesOfStudentInAllCourses";
            this.btnspReturnGradesOfStudentInAllCourses.Size = new System.Drawing.Size(140, 39);
            this.btnspReturnGradesOfStudentInAllCourses.TabIndex = 3;
            this.btnspReturnGradesOfStudentInAllCourses.Text = "Grade of Student";
            this.btnspReturnGradesOfStudentInAllCourses.UseVisualStyleBackColor = false;
            this.btnspReturnGradesOfStudentInAllCourses.Click += new System.EventHandler(this.btnspReturnGradesOfStudentInAllCourses_Click);
            // 
            // btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse
            // 
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.BackColor = System.Drawing.SystemColors.Highlight;
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Location = new System.Drawing.Point(172, 199);
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Name = "btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse";
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Size = new System.Drawing.Size(140, 39);
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.TabIndex = 4;
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Text = "Course and Num of Student Per Course";
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.UseVisualStyleBackColor = false;
            this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Click += new System.EventHandler(this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse_Click);
            // 
            // btnspRetriveTheExam
            // 
            this.btnspRetriveTheExam.BackColor = System.Drawing.SystemColors.Highlight;
            this.btnspRetriveTheExam.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnspRetriveTheExam.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.btnspRetriveTheExam.Location = new System.Drawing.Point(419, 256);
            this.btnspRetriveTheExam.Name = "btnspRetriveTheExam";
            this.btnspRetriveTheExam.Size = new System.Drawing.Size(140, 39);
            this.btnspRetriveTheExam.TabIndex = 5;
            this.btnspRetriveTheExam.Text = "Question with Answer";
            this.btnspRetriveTheExam.UseVisualStyleBackColor = false;
            this.btnspRetriveTheExam.Click += new System.EventHandler(this.btnspRetriveTheExam_Click);
            // 
            // button6
            // 
            this.button6.BackColor = System.Drawing.SystemColors.Highlight;
            this.button6.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.button6.Location = new System.Drawing.Point(172, 259);
            this.button6.Name = "button6";
            this.button6.Size = new System.Drawing.Size(140, 39);
            this.button6.TabIndex = 6;
            this.button6.Text = "Topic Per Course";
            this.button6.UseVisualStyleBackColor = false;
            this.button6.Click += new System.EventHandler(this.button6_Click);
            // 
            // txtbspGetStudentsInDepartment
            // 
            this.txtbspGetStudentsInDepartment.Location = new System.Drawing.Point(317, 156);
            this.txtbspGetStudentsInDepartment.Margin = new System.Windows.Forms.Padding(2);
            this.txtbspGetStudentsInDepartment.Name = "txtbspGetStudentsInDepartment";
            this.txtbspGetStudentsInDepartment.Size = new System.Drawing.Size(88, 20);
            this.txtbspGetStudentsInDepartment.TabIndex = 1;
            this.txtbspGetStudentsInDepartment.Tag = "";
            this.txtbspGetStudentsInDepartment.Text = "Department ID";
            // 
            // txtspReturnGradesOfStudentInAllCourses
            // 
            this.txtspReturnGradesOfStudentInAllCourses.Location = new System.Drawing.Point(579, 153);
            this.txtspReturnGradesOfStudentInAllCourses.Margin = new System.Windows.Forms.Padding(2);
            this.txtspReturnGradesOfStudentInAllCourses.Name = "txtspReturnGradesOfStudentInAllCourses";
            this.txtspReturnGradesOfStudentInAllCourses.Size = new System.Drawing.Size(88, 20);
            this.txtspReturnGradesOfStudentInAllCourses.TabIndex = 7;
            this.txtspReturnGradesOfStudentInAllCourses.Text = "Student ID";
            // 
            // txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse
            // 
            this.txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Location = new System.Drawing.Point(317, 209);
            this.txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Margin = new System.Windows.Forms.Padding(2);
            this.txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Name = "txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse";
            this.txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Size = new System.Drawing.Size(88, 20);
            this.txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.TabIndex = 8;
            this.txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse.Text = "Instructor ID";
            // 
            // txtExamNum
            // 
            this.txtExamNum.Location = new System.Drawing.Point(564, 266);
            this.txtExamNum.Margin = new System.Windows.Forms.Padding(2);
            this.txtExamNum.Name = "txtExamNum";
            this.txtExamNum.Size = new System.Drawing.Size(88, 20);
            this.txtExamNum.TabIndex = 9;
            this.txtExamNum.Text = "Exam Number";
            // 
            // txtTopic
            // 
            this.txtTopic.Location = new System.Drawing.Point(317, 269);
            this.txtTopic.Margin = new System.Windows.Forms.Padding(2);
            this.txtTopic.Name = "txtTopic";
            this.txtTopic.Size = new System.Drawing.Size(88, 20);
            this.txtTopic.TabIndex = 10;
            this.txtTopic.Text = "Course ID";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(12, 23);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(149, 153);
            this.pictureBox1.TabIndex = 11;
            this.pictureBox1.TabStop = false;
            // 
            // Reports
            // 
            this.Reports.AutoSize = true;
            this.Reports.Font = new System.Drawing.Font("Microsoft Sans Serif", 48F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Reports.ForeColor = System.Drawing.SystemColors.Highlight;
            this.Reports.Location = new System.Drawing.Point(328, 23);
            this.Reports.Name = "Reports";
            this.Reports.Size = new System.Drawing.Size(257, 73);
            this.Reports.TabIndex = 12;
            this.Reports.Text = "Reports";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 28F);
            this.label1.ForeColor = System.Drawing.SystemColors.Highlight;
            this.label1.Location = new System.Drawing.Point(2, 209);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(0, 44);
            this.label1.TabIndex = 13;
            // 
            // txtstudentId
            // 
            this.txtstudentId.Location = new System.Drawing.Point(666, 266);
            this.txtstudentId.Name = "txtstudentId";
            this.txtstudentId.Size = new System.Drawing.Size(88, 20);
            this.txtstudentId.TabIndex = 14;
            this.txtstudentId.Text = "Student ID";
            // 
            // frmInstructor
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.ClientSize = new System.Drawing.Size(775, 350);
            this.Controls.Add(this.txtstudentId);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.Reports);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.txtTopic);
            this.Controls.Add(this.txtExamNum);
            this.Controls.Add(this.txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse);
            this.Controls.Add(this.txtspReturnGradesOfStudentInAllCourses);
            this.Controls.Add(this.button6);
            this.Controls.Add(this.btnspRetriveTheExam);
            this.Controls.Add(this.btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse);
            this.Controls.Add(this.btnspReturnGradesOfStudentInAllCourses);
            this.Controls.Add(this.btnspGetStudentsInDepartment);
            this.Controls.Add(this.txtbspGetStudentsInDepartment);
            this.Controls.Add(this.textInstructorID);
            this.Controls.Add(this.btnspGetExambyID);
            this.Margin = new System.Windows.Forms.Padding(2);
            this.Name = "frmInstructor";
            this.Text = "frmInstructor";
            this.Load += new System.EventHandler(this.frmInstructor_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnspGetExambyID;
        private System.Windows.Forms.TextBox textInstructorID;
        private System.Windows.Forms.Button btnspGetStudentsInDepartment;
        private System.Windows.Forms.Button btnspReturnGradesOfStudentInAllCourses;
        private System.Windows.Forms.Button btnspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse;
        private System.Windows.Forms.Button btnspRetriveTheExam;
        private System.Windows.Forms.Button button6;
        private System.Windows.Forms.TextBox txtbspGetStudentsInDepartment;
        private System.Windows.Forms.TextBox txtspReturnGradesOfStudentInAllCourses;
        private System.Windows.Forms.TextBox txtspReturnCoursesTeachedByInstructorAndNumberOfStudentPerCourse;
        private System.Windows.Forms.TextBox txtExamNum;
        private System.Windows.Forms.TextBox txtTopic;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label Reports;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtstudentId;
    }
}