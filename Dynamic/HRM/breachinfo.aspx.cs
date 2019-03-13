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
    public partial class breachinfo : System.Web.UI.Page
    {
        public static DataTable dtBreachInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtBreachInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_BreachInfo_SEL").Tables[0];
        }
    }
}