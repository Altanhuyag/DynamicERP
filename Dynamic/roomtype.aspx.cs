using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class roomtype : System.Web.UI.Page
    {
        public static DataTable dtRoomType;

        protected void Page_Load(object sender, EventArgs e)
        {
            string XML = "<NewDataSet><BusinessObject><name></name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomTypeInfo_SEL", XML);
            dtRoomType = ds.Tables[0];
        }

        public static void Search(string Name)
        {
            dtRoomType = null;
            string XML = "<NewDataSet><BusinessObject><name>" + Name + "</name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomTypeInfo_SEL", XML);
            dtRoomType = ds.Tables[0];
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            Search(txtSearch.Text.Trim());
        }
    }
}