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
    public class Bol : Conexion
    {
        int n;
        //Atributos
        int id_bol;
        string fecha;
        string tipo_movimiento;
        int transportista;
        string chofer;
        int nro_documento;
        string placas;
        string zona;
        string especial;
        string nombre_transportista;
        //Propiedades de la clase
        public int Id_bol { get => id_bol; set => id_bol = value; }
        public string Fecha { get => fecha; set => fecha = value; }
        public string Tipo_movimiento { get => tipo_movimiento; set => tipo_movimiento = value; }
        public int Transportista { get => transportista; set => transportista = value; }
        public string Chofer { get => chofer; set => chofer = value; }
        public int Nro_documento { get => nro_documento; set => nro_documento = value; }
        public string Placas { get => placas; set => placas = value; }
        public string Zona { get => zona; set => zona = value; }
        public string Especial { get => especial; set => especial = value; }
        public string Nombre_transportista { get => nombre_transportista; set => nombre_transportista = value; }

        //Insertar BOL
        public void InsertarBOL()
        {
            try
            {
                Con.Open();
                CadenaConsulta = "INSERT INTO bol" +
                    " VALUES ('" + Fecha + "', '" + Tipo_movimiento + "'," + Transportista + ",'" + Chofer + "',"+ Nro_documento + 
                    ",'"+ Placas + "','" + Zona + "','" + especial + "')";
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Bol creado exitosamente", "Informacion", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
        public Bol CargarUltimo()
        {
            try
            {
                Bol bo = new Bol();
                Con.Open();
                CadenaConsulta = "SELECT TOP 1 * FROM bol ORDER BY id_bol DESC";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    bo.Id_bol = (int)reader["id_bol"];
                    bo.Fecha = reader["fecha"].ToString();
                    bo.Tipo_movimiento = reader["tipo_movimiento"].ToString();
                    bo.Transportista = (int)reader["id_transportista"];
                    bo.Chofer = reader["chofer"].ToString();
                    bo.Nro_documento = (int)reader["nro_documento"];
                    bo.Placas = reader["placas"].ToString();
                    bo.Zona = reader["zona"].ToString();
                    bo.especial = reader["especial"].ToString();
                }
                reader.Close();
                return bo;
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
        public Bol CargarPrimero()
        {
            try
            {
                Bol bo = new Bol();
                Con.Open();
                CadenaConsulta = "SELECT TOP 1 * FROM bol ORDER BY id_bol asc";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    bo.Id_bol = (int)reader["id_bol"];
                    bo.Fecha = reader["fecha"].ToString();
                    bo.Tipo_movimiento = reader["tipo_movimiento"].ToString();
                    bo.Transportista = (int)reader["id_transportista"];
                    bo.Chofer = reader["chofer"].ToString();
                    bo.Nro_documento = (int)reader["nro_documento"];
                    bo.Placas = reader["placas"].ToString();
                    bo.Zona = reader["zona"].ToString();
                    bo.especial = reader["especial"].ToString();
                }
                reader.Close();
                return bo;
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
        public List<Bol> ListarBol()
        {
            try
            {             
                Con.Open();
                List<Bol> listabo = new List<Bol>();
                CadenaConsulta = "SELECT * FROM bol ORDER BY id_bol ASC";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    Bol bo = new Bol();
                    bo.Id_bol = (int)reader["id_bol"];
                    bo.Fecha = reader["fecha"].ToString();
                    bo.Tipo_movimiento = reader["tipo_movimiento"].ToString();
                    bo.Transportista = (int)reader["id_transportista"];
                    bo.Chofer = reader["chofer"].ToString();
                    bo.Nro_documento = (int)reader["nro_documento"];
                    bo.Placas = reader["placas"].ToString();
                    bo.Zona = reader["zona"].ToString();
                    bo.especial = reader["especial"].ToString();
                    listabo.Add(bo);
                }
                reader.Close();
                return listabo;
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
        public void ModificarBol(Int32 idd)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "UPDATE bol SET fecha = '" + Fecha +
                    "', tipo_movimiento = '" + Tipo_movimiento + "', id_transportista = " + Transportista + "," +
                    "chofer = '"+ Chofer + "', nro_documento ="+ Nro_documento + ",placas='"+Placas+ "'," +
                    "zona='"+Zona+"',especial ='"+Especial+ "' WHERE id_bol = " + idd;
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se actualizo exitosamente el Bol", "Informacion", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
        public void EliminarBol(Int32 idd)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "delete from bol where id_bol = " + idd;
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se elimino exitosamente el Bol", "Informacion", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
        public int CantidadBol()
        {
            try
            {
                Con.Open();
                CadenaConsulta = "select count(id_bol) as Numeros from bol";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    n = (int)reader["Numeros"];
                }
                reader.Close();
                return n;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return -1;
            }
            finally
            {
                Con.Close();
            }
        }
        public List<Bol> BuscadorBOL(string id, string fecha, string transportista, string chofer)
        {
            try
            {
                Con.Open();
                List<Bol> listabo = new List<Bol>();
                CadenaConsulta = "Select b.id_bol, b.fecha, u.nombre as 'nombre' ,u.apellidos as 'apellidos', b.chofer from bol b " +
                    " inner join usuarios_trans u on b.id_transportista = u.id_transportista " +
                    " where b.id_bol like '%"+id+"%' and b.fecha like '%"+fecha+"%' and u.nombre like '%"+transportista+"%' and b.chofer like '%"+chofer+"%' "; 
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    Bol bo = new Bol();
                    bo.Id_bol = (int)reader["id_bol"];
                    bo.Fecha = reader["fecha"].ToString();
                    bo.Chofer = reader["chofer"].ToString();
                    bo.Placas = reader["nombre"].ToString() + " " + reader["apellidos"].ToString();
                    listabo.Add(bo);
                }
                reader.Close();
                return listabo;
            }
            catch(NullReferenceException nu){
                return null;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Se ha producido la siguiente excepcion: " +ex.Message);
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        public Bol CargarBuscador(int idd)
        {
            try
            {
                Bol bo = new Bol();
                Con.Open();
                CadenaConsulta = "SELECT * FROM bol where id_bol = "+ idd;
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    bo.Id_bol = (int)reader["id_bol"];
                    bo.Fecha = reader["fecha"].ToString();
                    bo.Tipo_movimiento = reader["tipo_movimiento"].ToString();
                    bo.Transportista = (int)reader["id_transportista"];
                    bo.Chofer = reader["chofer"].ToString();
                    bo.Nro_documento = (int)reader["nro_documento"];
                    bo.Placas = reader["placas"].ToString();
                    bo.Zona = reader["zona"].ToString();
                    bo.especial = reader["especial"].ToString();
                }
                reader.Close();
                return bo;
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
        public String ObtenerNombreTransportista(int id)
        {
            try
            {
                String nombre_completo = "";
                Con.Open();
                CadenaConsulta = "select * from usuarios_trans where id_transportista = " + id;
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    nombre_completo = (String)reader["nombre"] + " " + (String)reader["apellidos"]; ;
                }
                reader.Close();
                return nombre_completo;
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
        public int UltimoNumDoc()
        {
            int id_reg = -1;
            try
            {
                Con.Open();
                CadenaConsulta = "select nro_documento from registros";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    id_reg = (int)reader["nro_documento"];
                }
                reader.Close();
                CadenaConsulta = "UPDATE registros set nro_documento = " + (id_reg + 1);
                Cmd = new SqlCommand(CadenaConsulta, Con);
                Cmd.ExecuteNonQuery();
                return id_reg;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return id_reg;
            }
            finally
            {
                Con.Close();
            }
        }
    }
    
}
