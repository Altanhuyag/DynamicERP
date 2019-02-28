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
    public partial class extrarequirement : System.Web.UI.Page
    {
        public static DataTable dtExtrarequirementInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtExtrarequirementInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_ExtraRequirement_SEL").Tables[0];
        }
    }
}