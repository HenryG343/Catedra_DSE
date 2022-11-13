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
    public partial class frmPrincipal : Form
    {
        public frmPrincipal()
        {
            InitializeComponent();
        }
        public frmPrincipal(int id)
        {
            InitializeComponent();
            id_log = id;
        }
        //Variables
        bool EsNuevo = false;
        bool Modificando = false;
        bool HayDetalle = false;
        int numero_bol;
        int index;
        String tipo_movimiento;
        int id_log;
        //Variables para buscador
        public bool admin;
        public bool buscador = false;
        public int idbol;
        //Objetos
        Transportista transportista = new Transportista();
        Bol bol = new Bol();
        Bol bolUltimo = new Bol();
        Detalle_bol detalles_bol = new Detalle_bol();
        Series serie = new Series();
        List<Series> series_recuperadas = new List<Series>();
        List<Detalle_bol> detalle_actual = new List<Detalle_bol>();
        Sac sac = new Sac();
        List<String> series_escaneadas_salida = new List<String>();
        List<String> series_escaneadas_entrada = new List<String>();
        List<Sac> DataSetSacEntrada = new List<Sac>();
        List<Sac> DataSetSacSalida = new List<Sac>();
        //Evento Load
        private void frmPrincipal_Load(object sender, EventArgs e)
        {
            bolUltimo = bol.CargarUltimo();
            ActualizarDataSetSac();
            if (id_log == 1)
            {
                btnEliminar.Visible = true;
            }
            else
            {
                btnEliminar.Visible = false;
            }
            BloqueoInicialyLoad();
            Navegacion();
            btnSiguiente.Enabled = false;
            //Obtener la cantidad de boles en la base de datos
            numero_bol = bol.CantidadBol();
            index = numero_bol - 1;
            if (buscador == false)
            {
                //Mostramos por defecto el ultimo de estos
                CargarUltimo();
                //Cargar detalles de ese bol
                Rellenardgv();
            }
            else
            {
                //Cargar primer registro
                Bol primer = new Bol();
                primer = bol.CargarBuscador(idbol);
                dtpFecha.Text = primer.Fecha;
                txtChofer.Text = primer.Chofer;
                txtBol.Text = primer.Id_bol.ToString();
                cboPlaca.Text = primer.Placas;
                cboZona.Text = primer.Zona;
                cboEspecial.Text = primer.Especial;
                if (primer.Tipo_movimiento == "Entrada")
                {
                    rdbEntrada.Checked = true;
                }
                else
                {
                    rdbSalida.Checked = true;
                }
                cboTransportista.SelectedValue = primer.Transportista;
                Rellenardgv();
            }
        }
        //----
        public void BloqueoInicialyLoad()
        {
            //Bloquear controladores inicialmente
            dgvInformacion.Enabled = false;
            btnGuardar.Enabled = false;
            dtpFecha.Enabled = false;
            cboPlaca.Enabled = false;
            txtChofer.Enabled = false;
            cboZona.Enabled = false;
            cboEspecial.Enabled = false;
            rdbEntrada.Enabled = false;
            rdbSalida.Enabled = false;
            cboZona.SelectedIndex = 0;
            cboEspecial.SelectedIndex = 0;
            //Cargar trasnportistas y placas
            cboTransportista.DataSource = null;
            cboTransportista.DataSource = transportista.ListarTransportistasBuscador();
            cboTransportista.DisplayMember = "Name";
            cboTransportista.ValueMember = "Value";
            cboPlaca.DataSource = null;
            cboPlaca.DataSource = transportista.ListarPlacasCombo();
            cboPlaca.DisplayMember = "Name";
            cboPlaca.ValueMember = "Value";
        }
        //----
        //Metodo para habilitar o deshabilitar botones de navegacion
        public void Navegacion()
        {
            int IndexFin = 0;
            int IndexIn = 0;//Si hay bol esa es la posicion de inicio
            numero_bol = bol.CantidadBol();
            IndexFin = numero_bol - 1;
            if (numero_bol < 1)
            {
                btnSiguiente.Enabled = false;
                btnAnterior.Enabled = false;
                btnUltimo.Enabled = false;
                btnPrimero.Enabled = false;
                btnModificar.Enabled = false;
                btnEliminar.Enabled = false;
                btnNuevo.Enabled = true;
                btnBuscar.Enabled = false;
                btnImprimir.Enabled = false;
                btnCancelar.Enabled = false;
                btnReporte.Enabled = false;
                btnEmos.Enabled = false;
                btnComoDatos.Enabled = false;
                IndexIn = -2;
            }
            else
            {
                int pos = index;
                if (pos == IndexIn)
                {
                    btnSiguiente.Enabled = true;
                    btnAnterior.Enabled = false;
                    btnUltimo.Enabled = true;
                    btnPrimero.Enabled = false;
                }
                else if (pos == IndexFin)
                {
                    btnSiguiente.Enabled = false;
                    btnAnterior.Enabled = true;
                    btnUltimo.Enabled = false;
                    btnPrimero.Enabled = true;
                }
                else
                {
                    btnSiguiente.Enabled = true;
                    btnAnterior.Enabled = true;
                    btnUltimo.Enabled = true;
                    btnPrimero.Enabled = true;
                }
            }

        }

        //Controladores--------------------------------------------------------------------------------------------------------
        //Boton para salir de la aplicacion
        private void btnSalir_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Desea salir de la aplicacion", "Saliendo del programa", MessageBoxButtons.YesNo,
                MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == DialogResult.Yes)
            {
                Application.Exit();
            }
        }
        //Guardar nuevo bol o modificarlo
        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                //Creacion del bol
                bol = new Bol();
                //Campos obligatorios del BOL
                bol.Fecha = dtpFecha.Value.Year.ToString() + "-" + dtpFecha.Value.Month.ToString() + "-" + dtpFecha.Value.Day.ToString();
                bol.Tipo_movimiento = tipo_movimiento;
                if (cboTransportista.SelectedValue == null)
                {
                    throw new Exception("Debe seleccionar un transportista");
                }
                else
                {
                    bol.Transportista = int.Parse(cboTransportista.SelectedValue.ToString());
                }
                bol.Chofer = txtChofer.Text;
                bol.Nro_documento = bol.UltimoNumDoc();
                bol.Placas = cboPlaca.Text.Trim();
                bol.Zona = cboZona.Text;
                bol.Especial = cboEspecial.Text;
                //----
                //Objeto de tipo detalle bol
                Detalle_bol det = new Detalle_bol();
                //Validamos que el campo chofer no este vacio
                if (txtChofer.Text == " ")
                {
                    throw new Exception("Debe llenar el campo Chofer");
                }
                else
                {
                    //Verificamos si es un nuevo bol o una modificacion
                    if (EsNuevo)
                    {
                        HayDetalle = NoDetalleVacio();
                        if (HayDetalle)
                        {
                            bol.InsertarBOL();
                            Bol primer = new Bol();
                            primer = bol.CargarUltimo();
                            txtBol.Text = primer.Id_bol.ToString();
                            for (int i = 0; i < dgvInformacion.RowCount - 1; i++)
                            {
                                det = LlenarDetalleBol(i);
                                if (dgvInformacion.Rows[i].Cells[0].Value == null)
                                {
                                    det.InsertarDetalleBOL();
                                }
                                else
                                {
                                    det.ModificarDetalleBol(Int32.Parse(dgvInformacion.Rows[i].Cells[0].Value.ToString()));
                                    Series s = new Series();
                                    s.EliminarSeries(cboPlaca.Text.Trim());
                                }

                            }
                            Series serieScan = new Series();
                            serieScan.EliminarSeries(bol.Placas);
                            //Bloqueamos
                            ActivarControles();
                            btnReporte.Enabled = true;
                            //cargamos ultimo bol
                            CargarUltimo();
                            Navegacion();
                            EsNuevo = false;
                        }
                        else
                        {
                            throw new Exception("Debe ingresar detalle al bol");
                        }

                    }
                    else//Cuando se modifica
                    {
                        bol.ModificarBol(Int32.Parse(txtBol.Text));
                        for (int i = 0; i < dgvInformacion.RowCount - 1; i++)
                        {
                            det = LlenarDetalleBol(i);
                            if (dgvInformacion.Rows[i].Cells[0].Value == null)
                            {
                                det.InsertarDetalleBOL();
                            }
                            else
                            {
                                if (String.IsNullOrEmpty(det.Emo) && rdbSalida.Checked == true)
                                {
                                    det.Emo = det.UltimoEmo();
                                }
                                det.ModificarDetalleBol(Int32.Parse(dgvInformacion.Rows[i].Cells[0].Value.ToString()));
                                Series s = new Series();
                                s.EliminarSeries(cboPlaca.Text.Trim());
                                dgvInformacion.Refresh();
                            }
                            btnReporte.Enabled = true;
                        }
                        Modificando = false;
                        //Bloqueamos
                        ActivarControles();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error Guardar", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

        }
        //Para activar controles
        public void ActivarControles()
        {
            dtpFecha.Enabled = false;
            cboPlaca.Enabled = false;
            txtChofer.Enabled = false;
            cboZona.Enabled = false;
            cboEspecial.Enabled = false;
            btnModificar.Enabled = true;
            btnNuevo.Enabled = true;
            btnImprimir.Enabled = true;
            btnEliminar.Enabled = true;
            btnBuscar.Enabled = true;
            //Botones de navegacion
            btnSiguiente.Enabled = true;
            btnAnterior.Enabled = true;
            btnPrimero.Enabled = true;
            btnUltimo.Enabled = true;
        }
        //Metodo comun para llenar detalle de bol
        public Detalle_bol LlenarDetalleBol(int i)
        {
            Detalle_bol det = new Detalle_bol();
            det.Id_bol = Convert.ToInt32(txtBol.Text);
            det.Modelo = dgvInformacion.Rows[i].Cells[2].Value.ToString();
            det.Linea = dgvInformacion.Rows[i].Cells[5].Value.ToString();
            det.Serie = dgvInformacion.Rows[i].Cells[1].Value.ToString();
            det.Activo = dgvInformacion.Rows[i].Cells[3].Value.ToString();
            if (dgvInformacion.Rows[i].Cells[7].Value == null && rdbSalida.Checked == true)
            {
                det.Emo = det.UltimoEmo();
                dgvInformacion.Rows[i].Cells[7].Value = det.Emo;
            }
            else
            {
                if (dgvInformacion.Rows[i].Cells[7].Value == null)
                {
                    det.Emo = "0";
                }
                else
                {
                    det.Emo = dgvInformacion.Rows[i].Cells[7].Value.ToString();
                }

            }
            if (dgvInformacion.Rows[i].Cells[4].Value == null)
            {
                det.Ficha = " ";
            }
            else
            {
                det.Ficha = dgvInformacion.Rows[i].Cells[4].Value.ToString();
            }
            if (dgvInformacion.Rows[i].Cells[6].Value == null)
            {
                det.Emo_pepsi = " ";
            }
            else
            {
                det.Emo_pepsi = dgvInformacion.Rows[i].Cells[6].Value.ToString();
            }
            return det;
        }
        public bool NoDetalleVacio()
        {
            bool salida = false;
            for (int i = 0; i < dgvInformacion.RowCount - 1; i++)
            {
                if (dgvInformacion.Rows[i].Cells[1].Value == null)
                {
                    salida = false;
                    break;
                }
                else
                {
                    salida = true;
                }
                if (dgvInformacion.Rows[i].Cells[2].Value == null)
                {
                    salida = false;
                    break;
                }
                else
                {
                    salida = true;
                }
                if (dgvInformacion.Rows[i].Cells[3].Value == null)
                {
                    salida = false;
                    break;
                }
                else
                {
                    salida = true;
                }
                if (dgvInformacion.Rows[i].Cells[5].Value == null)
                {
                    salida = false;
                    break;
                }
                else
                {
                    salida = true;
                }
            }
            return salida;
        }
        //Activar los controladores para agregar nuevo bol
        private void btnNuevo_Click(object sender, EventArgs e)
        {
            rdbEntrada.Enabled = true;
            rdbSalida.Enabled = true;
            rdbSalida.Checked = true;
            CambiarControlesNuevoModificar();
            EsNuevo = true;
            //Limpiamos
            dtpFecha.Value = DateTime.Now;
            txtBol.Clear();
            txtChofer.Clear();
            dgvInformacion.Rows.Clear();
            btnCancelar.Enabled = true;
            Modificando = false;
        }
        private void cboTransportista_SelectedIndexChanged(object sender, EventArgs e) { }
        //Cancelar cualquier accion
        private void btnCancelar_Click(object sender, EventArgs e)
        {
            dgvInformacion.Enabled = false;
            dtpFecha.Enabled = false;
            cboPlaca.Enabled = false;
            txtChofer.Enabled = false;
            cboZona.Enabled = false;
            cboEspecial.Enabled = false;
            rdbEntrada.Enabled = false;
            rdbSalida.Enabled = false;
            btnNuevo.Enabled = true;
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnBuscar.Enabled = true;
            btnImprimir.Enabled = true;
            btnReporte.Enabled = true;
            EsNuevo = false;
            Modificando = false;
            CargarUltimo();
        }
        //Generar reportes
        private void btnReporte_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtBol.Text))
                {
                    throw new Exception("No hay ningun bol seleccionado");
                }
                else
                {
                    int id = int.Parse(txtBol.Text);
                    GenerarReporteTransportista reporte = new GenerarReporteTransportista();
                    reporte.Show();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

        }
        //Llevar al ultimo bol
        private void btnUltimo_Click(object sender, EventArgs e)
        {
            //Valida registros para botones de navegacion
            dtpFecha.Enabled = false;
            cboPlaca.Enabled = false;
            txtChofer.Enabled = false;
            cboZona.Enabled = false;
            cboEspecial.Enabled = false;
            rdbEntrada.Enabled = false;
            rdbSalida.Enabled = false;
            CargarUltimo();
            Rellenardgv();
            numero_bol = bol.CantidadBol();
            index = numero_bol - 1;
            btnAnterior.Enabled = true;
            btnSiguiente.Enabled = false;
        }
        //Levar al primer bol
        private void btnPrimero_Click(object sender, EventArgs e)
        {
            //Valida registros para botones de navegacion
            dtpFecha.Enabled = false;
            cboPlaca.Enabled = false;
            txtChofer.Enabled = false;
            cboZona.Enabled = false;
            cboEspecial.Enabled = false;
            rdbEntrada.Enabled = false;
            rdbSalida.Enabled = false;
            CargarPrimero();
            Rellenardgv();
            index = 0;
            btnSiguiente.Enabled = true;
            btnAnterior.Enabled = false;
        }
        //Activar todo para modificar
        private void btnModificar_Click(object sender, EventArgs e)
        {
            CambiarControlesNuevoModificar();
            rdbEntrada.Enabled = false;
            rdbSalida.Enabled = false;
            EsNuevo = false;
            Modificando = true;
        }
        //Habilitar/Deshabilitar controles para nuevo o modificar
        public void CambiarControlesNuevoModificar()
        {
            //Activamos
            btnGuardar.Enabled = true;
            dtpFecha.Enabled = true;
            cboPlaca.Enabled = true;
            txtChofer.Enabled = true;
            cboZona.Enabled = true;
            cboEspecial.Enabled = true;
            rdbEntrada.Enabled = true;
            rdbSalida.Enabled = true;
            dgvInformacion.Enabled = true;
            //Desactivamos
            btnNuevo.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            btnBuscar.Enabled = false;
            btnImprimir.Enabled = false;
            btnReporte.Enabled = false;
            btnPrimero.Enabled = false;
            btnAnterior.Enabled = false;
            btnSiguiente.Enabled = false;
            btnUltimo.Enabled = false;
        }
        //Eliminar un bol
        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("¿Estas seguro de eliminar este registro?", "Alerta", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                bol.EliminarBol(Int32.Parse(txtBol.Text));
                CargarUltimo();
                Navegacion();
            }
        }
        //Seleccionar placa y cambiar al transportista correspondiente
        private void cboPlaca_SelectedIndexChanged(object sender, EventArgs e)
        {
            numero_bol = bol.CantidadBol();
            cboTransportista.DataSource = null;
            if (numero_bol > 0 && EsNuevo == false)
            {
                if (!Modificando)
                {
                    cboTransportista.DataSource = transportista.ListarTransportistasCombo(bolUltimo.Transportista.ToString());
                }
                else
                {
                    cboTransportista.DataSource = transportista.ListarTransportistasCombo(cboPlaca.SelectedValue.ToString());
                }

            }
            else if (numero_bol > 0 && EsNuevo)
            {
                cboTransportista.DataSource = transportista.ListarTransportistasCombo(cboPlaca.SelectedValue.ToString());
            }
            else
            {
                cboTransportista.DataSource = transportista.ListarTransportistasBuscador();
            }
            cboTransportista.DisplayMember = "Name";
            cboTransportista.ValueMember = "Value";
            if (EsNuevo)
            {
                series_recuperadas = new List<Series>();
                series_recuperadas = serie.RecuperarSeries(cboPlaca.Text, dgvInformacion);
                if (series_recuperadas.Count > 0)
                {
                    dgvInformacion.Rows.Clear();
                    AgregarSeries(series_recuperadas);
                }
                else
                {
                    dgvInformacion.Rows.Clear();
                    MessageBox.Show("No se han escaneado series para esta placa", "Agregando Series", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            if (Modificando)
            {
                series_recuperadas = new List<Series>();
                series_recuperadas = serie.RecuperarSeries(cboPlaca.Text, dgvInformacion);
                if (series_recuperadas.Count > 0)
                {
                    AgregarModificandoSeries(series_recuperadas);
                }
                else
                {
                    MessageBox.Show("No se han escaneado series para esta placa", "Modificando Series", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
        }
        //Metodo para llenar el DataGridView con las series recuperadas
        public void AgregarSeries(List<Series> lst)
        {
            for (int i = 0; i < lst.Count; i++)
            {
                Sac sactmp = new Sac();
                if (rdbEntrada.Checked)
                {
                    sactmp = sac.BuscarSerie(series_escaneadas_entrada, lst[i].Serie, DataSetSacEntrada);
                }
                else
                {
                    sactmp = sac.BuscarSerie(series_escaneadas_salida, lst[i].Serie, DataSetSacSalida);
                }
                if (sactmp == null)
                {

                }
                else
                {
                    int p = dgvInformacion.Rows.Add();
                    dgvInformacion.Rows[i].Cells[1].Value = lst[i].Serie;
                    dgvInformacion.Rows[i].Cells[2].Value = sactmp.Modelo;
                    dgvInformacion.Rows[i].Cells[3].Value = sactmp.Activo;
                    dgvInformacion.Rows[i].Cells[4].Value = sactmp.Ficha;
                    dgvInformacion.Rows[i].Cells[5].Value = sactmp.Linea;
                }
            }
        }
        public void AgregarModificandoSeries(List<Series> lst)
        {
            for (int i = 0; i < lst.Count; i++)
            {
                Sac sactmp = new Sac();
                if (rdbEntrada.Checked)
                {
                    sactmp = sac.BuscarSerie(series_escaneadas_entrada, lst[i].Serie, DataSetSacEntrada);
                }
                else
                {
                    sactmp = sac.BuscarSerie(series_escaneadas_salida, lst[i].Serie, DataSetSacSalida);
                }
                if (sactmp == null)
                {

                }
                else
                {
                    int p = dgvInformacion.Rows.Add();
                    dgvInformacion.Rows[p].Cells[1].Value = lst[i].Serie;
                    dgvInformacion.Rows[p].Cells[2].Value = sactmp.Modelo;
                    dgvInformacion.Rows[p].Cells[3].Value = sactmp.Activo;
                    dgvInformacion.Rows[p].Cells[4].Value = sactmp.Ficha;
                    dgvInformacion.Rows[p].Cells[5].Value = sactmp.Linea;
                }
            }
        }
        public void AgregarSeries(String serie, int i)
        {
            try
            {
                Sac sactmp = new Sac();
                if (rdbEntrada.Checked)
                {
                    sactmp = sac.BuscarSerie(series_escaneadas_entrada, serie, DataSetSacEntrada);
                }
                else
                {
                    sactmp = sac.BuscarSerie(series_escaneadas_salida, serie, DataSetSacSalida);
                }
                if (sactmp == null)
                {
                    dgvInformacion.Rows[i].Cells[1].Value = "";
                    int row = dgvInformacion.CurrentCell.RowIndex;
                    dgvInformacion.Rows.Remove(dgvInformacion.CurrentRow);
                }
                else
                {
                    dgvInformacion.Rows[i].Cells[2].Value = sactmp.Modelo;
                    dgvInformacion.Rows[i].Cells[3].Value = sactmp.Activo;
                    dgvInformacion.Rows[i].Cells[4].Value = sactmp.Ficha;
                    dgvInformacion.Rows[i].Cells[5].Value = sactmp.Linea;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Serie no valida", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

        }
        //Llevar al bol anterior
        private void btnAnterior_Click(object sender, EventArgs e)
        {
            //Valida registros para botones de navegacion
            Navegacion();
            CargarAnterior();
            btnSiguiente.Enabled = true;
            Rellenardgv();
            if (index == 0)
            {
                btnAnterior.Enabled = false;
            }
        }
        //Llevar al bol siguiente
        private void btnSiguiente_Click(object sender, EventArgs e)
        {
            //Valida registros para botones de navegacion
            Navegacion();
            CargarSiguiente();
            btnAnterior.Enabled = true;
            numero_bol = bol.CantidadBol();
            if (index == numero_bol - 1)
            {
                btnSiguiente.Enabled = false;
            }
            Rellenardgv();
        }
        //Llamar al form del buscador
        private void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                Buscador busc = new Buscador(id_log);
                if (admin == true)
                {
                    busc.Principal = true;
                }
                this.Close();
                busc.Show();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion al buscar", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

        }
        //Eliminar en el dgv
        private void dgvInformacion_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvInformacion.Columns[e.ColumnIndex].HeaderText == "Eliminar")
            {
                if (dgvInformacion.CurrentRow.Cells[0].Value == null)
                {

                }
                else
                {
                    if (MessageBox.Show("¿Estas seguro de eliminar este registro del detalle?", "Eliminar Serie - Detalle", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                    {
                        detalles_bol.EliminarDetalleBol(dgvInformacion.CurrentRow.Cells[0].Value.ToString());
                        Rellenardgv();
                    }
                }
                if (dgvInformacion.CurrentRow.Cells[1].Value != null)
                {
                    if (EsNuevo)
                    {
                        if (MessageBox.Show("¿Estas seguro de eliminar este registro del detalle nuevo?", "Eliminar Serie - Detalle Nuevo", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                        {
                            dgvInformacion.Rows.Remove(dgvInformacion.CurrentRow);
                        }
                    }
                }
            }
        }
        //Funciones-------------------------------------------------------------------------------------------------------------------
        //Cargar primer bol
        public void CargarPrimero()
        {
            //Cargar primer registro
            //Bol bolUltimo = new Bol();
            bolUltimo = bol.CargarPrimero();
            //MessageBox.Show(primer.Placas.ToString());
            dtpFecha.Text = bolUltimo.Fecha;
            txtChofer.Text = bolUltimo.Chofer;
            txtBol.Text = bolUltimo.Id_bol.ToString();
            cboPlaca.Text = bolUltimo.Placas;
            cboZona.Text = bolUltimo.Zona;
            cboEspecial.Text = bolUltimo.Especial;
            if (bolUltimo.Tipo_movimiento == "Entrada")
            {
                rdbEntrada.Checked = true;
            }
            else
            {
                rdbSalida.Checked = true;
            }
            cboTransportista.DataSource = transportista.ListarTransportistasCombo(bolUltimo.Transportista.ToString());
            Navegacion();
            //cboTransportista.SelectedValue = bolUltimo.Transportista;
        }
        //Cargar ultimo bol
        public void CargarUltimo()
        {
            //Cargar primer registro
            //Bol bolUltimo = new Bol();
            bolUltimo = bol.CargarUltimo();
            //MessageBox.Show(primer.Placas.ToString());
            dtpFecha.Text = bolUltimo.Fecha;
            txtChofer.Text = bolUltimo.Chofer;
            txtBol.Text = bolUltimo.Id_bol.ToString();
            cboPlaca.Text = bolUltimo.Placas;
            cboZona.Text = bolUltimo.Zona;
            cboEspecial.Text = bolUltimo.Especial;
            if (bolUltimo.Tipo_movimiento == "Entrada")
            {
                rdbEntrada.Checked = true;
            }
            else
            {
                rdbSalida.Checked = true;
            }
            cboTransportista.DataSource = transportista.ListarTransportistasCombo(bolUltimo.Transportista.ToString());
            //cboTransportista.SelectedValue = bolUltimo.Transportista;
            Rellenardgv();
            Navegacion();
        }
        //Cargar anterior bol
        public void CargarAnterior()
        {
            List<Bol> listabo = new List<Bol>();
            //Bol bolUltimo = new Bol();
            listabo = bol.ListarBol();
            index--;
            bolUltimo = listabo[index];
            dtpFecha.Text = bolUltimo.Fecha;
            txtChofer.Text = bolUltimo.Chofer;
            txtBol.Text = bolUltimo.Id_bol.ToString();
            cboPlaca.Text = bolUltimo.Placas;
            cboZona.Text = bolUltimo.Zona;
            cboEspecial.Text = bolUltimo.Especial;
            if (bolUltimo.Tipo_movimiento == "Entrada")
            {
                rdbEntrada.Checked = true;
            }
            else
            {
                rdbSalida.Checked = true;
            }
            cboTransportista.DataSource = transportista.ListarTransportistasCombo(bolUltimo.Transportista.ToString());
            Navegacion();
            //cboTransportista.SelectedValue = bolUltimo.Transportista;
        }
        //Cargar siguiente
        public void CargarSiguiente()
        {
            List<Bol> listabo = new List<Bol>();
            //Bol bolUltimo = new Bol();
            listabo = bol.ListarBol();
            index++;
            bolUltimo = listabo[index];
            dtpFecha.Text = bolUltimo.Fecha;
            txtChofer.Text = bolUltimo.Chofer;
            txtBol.Text = bolUltimo.Id_bol.ToString();
            cboPlaca.Text = bolUltimo.Placas;
            cboZona.Text = bolUltimo.Zona;
            cboEspecial.Text = bolUltimo.Especial;
            if (bolUltimo.Tipo_movimiento == "Entrada")
            {
                rdbEntrada.Checked = true;
            }
            else
            {
                rdbSalida.Checked = true;
            }
            cboTransportista.DataSource = transportista.ListarTransportistasCombo(bolUltimo.Transportista.ToString());
            Navegacion();
            //cboTransportista.SelectedValue = bolUltimo.Transportista;
        }
        //Llenar el dgv con detalles_bol
        public void Rellenardgv()
        {
            dgvInformacion.Rows.Clear();
            foreach (Detalle_bol det in detalles_bol.ListarDetalles(Convert.ToInt32(txtBol.Text)))
            {
                int i = dgvInformacion.Rows.Add();
                dgvInformacion.Rows[i].Cells[0].Value = det.Id;
                dgvInformacion.Rows[i].Cells[1].Value = det.Serie;
                dgvInformacion.Rows[i].Cells[2].Value = det.Modelo;
                dgvInformacion.Rows[i].Cells[3].Value = det.Activo;
                dgvInformacion.Rows[i].Cells[4].Value = det.Ficha;
                dgvInformacion.Rows[i].Cells[5].Value = det.Linea;
                dgvInformacion.Rows[i].Cells[6].Value = det.Emo_pepsi;
                dgvInformacion.Rows[i].Cells[7].Value = det.Emo;
            }
        }

        private void rdbEntrada_CheckedChanged(object sender, EventArgs e)
        {
            tipo_movimiento = "Entrada";
            dgvInformacion.Columns[7].ReadOnly = false;
        }

        private void rdbSalida_CheckedChanged(object sender, EventArgs e)
        {
            tipo_movimiento = "Salida";
            dgvInformacion.Columns[7].ReadOnly = true;
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            ActualizarDataSetSac();
        }
        public void ActualizarDataSetSac()
        {
            DataSetSacEntrada = sac.RecuperarDataSetEntrada();
            DataSetSacSalida = sac.RecuperarDataSetSalida();
            series_escaneadas_salida = sac.ExtraerSeries(DataSetSacSalida);
            series_escaneadas_entrada = sac.ExtraerSeries(DataSetSacEntrada);
        }

        private void dgvInformacion_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            int col = dgvInformacion.CurrentCell.ColumnIndex;
            int row = dgvInformacion.CurrentCell.RowIndex;
            if (col == 1)
            {
                if (dgvInformacion.Rows[row].Cells[1].Value != null)
                {
                    List<String> seriesEnDGV = new List<String>();
                    String serie = dgvInformacion.Rows[row].Cells[1].Value.ToString();
                    seriesEnDGV = llenarSeriesEnDGV();
                    int count = seriesEnDGV.Count(f => f == serie);
                    if (count > 1)
                    {
                        MessageBox.Show("La serie: " + serie + " esta repetida", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                        dgvInformacion.Rows[row].Cells[1].Value = "";
                    }
                    else
                    {
                        AgregarSeries(serie, row);
                    }
                }
            }
            if(col == 6)
            {
                if (dgvInformacion.Rows[row].Cells[6].Value != null)
                {
                    List<String> emosEnDGV = new List<String>();
                    String emo = dgvInformacion.Rows[row].Cells[6].Value.ToString();
                    emosEnDGV = llenarEmoEnDGV(row);
                    int count = emosEnDGV.Count(f => f == emo);
                    if (count > 1)
                    {
                        MessageBox.Show("El emo: " + emo + " esta repetido", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                        dgvInformacion.Rows[row].Cells[6].Value = "";
                    }
                }
            }
            SendKeys.Send("{TAB}");
        }
        public List<String> llenarSeriesEnDGV()
        {
            List<String> lst = new List<String>();
            int totalRows = dgvInformacion.Rows.Count;
            totalRows -= 1;
            for (int i = 0; i < totalRows; i++)
            {
                lst.Add(dgvInformacion.Rows[i].Cells[1].Value.ToString());
            }
            return lst;
        }
        public List<String> llenarEmoEnDGV(int row)
        {
            List<String> lst = new List<String>();
            for (int i = 0; i < row + 1; i++)
            {
                lst.Add(dgvInformacion.Rows[i].Cells[6].Value.ToString());
            }
            return lst;
        }

        private void btnEmos_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtBol.Text))
                {
                    throw new Exception("No hay ningun bol seleccionado");
                }
                else
                {
                    int id = int.Parse(txtBol.Text);
                    Detalle_bol det = new Detalle_bol();
                    det.ActualizarIDBol(id);
                    EmoVisor vista = new EmoVisor();
                    vista.Show();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }

        private void btnImprimir_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtBol.Text))
                {
                    throw new Exception("No hay ningun bol seleccionado");
                }
                else
                {
                    int id = int.Parse(txtBol.Text);
                    VisorBol reporte = new VisorBol(id);
                    reporte.Show();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }

        private void btnComoDatos_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtBol.Text))
                {
                    throw new Exception("No hay ningun bol seleccionado");
                }
                else
                {
                    int id = int.Parse(txtBol.Text);
                    Detalle_bol det = new Detalle_bol();
                    det.ActualizarIDBol(id);
                    VisorComodatos vista = new VisorComodatos();
                    vista.Show();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Excepcion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }
    }
}
