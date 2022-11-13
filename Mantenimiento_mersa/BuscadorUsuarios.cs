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
    public partial class BuscadorUsuarios : Form
    {
        Transportista transportista = new Transportista();
        Usuarios usuarios = new Usuarios();
        int id_log;
        public BuscadorUsuarios()
        {
            InitializeComponent();
        }
        public BuscadorUsuarios(int id)
        {
            InitializeComponent();
            id_log = id;
        }

        private void BuscadorUsuarios_Load(object sender, EventArgs e)
        {
            Llenar_dgvTras();
            Llenar_dgvUs();
        }

        private void Llenar_dgvUs()
        {
            dgvUsuarios.Rows.Clear();
            foreach (Usuarios usu in usuarios.BuscadorUsuarios(txtDUI.Text, txtNombre.Text, txtApellido.Text))
            {
                int i = dgvUsuarios.Rows.Add();
                dgvUsuarios.Rows[i].Cells[0].Value = usu.Idusuario;
                dgvUsuarios.Rows[i].Cells[1].Value = usu.Dui;
                dgvUsuarios.Rows[i].Cells[2].Value = usu.Nombre;
                if (usu.Tipo == 1)
                {
                    dgvUsuarios.Rows[i].Cells[3].Value = "Administrador";
                }
                else
                {
                    dgvUsuarios.Rows[i].Cells[3].Value = "Empleado";
                }
            }
        }

        private void Llenar_dgvTras()
        {
            dgvTransportistas.Rows.Clear();
            foreach (Transportista tran in transportista.BuscadorTransportistas(txtDUI.Text, txtNombre.Text, txtApellido.Text))
            {
                int i = dgvTransportistas.Rows.Add();
                dgvTransportistas.Rows[i].Cells[0].Value = tran.Id_transportista;
                dgvTransportistas.Rows[i].Cells[1].Value = tran.Dui;
                dgvTransportistas.Rows[i].Cells[2].Value = tran.Nombre;
                dgvTransportistas.Rows[i].Cells[3].Value = tran.Placa;
            }
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            this.Close();
            Menu menu = new Menu(id_log);
            menu.buscador = true;
            menu.Show();
        }

        private void txtNbol_KeyUp(object sender, KeyEventArgs e)
        {
            Llenar_dgvTras();
            Llenar_dgvUs();
        }

        private void txtFecha_KeyUp(object sender, KeyEventArgs e)
        {
            Llenar_dgvTras();
            Llenar_dgvUs();
        }

        private void txtTran_KeyUp(object sender, KeyEventArgs e)
        {
            Llenar_dgvTras();
            Llenar_dgvUs();
        }

        private void dgvTransportistas_Click(object sender, EventArgs e)
        {
            frmUsuarios frm = new frmUsuarios();
            frm.idtranspor = int.Parse(dgvTransportistas.CurrentRow.Cells[0].Value.ToString());
            frm.idusuario = -1;
            frm.buscador = true;
            this.Close();
            frm.Show();
        }

        private void dgvUsuarios_Click(object sender, EventArgs e)
        {
            frmUsuarios frm = new frmUsuarios();
            frm.idusuario = int.Parse(dgvUsuarios.CurrentRow.Cells[0].Value.ToString());
            frm.idtranspor = -1;
            frm.buscador = true;
            this.Close();
            frm.Show();
        }
    }
}
