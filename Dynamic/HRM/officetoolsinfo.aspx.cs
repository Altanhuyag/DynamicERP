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
    public partial class officetoolsinfo : System.Web.UI.Page
    {
        public static DataTable dtOfficeToolsInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtOfficeToolsInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_OfficeToolsInfo_SEL").Tables[0];
        }
    }
}