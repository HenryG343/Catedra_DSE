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
    public partial class Buscador : Form
    {
        public bool Principal;
        public string buscar;
        Transportista transportista = new Transportista();
        Bol bol = new Bol();
        int id_log;
        public Buscador()
        {
            InitializeComponent();
        }
        public Buscador(int id)
        {
            InitializeComponent();
            id_log = id;
        }

        private void Buscador_Load(object sender, EventArgs e)
        {
            LlenarDGV();
        }

        public void LlenarDGV()
        {
            try
            {
                string Nbol, Fecha, Tran, Chofer;
                Nbol = txtNbol.Text;
                Fecha = txtFecha.Text;
                Tran = txtTran.Text;
                Chofer = txtChofer.Text;
                dataGridView1.Rows.Clear();
                if (string.IsNullOrEmpty(Nbol) && string.IsNullOrEmpty(Tran) && string.IsNullOrEmpty(Fecha) && string.IsNullOrEmpty(Chofer))
                {

                }
                else
                {
                    List<Bol> bolsRecuperado = new List<Bol>();
                    if (bol.BuscadorBOL(Nbol, Fecha, Tran, Chofer) != null)
                    {
                        bolsRecuperado = bol.BuscadorBOL(Nbol, Fecha, Tran, Chofer);
                        foreach (Bol det in bolsRecuperado)
                        {
                            int i = dataGridView1.Rows.Add();
                            dataGridView1.Rows[i].Cells[0].Value = det.Id_bol;
                            dataGridView1.Rows[i].Cells[1].Value = det.Fecha;
                            dataGridView1.Rows[i].Cells[2].Value = det.Placas;
                            dataGridView1.Rows[i].Cells[3].Value = det.Chofer;
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show("Se ha producida la siguiente excepcion: " +ex.Message,"Excepcion en llenar DataGridView");
            }

        }
        private void pictureBox1_Click(object sender, EventArgs e)
        {

            this.Close();
            if(Principal == true)
            {
                Menu menu = new Menu(id_log);
                menu.buscador = true;
                menu.Show();
            }
            else
            {
                frmPrincipal prin = new frmPrincipal(id_log);
                prin.Show();
            }
        }

        private void txtNbol_KeyPress(object sender, KeyPressEventArgs e)
        {
            LlenarDGV();
        }

        private void txtFecha_KeyPress(object sender, KeyPressEventArgs e)
        {
            LlenarDGV();
        }

        private void txtTran_KeyPress(object sender, KeyPressEventArgs e)
        {
            LlenarDGV();
        }

        private void txtChofer_KeyPress(object sender, KeyPressEventArgs e)
        {
            LlenarDGV();
        }

        private void txtNbol_KeyDown(object sender, KeyEventArgs e)
        {
            LlenarDGV();
        }

        private void txtFecha_KeyDown(object sender, KeyEventArgs e)
        {
            LlenarDGV();
        }

        private void txtChofer_KeyDown(object sender, KeyEventArgs e)
        {
            LlenarDGV();
        }

        private void txtNbol_KeyUp(object sender, KeyEventArgs e)
        {
            LlenarDGV();
        }

        private void txtFecha_KeyUp(object sender, KeyEventArgs e)
        {
            LlenarDGV();
        }

        private void txtTran_KeyDown(object sender, KeyEventArgs e)
        {
            LlenarDGV();
        }

        private void txtTran_KeyUp(object sender, KeyEventArgs e)
        {
            LlenarDGV();
        }

        private void txtChofer_KeyUp(object sender, KeyEventArgs e)
        {
            LlenarDGV();
        }

        private void dataGridView1_Click(object sender, EventArgs e)
        {
            /*
             
             */
            frmPrincipal frm = new frmPrincipal();
            frm.idbol = int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString());
            frm.buscador = true;
            this.Close();
            frm.Show();
        }

    }
}
