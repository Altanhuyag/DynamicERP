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
        public string MenuSubject = "ДАШБОАРД";
        public string MenuSubjectDescr = "Байгууллагын удирдах эрхтэй бол нийтээр энгийн эрхтэй бол зөвхөн өөрийн мэдээллийг харах боломжтой";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (Request.QueryString["m"] != null)
            {
                DataTable dtMenu = SystemGlobals.DataBase.ExecuteSQL("select * from smmWebMenuInfo where MenuInfoCode='"+Request.QueryString["m"].ToString()+"' and CreatedModuleID='"+Session["ProgID"].ToString()+"'").Tables[0];
                if (dtMenu!=null && dtMenu.Rows.Count>0)
                {
                    MenuSubject = dtMenu.Rows[0]["MenuInfoName"].ToString();
                    MenuSubjectDescr = dtMenu.Rows[0]["MenuInfoName"].ToString();
                }
                
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