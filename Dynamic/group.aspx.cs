using Minj.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Minj
{
    public partial class group : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from ordProjectGroupInfo where IsStatus='N' ").Tables[0];
            cmbProjectGroup.DataSource = dt;
            cmbProjectGroup.DataTextField = "ProjectGroupName";
            cmbProjectGroup.DataValueField = "ProjectGroupPkID";
            cmbProjectGroup.DataBind();

            dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from smmConstants where ConstType='houseStatus'").Tables[0];
            cmbStatus.DataSource = dt;
            cmbStatus.DataTextField = "ValueStr1";
            cmbStatus.DataValueField = "ValueNum";
            cmbStatus.DataBind();
        }

        public DataTable List()
        {
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spord_HouseInfo_SEL").Tables[0];
            return dt;
        }
    }
}