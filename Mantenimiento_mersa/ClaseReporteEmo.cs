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
    class ClaseReporteEmo : Conexion
    {
        private Int32 IDBOL;
        private string FECHA;
        private string TIPOMOVIMIENTO;
        private string NOMBRE;
        private string APELLIDOS;
        private string CHOFER;
        private Int32 NODOCUMENTO;
        private string PLACAS;
        private string ZONA;
        private string ESPECIAL;
        private Int32 IDDETALLE;
        private Int32 IDBOLDETALLE;
        private string MODELO;
        private string LINEA;
        private string SERIE;
        private string ACTIVO;
        private Int32 EMO;
        private string FICHA;
        private string EMOPEPSI;
        public ClaseReporteEmo()
        {
        }

        public int IDBOL1 { get => IDBOL; set => IDBOL = value; }
        public string FECHA1 { get => FECHA; set => FECHA = value; }
        public string TIPOMOVIMIENTO1 { get => TIPOMOVIMIENTO; set => TIPOMOVIMIENTO = value; }
        public string NOMBRE1 { get => NOMBRE; set => NOMBRE = value; }
        public string APELLIDOS1 { get => APELLIDOS; set => APELLIDOS = value; }
        public string CHOFER1 { get => CHOFER; set => CHOFER = value; }
        public int NODOCUMENTO1 { get => NODOCUMENTO; set => NODOCUMENTO = value; }
        public string PLACAS1 { get => PLACAS; set => PLACAS = value; }
        public string ZONA1 { get => ZONA; set => ZONA = value; }
        public string ESPECIAL1 { get => ESPECIAL; set => ESPECIAL = value; }
        public int IDDETALLE1 { get => IDDETALLE; set => IDDETALLE = value; }
        public int IDBOLDETALLE1 { get => IDBOLDETALLE; set => IDBOLDETALLE = value; }
        public string MODELO1 { get => MODELO; set => MODELO = value; }
        public string LINEA1 { get => LINEA; set => LINEA = value; }
        public string SERIE1 { get => SERIE; set => SERIE = value; }
        public string ACTIVO1 { get => ACTIVO; set => ACTIVO = value; }
        public int EMO1 { get => EMO; set => EMO = value; }
        public string FICHA1 { get => FICHA; set => FICHA = value; }
        public string EMOPEPSI1 { get => EMOPEPSI; set => EMOPEPSI = value; }

        public List<ClaseReporteEmo> ObtenerEmo()
        {
            try
            {
                Con.Open();
                List<ClaseReporteEmo> Emos = new List<ClaseReporteEmo>();
                CadenaConsulta = "select b.id_bol as IDBOL, b.fecha as FECHA, b.tipo_movimiento AS TIPOMOVIMIENTO, t.nombre AS NOMBRE, t.apellidos AS APELLIDOS," +
                " b.chofer AS CHOFER, b.nro_documento AS NODOCUMENTO, b.placas AS PLACAS, b.zona AS ZONA, b.especial AS ESPECIAL, d.id AS IDDETALLE," +
                " d.id_bol AS IDBOLDETALLE, SUBSTRING(d.modelo,0,10) AS MODELO, d.linea AS LINEA, d.serie AS SERIE, d.activo AS ACTIVO, d.emo AS EMO, d.ficha AS FICHA, d.emo_pepsi AS EMOPEPSI" +
                " from bol b inner join" +
                " detalle_bol d on b.id_bol = (select id_bol_reporte from registros)" +
                " AND d.id_bol = (select id_bol_reporte from registros)" +
                " INNER JOIN usuarios_trans t on b.id_transportista = t.id_transportista";
                Cmd.Connection = Con;
                Cmd.CommandText = CadenaConsulta;
                Cmd.CommandType = CommandType.Text;
                SqlDataReader reader = Cmd.ExecuteReader();
                while (reader.Read())
                {
                    ClaseReporteEmo emo = new ClaseReporteEmo();
                    emo.IDBOL = (Int32)reader["IDBOL"];
                    emo.FECHA = reader["FECHA"].ToString();
                    emo.TIPOMOVIMIENTO = reader["TIPOMOVIMIENTO"].ToString();
                    emo.NOMBRE = reader["NOMBRE"].ToString();
                    emo.APELLIDOS = reader["APELLIDOS"].ToString();
                    emo.CHOFER = reader["CHOFER"].ToString();
                    emo.NODOCUMENTO = (Int32)reader["NODOCUMENTO"];
                    emo.PLACAS = reader["PLACAS"].ToString();
                    emo.ZONA = reader["ZONA"].ToString();
                    emo.ESPECIAL = reader["ESPECIAL"].ToString();
                    emo.IDBOLDETALLE = (Int32)reader["IDBOLDETALLE"];
                    emo.IDDETALLE = (Int32)reader["IDDETALLE"];
                    emo.MODELO = reader["MODELO"].ToString();
                    emo.LINEA = reader["LINEA"].ToString();
                    emo.SERIE = reader["SERIE"].ToString();
                    emo.ACTIVO = reader["ACTIVO"].ToString();
                    emo.EMO = (Int32)reader["EMO"];
                    emo.FICHA = reader["FICHA"].ToString();
                    emo.EMOPEPSI = reader["EMOPEPSI"].ToString();
                    Emos.Add(emo);
                }
                reader.Close();
                return Emos;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + " Error Emos");
                return null;
            }
            finally
            {
                Con.Close();
            }
        }
    }
}
