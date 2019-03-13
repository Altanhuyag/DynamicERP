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
    public partial class countryinfo : System.Web.UI.Page
    {
        public static DataTable dtCountryInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtCountryInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_CountryInfo_SEL").Tables[0];
        }
    }
}