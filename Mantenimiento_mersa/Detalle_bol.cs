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
    public class Detalle_bol: Conexion
    {
        //Atributos
        int id;
        int id_bol;
        string modelo;
        string linea;
        string serie;
        string activo;
        string emo;
        string ficha;
        string emo_pepsi;
        //Propiedades de la clase
        public int Id { get => id; set => id = value; }
        public int Id_bol { get => id_bol; set => id_bol = value; }
        public string Modelo { get => modelo; set => modelo = value; }
        public string Linea { get => linea; set => linea = value; }
        public string Serie { get => serie; set => serie = value; }
        public string Activo { get => activo; set => activo = value; }
        public string Emo { get => emo; set => emo = value; }
        public string Ficha { get => ficha; set => ficha = value; }
        public string Emo_pepsi { get => emo_pepsi; set => emo_pepsi = value; }
        //Insertar detalles BOL
        public void InsertarDetalleBOL()
        {
            try
            {
                Con.Open();
                CadenaConsulta = "INSERT INTO detalle_bol" +
                    " VALUES (" +Id_bol + ", '" + Modelo + "' , '" + Linea + "' , '" + Serie + "' , '" + Activo +
                    "' , '" + Emo + "' , '" + Ficha + "' , '" + Emo_pepsi + "')";
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    //MessageBox.Show("Detalle agregado exitosamente", "Detalle Bol", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Ha ocurrido un error al insertar el detalle", "Error. Detalle Bol", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion. Agregar detalle bol", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            finally
            {
                Con.Close();
            }
        }
        //Listar en el dgv los detalles
        public List<Detalle_bol> ListarDetalles(int idbol)
        {
            try
            {
                Con.Open();
                List<Detalle_bol> lista_detalle_bo = new List<Detalle_bol>();
                CadenaConsulta = "select * from detalle_bol where id_bol = " + idbol;
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    Detalle_bol detalle_bo = new Detalle_bol();
                    detalle_bo.Id = (int)reader["id"];
                    detalle_bo.Id_bol = (int)reader["id_bol"];
                    detalle_bo.Modelo = reader["modelo"].ToString();
                    detalle_bo.Linea = reader["linea"].ToString();
                    detalle_bo.Serie = reader["serie"].ToString();
                    detalle_bo.Activo = reader["activo"].ToString();
                    detalle_bo.Emo = reader["emo"].ToString();
                    detalle_bo.Ficha = reader["ficha"].ToString();
                    detalle_bo.Emo_pepsi = reader["emo_pepsi"].ToString();
                    lista_detalle_bo.Add(detalle_bo);
                }
                reader.Close();
                return lista_detalle_bo;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion listar detalle bol");
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
        //Listar en el dgv los detalles
        public List<Detalle_bol> ListarDetallesReporteBol(int idbol)
        {
            try
            {
                Con.Open();
                List<Detalle_bol> lista_detalle_bo = new List<Detalle_bol>();
                CadenaConsulta = "select d.id,d.id_bol, SUBSTRING(d.modelo,0,10) AS MODELO, d.linea,d.serie," +
                    " d.activo,d.emo,d.ficha,d.emo_pepsi from detalle_bol d where id_bol = " + idbol;
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    Detalle_bol detalle_bo = new Detalle_bol();
                    detalle_bo.Id = (int)reader["id"];
                    detalle_bo.Id_bol = (int)reader["id_bol"];
                    detalle_bo.Modelo = reader["MODELO"].ToString();
                    detalle_bo.Linea = reader["linea"].ToString();
                    detalle_bo.Serie = reader["serie"].ToString();
                    detalle_bo.Activo = reader["activo"].ToString();
                    detalle_bo.Emo = reader["emo"].ToString();
                    detalle_bo.Ficha = reader["ficha"].ToString();
                    detalle_bo.Emo_pepsi = reader["emo_pepsi"].ToString();
                    lista_detalle_bo.Add(detalle_bo);
                }
                reader.Close();
                return lista_detalle_bo;
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
        //Eliminar detalle
        public void EliminarDetalleBol(string idd)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "delete from detalle_bol where id = " + Convert.ToInt32(idd);
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Se elimino exitosamente", "Informacion", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
        //Modificar detalles
        public void ModificarDetalleBol(Int32 idd)
        {
            try
            {
                Con.Open();
                CadenaConsulta = "UPDATE detalle_bol SET modelo = '" + Modelo +
                    "', linea = '" + Linea + "', serie = '" + Serie + "'," +
                    "activo = '" + Activo + "', emo =" + Emo + ",ficha='" + Ficha + "'," +
                    "emo_pepsi='" + Emo_pepsi +  "' WHERE id = " + idd;
                Cmd = new SqlCommand(CadenaConsulta, Con);
                if (Cmd.ExecuteNonQuery() > 0)
                {
                    //MessageBox.Show("Se actualizo exitosamente el Bol", "Informacion", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Ha ocurrido un error", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion modificar detalle bol", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            finally
            {
                Con.Close();
            }
        }
        //Cargar Ultimo numero de registro para el EMO
        public string UltimoEmo()
        {
            int id_reg = -1;
            try
            {
                Con.Open();
                CadenaConsulta = "select emo from registros";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    id_reg = (int)reader["emo"];
                }
                reader.Close();
                CadenaConsulta = "UPDATE registros set emo = " +(id_reg + 1);
                Cmd = new SqlCommand(CadenaConsulta, Con);
                Cmd.ExecuteNonQuery();
                return id_reg.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return id_reg.ToString();
            }
            finally
            {
                Con.Close();
            }
        }
        public string ActualizarIDBol(int idBol)
        {
            int id_reg = -1;
            try
            {
                Con.Open();
                CadenaConsulta = "UPDATE registros set id_bol_reporte = " + idBol;
                Cmd = new SqlCommand(CadenaConsulta, Con);
                Cmd.ExecuteNonQuery();
                return id_reg.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return id_reg.ToString();
            }
            finally
            {
                Con.Close();
            }
        }
    }
}
