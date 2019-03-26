using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class doc_detail : System.Web.UI.Page
    {
        public static DataTable dtDocuments;
        public static DataTable dtComments;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
            }

            Session["UserPkID"] = "2019021300000005";
            Session["EmployeeInfoPkID"] = "2019021900000001";
            string DocID = Request.QueryString["dId"];

            string XML = "<NewDataSet><BusinessObject><DocumentPkID>" + DocID + "</DocumentPkID><EmployeeInfoPkID>" + Session["EmployeeInfoPkID"].ToString() + "</EmployeeInfoPkID><UserPkID>" + Session["UserPkID"].ToString() + "</UserPkID></BusinessObject></NewDataSet>";
            dtDocuments = SystemGlobals.DataBase.ExecuteQuery("spint_docDocumentGET_SEL", XML).Tables[0];
            if (dtDocuments.Rows.Count == 0 || dtDocuments.Rows[0][0].ToString() == "Not found")
            {
                Response.Redirect("404.html");
            }
            dtComments = SystemGlobals.DataBase.ExecuteQuery("spint_docDocumentCommentGET_SEL", "<NewDataSet><BusinessObject><DocumentPkID>" + DocID + "</DocumentPkID></BusinessObject></NewDataSet>").Tables[0];
        }
    }
}