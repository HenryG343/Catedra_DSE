using ConexionDatos;
using WebService_Pub.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace WebService_Pub.Models
{
    public abstract class AbstractModel<T> where T : class
    {
        protected mersaEntities ctx = new mersaEntities();
        protected sacEntities ctx2 = new sacEntities();

        protected DbSet<T> dbSet;

        public AbstractModel()
        {
            dbSet = ctx.Set<T>();
        }
        public virtual int Insert(T entity)
        {
            try
            {
                dbSet.Add(entity);
                ctx.SaveChanges();
                return 1;
            }
            catch
            {
                return 0;
            }
        }

        public virtual List<T> List()
        {
            var result = from t in dbSet
                         select t;
            return result.ToList();
        }

        public virtual T getById(Object id)
        {
            return dbSet.Find(id);
        }

        public virtual int Update(T entity, Object id)
        {
            try
            {
                T old = dbSet.Find(id);
                if (old != null)
                {
                    ctx.Entry(old).CurrentValues.SetValues(entity);
                    ctx.SaveChanges();
                    return 1;
                }
                return 0;
            }
            catch
            {
                return 0;
            }
        }

        public virtual int Remove(Object id)
        {
            try
            {
                T entity = dbSet.Find(id);
                if (entity != null)
                {
                    dbSet.Remove(entity);
                    ctx.SaveChanges();
                    return 1;
                }
                return 0;
            }
            catch
            {
                return 0;
            }
        }


    }
}