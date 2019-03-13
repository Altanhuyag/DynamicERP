using Dynamic.Models;
using System;
using System.Data;
//using System.Web.Services;

namespace Dynamic
{
    public partial class restaurant : System.Web.UI.Page
    {
        public static DataTable dtRestaurants;
        public static DataTable dtResUsers;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            string XML = "<NewDataSet><BusinessObject><name></name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantInfo_SEL", XML);
            dtRestaurants = ds.Tables[0];

            dtResUsers = SystemGlobals.DataBase.ExecuteQuery("spres_resRestaurantUser_SEL", "").Tables[0];
        }
        public static void SearchRestaurant(string Name)
        {
            dtRestaurants = null;
            string XML = "<NewDataSet><BusinessObject><name>" + Name + "</name></BusinessObject></NewDataSet>";
            DataSet ds = new DataSet();
            ds = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantInfo_SEL", XML);
            dtRestaurants = ds.Tables[0];
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            SearchRestaurant(txtSearch.Text.Trim());
        }

        //[WebMethod]
        //public static bool RefreshRestaurants()
        //{
        //    try
        //    {
        //        SearchRestaurant("");
        //        return true;
        //    }
        //    catch (Exception ex)
        //    {
        //        return false;
        //    }
        //}
    }
}