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
    public partial class salaryinfo : System.Web.UI.Page
    {
        public static DataTable dtSalaryInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtSalaryInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_SalaryInfo_SEL").Tables[0];
        }
    }
}