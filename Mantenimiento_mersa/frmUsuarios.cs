using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Mantenimiento_mersa
{
    public partial class frmUsuarios : Form
    {
        int id_log;
        public frmUsuarios()
        {
            InitializeComponent();
        }
        public frmUsuarios(int id)
        {
            InitializeComponent();
            id_log = id;
        }
        Usuarios usuario = new Usuarios();
        Transportista transportista = new Transportista();
        tipo_usuarios tipo = new tipo_usuarios();
        List<TextBox> textBoxes = new List<TextBox>();
        Validaciones validaciones = new Validaciones();
        string id_dgv;
        private string patternDUI = @"^[0-9]{9}$";
        bool bandera = false;//False representa datos NO VALIDADOS, true lo contrario
        int edit_indice = -1;
        bool es_transportista;
        public bool buscador;
        public int idtranspor;
        public int idusuario;
        private void frmUsuarios_Load(object sender, EventArgs e)
        {
            CargarUsuarios();
            textBoxes.Add(txtApellido);
            textBoxes.Add(txtNombre);
            textBoxes.Add(txtDUI);
            textBoxes.Add(txtContra);
            txtApellido.Enabled = false;
            txtNombre.Enabled = false;
            txtDUI.Enabled = false;
            txtContra.Enabled = false;
        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Desea salir de la aplicacion", "Saliendo del programa", MessageBoxButtons.YesNo,
                MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == DialogResult.Yes)
            {
                Application.Exit();
            }
        }
        public void CargarUsuarios()
        {
            try
            {
                dgvUsuarios.Rows.Clear();
                foreach (Usuarios u in usuario.ListarUsuarios())
                {
                    int index = dgvUsuarios.Rows.Add();
                    dgvUsuarios.Rows[index].Cells[0].Value = u.Idusuario;
                    dgvUsuarios.Rows[index].Cells[1].Value = u.Dui;
                    dgvUsuarios.Rows[index].Cells[2].Value = u.Nombre;
                    dgvUsuarios.Rows[index].Cells[3].Value = u.Apellidos;
                    dgvUsuarios.Rows[index].Cells[4].Value = u.Contra;
                    dgvUsuarios.Rows[index].Cells[5].Value = u.Nombre_tipo;
                }
                dgvTransportistas.Rows.Clear();
                foreach (Transportista t in transportista.ListarTransportistasDataGrid())
                {
                    int index = dgvTransportistas.Rows.Add();
                    dgvTransportistas.Rows[index].Cells[0].Value = t.Id_transportista;
                    dgvTransportistas.Rows[index].Cells[1].Value = t.Dui;
                    dgvTransportistas.Rows[index].Cells[2].Value = t.Nombre;
                    dgvTransportistas.Rows[index].Cells[3].Value = t.Apellidos;
                    dgvTransportistas.Rows[index].Cells[4].Value = t.Placa;
                }
                cboTipo.DataSource = null;
                cboTipo.DataSource = tipo.listarTipos();
                cboTipo.DisplayMember = "Name";
                cboTipo.ValueMember = "Value";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }



        private void btnNuevo_Click(object sender, EventArgs e)
        {
            label2.Text = "Contraseña:";
            cboTipo.Visible = true;
            txtApellido.Enabled = true;
            txtNombre.Enabled = true;
            txtDUI.Enabled = true;
            txtContra.Enabled = true;
            es_transportista = false;
            btnAgregar.Enabled = true;
        }
        //Metodo para cargar la informacion del usuario en los controles de texto, para poder ser eliminado o editado
        public void CargarEnControles(Usuarios usu)
        {
            txtApellido.Text = usu.Apellidos;
            txtNombre.Text = usu.Nombre;
            txtDUI.Text = usu.Dui.ToString();
            txtContra.Text = usu.Contra;
            cboTipo.SelectedValue = usu.Tipo;
        }
        public void CargarEnControlesTranspor(Transportista tra)
        {
            txtApellido.Text = tra.Apellidos;
            txtNombre.Text = tra.Nombre;
            txtDUI.Text = tra.Dui.ToString();
            txtContra.Text = tra.Placa;
        }
        public void LimpiarControles()
        {
            foreach (TextBox t in textBoxes)
            {
                t.Clear();
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpiarControles();
            usuario = new Usuarios();
            edit_indice = -1;
            btnNuevoAdmin.Enabled = true;
            btnNuevoTranpor.Enabled = true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            txtApellido.Enabled = false;
            txtNombre.Enabled = false;
            txtDUI.Enabled = false;
            txtContra.Enabled = false;
            btnAgregar.Enabled = false;
        }

        private void txtDUI_Leave(object sender, EventArgs e)
        {
            try
            {
                if (!Regex.IsMatch(txtDUI.Text, patternDUI))
                {
                    bandera = false;
                    errorProvider1.SetError(txtDUI, "Ingrese un DUI valido");
                    txtDUI.Clear();
                    throw new Exception("Ingrese un DUI valido");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (!es_transportista)
            {
                try
                {
                    if (edit_indice > -1)
                    {
                        usuario.EliminarUsuario(edit_indice);
                        edit_indice = -1;
                        CambiarBotones();
                        CargarUsuarios();
                        btnNuevoAdmin.Enabled = true;
                        btnNuevoTranpor.Enabled = true;
                        btnModificar.Enabled = false;
                        btnEliminar.Enabled = false;
                        txtApellido.Enabled = false;
                        txtNombre.Enabled = false;
                        txtDUI.Enabled = false;
                        txtContra.Enabled = false;
                    }
                    else
                    {
                        throw new Exception("No ha seleccionado un Usuario para modificar");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            else
            {
                try
                {
                    if (edit_indice > -1)
                    {
                        transportista.EliminarTransportista(Int32.Parse(id_dgv));
                        edit_indice = -1;
                        CambiarBotones();
                        CargarUsuarios();
                        btnNuevoAdmin.Enabled = true;
                        btnNuevoTranpor.Enabled = true;
                        btnModificar.Enabled = false;
                        btnEliminar.Enabled = false;
                        txtApellido.Enabled = false;
                        txtNombre.Enabled = false;
                        txtDUI.Enabled = false;
                        txtContra.Enabled = false;
                    }
                    else
                    {
                        throw new Exception("No ha seleccionado un Usuario para modificar");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (!es_transportista)
            {
                try
                {
                    bandera = validaciones.NoCamposVacios(textBoxes, errorProvider1);
                    if (bandera)
                    {
                        if (edit_indice > -1)
                        {
                            usuario = new Usuarios();
                            usuario.Nombre = txtNombre.Text;
                            usuario.Apellidos = txtApellido.Text;
                            usuario.Contra = txtContra.Text;
                            usuario.Tipo = Int32.Parse(cboTipo.SelectedValue.ToString());
                            usuario.Dui = txtDUI.Text;
                            usuario.ModificarUsuario(edit_indice);
                            edit_indice = -1;
                            CargarUsuarios();
                            CambiarBotones();
                            if (usuario.Tipo == 1 || usuario.Tipo == 2)
                            {
                                label5.Visible = true;
                                cboTipo.Visible = true;
                            }
                            else
                            {
                                label5.Visible = false;
                                cboTipo.Visible = false;
                            }
                            btnNuevoAdmin.Enabled = true;
                            btnNuevoTranpor.Enabled = true;
                            btnModificar.Enabled = false;
                            btnEliminar.Enabled = false;
                            txtApellido.Enabled = false;
                            txtNombre.Enabled = false;
                            txtDUI.Enabled = false;
                            txtContra.Enabled = false;
                        }
                        else
                        {
                            throw new Exception("No ha seleccionado un Usuario para modificar");
                        }
                    }
                    else
                    {
                        MessageBox.Show("Hay campos sin completar o incorrectos", "Validaciones", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            else
            {
                try
                {
                    bandera = validaciones.NoCamposVacios(textBoxes, errorProvider1);
                    if (bandera && validaciones.PlacaCorrecta(txtContra))
                    {
                        if (edit_indice > -1)
                        {
                            transportista = new Transportista();
                            transportista.Nombre = txtNombre.Text;
                            transportista.Apellidos = txtApellido.Text;
                            transportista.Placa = txtContra.Text;
                            transportista.Dui = txtDUI.Text;
                            transportista.ModificarTransportista(Int32.Parse(id_dgv));
                            edit_indice = -1;
                            CargarUsuarios();
                            CambiarBotones();
                            btnNuevoAdmin.Enabled = true;
                            btnNuevoTranpor.Enabled = true;
                            btnModificar.Enabled = false;
                            btnEliminar.Enabled = false;
                            txtApellido.Enabled = false;
                            txtNombre.Enabled = false;
                            txtDUI.Enabled = false;
                            txtContra.Enabled = false;
                        }
                        else
                        {
                            throw new Exception("No ha seleccionado un Usuario para modificar");
                        }
                    }
                    else
                    {
                        MessageBox.Show("Hay campos sin completar o incorrectos", "Validaciones", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
        }
        public void CambiarBotones()
        {
            btnEliminar.Enabled = false;
            btnModificar.Enabled = false;
            btnNuevoAdmin.Enabled = true;
            gbAccion.Text = "Agregar Usuario";
            LimpiarControles();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            if (!es_transportista)
            {
                try
                {
                    bandera = validaciones.NoCamposVacios(textBoxes, errorProvider1);
                    if (bandera)
                    {
                        usuario = new Usuarios();
                        usuario.Nombre = txtNombre.Text;
                        usuario.Apellidos = txtApellido.Text;
                        usuario.Contra = txtContra.Text;
                        usuario.Tipo = Int32.Parse(cboTipo.SelectedValue.ToString());
                        usuario.Dui = txtDUI.Text;
                        usuario.InsertarUsuario();
                        CargarUsuarios();
                        LimpiarControles();
                        btnNuevoAdmin.Enabled = true;
                        btnNuevoTranpor.Enabled = true;
                        btnModificar.Enabled = false;
                        btnEliminar.Enabled = false;
                        txtApellido.Enabled = false;
                        txtNombre.Enabled = false;
                        txtDUI.Enabled = false;
                        txtContra.Enabled = false;
                        btnAgregar.Enabled = false;
                    }
                    else
                    {
                        MessageBox.Show("Hay campos sin completar o incorrectos", "Validaciones", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            else
            {
                try
                {
                    bandera = validaciones.NoCamposVacios(textBoxes, errorProvider1);
                    if (bandera && validaciones.PlacaCorrecta(txtContra))
                    {
                        transportista = new Transportista();
                        transportista.Nombre = txtNombre.Text;
                        transportista.Apellidos = txtApellido.Text;
                        transportista.Placa = "P"+txtContra.Text;
                        transportista.Dui = txtDUI.Text;
                        transportista.InsertarTransportista();
                        CargarUsuarios();
                        LimpiarControles();
                        btnNuevoAdmin.Enabled = true;
                        btnNuevoTranpor.Enabled = true;
                        btnModificar.Enabled = false;
                        btnEliminar.Enabled = false;
                        txtApellido.Enabled = false;
                        txtNombre.Enabled = false;
                        txtDUI.Enabled = false;
                        txtContra.Enabled = false;
                        btnAgregar.Enabled = false;
                    }
                    else
                    {
                        MessageBox.Show("Hay campos sin completar o incorrectos", "Validaciones", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
        }

        private void btnNuevoTranpor_Click(object sender, EventArgs e)
        {
            txtApellido.Enabled = true;
            txtNombre.Enabled = true;
            txtDUI.Enabled = true;
            txtContra.Enabled = true;
            label2.Text = "Placa:";
            label5.Visible = false;
            cboTipo.Visible = false;
            es_transportista = true;
            btnAgregar.Enabled = true;
        }

        private void dgvTransportistas_Click(object sender, EventArgs e)
        {
            try
            {
                label2.Text = "Placa:";
                gbAccion.Text = "Eliminar/Modificar Transportistas";
                DataGridViewRow selected = dgvTransportistas.SelectedRows[0];
                int posicion = dgvTransportistas.Rows.IndexOf(selected);
                transportista = new Transportista();
                transportista.Id_transportista = int.Parse(dgvTransportistas.CurrentRow.Cells[0].Value.ToString());
                transportista.Dui = dgvTransportistas.CurrentRow.Cells[1].Value.ToString();
                id_dgv = dgvTransportistas.CurrentRow.Cells[0].Value.ToString();
                transportista.Nombre = dgvTransportistas.CurrentRow.Cells[2].Value.ToString();
                transportista.Apellidos = dgvTransportistas.CurrentRow.Cells[3].Value.ToString();
                transportista.Placa = dgvTransportistas.CurrentRow.Cells[4].Value.ToString();
                CargarEnControlesTranspor(transportista);
                edit_indice = transportista.Id_transportista;
                btnModificar.Enabled = true;
                btnEliminar.Enabled = true;
                btnNuevoAdmin.Enabled = false;
                btnNuevoTranpor.Enabled = false;
                txtApellido.Enabled = true;
                txtNombre.Enabled = true;
                txtDUI.Enabled = true;
                txtContra.Enabled = true;
                cboTipo.Visible = false;
                label5.Visible = false;
                es_transportista = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

        }

        private void dgvUsuarios_Click(object sender, EventArgs e)
        {
            label2.Text = "Contraseña:";
            gbAccion.Text = "Eliminar/Modificar Usuario";
            DataGridViewRow selected = dgvUsuarios.SelectedRows[0];
            int posicion = dgvUsuarios.Rows.IndexOf(selected);
            int idRecuperado = int.Parse(dgvUsuarios.CurrentRow.Cells[0].Value.ToString());
            usuario = new Usuarios();
            usuario.Idusuario = idRecuperado;
            usuario.Dui = dgvUsuarios.CurrentRow.Cells[1].Value.ToString();
            usuario.Nombre = dgvUsuarios.CurrentRow.Cells[2].Value.ToString();
            usuario.Apellidos = dgvUsuarios.CurrentRow.Cells[3].Value.ToString();
            usuario.Contra = dgvUsuarios.CurrentRow.Cells[4].Value.ToString();
            string nombre_tipo = dgvUsuarios.CurrentRow.Cells[5].Value.ToString();
            if (nombre_tipo.Equals("Administrador"))
            {
                usuario.Tipo = 1;
            }
            else
            {
                usuario.Tipo = 2;
            }
            CargarEnControles(usuario);
            edit_indice = idRecuperado;
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnNuevoAdmin.Enabled = false;
            btnNuevoTranpor.Enabled = false;
            txtApellido.Enabled = true;
            txtNombre.Enabled = true;
            txtDUI.Enabled = true;
            txtContra.Enabled = true;
            es_transportista = false;
            cboTipo.Visible = true;
            label5.Visible = true;
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscadorUsuarios busc = new BuscadorUsuarios();
            this.Close();
            busc.Show();
        }
    }
}
