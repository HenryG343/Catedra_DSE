using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ConexionDatos;
using WebService_Pub.Models;

namespace WebService_Pub.Models
{
    public class TransportistaModel : AbstractModel<usuarios_trans>
    {
        public List<String> Placas()
        {
            var consulta = from t in ctx.usuarios_trans
                           select t.placa;
            return consulta.ToList();
        }
    }
}