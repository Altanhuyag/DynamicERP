using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic
{
    public partial class nationalityinfo : System.Web.UI.Page
    {
        public static DataTable dtNationalityInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtNationalityInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_NationalityInfo_SEL").Tables[0];
        }
    }
}