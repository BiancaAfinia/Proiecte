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
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace Proiect
{
    //DISCLAIMER: DE ARATA CA DRACU DESIGNU NU I BAI, FA NUMA CODU SI MODIFIC EU DUPA DIMENSIUNILE PICTUREBOXULUI ETC IN FUNCTIE DE CARTI
    public partial class PaginaPrincipala: Form
    {
        public Carte carte = new Carte();
        public PaginaPrincipala()
        {
            InitializeComponent();
            this.FormBorderStyle = FormBorderStyle.None;
            this.WindowState = FormWindowState.Maximized;
            this.AutoScaleMode = AutoScaleMode.Dpi;

        }


        private void Form2_Load(object sender, EventArgs e)
        {
            button3.BackColor = Color.FromArgb(100, 0, 0, 0);
            button1.BackColor = Color.FromArgb(50, 0, 0, 0);
            //aici testez eu sa vad cum ar arata
            //ca sa testezi si tu alte imagini, trebe sa te duci in II_Proiect/Proiect/Proiect/bin/Debug si sa pui acolo imaginile pe care vrei sa le incarci
            try
            {
                string ImagesFile= Path.Combine(Application.StartupPath, "Poze Carti");
                string[] ImageFiles=Directory.GetFiles(ImagesFile, "*.jpg");
                Random rnd= new Random();
                ImageFiles= ImageFiles.OrderBy(x => rnd.Next()).ToArray();
                pictureBox1.Image = new Bitmap(ImageFiles[0]);
                pictureBox2.Image = new Bitmap(ImageFiles[1]);
                pictureBox3.Image = new Bitmap(ImageFiles[2]);

            }
            catch (Exception ex)
            {
                MessageBox.Show("Eroare la incarcarea imaginii: " + ex.Message);
            }
            
            //aici te rog sa faci ca in locurile pentru imagini sa se incarce random poze. Poti face asta, vezi site ul https://learn.microsoft.com/en-us/answers/questions/275271/button-and-random-image;
            //ca sa mearga trebe sa avem un numar clar de imagini in folder si numarul random sa fie intre 1 si acel numar
        }

        private void button3_Click(object sender, EventArgs e)
        {
            new PaginaLogin().Show();
            this.Hide();
            //asta e butonul de iesire de pe pagina principala
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //asta e butonul de search, ca sa poti apasa pe el trebuie sa iei textul din searchbox si din combobox si sa caute in baza de date acele valori
            //butonu asta dupa trebe sa te duca pe PaginaCarte DOAR DACA AI INTRODUS UN TITLU IN SEARCHBOX
            // Get the text from the search textbox
            string titluCautat = searchbox.Text.Trim();
            // Check if the search box is not empty
            if (string.IsNullOrEmpty(titluCautat))
            {
                MessageBox.Show("Introdu un titlu în căsuța de căutare!");
                return;
            }

            using (LibrarieEntities entities = new LibrarieEntities())
            {
                // Search for the book in the database
                Carte carteGasita = entities.Cartes
     .FirstOrDefault(c => c.Titlu.Equals(titluCautat));

                if (carteGasita != null)
                {
                    // Book found - open the book page
                    Globale.numeCarte = titluCautat; // salvam titlul cartii ca sa l putem adauga in cos daca dorim
                    this.Hide();
                    new PaginaCarte(carteGasita).Show(); // Assuming PaginaCarte accepts a Carte object
                }
                else
                {
                    // Book not found - show error
                    MessageBox.Show("Cartea nu a fost găsită!");
                    searchbox.Clear();
                }
            }
        }
        

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            new PaginaCont().Show();
            //asta e butonul de intrare pe pagina cont
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //aici itemele in sectiunea de filter le adaugi din proprietatile comboboxului (dai click o data pe combobox si mergi pe proprietati) la iconita unde vezi ca scrie A -> Z si o sa ai acolo items.) si sunt Istorie, Medicina,Mister
         
            if (comboBox1.SelectedItem == null) return;

            string genSelectat = comboBox1.SelectedItem.ToString();

            // Calea către folderul cu coperți
            string folderPath = Path.Combine(Application.StartupPath, genSelectat);

            try
            {
                // Obținem toate fișierele imagine din folderul genului selectat
                string[] imageFiles = Directory.GetFiles(folderPath, "*.jpg");

                // Verificăm dacă avem exact 3 imagini (presupunând că sunt 3 cărți per gen)
                if (imageFiles.Length != 3)
                {
                    MessageBox.Show($"Folderul {genSelectat} nu conține exact 3 cărți!");
                    return;
                }

                // Clear previous images
                pictureBox1.Image = null;
                pictureBox2.Image = null;
                pictureBox3.Image = null;

                // Încărcăm imaginile în PictureBox-uri
                try
                {
                    pictureBox1.Image = new Bitmap(imageFiles[0]);
                    pictureBox2.Image = new Bitmap(imageFiles[1]);
                    pictureBox3.Image = new Bitmap(imageFiles[2]);
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Eroare la încărcarea imaginilor: {ex.Message}");

                }
            }
            catch (DirectoryNotFoundException)
            {
                MessageBox.Show($"Folderul pentru genul {genSelectat} nu a fost găsit!");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Eroare: {ex.Message}");
            }
        }

        private void pictureBox3_Click(object sender, EventArgs e)
        {
            // Verificăm dacă avem o imagine în PictureBox
            if (pictureBox3.Image == null)
            {
                MessageBox.Show("Nu există nicio carte asociată acestui PictureBox.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // 1. Încercăm să obținem titlul din proprietatea Tag (dacă a fost setat)
            string titluCarte = pictureBox3.Tag?.ToString();
            Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim

            // 2. Dacă Tag nu este setat, încercăm să obținem din numele imaginii
            if (string.IsNullOrEmpty(titluCarte))
            {
                titluCarte = GetTitluCarteFromPictureBox(pictureBox3);
                Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim
            }

            // 3. Dacă tot nu avem titlu, afișăm eroare
            if (string.IsNullOrEmpty(titluCarte))
            {
                MessageBox.Show("Nu s-a putut identifica cartea. Asigurați-vă că imaginile au nume corespunzătoare titlurilor cărților.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // 4. Căutăm cartea în baza de date
            Carte carteGasita = GasesteCarteDupaTitlu(titluCarte);

            if (carteGasita != null)
            {
                Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim
                PaginaCarte formDetalii = new PaginaCarte(carteGasita);
                formDetalii.Show();
            }
            else
            {
                MessageBox.Show($"Cartea '{titluCarte}' nu a fost găsită în baza de date.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // Funcție nouă care extrage titlul cărții din PictureBox
        private string GetTitluCarteFromPictureBox(PictureBox pictureBox)
        {
            try
            {
                // Verificăm dacă avem ImageLocation setat
                if (!string.IsNullOrEmpty(pictureBox.ImageLocation))
                {
                    return Path.GetFileNameWithoutExtension(pictureBox.ImageLocation);
                }

                // Dacă nu, încercăm să găsim imaginea în folderul cu poze
                string titluCautat = FindImageInPozeCarti(pictureBox.Image);
                if (!string.IsNullOrEmpty(titluCautat))
                {
                    return titluCautat;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Eroare la extragerea titlului: {ex.Message}");
            }

            return null;
        }

        // Funcție care caută imaginea în folderul "Poze Carti" și returnează numele fișierului
        private string FindImageInPozeCarti(Image image)
        {
            string baseFolder = Path.Combine(Application.StartupPath, "Poze Carti");
            if (!Directory.Exists(baseFolder))
                return null;

            // Generăm un hash pentru imaginea curentă
            string currentImageHash = GetImageHash(image);

            // Căutăm printre toate imaginile din folder
            foreach (string imageFile in Directory.GetFiles(baseFolder, "*.jpg", SearchOption.AllDirectories))
            {
                try
                {
                    using (Image img = Image.FromFile(imageFile))
                    {
                        if (currentImageHash == GetImageHash(img))
                        {
                            return Path.GetFileNameWithoutExtension(imageFile);
                        }
                    }
                }
                catch { /* Ignorăm fișierele corupte */ }
            }

            return null;
        }

        // Funcție care generează un hash simplu pentru imagine
        private string GetImageHash(Image image)
        {
            try
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                    return BitConverter.ToString(System.Security.Cryptography.MD5.Create().ComputeHash(ms.ToArray()));
                }
            }
            catch
            {
                return Guid.NewGuid().ToString(); // Dacă apare eroare, returnăm un hash random
            }
        }

        // Funcție care returnează toate cărțile din folderul "Poze Carti"
        public List<string> GetToateCartile()
        {
            List<string> toateCartile = new List<string>();
            string baseFolder = Path.Combine(Application.StartupPath, "Poze Carti");

            if (Directory.Exists(baseFolder))
            {
                foreach (string imageFile in Directory.GetFiles(baseFolder, "*.jpg", SearchOption.AllDirectories))
                {
                    toateCartile.Add(Path.GetFileNameWithoutExtension(imageFile));
                }
            }

            return toateCartile.Distinct().ToList();
        }
        private Carte GasesteCarteDupaTitlu(string titlu)
{
    if (string.IsNullOrWhiteSpace(titlu))
        return null;

    using (var context = new LibrarieEntities())
    {
        // Normalizăm titlul pentru căutare
        //string titluCautare = titlu.ToLower().Replace(" ", "").Replace("-", "");
        
        return context.Cartes
                    .AsEnumerable()
                    .FirstOrDefault(c => 
                        c.Titlu != null && 
                        c.Titlu.Contains(titlu));
    }
}

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            // Verificăm dacă avem o imagine în PictureBox
            if (pictureBox1.Image == null)
            {
                MessageBox.Show("Nu există nicio carte asociată acestui PictureBox.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // 1. Încercăm să obținem titlul din proprietatea Tag (dacă a fost setat)
            string titluCarte = pictureBox1.Tag?.ToString();
            Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim

            // 2. Dacă Tag nu este setat, încercăm să obținem din numele imaginii
            if (string.IsNullOrEmpty(titluCarte))
            {
                titluCarte = GetTitluCarteFromPictureBox(pictureBox1);
                Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim
            }

            // 3. Dacă tot nu avem titlu, afișăm eroare
            if (string.IsNullOrEmpty(titluCarte))
            {
                MessageBox.Show("Nu s-a putut identifica cartea. Asigurați-vă că imaginile au nume corespunzătoare titlurilor cărților.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // 4. Căutăm cartea în baza de date
            Carte carteGasita = GasesteCarteDupaTitlu(titluCarte);

            if (carteGasita != null)
            {
                Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim
                PaginaCarte formDetalii = new PaginaCarte(carteGasita);
                formDetalii.Show();
            }
            else
            {
                MessageBox.Show($"Cartea '{titluCarte}' nu a fost găsită în baza de date.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {

            // Verificăm dacă avem o imagine în PictureBox
            if (pictureBox2.Image == null)
            {
                MessageBox.Show("Nu există nicio carte asociată acestui PictureBox.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // 1. Încercăm să obținem titlul din proprietatea Tag (dacă a fost setat)
            string titluCarte = pictureBox2.Tag?.ToString();
            Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim

            // 2. Dacă Tag nu este setat, încercăm să obținem din numele imaginii
            if (string.IsNullOrEmpty(titluCarte))
            {
                titluCarte = GetTitluCarteFromPictureBox(pictureBox2);
                Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim
            }

            // 3. Dacă tot nu avem titlu, afișăm eroare
            if (string.IsNullOrEmpty(titluCarte))
            {
                MessageBox.Show("Nu s-a putut identifica cartea. Asigurați-vă că imaginile au nume corespunzătoare titlurilor cărților.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // 4. Căutăm cartea în baza de date
            Carte carteGasita = GasesteCarteDupaTitlu(titluCarte);

            if (carteGasita != null)
            {
                Globale.numeCarte = titluCarte; // salvam titlul cartii ca sa l putem adauga in cos daca dorim
                PaginaCarte formDetalii = new PaginaCarte(carteGasita);
                formDetalii.Show();
            }
            else
            {
                MessageBox.Show($"Cartea '{titluCarte}' nu a fost găsită în baza de date.", "Eroare", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
