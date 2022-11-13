using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Mantenimiento_mersa
{
    public class Validaciones
    {
        //Valida que los controles no vayan vacios o null, a traves
        //de la funcion IsNullOrEmpty de la clase string
        //El error provider se usa para cargar el error en el control
        public bool NoCamposVacios(List<TextBox> txts, ErrorProvider error)
        {
            error.Clear();
            int numErrores = 0;
            bool result = false;
            foreach (TextBox t in txts)
            {
                if (string.IsNullOrEmpty(t.Text))
                {
                    error.SetError(t, "Complete este campo");
                    numErrores++;
                }
            }
            if (numErrores > 0)
            {
                result = false;
            }
            else
            {
                result = true;
            }
            return result;
        }
        public bool PlacaCorrecta(TextBox txt)
        {
            if (!Regex.Match(txt.Text, "([0-9]{3}|[0-9]{2}|[0-9]{1})-([0-9]{3}|[0-9]{2}|[0-9]{1})").Success)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }
}
