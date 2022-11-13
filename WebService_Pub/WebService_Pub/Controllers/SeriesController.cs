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

namespace WebService_Pub.Controllers
{
    public class SeriesController : ApiController
    {
        private mersaEntities db = new mersaEntities();

        // POST: api/Series
        [ResponseType(typeof(series_escaneadas))]
        public async Task<IHttpActionResult> Postseries_escaneadas(series_escaneadas series_escaneadas)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            db.series_escaneadas.Add(series_escaneadas);
            await db.SaveChangesAsync();

            return Ok("0");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool series_escaneadasExists(int id)
        {
            return db.series_escaneadas.Count(e => e.id_serie == id) > 0;
        }
    }
}