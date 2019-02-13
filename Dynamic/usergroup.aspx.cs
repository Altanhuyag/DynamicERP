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
    public partial class usergroup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public DataTable List()
        {
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserGroup_SEL").Tables[0];
            return dt;
        }
    }
}