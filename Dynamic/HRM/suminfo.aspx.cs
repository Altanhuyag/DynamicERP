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
    public partial class suminfo : System.Web.UI.Page
    {
        public static DataTable dtSumInfo;
        public static DataTable dtAimagInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtSumInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_SumInfo_SEL").Tables[0];
            dtAimagInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_AimagInfo_SEL").Tables[0];
        }
    }
}