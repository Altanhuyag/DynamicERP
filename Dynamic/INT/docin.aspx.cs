using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class docin : System.Web.UI.Page
    {
        public static DataTable dtDocuments;
        public static DataTable dtDocumentsStatus;
        public static DataTable dtDepartments;
        public static DataTable dtEmployees;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
            }

            Session["UserPkID"] = "2019021300000005";
            string XML = "<NewDataSet><BusinessObject><DocumentTypeID>1</DocumentTypeID></BusinessObject></NewDataSet>";
            dtDocuments = SystemGlobals.DataBase.ExecuteQuery("spint_docDocument_SEL", XML).Tables[0];
            dtDocumentsStatus = SystemGlobals.DataBase.ExecuteSQL("SELECT ConstKey, ValueStr1 FROM smmConstants WHERE ConstType = N'docDocumentStatus'").Tables[0];
            dtDepartments = SystemGlobals.DataBase.ExecuteQuery("sphrm_DepartmentInfo_SEL", "").Tables[0];
            dtEmployees = SystemGlobals.DataBase.ExecuteQuery("sphrm_EmployeeInfo_SEL", "").Tables[0];
        }
    }
}