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
    public partial class deduceinfo : System.Web.UI.Page
    {
        public static DataTable dtDeduceInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtDeduceInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_DeduceInfo_SEL").Tables[0];
        }
    }
}