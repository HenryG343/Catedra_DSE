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
    public partial class EmoVisor : Form
    {
        public EmoVisor()
        {
            InitializeComponent();
        }

        private void EmoVisor_Load(object sender, EventArgs e)
        {
            ClaseReporteEmo emoR = new ClaseReporteEmo();
            ReportDataSource rds = new ReportDataSource("DataSet1",emoR.ObtenerEmo());
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "Mantenimiento_mersa.Reportes.Emo.rdlc";
            this.reportViewer1.LocalReport.DataSources.Clear();
            this.reportViewer1.LocalReport.DataSources.Add(rds);
            this.reportViewer1.RefreshReport();
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
