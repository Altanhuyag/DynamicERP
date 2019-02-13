using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] != null)
                SystemGlobals.DataBase.ExecuteSQL("update smmUserInfo set IsOnline='N',OfflineDate=getdate() where UserPkID='" + Session["UserPkID"].ToString() + "'");

            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();

            Response.Redirect("login.aspx");
        }
    }
}