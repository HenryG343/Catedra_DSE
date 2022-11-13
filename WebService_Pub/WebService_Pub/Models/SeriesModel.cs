using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ConexionDatos;
using WebService_Pub.Models;

namespace WebService_Pub.Models
{
    public class SeriesModel : AbstractModel<series_escaneadas>
    {
        public int Insertar(int idusuario, String serie, string placa)
        {
            UsuariosModel usuario = new UsuariosModel();
            series_escaneadas serieInsertar = new series_escaneadas();
            SeriesModel serieGetID = new SeriesModel();
            try
            {
                serieInsertar.placa = placa;
                serieInsertar.serie = serie;
                dbSet.Add(serieInsertar);
                ctx.SaveChanges();
                return 1;
            }
            catch
            {
                return 0;
            }
        }
        public int GetIDInsertado(int idusuario, String serie)
        {
            var consulta = (from t in ctx.series_escaneadas
                            where t.serie == serie
                            select t.id_serie).FirstOrDefault();
            return consulta;
        }
    }
}