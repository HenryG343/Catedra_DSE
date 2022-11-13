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
    public class Sac : ConexionSac
    {
        //Atributos
        string serie;
        string activo;
        string ficha;
        string modelo;
        string linea;

        //Propiedades
        public string Serie { get => serie; set => serie = value; }
        public string Activo { get => activo; set => activo = value; }
        public string Ficha { get => ficha; set => ficha = value; }
        public string Modelo { get => modelo; set => modelo = value; }
        public string Linea { get => linea; set => linea = value; }

        //Metodos
        //--------------
        //Metodo para cargar el dataset
        public List<Sac> RecuperarDataSetSalida()
        {
            List<Sac> sacDataSet = new List<Sac>();
            Sac sactmp = new Sac();
            try
            {
                Con.Open();
                CadenaConsulta = "select a.id_serie AS SERIE, ISNULL(a.ID_ACTIVO, '') as ACTIVO," +
                    " ISNULL(A.ID_FICHA, '') as FICHA, B.DESCRIPCION AS MODELO, B.LINEA AS LINEA" +
                    " from tbl_ACTIVOS a inner join tbl_MODELOS b on a.id_MODELO = b.id_MODELO where" +
                    " a.id_negocio in ('47223', '73600', '47233', '47215', '47231', '55269', '55830', '68090', '80247')";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    sactmp = new Sac();//Limpiamos el objeto
                    sactmp.Serie = (String)reader["SERIE"];
                    sactmp.Serie = sactmp.Serie.Trim();
                    sactmp.Activo = (String)reader["ACTIVO"];
                    sactmp.Activo = sactmp.Activo.Trim();
                    sactmp.Linea = (String)reader["LINEA"];
                    sactmp.Linea = sactmp.Linea.Trim();
                    sactmp.Modelo = (String)reader["MODELO"];
                    sactmp.Modelo = sactmp.Modelo.Trim();
                    sactmp.Ficha = (String)reader["FICHA"];
                    sactmp.Ficha = sactmp.Ficha.Trim();
                    sacDataSet.Add(sactmp);//Lo agregamos a la lista
                }
                reader.Close();
                return sacDataSet;
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
        public List<Sac> RecuperarDataSetEntrada()
        {
            List<Sac> sacDataSet = new List<Sac>();
            Sac sactmp = new Sac();
            try
            {
                Con.Open();
                CadenaConsulta = "select a.id_serie AS SERIE, ISNULL(a.ID_ACTIVO, '') as ACTIVO," +
                    " ISNULL(A.ID_FICHA, '') as FICHA, B.DESCRIPCION AS MODELO, B.LINEA AS LINEA" +
                    " from tbl_ACTIVOS a inner join tbl_MODELOS b on a.id_MODELO = b.id_MODELO where" +
                    " a.id_negocio not in ('47223', '73600', '47233', '47215', '47231', '55269', '55830', '68090', '80247')";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    sactmp = new Sac();//Limpiamos el objeto
                    sactmp.Serie = (String)reader["SERIE"];
                    sactmp.Serie = sactmp.Serie.Trim();
                    sactmp.Activo = (String)reader["ACTIVO"];
                    sactmp.Activo = sactmp.Activo.Trim();
                    sactmp.Linea = (String)reader["LINEA"];
                    sactmp.Linea = sactmp.Linea.Trim();
                    sactmp.Modelo = (String)reader["MODELO"];
                    sactmp.Modelo = sactmp.Modelo.Trim();
                    sactmp.Ficha = (String)reader["FICHA"];
                    sactmp.Ficha = sactmp.Ficha.Trim();
                    sacDataSet.Add(sactmp);//Lo agregamos a la lista
                }
                reader.Close();
                return sacDataSet;
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
        public List<String> ExtraerSeries(List<Sac> DataSet)
        {
            List<String> salida = new List<String>();
            if(DataSet.Count < 0)
            {
                return null;
            }
            else
            {
                for (int i = 0; i < DataSet.Count; i++)
                {
                    salida.Add(DataSet[i].serie);
                }
            }
            return salida;
        }
        //Metodo para completar informacion a partir del DataSet
        public Sac BuscarSerie(List<String> lista_series, String serie, List<Sac> DataSet)
        {
            try
            {
                Sac sac = new Sac();
                int posicion = -1;
                bool existe = lista_series.Contains(serie);
                if (existe)
                {
                    posicion = lista_series.IndexOf(serie);
                }
                else
                {
                    throw new Exception("La serie "+ serie + " no es valida");
                }
                sac = DataSet[posicion];
                return sac;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return null;
            }
        }
    }
}
