using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mantenimiento_mersa
{
    //Se crea una clase de conexion para mantener un estandar
    //de la conexion a la base de datos y no repetir codigo
    public class Conexion
    {
        //variables para la conexion a base de datos y comandos
        SqlConnection con = new SqlConnection(Properties.Settings.Default.mersaConnectionString);
        SqlCommand cmd = new SqlCommand();
        //Para cargar las consultas
        string cadenaConsulta = "";

        public SqlConnection Con { get => con; set => con = value; }
        public SqlCommand Cmd { get => cmd; set => cmd = value; }
        public string CadenaConsulta { get => cadenaConsulta; set => cadenaConsulta = value; }
    }
    public class ConexionSac
    {
        //variables para la conexion a base de datos y comandos
        SqlConnection con = new SqlConnection(Properties.Settings.Default.sacConnectionString);
        SqlCommand cmd = new SqlCommand();
        //Para cargar las consultas
        string cadenaConsulta = "";

        public SqlConnection Con { get => con; set => con = value; }
        public SqlCommand Cmd { get => cmd; set => cmd = value; }
        public string CadenaConsulta { get => cadenaConsulta; set => cadenaConsulta = value; }
    }
}
