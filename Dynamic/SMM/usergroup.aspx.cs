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
    public partial class usergroupSMM : System.Web.UI.Page
    {
        public DataTable dtSearch;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect(ResolveUrl("../login.aspx"));
                return;
            }

            dtSearch = List();
        }
        public DataTable List()
        {
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserGroup_WEB_SEL").Tables[0];
            return dt;
        }

        protected void btnSearch_ServerClick(object sender, EventArgs e)
        {

        }
    }
}