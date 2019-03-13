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
    public partial class learninginfo : System.Web.UI.Page
    {
        public static DataTable dtLearningInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtLearningInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_LearningInfo_SEL").Tables[0];
        }
    }
}