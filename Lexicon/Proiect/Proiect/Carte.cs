//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Proiect
{
    using System;
    using System.Collections.Generic;
    
    public partial class Carte
    {
        public Carte()
        {
            this.Cos = new HashSet<Co>();
        }
    
        public int Cod_carte { get; set; }
        public string Titlu { get; set; }
        public int Cod_autor { get; set; }
        public int Cod_gen { get; set; }
        public int Cod_edit { get; set; }
        public string Descriere { get; set; }
        public string Recenzie { get; set; }
    
        public virtual Autori Autori { get; set; }
        public virtual Editura Editura { get; set; }
        public virtual Gen Gen { get; set; }
        public virtual ICollection<Co> Cos { get; set; }
    }
}
