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
    public partial class familymemberinfo : System.Web.UI.Page
    {
        public static DataTable dtFamilyMemberInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtFamilyMemberInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_FamilyMemberInfo_SEL").Tables[0];
        }
    }
}