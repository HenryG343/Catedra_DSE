using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ConexionDatos;
using WebService_Pub.Models;

namespace WebService_Pub.Models
{
    //Clase para modelar la salida de forma mas sencilla
    //ya que solo devuelve 
    public class Usuarios
    {
        int idUsuario;
        string dui;
        string pass;
        string tipoUsuario;
        public Usuarios()
        {
        }
        public Usuarios(string dui, string pass, string tipoUsuario, int idusuario)
        {
            this.dui = dui;
            this.pass = pass;
            this.tipoUsuario = tipoUsuario;
            this.idUsuario = idusuario;
        }

        public string Dui { get => dui; set => dui = value; }
        public string Pass { get => pass; set => pass = value; }
        public string TipoUsuario { get => tipoUsuario; set => tipoUsuario = value; }
        public int IdUsuario { get => idUsuario; set => idUsuario = value; }
    }
    public class UsuariosModel : AbstractModel<usuarios_adm>
    {
        public String Login(string dui, string pass)
        {
            var consulta = (from t in ctx.usuarios_adm
                            where t.dui == dui && t.contra == pass
                            select t).FirstOrDefault();
            Usuarios user = new Usuarios(consulta.dui, consulta.contra, consulta.tipo_usuarios.nombre_tipo, consulta.id_usuario);
            String salida = consulta.dui + ";" + consulta.contra + ";" + consulta.id_usuario;
            return salida;
        }
    }
}