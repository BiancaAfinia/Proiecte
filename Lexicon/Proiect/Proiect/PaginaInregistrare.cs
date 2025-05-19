using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Objects.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Proiect
{
    public partial class PaginaInregistrare: Form
    {
        Cont contModel = new Cont();
        public PaginaInregistrare()
        {
            InitializeComponent();
            this.FormBorderStyle = FormBorderStyle.None;
            this.WindowState = FormWindowState.Maximized;
        }

        private void Form3_Load(object sender, EventArgs e)
        {
            panel1.BackColor = Color.FromArgb(170, 0, 0, 0);
            button3.BackColor = Color.FromArgb(100, 0, 0, 0);
            button1.BackColor = Color.FromArgb(150, 0, 0, 0);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Hide();
            new PaginaLogin().Show();
        }
        
        private void button1_Click(object sender, EventArgs e)
        {
            /*LibrarieEntities1 entities = new LibrarieEntities1();
            IList<Cont> conturi = (from cont in entities.Conts select cont).ToList();
            contModel.Email = email.Text;
            contModel.Parola = parola.Text;
            if(contModel.Email != "" && contModel.Parola != "")
            {
                if(contModel.Parola == parolaRe.Text)
                {
                    foreach(Cont cont in conturi)
                    {
                        if (contModel.Email == cont.Email)
                        {
                            email.Clear();
                            parola.Clear();
                            parolaRe.Clear();
                            MessageBox.Show("Email-ul există deja!");
                            return;
                        }
                    }
                    //Creaza cont nou
                    int lastId = entities.Conts.Max(c => (int?)c.Cod_cont) ?? 0; 
                    int newId = lastId + 1;

                    var testCont = new Cont()
                    {
                        Cod_cont = newId,
                        Email =contModel.Email,
                       Parola=contModel.Parola
                    };
                    entities.Conts.Add(testCont);
                    entities.SaveChanges();
                    email.Clear();
                    parola.Clear();
                    parolaRe.Clear();
                    MessageBox.Show("Cont creat cu succes!");
                    this.Hide();
                    new Form1().Show();

                }
                else
                {
                    MessageBox.Show("Parolele nu coincid!");
                }
            }
            else
            {
                MessageBox.Show("Introduceți date valide!");
            }*/
            using (LibrarieEntities entities = new LibrarieEntities()) // Asigură eliberarea corectă a resurselor
            {
                // Preia datele din câmpurile de text
                contModel.Email = email.Text.Trim();  // Elimină spațiile albe la început și sfârșit
                contModel.Parola = parola.Text.Trim();

                // Verifică dacă câmpurile sunt completate
                if (string.IsNullOrWhiteSpace(contModel.Email) || string.IsNullOrWhiteSpace(contModel.Parola))
                {
                    MessageBox.Show("Introduceți date valide!");
                    return;
                }

                // Verifică dacă parolele coincid
                if (contModel.Parola != parolaRe.Text.Trim())
                {
                    MessageBox.Show("Parolele nu coincid!");
                    return;
                }

                // Verifică dacă email-ul există deja în baza de date
                bool emailExists = entities.Conts.Any(c => c.Email == contModel.Email);
                if (emailExists)
                {
                    MessageBox.Show("Email-ul există deja!");
                    email.Clear();
                    parola.Clear();
                    parolaRe.Clear();
                    return;
                }

                // Găsește ultimul ID și creează unul nou
                int lastId = entities.Conts.Max(c => (int?)c.Cod_cont) ?? 0;
                int newId = lastId + 1;

                // Creează și adaugă noul cont
                var testCont = new Cont()
                {
                    Cod_cont = newId,
                    Email = contModel.Email,
                    Parola = contModel.Parola
                };

                entities.Conts.Add(testCont);
                entities.SaveChanges();  // Salvează în baza de date

                // Curăță câmpurile și afișează mesajul de succes
                email.Clear();
                parola.Clear();
                parolaRe.Clear();
                MessageBox.Show("Cont creat cu succes!");

                // Ascunde fereastra curentă și deschide Form1
                this.Hide();
                new PaginaLogin().Show();
            }
        }
    }

}
