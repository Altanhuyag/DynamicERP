using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic
{
    public partial class usergroup_newSMM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserPkID"] != null)
                {
                    DataTable dt = SystemGlobals.DataBase.ExecuteSQL("select * from smmConstants where ConstType='smmProg'").Tables[0];
                    cmbProgID.DataSource = dt;
                    cmbProgID.DataTextField = "ValueStr1";
                    cmbProgID.DataValueField = "ConstKey";
                    cmbProgID.DataBind();

                    Label1.Text = "";

                    if (Request.QueryString["uId"] != null)
                    {
                        DataTable dtCompany = SystemGlobals.DataBase.ExecuteSQL("select * from smmUserGroup where UserGroupID='"+Request.QueryString["uId"].ToString()+"'").Tables[0];
                        if (dtCompany.Rows.Count == 0)
                        {
                            Response.Redirect("usergroup.aspx");
                        }
                        else
                        {
                            txtUserGroupName.Text = dtCompany.Rows[0]["UserGroupName"].ToString();
                            cmbProgID.SelectedValue= dtCompany.Rows[0]["ProgID"].ToString();
                           
                        }
                    }
                }
                else
                {
                    Response.Redirect(ResolveUrl("../login.aspx"));
                }                
            }           
        }

        
        
    }
}