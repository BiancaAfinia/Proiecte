using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.Entity;

namespace Proiect
{
    public partial class PaginaCont : Form
    {
        
        public PaginaCont()
        {
            InitializeComponent();
            this.FormBorderStyle = FormBorderStyle.None;
            this.WindowState = FormWindowState.Maximized;
            this.AutoScaleMode = AutoScaleMode.Dpi;

        }

        private void PaginaCont_Load(object sender, EventArgs e)
        {
            email.Text = Globale.email;
            parola.Text = Globale.parola;

            using (var context = new LibrarieEntities())
            {
                var account = context.Conts.Include(a=> a.Cos.Select(c=> c.Carte.Autori)).FirstOrDefault(a => a.Email == Globale.email);
                listView1.View = View.Details;
                listView1.Columns.Add("Titlu", 400);
                listView1.Columns.Add("Autor", 400);
                if (account != null)
                {
                    
                    foreach (var c in account.Cos)
                    {
                        var carte = c.Carte;
                        var autor = context.Autoris.FirstOrDefault(a => a.Cod_autor == carte.Cod_autor);
                        if (carte != null && autor != null)
                        {
                            ListViewItem item = new ListViewItem(carte.Titlu);
                            item.SubItems.Add(autor.Nume);
                            item.Tag = carte.Cod_carte; // Seteaza tag-ul cu codul cartii
                            listView1.Items.Add(item);
                        }
                    }
                }
                
            }
        }
       

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            new PaginaPrincipala().Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            //daca nu avem nimic selectat in listview, afisam un mesaj
            if (listView1.SelectedItems.Count == 0)
            {
                MessageBox.Show("Selectati o carte pentru a o sterge din cos!");
                return;
            }
            var selectedItem = listView1.SelectedItems[0];
            int codCarte = (int)selectedItem.Tag; // Obține codul cărții din tag-ul item-ului
            using (var context = new LibrarieEntities())
            {
                var account = context.Conts.FirstOrDefault(a => a.Email == Globale.email);
                if (account != null)
                {
                    var carte = account.Cos.FirstOrDefault(c => c.Cod_cont == account.Cod_cont && c.Cod_carte == codCarte);
                    if (carte != null)
                    {
                        context.Cos.Remove(carte);
                        context.SaveChanges();
                        MessageBox.Show("Cartea a fost stearsa din cos!");
                        listView1.Items.Remove(selectedItem);
                    }
                    else
                    {
                        MessageBox.Show("Cartea nu a fost gasita in cos!");
                    }
                }
            }
        }

        private void SchimbaParola_Click(object sender, EventArgs e)
        {
            string parolaNoua = textBox1.Text;
            string confirmaParola = textBox2.Text;

            if (string.IsNullOrWhiteSpace(parolaNoua) || string.IsNullOrWhiteSpace(confirmaParola))
            {
                MessageBox.Show("Ambele câmpuri trebuie completate!", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // Verificăm dacă parolele coincid
            if (parolaNoua != confirmaParola)
            {
                MessageBox.Show("Parolele nu coincid!", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // Actualizăm parola în baza de date
            try
            {
                using (var context = new LibrarieEntities())
                {
                    // Găsim contul curent (presupunem că avem emailul în variabila globală)
                    var cont = context.Conts.FirstOrDefault(c => c.Email == Globale.email);

                    if (cont != null)
                    {
                        cont.Parola = parolaNoua;
                        parola.Text = parolaNoua;
                        context.SaveChanges();

                        MessageBox.Show("Parola a fost schimbată cu succes!", "Succes", MessageBoxButtons.OK, MessageBoxIcon.Information);

                        // Resetăm câmpurile după succes
                        textBox1.Text = "";
                        textBox2.Text = "";
                    }
                    else
                    {
                        MessageBox.Show("Contul nu a fost găsit!", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"A apărut o eroare la actualizarea parolei: {ex.Message}", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
