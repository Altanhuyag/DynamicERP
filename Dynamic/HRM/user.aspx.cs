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
    public partial class userHRM : System.Web.UI.Page
    {
        public DataTable dtSearch = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }

            DataTable dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from smmUserGroup where ProgID='"+Session["ProgID"].ToString()+"'").Tables[0];
            cmbUserGroup.DataSource = dt;
            cmbUserGroup.DataTextField = "UserGroupName";
            cmbUserGroup.DataValueField = "UserGroupID";
            cmbUserGroup.DataBind();

            dt = SystemGlobals.DataBase.ExecuteSQL(@"select '' as EmployeeInfoPkID,N'--Ажилтанг сонго--' FullName union all select EmployeeInfoPkID,LastName + N' овогтой ' + FirstName as FullName from hrmEmployeeInfo where Status  not in (2,3,5) ").Tables[0];
            cmbEmployeeInfo.DataSource = dt;
            cmbEmployeeInfo.DataTextField = "FullName";
            cmbEmployeeInfo.DataValueField = "EmployeeInfoPkID";
            cmbEmployeeInfo.DataBind();

            if (Session["ProgID"]==null)
                dt = SystemGlobals.DataBase.ExecuteSQL("select * from smmConstants where ConstType='smmProg'").Tables[0];
            else
                dt = SystemGlobals.DataBase.ExecuteSQL("select * from smmConstants where ConstType='smmProg' and ConstKey='"+Session["ProgID"].ToString()+"'").Tables[0];
            cmbProgID.DataSource = dt;
            cmbProgID.DataTextField = "ValueStr1";
            cmbProgID.DataValueField = "ConstKey";
            cmbProgID.DataBind();

            dtSearch = List("");

        }
        public DataTable List(string SearchString)
        {
            string XML = "";
            if (SearchString == "")
            {
                XML = "<NewDataSet><BusinessObject><ProgID>" + Session["ProgID"].ToString() + "</ProgID></BusinessObject></NewDataSet>";                
            }
            else
                XML = "<NewDataSet><BusinessObject><ProgID>" + Session["ProgID"].ToString() + "</ProgID><SearchText>"+SearchString+"</SearchText></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserInfo_SEL", XML).Tables[0];
            return dt;
        }
      

        protected void btnSearch_ServerClick(object sender, EventArgs e)
        {
            dtSearch = List(txtSearchText.Text);
        }
    }
}