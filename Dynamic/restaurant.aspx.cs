using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class restaurant : System.Web.UI.Page
    {
        public static DataTable dtRestaurants;

        protected void Page_Load(object sender, EventArgs e)
        {
            dtRestaurants = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantInfo_SEL").Tables[0];
        }
    }
}