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
    
    public partial class tbl_modelos
    {
        public int id_agencia { get; set; }
        public int id_modelo { get; set; }
        public string descripcion { get; set; }
        public decimal costo { get; set; }
        public int trasladado { get; set; }
        public Nullable<System.DateTime> fecha_traslado { get; set; }
        public string linea { get; set; }
    }
}