using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Mantenimiento_mersa
{
    class ClaseDeReporteTransportistas : Conexion
    {
        private Int32 idBol;
        private string fecha;
        private string chofer;
        private string placas;
        private string zona;
        private string especial;
        private string transportista;
        //Propiedades
        public int IdBol { get => idBol; set => idBol = value; }
        public string Fecha { get => fecha; set => fecha = value; }
        public string Chofer { get => chofer; set => chofer = value; }
        public string Placas { get => placas; set => placas = value; }
        public string Zona { get => zona; set => zona = value; }
        public string Especial { get => especial; set => especial = value; }
        public string Transportista { get => transportista; set => transportista = value; }

        public List<ClaseDeReporteTransportistas> ReporteTransportistasFecha(String fechainP, String fechafinP)
        {
            try
            {
                Con.Open();
                ParaBusqueda p = new ParaBusqueda(fechainP, fechafinP, 0);
                List<ClaseDeReporteTransportistas> Listatransportistas = new List<ClaseDeReporteTransportistas>();
                CadenaConsulta = "select b.id_bol as IDBOL, b.fecha as FECHA, t.nombre AS NOMBRE,t.apellidos AS APELLIDOS, " +
                " b.chofer AS CHOFER, b.placas AS PLACAS, b.zona AS ZONA, b.especial AS ESPECIAL" +
                " from bol b " +
                " INNER JOIN usuarios_trans t on b.id_transportista = t.id_transportista" +
                " where b.fecha BETWEEN '" + p.Fechain + "' AND '" + p.Fechafin + "' ";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    ClaseDeReporteTransportistas transportistas = new ClaseDeReporteTransportistas();
                    transportistas.idBol = (Int32)reader["IDBOL"];
                    transportistas.fecha = reader["FECHA"].ToString();
                    transportistas.transportista = (string)reader["NOMBRE"] + " " + (string)reader["APELLIDOS"];
                    transportistas.chofer = reader["CHOFER"].ToString();
                    transportistas.placas = reader["PLACAS"].ToString();
                    transportistas.zona = reader["ZONA"].ToString();
                    transportistas.especial = reader["ESPECIAL"].ToString();
                    Listatransportistas.Add(transportistas);
                }
                reader.Close();
                return Listatransportistas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + " Error Reporte ");
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public List<ClaseDeReporteTransportistas> ReporteTransportistasEspecifico(String fechainP, String fechafinP, int idP)
        {
            try
            {
                Con.Open();
                ParaBusqueda p = new ParaBusqueda(fechainP, fechafinP, idP);
                List<ClaseDeReporteTransportistas> Listatransportistas = new List<ClaseDeReporteTransportistas>();
                CadenaConsulta = "select b.id_bol as IDBOL, b.fecha as FECHA, t.nombre AS NOMBRE,t.apellidos AS APELLIDOS, " +
                " b.chofer AS CHOFER, b.placas AS PLACAS, b.zona AS ZONA, b.especial AS ESPECIAL" +
                " from bol b " +
                " INNER JOIN usuarios_trans t on b.id_transportista = t.id_transportista" +
                " where b.fecha BETWEEN '" + p.Fechain + "' AND '" + p.Fechafin + "' AND b.id_transportista = " + p.Id;
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    ClaseDeReporteTransportistas transportistas = new ClaseDeReporteTransportistas();
                    transportistas.idBol = (Int32)reader["IDBOL"];
                    transportistas.fecha = reader["FECHA"].ToString();
                    transportistas.transportista = (string)reader["NOMBRE"] + " " + (string)reader["APELLIDOS"];
                    transportistas.chofer = reader["CHOFER"].ToString();
                    transportistas.placas = reader["PLACAS"].ToString();
                    transportistas.zona = reader["ZONA"].ToString();
                    transportistas.especial = reader["ESPECIAL"].ToString();
                    Listatransportistas.Add(transportistas);
                }
                reader.Close();
                return Listatransportistas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + " Error Reporte ");
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
    }
    public class ParaBusqueda
    {
        //para filtrar
        private string fechain;
        private string fechafin;
        private Int32 id;

        public ParaBusqueda(string fechain, string fechafin, int id)
        {
            this.fechain = fechain;
            this.fechafin = fechafin;
            this.id = id;
        }
        public ParaBusqueda() { }

        //propiedades
        public string Fechain { get => fechain; set => fechain = value; }
        public string Fechafin { get => fechafin; set => fechafin = value; }
        public int Id { get => id; set => id = value; }
    }
}
