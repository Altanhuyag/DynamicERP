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
    public partial class experienceinfo : System.Web.UI.Page
    {
        public static DataTable dtExperienceInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtExperienceInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_ExperienceInfo_SEL").Tables[0];
        }
    }
}