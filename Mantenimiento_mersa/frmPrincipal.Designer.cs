
namespace Mantenimiento_mersa
{
    partial class frmPrincipal
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.tlpPrincipal = new System.Windows.Forms.TableLayoutPanel();
            this.tlpOpciones = new System.Windows.Forms.TableLayoutPanel();
            this.tlpRegistros = new System.Windows.Forms.TableLayoutPanel();
            this.btnPrimero = new System.Windows.Forms.Button();
            this.btnAnterior = new System.Windows.Forms.Button();
            this.btnSiguiente = new System.Windows.Forms.Button();
            this.btnUltimo = new System.Windows.Forms.Button();
            this.tlpAcciones = new System.Windows.Forms.TableLayoutPanel();
            this.btnNuevo = new System.Windows.Forms.Button();
            this.btnModificar = new System.Windows.Forms.Button();
            this.btnEliminar = new System.Windows.Forms.Button();
            this.btnBuscar = new System.Windows.Forms.Button();
            this.btnImprimir = new System.Windows.Forms.Button();
            this.btnGuardar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.btnReporte = new System.Windows.Forms.Button();
            this.btnSalir = new System.Windows.Forms.Button();
            this.tlpInformacion = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.panelBol = new System.Windows.Forms.TableLayoutPanel();
            this.dtpFecha = new System.Windows.Forms.DateTimePicker();
            this.txtBol = new System.Windows.Forms.TextBox();
            this.btnComoDatos = new System.Windows.Forms.Button();
            this.btnEmos = new System.Windows.Forms.Button();
            this.lblFecha = new System.Windows.Forms.Label();
            this.lblBol = new System.Windows.Forms.Label();
            this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel4 = new System.Windows.Forms.TableLayoutPanel();
            this.cboTransportista = new System.Windows.Forms.ComboBox();
            this.lblTransportista = new System.Windows.Forms.Label();
            this.tableLayoutPanel5 = new System.Windows.Forms.TableLayoutPanel();
            this.txtChofer = new System.Windows.Forms.TextBox();
            this.lblChofer = new System.Windows.Forms.Label();
            this.tableLayoutPanel6 = new System.Windows.Forms.TableLayoutPanel();
            this.lblPlacas = new System.Windows.Forms.Label();
            this.cboPlaca = new System.Windows.Forms.ComboBox();
            this.tableLayoutPanel7 = new System.Windows.Forms.TableLayoutPanel();
            this.btnActualizar = new System.Windows.Forms.Button();
            this.tableLayoutPanel8 = new System.Windows.Forms.TableLayoutPanel();
            this.lblZona = new System.Windows.Forms.Label();
            this.lblEspecial = new System.Windows.Forms.Label();
            this.cboZona = new System.Windows.Forms.ComboBox();
            this.cboEspecial = new System.Windows.Forms.ComboBox();
            this.rdbEntrada = new System.Windows.Forms.RadioButton();
            this.rdbSalida = new System.Windows.Forms.RadioButton();
            this.dgvInformacion = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Serie = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Modelo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Activo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Ficha = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Linea = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.emo_pepsi = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.emo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Eliminar = new System.Windows.Forms.DataGridViewButtonColumn();
            this.mersaDataSet = new Mantenimiento_mersa.mersaDataSet();
            this.tlpPrincipal.SuspendLayout();
            this.tlpOpciones.SuspendLayout();
            this.tlpRegistros.SuspendLayout();
            this.tlpAcciones.SuspendLayout();
            this.tlpInformacion.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            this.panelBol.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            this.tableLayoutPanel4.SuspendLayout();
            this.tableLayoutPanel5.SuspendLayout();
            this.tableLayoutPanel6.SuspendLayout();
            this.tableLayoutPanel7.SuspendLayout();
            this.tableLayoutPanel8.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvInformacion)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.mersaDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // tlpPrincipal
            // 
            this.tlpPrincipal.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(57)))), ((int)(((byte)(120)))));
            this.tlpPrincipal.ColumnCount = 2;
            this.tlpPrincipal.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 15.27348F));
            this.tlpPrincipal.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 84.72652F));
            this.tlpPrincipal.Controls.Add(this.tlpOpciones, 0, 0);
            this.tlpPrincipal.Controls.Add(this.tlpInformacion, 1, 0);
            this.tlpPrincipal.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tlpPrincipal.Location = new System.Drawing.Point(0, 0);
            this.tlpPrincipal.Name = "tlpPrincipal";
            this.tlpPrincipal.RowCount = 1;
            this.tlpPrincipal.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpPrincipal.Size = new System.Drawing.Size(982, 653);
            this.tlpPrincipal.TabIndex = 0;
            // 
            // tlpOpciones
            // 
            this.tlpOpciones.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(100)))), ((int)(((byte)(182)))));
            this.tlpOpciones.ColumnCount = 1;
            this.tlpOpciones.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpOpciones.Controls.Add(this.tlpRegistros, 0, 1);
            this.tlpOpciones.Controls.Add(this.tlpAcciones, 0, 0);
            this.tlpOpciones.Controls.Add(this.btnSalir, 0, 2);
            this.tlpOpciones.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tlpOpciones.Location = new System.Drawing.Point(3, 3);
            this.tlpOpciones.Name = "tlpOpciones";
            this.tlpOpciones.RowCount = 3;
            this.tlpOpciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 67.01031F));
            this.tlpOpciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 24.74227F));
            this.tlpOpciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 8.247422F));
            this.tlpOpciones.Size = new System.Drawing.Size(143, 647);
            this.tlpOpciones.TabIndex = 0;
            // 
            // tlpRegistros
            // 
            this.tlpRegistros.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(100)))), ((int)(((byte)(182)))));
            this.tlpRegistros.ColumnCount = 1;
            this.tlpRegistros.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpRegistros.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 23F));
            this.tlpRegistros.Controls.Add(this.btnPrimero, 0, 0);
            this.tlpRegistros.Controls.Add(this.btnAnterior, 0, 1);
            this.tlpRegistros.Controls.Add(this.btnSiguiente, 0, 2);
            this.tlpRegistros.Controls.Add(this.btnUltimo, 0, 3);
            this.tlpRegistros.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tlpRegistros.Location = new System.Drawing.Point(3, 436);
            this.tlpRegistros.Name = "tlpRegistros";
            this.tlpRegistros.RowCount = 4;
            this.tlpRegistros.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tlpRegistros.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tlpRegistros.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tlpRegistros.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tlpRegistros.Size = new System.Drawing.Size(137, 154);
            this.tlpRegistros.TabIndex = 5;
            // 
            // btnPrimero
            // 
            this.btnPrimero.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnPrimero.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnPrimero.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPrimero.ForeColor = System.Drawing.Color.LightGray;
            this.btnPrimero.Image = global::Mantenimiento_mersa.Properties.Resources.First;
            this.btnPrimero.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnPrimero.Location = new System.Drawing.Point(2, 2);
            this.btnPrimero.Margin = new System.Windows.Forms.Padding(2);
            this.btnPrimero.Name = "btnPrimero";
            this.btnPrimero.Size = new System.Drawing.Size(133, 34);
            this.btnPrimero.TabIndex = 0;
            this.btnPrimero.Text = "Primero";
            this.btnPrimero.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnPrimero.UseVisualStyleBackColor = false;
            this.btnPrimero.Click += new System.EventHandler(this.btnPrimero_Click);
            // 
            // btnAnterior
            // 
            this.btnAnterior.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnAnterior.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnAnterior.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAnterior.ForeColor = System.Drawing.Color.LightGray;
            this.btnAnterior.Image = global::Mantenimiento_mersa.Properties.Resources.Back;
            this.btnAnterior.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnAnterior.Location = new System.Drawing.Point(2, 40);
            this.btnAnterior.Margin = new System.Windows.Forms.Padding(2);
            this.btnAnterior.Name = "btnAnterior";
            this.btnAnterior.Size = new System.Drawing.Size(133, 34);
            this.btnAnterior.TabIndex = 1;
            this.btnAnterior.Text = "Anterior";
            this.btnAnterior.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnAnterior.UseVisualStyleBackColor = false;
            this.btnAnterior.Click += new System.EventHandler(this.btnAnterior_Click);
            // 
            // btnSiguiente
            // 
            this.btnSiguiente.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnSiguiente.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnSiguiente.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSiguiente.ForeColor = System.Drawing.Color.LightGray;
            this.btnSiguiente.Image = global::Mantenimiento_mersa.Properties.Resources.Next;
            this.btnSiguiente.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnSiguiente.Location = new System.Drawing.Point(2, 78);
            this.btnSiguiente.Margin = new System.Windows.Forms.Padding(2);
            this.btnSiguiente.Name = "btnSiguiente";
            this.btnSiguiente.Size = new System.Drawing.Size(133, 34);
            this.btnSiguiente.TabIndex = 2;
            this.btnSiguiente.Text = "Siguiente";
            this.btnSiguiente.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnSiguiente.UseVisualStyleBackColor = false;
            this.btnSiguiente.Click += new System.EventHandler(this.btnSiguiente_Click);
            // 
            // btnUltimo
            // 
            this.btnUltimo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnUltimo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnUltimo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnUltimo.ForeColor = System.Drawing.Color.LightGray;
            this.btnUltimo.Image = global::Mantenimiento_mersa.Properties.Resources.Last;
            this.btnUltimo.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnUltimo.Location = new System.Drawing.Point(2, 116);
            this.btnUltimo.Margin = new System.Windows.Forms.Padding(2);
            this.btnUltimo.Name = "btnUltimo";
            this.btnUltimo.Size = new System.Drawing.Size(133, 36);
            this.btnUltimo.TabIndex = 3;
            this.btnUltimo.Text = "Ultimo";
            this.btnUltimo.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnUltimo.UseVisualStyleBackColor = false;
            this.btnUltimo.Click += new System.EventHandler(this.btnUltimo_Click);
            // 
            // tlpAcciones
            // 
            this.tlpAcciones.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(100)))), ((int)(((byte)(182)))));
            this.tlpAcciones.ColumnCount = 1;
            this.tlpAcciones.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpAcciones.Controls.Add(this.btnNuevo, 0, 0);
            this.tlpAcciones.Controls.Add(this.btnModificar, 0, 1);
            this.tlpAcciones.Controls.Add(this.btnEliminar, 0, 2);
            this.tlpAcciones.Controls.Add(this.btnBuscar, 0, 3);
            this.tlpAcciones.Controls.Add(this.btnImprimir, 0, 4);
            this.tlpAcciones.Controls.Add(this.btnGuardar, 0, 5);
            this.tlpAcciones.Controls.Add(this.btnCancelar, 0, 6);
            this.tlpAcciones.Controls.Add(this.btnReporte, 0, 7);
            this.tlpAcciones.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tlpAcciones.Location = new System.Drawing.Point(3, 3);
            this.tlpAcciones.Name = "tlpAcciones";
            this.tlpAcciones.RowCount = 8;
            this.tlpAcciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 17.58749F));
            this.tlpAcciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 11.77322F));
            this.tlpAcciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 11.77322F));
            this.tlpAcciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 11.77322F));
            this.tlpAcciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 11.77322F));
            this.tlpAcciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 11.77322F));
            this.tlpAcciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 11.77322F));
            this.tlpAcciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 11.77322F));
            this.tlpAcciones.Size = new System.Drawing.Size(137, 427);
            this.tlpAcciones.TabIndex = 4;
            // 
            // btnNuevo
            // 
            this.btnNuevo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnNuevo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnNuevo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNuevo.ForeColor = System.Drawing.Color.LightGray;
            this.btnNuevo.Image = global::Mantenimiento_mersa.Properties.Resources.new__1_;
            this.btnNuevo.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnNuevo.Location = new System.Drawing.Point(5, 5);
            this.btnNuevo.Margin = new System.Windows.Forms.Padding(5);
            this.btnNuevo.Name = "btnNuevo";
            this.btnNuevo.Size = new System.Drawing.Size(127, 65);
            this.btnNuevo.TabIndex = 0;
            this.btnNuevo.Text = "Nuevo";
            this.btnNuevo.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnNuevo.UseVisualStyleBackColor = false;
            this.btnNuevo.Click += new System.EventHandler(this.btnNuevo_Click);
            // 
            // btnModificar
            // 
            this.btnModificar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnModificar.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnModificar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnModificar.ForeColor = System.Drawing.Color.LightGray;
            this.btnModificar.Image = global::Mantenimiento_mersa.Properties.Resources.update__1_;
            this.btnModificar.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnModificar.Location = new System.Drawing.Point(2, 77);
            this.btnModificar.Margin = new System.Windows.Forms.Padding(2);
            this.btnModificar.Name = "btnModificar";
            this.btnModificar.Size = new System.Drawing.Size(133, 46);
            this.btnModificar.TabIndex = 1;
            this.btnModificar.Text = "Modificar";
            this.btnModificar.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnModificar.UseVisualStyleBackColor = false;
            this.btnModificar.Click += new System.EventHandler(this.btnModificar_Click);
            // 
            // btnEliminar
            // 
            this.btnEliminar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnEliminar.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnEliminar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEliminar.ForeColor = System.Drawing.Color.LightGray;
            this.btnEliminar.Image = global::Mantenimiento_mersa.Properties.Resources.trash;
            this.btnEliminar.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnEliminar.Location = new System.Drawing.Point(2, 127);
            this.btnEliminar.Margin = new System.Windows.Forms.Padding(2);
            this.btnEliminar.Name = "btnEliminar";
            this.btnEliminar.Size = new System.Drawing.Size(133, 46);
            this.btnEliminar.TabIndex = 2;
            this.btnEliminar.Text = "Eliminar";
            this.btnEliminar.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnEliminar.UseVisualStyleBackColor = false;
            this.btnEliminar.Click += new System.EventHandler(this.btnEliminar_Click);
            // 
            // btnBuscar
            // 
            this.btnBuscar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnBuscar.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnBuscar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnBuscar.ForeColor = System.Drawing.Color.LightGray;
            this.btnBuscar.Image = global::Mantenimiento_mersa.Properties.Resources.loupe;
            this.btnBuscar.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnBuscar.Location = new System.Drawing.Point(2, 177);
            this.btnBuscar.Margin = new System.Windows.Forms.Padding(2);
            this.btnBuscar.Name = "btnBuscar";
            this.btnBuscar.Size = new System.Drawing.Size(133, 46);
            this.btnBuscar.TabIndex = 3;
            this.btnBuscar.Text = "Buscar";
            this.btnBuscar.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnBuscar.UseVisualStyleBackColor = false;
            this.btnBuscar.Click += new System.EventHandler(this.btnBuscar_Click);
            // 
            // btnImprimir
            // 
            this.btnImprimir.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnImprimir.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnImprimir.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnImprimir.ForeColor = System.Drawing.Color.LightGray;
            this.btnImprimir.Image = global::Mantenimiento_mersa.Properties.Resources.printer;
            this.btnImprimir.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnImprimir.Location = new System.Drawing.Point(2, 227);
            this.btnImprimir.Margin = new System.Windows.Forms.Padding(2);
            this.btnImprimir.Name = "btnImprimir";
            this.btnImprimir.Size = new System.Drawing.Size(133, 46);
            this.btnImprimir.TabIndex = 4;
            this.btnImprimir.Text = "Imprimir";
            this.btnImprimir.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnImprimir.UseVisualStyleBackColor = false;
            this.btnImprimir.Click += new System.EventHandler(this.btnImprimir_Click);
            // 
            // btnGuardar
            // 
            this.btnGuardar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnGuardar.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnGuardar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnGuardar.ForeColor = System.Drawing.Color.LightGray;
            this.btnGuardar.Image = global::Mantenimiento_mersa.Properties.Resources.floppy_disk;
            this.btnGuardar.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnGuardar.Location = new System.Drawing.Point(2, 277);
            this.btnGuardar.Margin = new System.Windows.Forms.Padding(2);
            this.btnGuardar.Name = "btnGuardar";
            this.btnGuardar.Size = new System.Drawing.Size(133, 46);
            this.btnGuardar.TabIndex = 5;
            this.btnGuardar.Text = "Guardar";
            this.btnGuardar.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnGuardar.UseVisualStyleBackColor = false;
            this.btnGuardar.Click += new System.EventHandler(this.btnGuardar_Click);
            // 
            // btnCancelar
            // 
            this.btnCancelar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnCancelar.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnCancelar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCancelar.ForeColor = System.Drawing.Color.LightGray;
            this.btnCancelar.Image = global::Mantenimiento_mersa.Properties.Resources.cancel;
            this.btnCancelar.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnCancelar.Location = new System.Drawing.Point(2, 327);
            this.btnCancelar.Margin = new System.Windows.Forms.Padding(2);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(133, 46);
            this.btnCancelar.TabIndex = 6;
            this.btnCancelar.Text = "Cancelar";
            this.btnCancelar.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnCancelar.UseVisualStyleBackColor = false;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            // 
            // btnReporte
            // 
            this.btnReporte.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnReporte.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnReporte.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnReporte.ForeColor = System.Drawing.Color.LightGray;
            this.btnReporte.Image = global::Mantenimiento_mersa.Properties.Resources.analytics;
            this.btnReporte.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnReporte.Location = new System.Drawing.Point(2, 377);
            this.btnReporte.Margin = new System.Windows.Forms.Padding(2);
            this.btnReporte.Name = "btnReporte";
            this.btnReporte.Size = new System.Drawing.Size(133, 48);
            this.btnReporte.TabIndex = 7;
            this.btnReporte.Text = "Reporte";
            this.btnReporte.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnReporte.UseVisualStyleBackColor = false;
            this.btnReporte.Click += new System.EventHandler(this.btnReporte_Click);
            // 
            // btnSalir
            // 
            this.btnSalir.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnSalir.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnSalir.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSalir.ForeColor = System.Drawing.Color.LightGray;
            this.btnSalir.Image = global::Mantenimiento_mersa.Properties.Resources.logout;
            this.btnSalir.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnSalir.Location = new System.Drawing.Point(2, 595);
            this.btnSalir.Margin = new System.Windows.Forms.Padding(2);
            this.btnSalir.Name = "btnSalir";
            this.btnSalir.Size = new System.Drawing.Size(139, 50);
            this.btnSalir.TabIndex = 6;
            this.btnSalir.Text = "Salir";
            this.btnSalir.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnSalir.UseVisualStyleBackColor = false;
            this.btnSalir.Click += new System.EventHandler(this.btnSalir_Click);
            // 
            // tlpInformacion
            // 
            this.tlpInformacion.ColumnCount = 1;
            this.tlpInformacion.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpInformacion.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 23F));
            this.tlpInformacion.Controls.Add(this.tableLayoutPanel1, 0, 0);
            this.tlpInformacion.Controls.Add(this.dgvInformacion, 0, 1);
            this.tlpInformacion.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tlpInformacion.Location = new System.Drawing.Point(152, 3);
            this.tlpInformacion.Name = "tlpInformacion";
            this.tlpInformacion.RowCount = 2;
            this.tlpInformacion.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 34.03846F));
            this.tlpInformacion.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 65.96154F));
            this.tlpInformacion.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tlpInformacion.Size = new System.Drawing.Size(827, 647);
            this.tlpInformacion.TabIndex = 1;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(57)))), ((int)(((byte)(120)))));
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.panelBol, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.tableLayoutPanel3, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.tableLayoutPanel8, 0, 2);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(2, 2);
            this.tableLayoutPanel1.Margin = new System.Windows.Forms.Padding(2);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 3;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(823, 216);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // panelBol
            // 
            this.panelBol.ColumnCount = 7;
            this.panelBol.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 14F));
            this.panelBol.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 14F));
            this.panelBol.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 14F));
            this.panelBol.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 15F));
            this.panelBol.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 14F));
            this.panelBol.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 15F));
            this.panelBol.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 14F));
            this.panelBol.Controls.Add(this.dtpFecha, 1, 0);
            this.panelBol.Controls.Add(this.txtBol, 3, 0);
            this.panelBol.Controls.Add(this.btnComoDatos, 5, 0);
            this.panelBol.Controls.Add(this.btnEmos, 6, 0);
            this.panelBol.Controls.Add(this.lblFecha, 0, 0);
            this.panelBol.Controls.Add(this.lblBol, 2, 0);
            this.panelBol.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelBol.Location = new System.Drawing.Point(2, 2);
            this.panelBol.Margin = new System.Windows.Forms.Padding(2);
            this.panelBol.Name = "panelBol";
            this.panelBol.RowCount = 1;
            this.panelBol.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.panelBol.Size = new System.Drawing.Size(819, 50);
            this.panelBol.TabIndex = 0;
            // 
            // dtpFecha
            // 
            this.dtpFecha.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpFecha.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpFecha.Location = new System.Drawing.Point(116, 15);
            this.dtpFecha.Margin = new System.Windows.Forms.Padding(2);
            this.dtpFecha.Name = "dtpFecha";
            this.dtpFecha.Size = new System.Drawing.Size(110, 20);
            this.dtpFecha.TabIndex = 0;
            // 
            // txtBol
            // 
            this.txtBol.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.txtBol.Enabled = false;
            this.txtBol.Location = new System.Drawing.Point(344, 15);
            this.txtBol.Margin = new System.Windows.Forms.Padding(2);
            this.txtBol.Name = "txtBol";
            this.txtBol.Size = new System.Drawing.Size(118, 20);
            this.txtBol.TabIndex = 1;
            // 
            // btnComoDatos
            // 
            this.btnComoDatos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnComoDatos.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnComoDatos.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnComoDatos.ForeColor = System.Drawing.Color.LightGray;
            this.btnComoDatos.Location = new System.Drawing.Point(580, 2);
            this.btnComoDatos.Margin = new System.Windows.Forms.Padding(2);
            this.btnComoDatos.Name = "btnComoDatos";
            this.btnComoDatos.Size = new System.Drawing.Size(118, 46);
            this.btnComoDatos.TabIndex = 0;
            this.btnComoDatos.Text = "COMODATOS";
            this.btnComoDatos.UseVisualStyleBackColor = false;
            this.btnComoDatos.Click += new System.EventHandler(this.btnComoDatos_Click);
            // 
            // btnEmos
            // 
            this.btnEmos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnEmos.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnEmos.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEmos.ForeColor = System.Drawing.Color.LightGray;
            this.btnEmos.Location = new System.Drawing.Point(702, 2);
            this.btnEmos.Margin = new System.Windows.Forms.Padding(2);
            this.btnEmos.Name = "btnEmos";
            this.btnEmos.Size = new System.Drawing.Size(115, 46);
            this.btnEmos.TabIndex = 3;
            this.btnEmos.Text = "EMOS";
            this.btnEmos.UseVisualStyleBackColor = false;
            this.btnEmos.Click += new System.EventHandler(this.btnEmos_Click);
            // 
            // lblFecha
            // 
            this.lblFecha.AutoSize = true;
            this.lblFecha.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblFecha.ForeColor = System.Drawing.Color.LightGray;
            this.lblFecha.Location = new System.Drawing.Point(2, 0);
            this.lblFecha.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblFecha.Name = "lblFecha";
            this.lblFecha.Size = new System.Drawing.Size(110, 50);
            this.lblFecha.TabIndex = 4;
            this.lblFecha.Text = "Fecha";
            this.lblFecha.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblBol
            // 
            this.lblBol.AutoSize = true;
            this.lblBol.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblBol.ForeColor = System.Drawing.Color.LightGray;
            this.lblBol.Location = new System.Drawing.Point(230, 0);
            this.lblBol.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblBol.Name = "lblBol";
            this.lblBol.Size = new System.Drawing.Size(110, 50);
            this.lblBol.TabIndex = 5;
            this.lblBol.Text = "N° BOL";
            this.lblBol.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // tableLayoutPanel3
            // 
            this.tableLayoutPanel3.ColumnCount = 2;
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel3.Controls.Add(this.tableLayoutPanel4, 0, 0);
            this.tableLayoutPanel3.Controls.Add(this.tableLayoutPanel5, 0, 1);
            this.tableLayoutPanel3.Controls.Add(this.tableLayoutPanel6, 1, 0);
            this.tableLayoutPanel3.Controls.Add(this.tableLayoutPanel7, 1, 1);
            this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel3.Location = new System.Drawing.Point(2, 56);
            this.tableLayoutPanel3.Margin = new System.Windows.Forms.Padding(2);
            this.tableLayoutPanel3.Name = "tableLayoutPanel3";
            this.tableLayoutPanel3.RowCount = 2;
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel3.Size = new System.Drawing.Size(819, 104);
            this.tableLayoutPanel3.TabIndex = 1;
            // 
            // tableLayoutPanel4
            // 
            this.tableLayoutPanel4.ColumnCount = 2;
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 27.3399F));
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 72.6601F));
            this.tableLayoutPanel4.Controls.Add(this.cboTransportista, 1, 0);
            this.tableLayoutPanel4.Controls.Add(this.lblTransportista, 0, 0);
            this.tableLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel4.Location = new System.Drawing.Point(2, 2);
            this.tableLayoutPanel4.Margin = new System.Windows.Forms.Padding(2);
            this.tableLayoutPanel4.Name = "tableLayoutPanel4";
            this.tableLayoutPanel4.RowCount = 1;
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel4.Size = new System.Drawing.Size(405, 48);
            this.tableLayoutPanel4.TabIndex = 0;
            // 
            // cboTransportista
            // 
            this.cboTransportista.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.cboTransportista.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboTransportista.Enabled = false;
            this.cboTransportista.FormattingEnabled = true;
            this.cboTransportista.Location = new System.Drawing.Point(112, 13);
            this.cboTransportista.Margin = new System.Windows.Forms.Padding(2);
            this.cboTransportista.Name = "cboTransportista";
            this.cboTransportista.Size = new System.Drawing.Size(291, 21);
            this.cboTransportista.TabIndex = 0;
            this.cboTransportista.SelectedIndexChanged += new System.EventHandler(this.cboTransportista_SelectedIndexChanged);
            // 
            // lblTransportista
            // 
            this.lblTransportista.AutoSize = true;
            this.lblTransportista.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblTransportista.ForeColor = System.Drawing.Color.LightGray;
            this.lblTransportista.Location = new System.Drawing.Point(2, 0);
            this.lblTransportista.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblTransportista.Name = "lblTransportista";
            this.lblTransportista.Size = new System.Drawing.Size(106, 48);
            this.lblTransportista.TabIndex = 1;
            this.lblTransportista.Text = "Transportista";
            this.lblTransportista.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // tableLayoutPanel5
            // 
            this.tableLayoutPanel5.ColumnCount = 2;
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 26.84729F));
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 73.15271F));
            this.tableLayoutPanel5.Controls.Add(this.txtChofer, 1, 0);
            this.tableLayoutPanel5.Controls.Add(this.lblChofer, 0, 0);
            this.tableLayoutPanel5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel5.Location = new System.Drawing.Point(2, 54);
            this.tableLayoutPanel5.Margin = new System.Windows.Forms.Padding(2);
            this.tableLayoutPanel5.Name = "tableLayoutPanel5";
            this.tableLayoutPanel5.RowCount = 1;
            this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel5.Size = new System.Drawing.Size(405, 48);
            this.tableLayoutPanel5.TabIndex = 1;
            // 
            // txtChofer
            // 
            this.txtChofer.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.txtChofer.Location = new System.Drawing.Point(110, 14);
            this.txtChofer.Margin = new System.Windows.Forms.Padding(2);
            this.txtChofer.Name = "txtChofer";
            this.txtChofer.Size = new System.Drawing.Size(293, 20);
            this.txtChofer.TabIndex = 0;
            // 
            // lblChofer
            // 
            this.lblChofer.AutoSize = true;
            this.lblChofer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblChofer.ForeColor = System.Drawing.Color.LightGray;
            this.lblChofer.Location = new System.Drawing.Point(2, 0);
            this.lblChofer.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblChofer.Name = "lblChofer";
            this.lblChofer.Size = new System.Drawing.Size(104, 48);
            this.lblChofer.TabIndex = 1;
            this.lblChofer.Text = "Chofer";
            this.lblChofer.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // tableLayoutPanel6
            // 
            this.tableLayoutPanel6.ColumnCount = 2;
            this.tableLayoutPanel6.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 30F));
            this.tableLayoutPanel6.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 70F));
            this.tableLayoutPanel6.Controls.Add(this.lblPlacas, 0, 0);
            this.tableLayoutPanel6.Controls.Add(this.cboPlaca, 1, 0);
            this.tableLayoutPanel6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel6.Location = new System.Drawing.Point(411, 2);
            this.tableLayoutPanel6.Margin = new System.Windows.Forms.Padding(2);
            this.tableLayoutPanel6.Name = "tableLayoutPanel6";
            this.tableLayoutPanel6.RowCount = 1;
            this.tableLayoutPanel6.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel6.Size = new System.Drawing.Size(406, 48);
            this.tableLayoutPanel6.TabIndex = 2;
            // 
            // lblPlacas
            // 
            this.lblPlacas.AutoSize = true;
            this.lblPlacas.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblPlacas.ForeColor = System.Drawing.Color.LightGray;
            this.lblPlacas.Location = new System.Drawing.Point(2, 0);
            this.lblPlacas.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblPlacas.Name = "lblPlacas";
            this.lblPlacas.Size = new System.Drawing.Size(117, 48);
            this.lblPlacas.TabIndex = 1;
            this.lblPlacas.Text = "Placas";
            this.lblPlacas.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // cboPlaca
            // 
            this.cboPlaca.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.cboPlaca.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboPlaca.FormattingEnabled = true;
            this.cboPlaca.Location = new System.Drawing.Point(124, 13);
            this.cboPlaca.Name = "cboPlaca";
            this.cboPlaca.Size = new System.Drawing.Size(279, 21);
            this.cboPlaca.TabIndex = 2;
            this.cboPlaca.SelectedIndexChanged += new System.EventHandler(this.cboPlaca_SelectedIndexChanged);
            // 
            // tableLayoutPanel7
            // 
            this.tableLayoutPanel7.ColumnCount = 2;
            this.tableLayoutPanel7.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel7.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel7.Controls.Add(this.btnActualizar, 1, 0);
            this.tableLayoutPanel7.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel7.Location = new System.Drawing.Point(411, 54);
            this.tableLayoutPanel7.Margin = new System.Windows.Forms.Padding(2);
            this.tableLayoutPanel7.Name = "tableLayoutPanel7";
            this.tableLayoutPanel7.RowCount = 1;
            this.tableLayoutPanel7.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel7.Size = new System.Drawing.Size(406, 48);
            this.tableLayoutPanel7.TabIndex = 3;
            // 
            // btnActualizar
            // 
            this.btnActualizar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(39)))), ((int)(((byte)(37)))), ((int)(((byte)(100)))));
            this.btnActualizar.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnActualizar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnActualizar.ForeColor = System.Drawing.Color.LightGray;
            this.btnActualizar.Location = new System.Drawing.Point(205, 2);
            this.btnActualizar.Margin = new System.Windows.Forms.Padding(2);
            this.btnActualizar.Name = "btnActualizar";
            this.btnActualizar.Size = new System.Drawing.Size(199, 44);
            this.btnActualizar.TabIndex = 1;
            this.btnActualizar.Text = "Actualizar";
            this.btnActualizar.UseVisualStyleBackColor = false;
            this.btnActualizar.Click += new System.EventHandler(this.btnActualizar_Click);
            // 
            // tableLayoutPanel8
            // 
            this.tableLayoutPanel8.ColumnCount = 6;
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 13.41463F));
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 21.34146F));
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 18F));
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 12F));
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 17F));
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 18F));
            this.tableLayoutPanel8.Controls.Add(this.lblZona, 0, 0);
            this.tableLayoutPanel8.Controls.Add(this.lblEspecial, 2, 0);
            this.tableLayoutPanel8.Controls.Add(this.cboZona, 1, 0);
            this.tableLayoutPanel8.Controls.Add(this.cboEspecial, 3, 0);
            this.tableLayoutPanel8.Controls.Add(this.rdbEntrada, 4, 0);
            this.tableLayoutPanel8.Controls.Add(this.rdbSalida, 5, 0);
            this.tableLayoutPanel8.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel8.Location = new System.Drawing.Point(2, 164);
            this.tableLayoutPanel8.Margin = new System.Windows.Forms.Padding(2);
            this.tableLayoutPanel8.Name = "tableLayoutPanel8";
            this.tableLayoutPanel8.RowCount = 1;
            this.tableLayoutPanel8.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel8.Size = new System.Drawing.Size(819, 50);
            this.tableLayoutPanel8.TabIndex = 2;
            // 
            // lblZona
            // 
            this.lblZona.AutoSize = true;
            this.lblZona.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblZona.ForeColor = System.Drawing.Color.LightGray;
            this.lblZona.Location = new System.Drawing.Point(2, 0);
            this.lblZona.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblZona.Name = "lblZona";
            this.lblZona.Size = new System.Drawing.Size(106, 50);
            this.lblZona.TabIndex = 0;
            this.lblZona.Text = "Zona";
            this.lblZona.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblEspecial
            // 
            this.lblEspecial.AutoSize = true;
            this.lblEspecial.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblEspecial.ForeColor = System.Drawing.Color.LightGray;
            this.lblEspecial.Location = new System.Drawing.Point(287, 0);
            this.lblEspecial.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.lblEspecial.Name = "lblEspecial";
            this.lblEspecial.Size = new System.Drawing.Size(143, 50);
            this.lblEspecial.TabIndex = 1;
            this.lblEspecial.Text = "Especial";
            this.lblEspecial.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // cboZona
            // 
            this.cboZona.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.cboZona.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboZona.FormattingEnabled = true;
            this.cboZona.Items.AddRange(new object[] {
            "Central",
            "Oriente",
            "Occidente",
            "Desecho",
            "Traslados",
            "Chalatenango",
            "Postmix"});
            this.cboZona.Location = new System.Drawing.Point(112, 14);
            this.cboZona.Margin = new System.Windows.Forms.Padding(2);
            this.cboZona.Name = "cboZona";
            this.cboZona.Size = new System.Drawing.Size(171, 21);
            this.cboZona.TabIndex = 2;
            // 
            // cboEspecial
            // 
            this.cboEspecial.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.cboEspecial.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboEspecial.FormattingEnabled = true;
            this.cboEspecial.Items.AddRange(new object[] {
            "Si",
            "No"});
            this.cboEspecial.Location = new System.Drawing.Point(434, 14);
            this.cboEspecial.Margin = new System.Windows.Forms.Padding(2);
            this.cboEspecial.Name = "cboEspecial";
            this.cboEspecial.Size = new System.Drawing.Size(94, 21);
            this.cboEspecial.TabIndex = 3;
            // 
            // rdbEntrada
            // 
            this.rdbEntrada.AutoSize = true;
            this.rdbEntrada.Checked = true;
            this.rdbEntrada.Dock = System.Windows.Forms.DockStyle.Fill;
            this.rdbEntrada.ForeColor = System.Drawing.Color.LightGray;
            this.rdbEntrada.Location = new System.Drawing.Point(532, 2);
            this.rdbEntrada.Margin = new System.Windows.Forms.Padding(2);
            this.rdbEntrada.Name = "rdbEntrada";
            this.rdbEntrada.Size = new System.Drawing.Size(135, 46);
            this.rdbEntrada.TabIndex = 4;
            this.rdbEntrada.TabStop = true;
            this.rdbEntrada.Text = "Recepcion";
            this.rdbEntrada.UseVisualStyleBackColor = true;
            this.rdbEntrada.CheckedChanged += new System.EventHandler(this.rdbEntrada_CheckedChanged);
            // 
            // rdbSalida
            // 
            this.rdbSalida.AutoSize = true;
            this.rdbSalida.Dock = System.Windows.Forms.DockStyle.Fill;
            this.rdbSalida.ForeColor = System.Drawing.Color.LightGray;
            this.rdbSalida.Location = new System.Drawing.Point(671, 2);
            this.rdbSalida.Margin = new System.Windows.Forms.Padding(2);
            this.rdbSalida.Name = "rdbSalida";
            this.rdbSalida.Size = new System.Drawing.Size(146, 46);
            this.rdbSalida.TabIndex = 5;
            this.rdbSalida.Text = "Envio";
            this.rdbSalida.UseVisualStyleBackColor = true;
            this.rdbSalida.CheckedChanged += new System.EventHandler(this.rdbSalida_CheckedChanged);
            // 
            // dgvInformacion
            // 
            this.dgvInformacion.AllowUserToDeleteRows = false;
            this.dgvInformacion.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvInformacion.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(100)))), ((int)(((byte)(182)))));
            this.dgvInformacion.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvInformacion.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Serie,
            this.Modelo,
            this.Activo,
            this.Ficha,
            this.Linea,
            this.emo_pepsi,
            this.emo,
            this.Eliminar});
            this.dgvInformacion.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvInformacion.Location = new System.Drawing.Point(2, 222);
            this.dgvInformacion.Margin = new System.Windows.Forms.Padding(2);
            this.dgvInformacion.MultiSelect = false;
            this.dgvInformacion.Name = "dgvInformacion";
            this.dgvInformacion.RowTemplate.Height = 24;
            this.dgvInformacion.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.CellSelect;
            this.dgvInformacion.Size = new System.Drawing.Size(823, 423);
            this.dgvInformacion.TabIndex = 1;
            this.dgvInformacion.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvInformacion_CellContentClick);
            this.dgvInformacion.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvInformacion_CellEndEdit);
            // 
            // Id
            // 
            this.Id.HeaderText = "Id";
            this.Id.Name = "Id";
            this.Id.Visible = false;
            // 
            // Serie
            // 
            this.Serie.HeaderText = "Serie";
            this.Serie.Name = "Serie";
            // 
            // Modelo
            // 
            this.Modelo.HeaderText = "Modelo";
            this.Modelo.Name = "Modelo";
            // 
            // Activo
            // 
            this.Activo.HeaderText = "Activo";
            this.Activo.Name = "Activo";
            // 
            // Ficha
            // 
            this.Ficha.HeaderText = "Ficha";
            this.Ficha.Name = "Ficha";
            // 
            // Linea
            // 
            this.Linea.HeaderText = "Linea";
            this.Linea.Name = "Linea";
            // 
            // emo_pepsi
            // 
            this.emo_pepsi.HeaderText = "EMO PEPSI";
            this.emo_pepsi.Name = "emo_pepsi";
            // 
            // emo
            // 
            this.emo.HeaderText = "EMO";
            this.emo.Name = "emo";
            // 
            // Eliminar
            // 
            this.Eliminar.HeaderText = "Eliminar";
            this.Eliminar.Name = "Eliminar";
            this.Eliminar.Text = "Eliminar";
            this.Eliminar.UseColumnTextForButtonValue = true;
            // 
            // mersaDataSet
            // 
            this.mersaDataSet.DataSetName = "mersaDataSet";
            this.mersaDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // frmPrincipal
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(982, 653);
            this.Controls.Add(this.tlpPrincipal);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
            this.MaximumSize = new System.Drawing.Size(1000, 700);
            this.MinimumSize = new System.Drawing.Size(900, 600);
            this.Name = "frmPrincipal";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "BOL";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.frmPrincipal_Load);
            this.tlpPrincipal.ResumeLayout(false);
            this.tlpOpciones.ResumeLayout(false);
            this.tlpRegistros.ResumeLayout(false);
            this.tlpAcciones.ResumeLayout(false);
            this.tlpInformacion.ResumeLayout(false);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.panelBol.ResumeLayout(false);
            this.panelBol.PerformLayout();
            this.tableLayoutPanel3.ResumeLayout(false);
            this.tableLayoutPanel4.ResumeLayout(false);
            this.tableLayoutPanel4.PerformLayout();
            this.tableLayoutPanel5.ResumeLayout(false);
            this.tableLayoutPanel5.PerformLayout();
            this.tableLayoutPanel6.ResumeLayout(false);
            this.tableLayoutPanel6.PerformLayout();
            this.tableLayoutPanel7.ResumeLayout(false);
            this.tableLayoutPanel8.ResumeLayout(false);
            this.tableLayoutPanel8.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvInformacion)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.mersaDataSet)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tlpPrincipal;
        private System.Windows.Forms.TableLayoutPanel tlpOpciones;
        private System.Windows.Forms.TableLayoutPanel tlpInformacion;
        private System.Windows.Forms.TableLayoutPanel tlpRegistros;
        private System.Windows.Forms.TableLayoutPanel tlpAcciones;
        private System.Windows.Forms.Button btnPrimero;
        private System.Windows.Forms.Button btnAnterior;
        private System.Windows.Forms.Button btnSiguiente;
        private System.Windows.Forms.Button btnUltimo;
        private System.Windows.Forms.Button btnNuevo;
        private System.Windows.Forms.Button btnModificar;
        private System.Windows.Forms.Button btnEliminar;
        private System.Windows.Forms.Button btnBuscar;
        private System.Windows.Forms.Button btnImprimir;
        private System.Windows.Forms.Button btnGuardar;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.Button btnReporte;
        private System.Windows.Forms.Button btnSalir;
        private System.Windows.Forms.DataGridView dgvInformacion;
        private mersaDataSet mersaDataSet;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.TableLayoutPanel panelBol;
        private System.Windows.Forms.DateTimePicker dtpFecha;
        private System.Windows.Forms.TextBox txtBol;
        private System.Windows.Forms.Button btnComoDatos;
        private System.Windows.Forms.Button btnEmos;
        private System.Windows.Forms.Label lblFecha;
        private System.Windows.Forms.Label lblBol;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel3;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel4;
        private System.Windows.Forms.ComboBox cboTransportista;
        private System.Windows.Forms.Label lblTransportista;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel5;
        private System.Windows.Forms.TextBox txtChofer;
        private System.Windows.Forms.Label lblChofer;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel6;
        private System.Windows.Forms.Label lblPlacas;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel7;
        private System.Windows.Forms.Button btnActualizar;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel8;
        private System.Windows.Forms.Label lblZona;
        private System.Windows.Forms.Label lblEspecial;
        private System.Windows.Forms.ComboBox cboZona;
        private System.Windows.Forms.ComboBox cboEspecial;
        private System.Windows.Forms.RadioButton rdbEntrada;
        private System.Windows.Forms.RadioButton rdbSalida;
        private System.Windows.Forms.ComboBox cboPlaca;
        private System.Windows.Forms.DataGridViewTextBoxColumn Id;
        private System.Windows.Forms.DataGridViewTextBoxColumn Serie;
        private System.Windows.Forms.DataGridViewTextBoxColumn Modelo;
        private System.Windows.Forms.DataGridViewTextBoxColumn Activo;
        private System.Windows.Forms.DataGridViewTextBoxColumn Ficha;
        private System.Windows.Forms.DataGridViewTextBoxColumn Linea;
        private System.Windows.Forms.DataGridViewTextBoxColumn emo_pepsi;
        private System.Windows.Forms.DataGridViewTextBoxColumn emo;
        private System.Windows.Forms.DataGridViewButtonColumn Eliminar;
    }
}

