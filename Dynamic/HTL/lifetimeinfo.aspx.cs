using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class lifetimeinfo : System.Web.UI.Page
    {
        public static DataTable dtLifeTime;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            string XML = "<NewDataSet><BusinessObject><name></name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_LifeTimeInfo_SEL", XML);
            dtLifeTime = ds.Tables[0];
        }

        public static void Search(string Name)
        {
            dtLifeTime = null;
            string XML = "<NewDataSet><BusinessObject><name>" + Name + "</name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_LifeTimeInfo_SEL", XML);
            dtLifeTime = ds.Tables[0];
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            Search(txtSearch.Text.Trim());
        }
    }
}