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
    public partial class degreeinfo : System.Web.UI.Page
    {
        public static DataTable dtDegreeInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtDegreeInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_DegreeInfo_SEL").Tables[0];
        }
    }
}