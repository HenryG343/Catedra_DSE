using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Description;
using WebService_Pub.Models;
using ConexionDatos;

namespace WebService_Pub.Controllers
{
    public class UsuariosController : ApiController
    {
        private UsuariosModel usuariosModel = new UsuariosModel();
        [ResponseType(typeof(String))]
        public String Getusuarios_adm(string dui, string pass)
        {
            String salida = usuariosModel.Login(dui, pass);
            if (String.IsNullOrEmpty(salida))
            {
                return null;
            }

            return salida;
        }
    }
}