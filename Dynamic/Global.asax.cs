using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace Dynamic
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            try
            {
                var conn = ConfigurationManager.ConnectionStrings["serviceCon"].ConnectionString;
                var csb = new SqlConnectionStringBuilder(conn);

                SystemGlobals.DataBase = new Models.CDataBase();
                SystemGlobals.DataBase.DataBaseName = csb.InitialCatalog;
                SystemGlobals.DataBase.ServerName = csb.DataSource;
                SystemGlobals.DataBase.UserName = csb.UserID;
                SystemGlobals.DataBase.Password = csb.Password;

                DataTable dt = SystemGlobals.DataBase.ExecuteSQL("select * from smmConfig where ConfigID='FooterForm' and ModuleID='APP'").Tables[0];
                SystemGlobals.FooterTitleText = dt.Rows[0]["ConfigValue"].ToString();

                dt = SystemGlobals.DataBase.ExecuteSQL("select * from smmConfig where ConfigID='HeaderTitleForm' and ModuleID='APP'").Tables[0];
                SystemGlobals.HeaderTitleText = dt.Rows[0]["ConfigValue"].ToString();

                //RegisterRoute(RouteTable.Routes);
            }
            catch
            {

            }
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            if (Session["UserPkID"] != null)
                SystemGlobals.DataBase.ExecuteSQL("update smmUserInfo set IsOnline='N',OfflineDate=getdate() where UserPkID='" + Session["UserPkID"].ToString() + "'");
            Response.Redirect("login.aspx");
        }

        protected void Application_End(object sender, EventArgs e)
        {
            if (Session["UserPkID"] != null)
                SystemGlobals.DataBase.ExecuteSQL("update smmUserInfo set IsOnline='N',OfflineDate=getdate() where UserPkID='" + Session["UserPkID"].ToString() + "'");
        }

        protected void Application_Disposed(object sender, EventArgs e)
        {
            if (Session["UserPkID"] != null)
                SystemGlobals.DataBase.ExecuteSQL("update smmUserInfo set IsOnline='N',OfflineDate=getdate() where UserPkID='" + Session["UserPkID"].ToString() + "'");
        }
    }
}