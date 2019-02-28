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
    public partial class jobtimetableinfo : System.Web.UI.Page
    {
        public static DataTable dtJobTimeTableInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtJobTimeTableInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_JobTimeTableInfo_SEL").Tables[0];
        }
    }
}