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
    public partial class skillinfo : System.Web.UI.Page
    {
        public static DataTable dtSkillInfo;
        public static DataTable dtSkillTypeInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            dtSkillInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_SkillInfo_SEL").Tables[0];
            dtSkillTypeInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_SkillTypeInfo_SEL").Tables[0];

        }
    }
}