using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class docout : System.Web.UI.Page
    {
        public static DataTable dtDocuments;
        public static DataTable dtDocumentsStatus;
        public static DataTable dtDepartments;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
            }

            Session["UserPkID"] = "2019021800000003";
            string XML = "<NewDataSet><BusinessObject><DocumentTypeID>2</DocumentTypeID></BusinessObject></NewDataSet>";
            dtDocuments = SystemGlobals.DataBase.ExecuteQuery("spint_docDocument_SEL", XML).Tables[0];
            dtDocumentsStatus = SystemGlobals.DataBase.ExecuteSQL("SELECT ConstKey, ValueStr1 FROM smmConstants WHERE ConstType = N'docDocumentStatus'").Tables[0];
            dtDepartments = SystemGlobals.DataBase.ExecuteQuery("sphrm_DepartmentInfo_SEL", "").Tables[0];
        }
    }
}