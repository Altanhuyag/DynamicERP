using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class seasoninfo : System.Web.UI.Page
    {
        public static DataTable dtSeasonInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            string XML = "<NewDataSet><BusinessObject><name></name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_SeasonInfo_SEL", XML);
            dtSeasonInfo = ds.Tables[0];
        }

        public static void Search(string Name)
        {
            dtSeasonInfo = null;
            string XML = "<NewDataSet><BusinessObject><name>" + Name + "</name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_SeasonInfo_SEL", XML);
            dtSeasonInfo = ds.Tables[0];
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            Search(txtSearch.Text.Trim());
        }
    }
}