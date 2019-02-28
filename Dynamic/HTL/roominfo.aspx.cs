using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class roominfo : System.Web.UI.Page
    {
        public static DataTable dtRoomInfo;
        public static DataTable dtRoomGroupInfo;
        public static DataTable dtRoomTypeInfo;
        public static DataTable dtMiniBarTypeInfo;
        public static DataTable dtFactionInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            string XML = "<NewDataSet><BusinessObject><number></number></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomInfo_SEL", XML);
            dtRoomInfo = ds.Tables[0];

            string altXML = "<NewDataSet><BusinessObject><name></name></BusinessObject></NewDataSet>";
            dtRoomGroupInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomGroupInfo_SEL", altXML).Tables[0];
            dtRoomTypeInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomTypeInfo_SEL", altXML).Tables[0];
            dtMiniBarTypeInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_MiniBarTypeInfo_SEL", altXML).Tables[0];
            dtFactionInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_FactionInfo_SEL", altXML).Tables[0];

        }

        public static void Search(string Name)
        {
            dtRoomInfo = null;
            string XML = "<NewDataSet><BusinessObject><number>" + Name + "</number></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomInfo_SEL", XML);
            dtRoomInfo = ds.Tables[0];
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            Search(txtSearch.Text.Trim());
        }
    }
}