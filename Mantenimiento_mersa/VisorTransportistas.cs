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
    public partial class VisorTransportistas : Form
    {
        ParaBusqueda p = new ParaBusqueda();
        public VisorTransportistas()
        {
            InitializeComponent();
        }
        public VisorTransportistas(String feI,String feFin)
        {
            InitializeComponent();
            p.Fechain = feI;
            p.Fechafin = feFin;
            p.Id = 0;
        }
        public VisorTransportistas(String feI, String feFin,int id)
        {
            InitializeComponent();
            p.Fechain = feI;
            p.Fechafin = feFin;
            p.Id = id;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void VisorTransportistas_Load(object sender, EventArgs e)
        {
            ClaseDeReporteTransportistas transportistas = new ClaseDeReporteTransportistas();
            ReportDataSource rds = new ReportDataSource();
            ReportDataSource rds2 = new ReportDataSource();
            if (p.Id > 0)
            {
                rds = new ReportDataSource("DataSet1", transportistas.ReporteTransportistasEspecifico(p.Fechain,p.Fechafin,p.Id));
            }
            else
            {
                rds = new ReportDataSource("DataSet1", transportistas.ReporteTransportistasFecha(p.Fechain, p.Fechafin));
            }
            List<ParaBusqueda> parametros = new List<ParaBusqueda>();
            parametros.Add(p);
            rds2 = new ReportDataSource("DataSet2", parametros);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "Mantenimiento_mersa.Reportes.ReporteTransportistas.rdlc";
            this.reportViewer1.LocalReport.DataSources.Clear();
            this.reportViewer1.LocalReport.DataSources.Add(rds);
            this.reportViewer1.LocalReport.DataSources.Add(rds2);
            this.reportViewer1.RefreshReport();
        }
    }
}
