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
    public partial class sheetinfo : System.Web.UI.Page
    {
        public static DataTable dtSheetInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtSheetInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_SheetInfo_SEL").Tables[0];
        }
    }
}