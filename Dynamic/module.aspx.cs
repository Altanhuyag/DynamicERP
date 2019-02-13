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
    public partial class module : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
                Response.Redirect("login.aspx");

            if (Request.QueryString["pId"] != null)
            {
                Session["ProgID"] = Request.QueryString["pId"].ToString();
                Response.Redirect("index.aspx");
            }
            else
                Session["ProgID"] = "";
        }

        public DataTable UserProgList(string UserPkID)
        {
            DataTable dt = SystemGlobals.DataBase.ExecuteSQL(@"select A.*,C.ValueStr1 as ProgName,c.ValueStr2 from smmUserProgInfo A
inner join smmConstants c on A.ModuleID = C.ConstKey and C.ConstType = 'smmProg' where A.UserPkID='"+UserPkID+"'").Tables[0];
            return dt;
        }
    }
}