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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class mersaEntities : DbContext
    {
        public mersaEntities()
            : base("name=mersaEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<series_escaneadas> series_escaneadas { get; set; }
        public virtual DbSet<tipo_usuarios> tipo_usuarios { get; set; }
        public virtual DbSet<usuarios_adm> usuarios_adm { get; set; }
        public virtual DbSet<usuarios_trans> usuarios_trans { get; set; }
    }
}
