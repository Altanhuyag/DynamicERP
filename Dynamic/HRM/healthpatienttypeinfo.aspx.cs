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
    public partial class healthpatienttypeinfo : System.Web.UI.Page
    {
        public static DataTable dtHealtPatientTypeInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtHealtPatientTypeInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_HealthPatientTypeInfo_SEL").Tables[0];
        }
    }
}