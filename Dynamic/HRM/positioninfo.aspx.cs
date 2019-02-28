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
    public partial class positioninfo : System.Web.UI.Page
    {
        public static DataTable dtPositionInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            dtPositionInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_PositionInfo_SEL").Tables[0];
        }
    }
}