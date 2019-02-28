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
    public partial class responseinfo : System.Web.UI.Page
    {
        public static DataTable dtResponseInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtResponseInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_ResponseInfo_SEL").Tables[0];
        }
    }
}