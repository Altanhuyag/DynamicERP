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
    public partial class advertenceinfo : System.Web.UI.Page
    {
        public static DataTable dtAdvertenceInfo;
        public static DataTable dtAdvertenceTypeInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            dtAdvertenceInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_AdvertenceInfo_SEL").Tables[0];
            dtAdvertenceTypeInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_AdvertenceTypeInfo_SEL").Tables[0];
        }
    }
}