using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace WebService_Pub
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            //Remueve el formateo en XML y lo deja en JSON
            var json = config.Formatters.JsonFormatter;
            json.SerializerSettings.PreserveReferencesHandling =
                Newtonsoft.Json.PreserveReferencesHandling.Objects;
            config.Formatters.Remove(config.Formatters.XmlFormatter);

            // Configuración y servicios de API web

            // Rutas de API web
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
