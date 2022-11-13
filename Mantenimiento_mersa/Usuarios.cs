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
    public class Usuarios : Conexion
    {
        //Atributos
        Int32 idusuario;
        string dui;
        Int32 tipo;
        string contra;
        string nombre;
        string apellidos;
        string nombre_tipo;
        //Propiedades
        public string Dui { get => dui; set => dui = value; }
        public Int32 Tipo { get => tipo; set => tipo = value; }
        public string Contra { get => contra; set => contra = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Apellidos { get => apellidos; set => apellidos = value; }
        public string Nombre_tipo { get => nombre_tipo; set => nombre_tipo = value; }
        public int Idusuario { get => idusuario; set => idusuario = value; }

        public Usuarios Login(string id, string con)
        {
            try
            {
                Usuarios us = new Usuarios();
                Con.Open();
                CadenaConsulta = "select * from usuarios_adm where dui='" + id + "' and contra='" + con + "'";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    us.Dui = (string)reader["dui"];
                    us.Tipo = (int)reader["id_tipo"];
                }
                reader.Close();
                if (string.IsNullOrEmpty(us.Dui))
                {
                    return null;
                }
                else
                {
                    return us;
                }
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
        public List<Usuarios> ListarUsuarios()
        {
            try
            {
                Con.Open();
                List<Usuarios> listaUsuarios = new List<Usuarios>();
                Usuarios usuario = new Usuarios();
                CadenaConsulta = "select * from usuarios_adm u inner join tipo_usuarios t on u.id_tipo = t.id_tipo";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    usuario = new Usuarios();
                    usuario.Idusuario = (int)reader["id_usuario"];
                    usuario.Dui = (string)reader["dui"];
                    usuario.Nombre_tipo = (string)reader["nombre_tipo"];
                    usuario.Tipo = (int)reader["id_tipo"];
                    usuario.Nombre = (string)reader["nombre"];
                    usuario.Apellidos = (string)reader["apellidos"];
                    usuario.Contra = (string)reader["contra"];
                    listaUsuarios.Add(usuario);
                }
                reader.Close();
                return listaUsuarios;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return null;
            }
            finally
            {
                Con.Close();
            }

        }
        public Usuarios BuscarUsuario(int dui)
        {
            Usuarios usuario = new Usuarios();
            return usuario;
        }
        public void InsertarUsuario()
        {
            try
            {
                Con.Open();
                CadenaConsulta = "INSERT INTO usuarios_adm ([dui],[id_tipo],[nombre],[apellidos],[contra])" +
                    " VALUES ('" + Dui + "', " + Tipo + ",'" + Nombre + "','" + Apellidos + "','" + Contra + "')";
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se agrego exitosamente el Usuario");
                }
                else
                {
                    MessageBox.Show("Ha ocurrido un error");
                }
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
        public void EliminarUsuario(Int32 idusuario)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "delete from usuarios_adm where id_usuario = " + idusuario;
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se elimino exitosamente el Usuario");
                }
                else
                {
                    MessageBox.Show("Ha ocurrido un error");
                }
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
        public void ModificarUsuario(Int32 idusuario)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "UPDATE usuarios_adm SET dui = " + Dui + ",id_tipo = " + Tipo + ",[nombre] = '" + Nombre +
                    "',[apellidos] = '" + Apellidos + "',[contra] = '" + Contra + "' WHERE id_usuario = " + idusuario;
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se actualizo exitosamente el Usuario");
                }
                else
                {
                    MessageBox.Show("Ha ocurrido un error");
                }
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
        public List<Usuarios> BuscadorUsuarios(string dui, string nombre, string apellidos)
        {
            try
            {
                Con.Open();
                List<Usuarios> listaus = new List<Usuarios>();
                CadenaConsulta = "Select id_usuario,nombre,apellidos, dui, id_tipo " +
                    "from usuarios_adm where dui like '%" + dui + "%' and nombre like '%" + nombre + "%' and apellidos like '%" + apellidos + "%'";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    Usuarios usu = new Usuarios();
                    usu.idusuario = (int)reader["id_usuario"];
                    usu.nombre = reader["nombre"].ToString() + " "+ reader["apellidos"].ToString();
                    usu.dui = reader["dui"].ToString();
                    usu.tipo = (int)reader["id_tipo"];
                    listaus.Add(usu);
                }
                reader.Close();
                return listaus;
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
}
