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
    public partial class agelimitinfo : System.Web.UI.Page
    {
        public static DataTable dtAgeLimitInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            dtAgeLimitInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_AgeLimitInfo_SEL").Tables[0];
        }
    }
}