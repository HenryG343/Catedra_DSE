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
    //Clase transportista
    public class Transportista : Conexion
    {
        //Atributos de la clase
        Int32 id_transportista;
        string dui;
        string nombre;
        string apellidos;
        string placa;
        //Propiedades de la clase
        public int Id_transportista { get => id_transportista; set => id_transportista = value; }
        public string Dui { get => dui; set => dui = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Apellidos { get => apellidos; set => apellidos = value; }
        public string Placa { get => placa; set => placa = value; }

        public List<TransportistaCombo> ListarTransportistasCombo(string idd)
        {
            try
            {
                List<TransportistaCombo> transportistas = new List<TransportistaCombo>();
                TransportistaCombo trans = new TransportistaCombo();
                Con.Open();
                CadenaConsulta = "select nombre,apellidos, id_transportista from usuarios_trans" +
                    " where id_transportista = " + idd + "";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    trans = new TransportistaCombo();
                    trans.Name = (string)reader["nombre"] + " " + (string)reader["apellidos"];
                    trans.Value = (int)reader["id_transportista"];
                    transportistas.Add(trans);
                }

                reader.Close();
                return transportistas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error lista transportistas combo id", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public List<TransportistaCombo> ListarTransportistasBuscador()
        {
            try
            {
                List<TransportistaCombo> transportistas = new List<TransportistaCombo>();
                TransportistaCombo trans = new TransportistaCombo();
                Con.Open();
                CadenaConsulta = "select nombre,apellidos, id_transportista from usuarios_trans";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    trans = new TransportistaCombo();
                    trans.Name = (string)reader["nombre"] + " " + (string)reader["apellidos"];
                    trans.Value = (int)reader["id_transportista"];
                    transportistas.Add(trans);
                }

                reader.Close();
                return transportistas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error transportistas buscador", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public List<TransportistaCombo> TransportistasComboBuscador()
        {
            try
            {
                List<TransportistaCombo> transportistas = new List<TransportistaCombo>();
                TransportistaCombo trans = new TransportistaCombo();
                Con.Open();
                CadenaConsulta = "select nombre,apellidos, id_transportista from usuarios_trans";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    trans = new TransportistaCombo();
                    trans.Name = (string)reader["nombre"] + " " + (string)reader["apellidos"];
                    trans.Value = (int)reader["id_transportista"];
                    transportistas.Add(trans);
                }
                trans = new TransportistaCombo();
                trans.Name = "TODOS";
                trans.Value = 0;
                transportistas.Add(trans);
                trans = new TransportistaCombo();
                reader.Close();
                return transportistas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error transportistas combo buscador", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public List<TransportistaCombo> TransportistasComboReporte()
        {
            try
            {
                List<TransportistaCombo> transportistas = new List<TransportistaCombo>();
                TransportistaCombo trans = new TransportistaCombo();
                Con.Open();
                CadenaConsulta = "select nombre,apellidos, id_transportista,placa from usuarios_trans";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    trans = new TransportistaCombo();
                    trans.Name = (string)reader["nombre"] + " " + (string)reader["apellidos"] + " - " + (string)reader["placa"];
                    trans.Value = (int)reader["id_transportista"];
                    transportistas.Add(trans);
                }
                trans = new TransportistaCombo();
                trans.Name = "TODOS";
                trans.Value = 0;
                transportistas.Add(trans);
                trans = new TransportistaCombo();
                reader.Close();
                return transportistas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error transportistas combo buscador", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public List<TransportistaCombo> ListarPlacasCombo()
        {
            try
            {
                List<TransportistaCombo> placas = new List<TransportistaCombo>();
                TransportistaCombo trans = new TransportistaCombo();
                Con.Open();
                CadenaConsulta = "select placa, id_transportista from usuarios_trans ";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    trans = new TransportistaCombo();
                    trans.Name = (string)reader["placa"];
                    trans.Value = (int)reader["id_transportista"];
                    placas.Add(trans);
                }

                reader.Close();
                return placas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error listar placas", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public List<Transportista> ListarTransportistasDataGrid()
        {
            try
            {
                Con.Open();
                List<Transportista> listaTransportistas = new List<Transportista>();
                Transportista transportista = new Transportista();
                CadenaConsulta = "select * from usuarios_trans";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    transportista = new Transportista();
                    transportista.id_transportista = (int)reader["id_transportista"];
                    transportista.Dui = (string)reader["dui"];
                    transportista.nombre = (string)reader["nombre"];
                    transportista.apellidos = (string)reader["apellidos"];
                    transportista.placa = (string)reader["placa"];
                    listaTransportistas.Add(transportista);
                }
                reader.Close();
                return listaTransportistas;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error listar transportistas grid", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public void InsertarTransportista()
        {
            try
            {
                Con.Open();
                CadenaConsulta = "INSERT INTO usuarios_trans" +
                    " VALUES ('" + Dui + "', '" + Nombre + "','" + Apellidos + "','" + Placa + "')";
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se agrego exitosamente el Transportista", "Informacion", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Ha ocurrido un error", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            finally
            {
                Con.Close();
            }
        }
        public void ModificarTransportista(Int32 id_transportista)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "UPDATE usuarios_trans SET dui = " + Dui + ", nombre = '" + Nombre +
                    "', apellidos = '" + Apellidos + "', placa = '" + Placa + "' WHERE id_transportista = " + id_transportista;
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se actualizo exitosamente el Transportista", "Informacion", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Ha ocurrido un error", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            finally
            {
                Con.Close();
            }
        }
        public void EliminarTransportista(Int32 id_transportista)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "delete from usuarios_trans where id_transportista = " + id_transportista;
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se elimino exitosamente el Transportista", "Informacion", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Ha ocurrido un error", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            finally
            {
                Con.Close();
            }
        }
        public List<Transportista> BuscadorTransportistas(string dui, string nombre, string apellidos)
        {
            try
            {
                Con.Open();
                List<Transportista> listatra = new List<Transportista>();
                CadenaConsulta = "Select id_transportista,dui,nombre,apellidos, placa " +
                    "from usuarios_trans where dui like '%"+dui+"%' and nombre like '%"+nombre+"%' and apellidos like '%"+apellidos+"%'";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    Transportista tra = new Transportista();
                    tra.id_transportista = (int)reader["id_transportista"];
                    tra.dui = reader["dui"].ToString();
                    tra.nombre = reader["nombre"].ToString() + " " + reader["apellidos"].ToString();
                    tra.placa = reader["placa"].ToString();
                    listatra.Add(tra);
                }
                reader.Close();
                return listatra;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + "aaa");
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
    }

    //Clase transportista para el ComboBox
    public class TransportistaCombo
    {
        Int32 value;
        string name;

        public int Value { get => this.value; set => this.value = value; }
        public string Name { get => name; set => name = value; }
    }
}
