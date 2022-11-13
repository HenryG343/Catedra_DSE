using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using ConexionDatos;
using WebService_Pub.Models;

namespace WebService_Pub.Controllers
{
    public class TransportistasController : ApiController
    {
        private mersaEntities db = new mersaEntities();
        private TransportistaModel transportista = new TransportistaModel();

        // GET: api/Transportistas
        public List<String> GET()
        {
            return transportista.Placas();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool usuarios_transExists(int id)
        {
            return db.usuarios_trans.Count(e => e.id_transportista == id) > 0;
        }
    }
}