//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ConexionDatos
{
    using System;
    using System.Collections.Generic;
    
    public partial class usuarios_adm
    {
        public int id_usuario { get; set; }
        public string dui { get; set; }
        public int id_tipo { get; set; }
        public string nombre { get; set; }
        public string apellidos { get; set; }
        public string contra { get; set; }
    
        public virtual tipo_usuarios tipo_usuarios { get; set; }
    }
}
