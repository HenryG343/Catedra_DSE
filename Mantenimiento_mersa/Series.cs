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
    public class Series : Conexion
    {
        //Atributos
        int id_serie;
        int id_usuario;
        String serie;
        String placa;
        public Series()
        {
        }
        public Series(int id_serie, int id_usuario, string serie, string placa)
        {
            this.Id_serie = id_serie;
            this.Id_usuario = id_usuario;
            this.Serie = serie;
            this.Placa = placa;
        }
        //Propiedades
        public int Id_serie { get => id_serie; set => id_serie = value; }
        public int Id_usuario { get => id_usuario; set => id_usuario = value; }
        public string Serie { get => serie; set => serie = value; }
        public string Placa { get => placa; set => placa = value; }
        //Metodos y funciones
        public List<Series> RecuperarSeries(String placa, DataGridView dgv)
        {
            List<Series> series_escaneadas = new List<Series>();
            Series serieTmp = new Series();
            try
            {
                Con.Open();
                CadenaConsulta = "select * from series_escaneadas where placa = '" + placa + "'";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    serieTmp = new Series();//Limpiamos el objeto
                    serieTmp.Id_serie = (int)reader["id_serie"];
                    serieTmp.Id_usuario = (int)reader["id_usuario"];
                    serieTmp.Serie = (String)reader["serie"];
                    serieTmp.Placa = (String)reader["placa"];
                    series_escaneadas.Add(serieTmp);//Lo agregamos a la lista
                }
                reader.Close();
                return series_escaneadas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public void EliminarSeries(String placa)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "delete from series_escaneadas where placa = '" + placa + "'";
                Cmd = new SqlCommand(CadenaConsulta, Con);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                Con.Close();
            }
        }
    }
}
