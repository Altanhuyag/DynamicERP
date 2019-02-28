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
    public partial class eventinfo : System.Web.UI.Page
    {
        public static DataTable dteventinfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dteventinfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_EventInfo_SEL").Tables[0];
        }
    }
}