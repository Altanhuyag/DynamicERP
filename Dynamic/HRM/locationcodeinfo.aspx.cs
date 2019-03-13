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
    public partial class locationcodeinfo : System.Web.UI.Page
    {
        public static DataTable dtLocationCodeInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            dtLocationCodeInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_LocationCodeInfo_SEL").Tables[0];
        }
    }
}