
using System;

namespace System_Examination
{
    partial class frmQuestion
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
            this.Gbexam = new System.Windows.Forms.GroupBox();
            this.lbwelcome = new System.Windows.Forms.Label();
            this.gBoxquestioncontianer = new System.Windows.Forms.GroupBox();
            this.lblQuestionBody = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.lbQuestion = new System.Windows.Forms.Label();
            this.btnPrev = new System.Windows.Forms.Button();
            this.btnFinish = new System.Windows.Forms.Button();
            this.btnNext = new System.Windows.Forms.Button();
            this.radioButtonAnswer4 = new System.Windows.Forms.RadioButton();
            this.radioButtonAnswer3 = new System.Windows.Forms.RadioButton();
            this.radioButtonAnswer2 = new System.Windows.Forms.RadioButton();
            this.radioButtonAnswer1 = new System.Windows.Forms.RadioButton();
            this.Gbexam.SuspendLayout();
            this.gBoxquestioncontianer.SuspendLayout();
            this.SuspendLayout();
            // 
            // Gbexam
            // 
            this.Gbexam.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.Gbexam.Controls.Add(this.lbwelcome);
            this.Gbexam.Controls.Add(this.gBoxquestioncontianer);
            this.Gbexam.Controls.Add(this.btnPrev);
            this.Gbexam.Controls.Add(this.btnFinish);
            this.Gbexam.Controls.Add(this.btnNext);
            this.Gbexam.Controls.Add(this.radioButtonAnswer4);
            this.Gbexam.Controls.Add(this.radioButtonAnswer3);
            this.Gbexam.Controls.Add(this.radioButtonAnswer2);
            this.Gbexam.Controls.Add(this.radioButtonAnswer1);
            this.Gbexam.Font = new System.Drawing.Font("Gabriola", 19F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.Gbexam.ForeColor = System.Drawing.SystemColors.Highlight;
            this.Gbexam.Location = new System.Drawing.Point(15, 18);
            this.Gbexam.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.Gbexam.Name = "Gbexam";
            this.Gbexam.Padding = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.Gbexam.Size = new System.Drawing.Size(1005, 535);
            this.Gbexam.TabIndex = 0;
            this.Gbexam.TabStop = false;
            // 
            // lbwelcome
            // 
            this.lbwelcome.AutoSize = true;
            this.lbwelcome.Font = new System.Drawing.Font("Gabriola", 22F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lbwelcome.ForeColor = System.Drawing.SystemColors.Highlight;
            this.lbwelcome.Location = new System.Drawing.Point(19, -9);
            this.lbwelcome.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lbwelcome.Name = "lbwelcome";
            this.lbwelcome.Size = new System.Drawing.Size(123, 68);
            this.lbwelcome.TabIndex = 11;
            this.lbwelcome.Text = "welcome";
            // 
            // gBoxquestioncontianer
            // 
            this.gBoxquestioncontianer.AutoSize = true;
            this.gBoxquestioncontianer.Controls.Add(this.lblQuestionBody);
            this.gBoxquestioncontianer.Controls.Add(this.label1);
            this.gBoxquestioncontianer.Controls.Add(this.lbQuestion);
            this.gBoxquestioncontianer.ForeColor = System.Drawing.SystemColors.Highlight;
            this.gBoxquestioncontianer.Location = new System.Drawing.Point(19, 51);
            this.gBoxquestioncontianer.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.gBoxquestioncontianer.Name = "gBoxquestioncontianer";
            this.gBoxquestioncontianer.Padding = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.gBoxquestioncontianer.Size = new System.Drawing.Size(906, 193);
            this.gBoxquestioncontianer.TabIndex = 10;
            this.gBoxquestioncontianer.TabStop = false;
            // 
            // lblQuestionBody
            // 
            this.lblQuestionBody.AutoSize = true;
            this.lblQuestionBody.Location = new System.Drawing.Point(44, 62);
            this.lblQuestionBody.Name = "lblQuestionBody";
            this.lblQuestionBody.Size = new System.Drawing.Size(0, 59);
            this.lblQuestionBody.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, -63);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(0, 59);
            this.label1.TabIndex = 2;
            // 
            // lbQuestion
            // 
            this.lbQuestion.AutoSize = true;
            this.lbQuestion.Font = new System.Drawing.Font("Gabriola", 19F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lbQuestion.Location = new System.Drawing.Point(12, 76);
            this.lbQuestion.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lbQuestion.Name = "lbQuestion";
            this.lbQuestion.Size = new System.Drawing.Size(0, 59);
            this.lbQuestion.TabIndex = 1;
            // 
            // btnPrev
            // 
            this.btnPrev.BackColor = System.Drawing.SystemColors.Menu;
            this.btnPrev.Font = new System.Drawing.Font("Gabriola", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnPrev.Location = new System.Drawing.Point(148, 438);
            this.btnPrev.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.btnPrev.Name = "btnPrev";
            this.btnPrev.Size = new System.Drawing.Size(155, 61);
            this.btnPrev.TabIndex = 9;
            this.btnPrev.Text = "Previous";
            this.btnPrev.UseVisualStyleBackColor = false;
            this.btnPrev.Click += new System.EventHandler(this.button1_Click);
            // 
            // btnFinish
            // 
            this.btnFinish.BackColor = System.Drawing.SystemColors.Highlight;
            this.btnFinish.Font = new System.Drawing.Font("Gabriola", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnFinish.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnFinish.Location = new System.Drawing.Point(725, 438);
            this.btnFinish.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.btnFinish.Name = "btnFinish";
            this.btnFinish.Size = new System.Drawing.Size(179, 61);
            this.btnFinish.TabIndex = 8;
            this.btnFinish.Text = "Finish  Exam";
            this.btnFinish.UseVisualStyleBackColor = false;
            this.btnFinish.Click += new System.EventHandler(this.btnFinish_Click);
            // 
            // btnNext
            // 
            this.btnNext.BackColor = System.Drawing.SystemColors.MenuBar;
            this.btnNext.Font = new System.Drawing.Font("Gabriola", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnNext.Location = new System.Drawing.Point(442, 439);
            this.btnNext.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(164, 60);
            this.btnNext.TabIndex = 7;
            this.btnNext.Text = "Next";
            this.btnNext.UseVisualStyleBackColor = false;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
            // 
            // radioButtonAnswer4
            // 
            this.radioButtonAnswer4.AutoSize = true;
            this.radioButtonAnswer4.Font = new System.Drawing.Font("Gabriola", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.radioButtonAnswer4.Location = new System.Drawing.Point(26, 362);
            this.radioButtonAnswer4.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.radioButtonAnswer4.Name = "radioButtonAnswer4";
            this.radioButtonAnswer4.Size = new System.Drawing.Size(118, 54);
            this.radioButtonAnswer4.TabIndex = 5;
            this.radioButtonAnswer4.TabStop = true;
            this.radioButtonAnswer4.Text = "answer 4";
            this.radioButtonAnswer4.UseVisualStyleBackColor = true;
            // 
            // radioButtonAnswer3
            // 
            this.radioButtonAnswer3.AutoSize = true;
            this.radioButtonAnswer3.Font = new System.Drawing.Font("Gabriola", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.radioButtonAnswer3.Location = new System.Drawing.Point(26, 325);
            this.radioButtonAnswer3.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.radioButtonAnswer3.Name = "radioButtonAnswer3";
            this.radioButtonAnswer3.Size = new System.Drawing.Size(116, 54);
            this.radioButtonAnswer3.TabIndex = 4;
            this.radioButtonAnswer3.TabStop = true;
            this.radioButtonAnswer3.Text = "answer 3";
            this.radioButtonAnswer3.UseVisualStyleBackColor = true;
            // 
            // radioButtonAnswer2
            // 
            this.radioButtonAnswer2.AutoSize = true;
            this.radioButtonAnswer2.Font = new System.Drawing.Font("Gabriola", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.radioButtonAnswer2.Location = new System.Drawing.Point(26, 288);
            this.radioButtonAnswer2.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.radioButtonAnswer2.Name = "radioButtonAnswer2";
            this.radioButtonAnswer2.Size = new System.Drawing.Size(116, 54);
            this.radioButtonAnswer2.TabIndex = 3;
            this.radioButtonAnswer2.TabStop = true;
            this.radioButtonAnswer2.Text = "answer 2";
            this.radioButtonAnswer2.UseVisualStyleBackColor = true;
            // 
            // radioButtonAnswer1
            // 
            this.radioButtonAnswer1.AutoSize = true;
            this.radioButtonAnswer1.Font = new System.Drawing.Font("Gabriola", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.radioButtonAnswer1.Location = new System.Drawing.Point(26, 252);
            this.radioButtonAnswer1.Margin = new System.Windows.Forms.Padding(2, 4, 2, 4);
            this.radioButtonAnswer1.Name = "radioButtonAnswer1";
            this.radioButtonAnswer1.Size = new System.Drawing.Size(113, 54);
            this.radioButtonAnswer1.TabIndex = 2;
            this.radioButtonAnswer1.TabStop = true;
            this.radioButtonAnswer1.Text = "answer 1";
            this.radioButtonAnswer1.UseVisualStyleBackColor = true;
            // 
            // frmQuestion
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 28F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.ClientSize = new System.Drawing.Size(1112, 582);
            this.Controls.Add(this.Gbexam);
            this.Font = new System.Drawing.Font("Gabriola", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmQuestion";
            this.Text = "Exam";
            this.Load += new System.EventHandler(this.frmQuestion_Load);
            this.Gbexam.ResumeLayout(false);
            this.Gbexam.PerformLayout();
            this.gBoxquestioncontianer.ResumeLayout(false);
            this.gBoxquestioncontianer.PerformLayout();
            this.ResumeLayout(false);

        }


        #endregion

        private System.Windows.Forms.GroupBox Gbexam;
        private System.Windows.Forms.Button btnPrev;
        private System.Windows.Forms.Button btnFinish;
        private System.Windows.Forms.Button btnNext;
        private System.Windows.Forms.RadioButton radioButtonAnswer4;
        private System.Windows.Forms.RadioButton radioButtonAnswer3;
        private System.Windows.Forms.RadioButton radioButtonAnswer2;
        private System.Windows.Forms.RadioButton radioButtonAnswer1;
        private System.Windows.Forms.Label lbQuestion;
        private System.Windows.Forms.Label lbwelcome;
        private System.Windows.Forms.GroupBox gBoxquestioncontianer;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblQuestionBody;
    }
}