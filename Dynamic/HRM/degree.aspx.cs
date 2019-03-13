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
    public partial class degree : System.Web.UI.Page
    {
        public static DataTable dtdegree;
        public static DataTable dtemployees;
        public static DataTable dtdegreeInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtdegree = SystemGlobals.DataBase.ExecuteQuery("sphrm_Degree_SEL").Tables[0];
            dtemployees = SystemGlobals.DataBase.ExecuteQuery("sphrm_EmployeeInfo_SEL").Tables[0];
            dtdegreeInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_DegreeInfo_SEL").Tables[0];
        }
    }
}