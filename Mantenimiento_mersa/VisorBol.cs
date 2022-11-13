using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Mantenimiento_mersa
{
    public partial class VisorBol : Form
    {
        private int id_bol = -1;
        public VisorBol()
        {
            InitializeComponent();
        }
        public VisorBol(int id)
        {
            InitializeComponent();
            this.id_bol = id;
        }

        private void VisorBol_Load(object sender, EventArgs e)
        {
            Bol bol = new Bol();
            List<Detalle_bol> Lista = new List<Detalle_bol>();
            Detalle_bol detalle = new Detalle_bol();
            if (id_bol > 0)
            {
                bol = bol.CargarBuscador(id_bol);
                DateTime fechaLarga = new DateTime();
                fechaLarga = Convert.ToDateTime(bol.Fecha);
                bol.Fecha = fechaLarga.ToShortDateString();
                bol.Nombre_transportista = bol.ObtenerNombreTransportista(bol.Transportista);
                Lista = detalle.ListarDetallesReporteBol(bol.Id_bol);
                int num_items = Lista.Count();
                if (num_items < 10)
                {
                    num_items -= 10;
                    num_items *= -1;
                    for (int i = 0; i < num_items; i++)
                    {
                        Detalle_bol det = new Detalle_bol();
                        Lista.Add(det);
                    }
                }
                List<Bol> bols = new List<Bol>();
                bols.Add(bol);
                ReportDataSource rds = new ReportDataSource("BolDataSet", bols);
                ReportDataSource rds2 = new ReportDataSource("DetalleDataSet", Lista);
                if(bol.Tipo_movimiento == "Salida")
                {
                    this.reportViewer1.LocalReport.ReportEmbeddedResource = "Mantenimiento_mersa.Reportes.BolSalida.rdlc";
                }
                else
                {
                    this.reportViewer1.LocalReport.ReportEmbeddedResource = "Mantenimiento_mersa.Reportes.BolEntrada.rdlc";
                }
                this.reportViewer1.LocalReport.DataSources.Clear();
                this.reportViewer1.LocalReport.DataSources.Add(rds);
                this.reportViewer1.LocalReport.DataSources.Add(rds2);
                this.reportViewer1.RefreshReport();
                this.reportViewer1.RefreshReport();
            }
            else
            {
                MessageBox.Show("No se ha seleccinado un bol para su reporte");
                this.Close();
            }
        }
    }
}
