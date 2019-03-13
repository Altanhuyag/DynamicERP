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
            dtYearInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_Year_SEL").Tables[0];
        }
    }
}