using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class yearinfo : System.Web.UI.Page
    {
        public static DataTable dtYearInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }

            dtYearInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_Year_SEL").Tables[0];
        }
    }
}