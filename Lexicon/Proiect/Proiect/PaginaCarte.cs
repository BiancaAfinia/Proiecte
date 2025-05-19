using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.Entity;
using PdfiumViewer;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TextBox;
namespace Proiect
{
    public partial class PaginaCarte: Form
    { Carte _carte;
        public PaginaCarte()
        {
            InitializeComponent();
            this.FormBorderStyle = FormBorderStyle.None;
            this.WindowState = FormWindowState.Maximized;
            this.AutoScaleMode = AutoScaleMode.Dpi;
        }
        public PaginaCarte(Carte carte)
        {
            InitializeComponent();
            Gasire(carte);
            _carte = carte;
            this.FormBorderStyle = FormBorderStyle.None;
            this.WindowState = FormWindowState.Maximized;
            this.AutoScaleMode = AutoScaleMode.Dpi;
        }
        private void Gasire(Carte carte)
        {
            try
            {
                // Verify the passed object has all required data
                if (carte == null)
                {
                    MessageBox.Show("Cartea nu a fost găsită!");
                    return;
                }
                // Set title in label1
                label1.Text = carte.Titlu;

                // Load image in pictureBox1
                try
                {
                    string imagePath = Path.Combine(Application.StartupPath, $"{carte.Titlu}.jpg");
                    if (File.Exists(imagePath))
                    {
                        pictureBox1.Image = new Bitmap(imagePath);
                    }
                    else
                    {
                       // pictureBox1.Image = Properties.Resources.DefaultCover;
                        MessageBox.Show($"Imaginea pentru {carte.Titlu} nu a fost găsită!");
                    }
                }
                catch (Exception ex)
                {
                   // pictureBox1.Image = Properties.Resources.DefaultCover;
                    MessageBox.Show($"Eroare la încărcarea imaginii: {ex.Message}");
                }

                textBox1.Text = !string.IsNullOrEmpty(carte.Descriere)
        ? carte.Descriere
        : "Nu există descriere disponibilă";

                textBox2.Text = !string.IsNullOrEmpty(carte.Recenzie)
                    ? carte.Recenzie
                    : "Nu există recenzie disponibilă";

            }
            catch (Exception ex)
            {
                MessageBox.Show($"Eroare la încărcarea datelor cărții: {ex.Message}");
            }
        }

        
        private void PaginaCarte_Load(object sender, EventArgs e)
        {
            //aici la load trebe setate toate, gen imaginea din picturebox, textul de la descriere, recenzia si textul din label unde vezi ca am scris --------. toate astea se iau din baza de date
        }


        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            new PaginaCont().Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //asta e butonu de adaugat in cos. Aici ma gandesc ca putem seta o variabila globala in clasa Globale care sa memoreze o caracteristica a cartii, gen codul ei si in cos sa bagam cartea in functie de acel cod. Variabila globala va primi valoarea cartii doar daca intram pe pagina cartii.
            if (Globale.numeCarte != null)
            {
                using (var context = new LibrarieEntities())
                {
                    var existaCarte = context.Cos.Include(a => a.Carte).FirstOrDefault(a => a.Carte.Titlu == Globale.numeCarte && a.Cont.Email == Globale.email);
                    if (existaCarte != null)
                    {
                        MessageBox.Show("Cartea este deja în coș!");
                        return;
                    }
                    else
                    {
                        var carte = context.Cartes.FirstOrDefault(a => a.Titlu == Globale.numeCarte);
                        if (carte != null)
                        {
                            context.Cos.Add(new Co
                            {
                                Cod_carte = carte.Cod_carte,
                                Cod_cont = context.Conts.FirstOrDefault(a => a.Email == Globale.email).Cod_cont,
                                ID_cos = context.Cos.Count() + 1

                            });
                            context.SaveChanges();
                            MessageBox.Show("Cartea a fost adăugată în coș!");
                        }


                    }
                }

            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Hide();
            new PaginaPrincipala().Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (_carte == null)
            {
                MessageBox.Show("Nu există carte selectată!");
                return;
            }

            string pdfPath = FindPdfByTitle(_carte.Titlu); // Folosește titlul cărții salvate

            if (pdfPath != null)
            {
                try
                {
                    pdfViewer1.Document?.Dispose();
                    pdfViewer1.Document = PdfDocument.Load(pdfPath);
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Eroare la încărcare: {ex.Message}");
                }
            }
            else
            {
                MessageBox.Show($"PDF-ul pentru '{_carte.Titlu}' nu a fost găsit în folderul aplicației.");
            }
        }

        private string FindPdfByTitle(string partialName)
        {
            string appPath = Application.StartupPath;
            string[] pdfFiles = Directory.GetFiles(appPath, "*.pdf");

            foreach (string file in pdfFiles)
            {
                if (Path.GetFileNameWithoutExtension(file).Equals(partialName, StringComparison.OrdinalIgnoreCase))
                {
                    return file;
                }
            }
            return null;
        }
    }
}
