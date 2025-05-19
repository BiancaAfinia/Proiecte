using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Proiect
{
    public partial class PaginaLogin : Form
    {
        public Cont cont = new Cont();
        private bool ParolaVizibila = false;
        public PaginaLogin()
        {
            InitializeComponent();
            this.FormBorderStyle = FormBorderStyle.None;
            this.WindowState = FormWindowState.Maximized;

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            panel1.BackColor = Color.FromArgb(170, 0, 0, 0);
            button1.BackColor = Color.FromArgb(150, 0, 0, 0);
            button2.BackColor = Color.FromArgb(150, 0, 0, 0);
            button3.BackColor = Color.FromArgb(100, 0, 0, 0);
            btnPassword.BackColor = Color.FromArgb(30, 0, 0, 0);
            btnPassword.BackgroundImage = Proiect.Properties.Resources.icons8_eye_50;

            if (Globale.emailRetinut != null)
            {
                email.Text = Globale.emailRetinut;
                checkBox1.Checked = true;
                parola.Focus();
            }
            else
            {
                email.Clear();
                checkBox1.Checked = false;
            }
        }
        private bool ValidEmail(string email)
        {
            if (string.IsNullOrEmpty(email)) return false;

            foreach (char c in email)
            {
                if (c > 127) return false; // verific dacă e caracter ASCII între [0, 126]
            }

            if (!char.IsLetter(email[0]) || !char.IsLetter(email[email.Length - 1]))
            {
                return false;
            }

            int arond = email.IndexOf('@');
            if (arond < 0 || arond >= email.Length - 1) return false;

            int pct = email.IndexOf('.', arond + 2);
            if (pct < 0 || pct == email.Length - 1) return false;

            foreach (char c in email)
            {
                if (!(char.IsLetterOrDigit(c) || c == '@' || c == '.' || c == '-' || c == '_'))
                {
                    return false;
                }
            }

            return true;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(email.Text) || string.IsNullOrWhiteSpace(parola.Text))
            {
                MessageBox.Show("Introduceți email-ul și parola!");
                return;
            }

            if (!ValidEmail(email.Text))
            {
                MessageBox.Show("Email-ul introdus nu este valid!");
                email.Clear();
                return;
            }
            if (checkBox1.Checked == true)
            {
                Globale.emailRetinut = email.Text;
            }
            else
            {
                if (Globale.emailRetinut != null)
                {
                    Globale.emailRetinut = null;
                }
            }

            using (LibrarieEntities entities = new LibrarieEntities())
            {
                IList<Cont> conturi = (from cont in entities.Conts select cont).ToList();

                bool emailGasit = false;

                foreach (Cont cont in conturi)
                {
                    if (cont.Email == email.Text)
                    {
                        emailGasit = true;
                        if (cont.Parola == parola.Text)
                        {
                            Globale.email = email.Text;
                            Globale.parola = parola.Text;

                            email.Clear();
                            parola.Clear();
                            this.Hide();
                            new PaginaPrincipala().Show();
                            return;
                        }
                        else
                        {
                            MessageBox.Show("Parola greșită!");
                            parola.Clear();
                            return;
                        }
                    }
                }

                if (!emailGasit)
                {
                    MessageBox.Show("Email-ul nu există!");
                    email.Clear();
                    parola.Clear();
                }
            }
        }
        private void button3_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            new PaginaInregistrare().Show();
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void btnPassword_Click(object sender, EventArgs e)
        {
            if (ParolaVizibila)
            {
                parola.PasswordChar = '*';
                btnPassword.BackgroundImage = Proiect.Properties.Resources.icons8_eye_50;
                ParolaVizibila = false;
            }
            else
            {
                parola.PasswordChar = '\0';
                btnPassword.BackgroundImage = Proiect.Properties.Resources.icons8_closed_eye_50;
                ParolaVizibila = true;
            }
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (!checkBox1.Checked)
            {
                if (Globale.emailRetinut != null)
                {
                    Globale.emailRetinut = null;
                }
                email.Clear();
            }

        }
    }
   
}
