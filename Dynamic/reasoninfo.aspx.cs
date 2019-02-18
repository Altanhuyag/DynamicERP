using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class reasoninfo : System.Web.UI.Page
    {
        public static DataTable dtReasonInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            string XML = "<NewDataSet><BusinessObject><name></name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_ReasonInfo_SEL", XML);
            dtReasonInfo = ds.Tables[0];
        }

        public static void Search(string Name)
        {
            dtReasonInfo = null;
            string XML = "<NewDataSet><BusinessObject><name>" + Name + "</name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_ReasonInfo_SEL", XML);
            dtReasonInfo = ds.Tables[0];
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            Search(txtSearch.Text.Trim());
        }
    }
}