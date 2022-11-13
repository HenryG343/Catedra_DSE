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
    public partial class GenerarReporteTransportista : Form
    {
        public GenerarReporteTransportista()
        {
            InitializeComponent();
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGenerar_Click(object sender, EventArgs e)
        {
            try
            {
                String fechaInicial = dtpInicial.Value.Year.ToString() + "-" + dtpInicial.Value.Month.ToString() + "-" + dtpInicial.Value.Day.ToString();
                String fechaFinal = dtpFinal.Value.Year.ToString() + "-" + dtpFinal.Value.Month.ToString() + "-" + dtpFinal.Value.Day.ToString();
                if (cboTransportista.SelectedValue == null)
                {
                    throw new Exception("No se ha seleccionad una placa");
                }
                else if (cboTransportista.Text == "TODOS")
                {
                    VisorTransportistas visor = new VisorTransportistas(fechaInicial, fechaFinal);
                    visor.Show();
                }
                else
                {
                    VisorTransportistas visor = new VisorTransportistas(fechaInicial, fechaFinal, int.Parse(cboTransportista.SelectedValue.ToString()));
                    visor.Show();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }


        }

        private void GenerarReporteTransportista_Load(object sender, EventArgs e)
        {
            Transportista transportista = new Transportista();
            cboTransportista.DataSource = null;
            cboTransportista.DataSource = transportista.TransportistasComboReporte();
            cboTransportista.DisplayMember = "Name";
            cboTransportista.ValueMember = "Value";
        }
    }
}
