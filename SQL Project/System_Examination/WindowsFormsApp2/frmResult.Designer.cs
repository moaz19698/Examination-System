
namespace System_Examination
{
    partial class frmResult
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
            this.label1 = new System.Windows.Forms.Label();
            this.lbfinalscore = new System.Windows.Forms.Label();
            this.lbResult = new System.Windows.Forms.Label();
            this.btnFinish = new System.Windows.Forms.Button();
            this.gBContianer = new System.Windows.Forms.GroupBox();
            this.lblGrade = new System.Windows.Forms.Label();
            this.gBContianer.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Gabriola", 22F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(208, -21);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(129, 68);
            this.label1.TabIndex = 0;
            this.label1.Text = "Welcome";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // lbfinalscore
            // 
            this.lbfinalscore.AutoSize = true;
            this.lbfinalscore.Font = new System.Drawing.Font("Gabriola", 19F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lbfinalscore.Location = new System.Drawing.Point(55, 57);
            this.lbfinalscore.Name = "lbfinalscore";
            this.lbfinalscore.Size = new System.Drawing.Size(203, 59);
            this.lbfinalscore.TabIndex = 1;
            this.lbfinalscore.Text = "Your Final Score Is";
            // 
            // lbResult
            // 
            this.lbResult.AutoSize = true;
            this.lbResult.Font = new System.Drawing.Font("Gabriola", 19F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lbResult.Location = new System.Drawing.Point(325, 57);
            this.lbResult.Name = "lbResult";
            this.lbResult.Size = new System.Drawing.Size(58, 59);
            this.lbResult.TabIndex = 2;
            this.lbResult.Text = "100";
            // 
            // btnFinish
            // 
            this.btnFinish.BackColor = System.Drawing.SystemColors.Highlight;
            this.btnFinish.Font = new System.Drawing.Font("Gabriola", 20F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnFinish.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnFinish.Location = new System.Drawing.Point(378, 140);
            this.btnFinish.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnFinish.Name = "btnFinish";
            this.btnFinish.Size = new System.Drawing.Size(127, 76);
            this.btnFinish.TabIndex = 3;
            this.btnFinish.Text = "Finish";
            this.btnFinish.UseVisualStyleBackColor = false;
            this.btnFinish.Click += new System.EventHandler(this.button1_Click);
            // 
            // gBContianer
            // 
            this.gBContianer.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.gBContianer.Controls.Add(this.lblGrade);
            this.gBContianer.Controls.Add(this.lbResult);
            this.gBContianer.Controls.Add(this.label1);
            this.gBContianer.Controls.Add(this.btnFinish);
            this.gBContianer.Controls.Add(this.lbfinalscore);
            this.gBContianer.Location = new System.Drawing.Point(177, 60);
            this.gBContianer.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.gBContianer.Name = "gBContianer";
            this.gBContianer.Padding = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.gBContianer.Size = new System.Drawing.Size(530, 224);
            this.gBContianer.TabIndex = 4;
            this.gBContianer.TabStop = false;
            // 
            // lblGrade
            // 
            this.lblGrade.AutoSize = true;
            this.lblGrade.Location = new System.Drawing.Point(264, 79);
            this.lblGrade.Name = "lblGrade";
            this.lblGrade.Size = new System.Drawing.Size(0, 20);
            this.lblGrade.TabIndex = 4;
            // 
            // frmResult
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.ClientSize = new System.Drawing.Size(914, 600);
            this.Controls.Add(this.gBContianer);
            this.ForeColor = System.Drawing.SystemColors.Highlight;
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmResult";
            this.Text = "Form3";
            this.Load += new System.EventHandler(this.frmResult_Load);
            this.gBContianer.ResumeLayout(false);
            this.gBContianer.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lbfinalscore;
        private System.Windows.Forms.Label lbResult;
        private System.Windows.Forms.Button btnFinish;
        private System.Windows.Forms.GroupBox gBContianer;
        private System.Windows.Forms.Label lblGrade;
    }
}