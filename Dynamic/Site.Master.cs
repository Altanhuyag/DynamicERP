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
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("login.aspx");
            }
        }

        public DataTable MenuList(string UserPkID, string ModuleID)
        {
            DataTable dtUser = SystemGlobals.DataBase.ExecuteSQL("select * from smmWebMenuInfo where CreatedModuleID='"+ModuleID+"' order by SortedOrder").Tables[0];
            return dtUser;
        }

        public DataTable MenuList(string UserPkID, string ModuleID,int Len)
        {
            DataTable dtUser = SystemGlobals.DataBase.ExecuteSQL("select * from smmWebMenuInfo where CreatedModuleID='" + ModuleID + "' and Len(MenuInfoCode)="+Len.ToString()+" order by SortedOrder").Tables[0];
            return dtUser;
        }

        public DataTable MenuList(string UserPkID, string ModuleID,int Len, string MenuInfoCode)
        {
            DataTable dtUser = SystemGlobals.DataBase.ExecuteSQL("select * from smmWebMenuInfo where CreatedModuleID='" + ModuleID + "' and Len(MenuInfoCode)=" + Len.ToString() + " and MenuInfoCode like '" + MenuInfoCode.ToString() + "%' order by SortedOrder").Tables[0];
            return dtUser;
        }

    }
}