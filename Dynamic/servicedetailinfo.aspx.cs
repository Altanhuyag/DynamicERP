using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class servicedetailinfo : System.Web.UI.Page
    {
        public static DataTable dtServiceDetailInfo;
        public static DataTable dtServiceInfo;
        public static DataTable dtGuestTypeInfo;
        public static DataTable dtCurrencyInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            string XML = "<NewDataSet><BusinessObject><name></name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_ServiceDetailInfo_SEL", XML);
            dtServiceDetailInfo = ds.Tables[0];
            
            dtServiceInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_ServiceInfo_SEL", XML).Tables[0];
            dtGuestTypeInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_GuestTypeInfo_SEL", XML).Tables[0];
            dtCurrencyInfo = SystemGlobals.DataBase.ExecuteQuery("spacc_CurrencyInfo_SEL", "").Tables[0];
        }

        public static void Search(string Name)
        {
            dtServiceDetailInfo = null;
            string XML = "<NewDataSet><BusinessObject><name>" + Name + "</name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_ServiceDetailInfo_SEL", XML);
            dtServiceDetailInfo = ds.Tables[0];
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            Search(txtSearch.Text.Trim());
        }
    }
}