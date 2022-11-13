using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ConexionDatos;
using WebService_Pub.Models;

namespace WebService_Pub.Controllers
{
    public class SacController : ApiController
    {
        private sacEntities db = new sacEntities();
        private SerieSacModel sac = new SerieSacModel();

        // GET: api/Transportistas
        public List<String> GET()
        {
            return sac.Sac();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
