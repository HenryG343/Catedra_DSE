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
    //Clase tipo_usuarios
    public class tipo_usuarios : Conexion
    {
        //Atributos
        Int32 id_tipo;
        string nombre_tipo;
        //Propiedades
        public int Id_tipo { get => id_tipo; set => id_tipo = value; }
        public string Nombre_tipo { get => nombre_tipo; set => nombre_tipo = value; }

        public List<TipoCombo> listarTipos()
        {
            try
            {
                List<TipoCombo> tipoCombo = new List<TipoCombo>();
                TipoCombo tipo = new TipoCombo();
                Con.Open();
                CadenaConsulta = "select * from tipo_usuarios";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    tipo = new TipoCombo();
                    tipo.Name = (string)reader["nombre_tipo"];
                    tipo.Value = (int)reader["id_tipo"];
                    tipoCombo.Add(tipo);
                }

                reader.Close();
                return tipoCombo;
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
    }
    public class TipoCombo
    {
        Int32 value;
        string name;

        public int Value { get => this.value; set => this.value = value; }
        public string Name { get => name; set => name = value; }
    }
}
