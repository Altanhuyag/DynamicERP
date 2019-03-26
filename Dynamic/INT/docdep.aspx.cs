using Dynamic.Models;
using System;
using System.Data;

namespace Dynamic
{
    public partial class docdep : System.Web.UI.Page
    {
        public static DataTable dtDocuments;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
            }

            Session["UserPkID"] = "2017041900000002";
            string XML = "<NewDataSet><BusinessObject><UserPkID>" + Session["UserPkID"].ToString() + "</UserPkID></BusinessObject></NewDataSet>";
            dtDocuments = SystemGlobals.DataBase.ExecuteQuery("spint_docDocumentDep_SEL", XML).Tables[0];
            if (dtDocuments.Rows.Count == 0 || dtDocuments.Rows[0][0].ToString() == "Not found")
            {
                dtDocuments = null;
                dtDocuments = new DataTable();
                dtDocuments.Columns.Add("DocumentDate");
                dtDocuments.Columns.Add("DocumentNo");
                dtDocuments.Columns.Add("CompanyName");
                dtDocuments.Columns.Add("Subject");
                dtDocuments.Columns.Add("PageCnt");
                dtDocuments.Columns.Add("DocumentFilePath");
                dtDocuments.Columns.Add("CreatedDate");
                dtDocuments.Columns.Add("ValueStr1");
                dtDocuments.Columns.Add("StatusName");
                dtDocuments.Columns.Add("IsReturnName");
                dtDocuments.Columns.Add("ReturnDate");
                dtDocuments.Columns.Add("DepartmentName");
                dtDocuments.Columns.Add("ReturnDescr");
                dtDocuments.Columns.Add("DocTypeName");
            }
        }
    }
}