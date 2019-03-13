using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class rescheckout : System.Web.UI.Page
    {
        public static DataTable dtResCategory;
        public static DataTable dtTables;
        public static DataTable dtRestaurant;
        public static DataTable dtMenu;
        public static DataTable dtItem;
        public static DataTable dtCustomerInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"]==null)
            {
                Response.Redirect("../login.aspx");
            }

            Session["RestaurantPkID"] = "2019021800000002";
            Session["PosDate"] = "2019-03-06";

            dtResCategory = SystemGlobals.DataBase.ExecuteQuery("spres_resRestaurantCategoryGET_SEL", "<NewDataSet><BusinessObject><RestaurantPkID>" + Session["RestaurantPkID"] + "</RestaurantPkID></BusinessObject></NewDataSet>").Tables[0];
            dtRestaurant = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantInfoGET_SEL", "<NewDataSet><BusinessObject><id>" + Session["RestaurantPkID"] + "</id></BusinessObject></NewDataSet>").Tables[0];
            dtMenu = SystemGlobals.DataBase.ExecuteQuery("spres_resRestaurantMenuGET_SEL", "<NewDataSet><BusinessObject><RestaurantPkID>" + Session["RestaurantPkID"] + "</RestaurantPkID></BusinessObject></NewDataSet>").Tables[0];
            dtCustomerInfo = SystemGlobals.DataBase.ExecuteQuery("spacc_CustomerInfo_SEL", "").Tables[0];
        }

        public static void LoadTables(string catid)
        {
            dtTables = null;
            string XML = "<NewDataSet><BusinessObject><CategoryPkID>" + catid + "</CategoryPkID></BusinessObject></NewDataSet>";
            dtTables = SystemGlobals.DataBase.ExecuteQuery("spres_resRestaurantTableGET_SEL", XML).Tables[0];
        }

        public static void LoadItems(string menuid)
        {
            dtItem = null;
            string XML = "<NewDataSet><BusinessObject><RestaurantMenuPkID>" + menuid + "</RestaurantMenuPkID></BusinessObject></NewDataSet>";
            dtItem = SystemGlobals.DataBase.ExecuteQuery("spres_resItemInfoGET_SEL", XML).Tables[0];
        }
        
    }
}