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
    public partial class professioninfo : System.Web.UI.Page
    {
        public static DataTable dtProfessionInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtProfessionInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_ProfessionInfo_SEL").Tables[0];
        }
    }
}