using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ConexionDatos;
using WebService_Pub.Models;

namespace WebService_Pub.Models
{
    public class SerieSacModel : AbstractModel<sacEntities>
    {
        public List<String> Sac()
        {
            //var idNegocios = new[] { "47223", "73600", "47233", "47215", "47231", "55269", "55830", "68090", "80247" };
            var consulta = from a in ctx2.tbl_activos
                           join m in ctx2.tbl_modelos
                           on a.id_modelo equals m.id_modelo
                           where new[] { "47223", "73600", "47233", "47215", "47231", "55269", "55830", "68090", "80247" }.Any(s => s.Equals(a.id_negocio.ToString()))
                           select a.id_serie;
            return consulta.ToList();
        }
    }
}