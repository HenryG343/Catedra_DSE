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
    public partial class Menu : Form
    {
        public bool admin;
        public bool buscador;
        //Para validar sesion
        private int id_log;
        public Menu()
        {
            InitializeComponent();
        }
        public Menu(int id)
        {
            InitializeComponent();
            id_log = id;
        }

        private void mantenimientoDeUsuariosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmUsuarios mdiUsuarios = new frmUsuarios(id_log);
            mdiUsuarios.MdiParent = this;
            mdiUsuarios.Show();
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Desea salir de la aplicacion", "Saliendo del programa", MessageBoxButtons.YesNo,
                MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == DialogResult.Yes)
            {
                Application.Exit();
            }
        }

        private void bOLToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmPrincipal mdiPrincipal = new frmPrincipal(id_log);
            mdiPrincipal.admin = true;
            mdiPrincipal.MdiParent = this;
            mdiPrincipal.Show();
        }

        private void Menu_Load(object sender, EventArgs e)
        {
            if(buscador == true)
            {
                frmPrincipal mdiPrincipal = new frmPrincipal(id_log);
                mdiPrincipal.admin = true;
                mdiPrincipal.MdiParent = this;
                mdiPrincipal.Show();
            }
        }
    }
}
