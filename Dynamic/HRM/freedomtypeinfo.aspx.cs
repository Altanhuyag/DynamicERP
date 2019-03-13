using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic
{
    public partial class freedomtypeinfo : System.Web.UI.Page
    {
        public static DataTable dtFreedomTypeInfoInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtFreedomTypeInfoInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_FreedomTypeInfo_SEL").Tables[0];
        }
    }
}