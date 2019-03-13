using Dynamic.Models;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace Dynamic
{
    public partial class roompriceinfo : System.Web.UI.Page
    {
        public static DataTable dtPriceInfo;
        public static DataTable dtCurrencyInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            string defcur = "";
            defcur = SystemGlobals.DataBase.ExecuteSQL("select CurrencyID from accCurrencyInfo where IsMainCurrency = N'Y'").Tables[0].Rows[0][0].ToString();

            string XML = "<NewDataSet><BusinessObject><curid>" + defcur + "</curid></BusinessObject></NewDataSet>";
            dtPriceInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomPriceInfo_SEL", XML).Tables[0];

            dtCurrencyInfo = SystemGlobals.DataBase.ExecuteQuery("spacc_CurrencyInfo_SEL", "").Tables[0];

            if (!Page.IsPostBack)
            {
                cmbSearch.DataSource = dtCurrencyInfo;
                cmbSearch.DataValueField = "CurrencyID";
                cmbSearch.DataTextField = "CurrencyName";
                cmbSearch.DataBind();
                cmbSearch.Items.FindByValue(defcur).Selected = true;
            }
        }

        public static void Search(string currency)
        {
            dtPriceInfo = null;
            string XML = "<NewDataSet><BusinessObject><curid>" + currency + "</curid></BusinessObject></NewDataSet>";
            dtPriceInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomPriceInfo_SEL", XML).Tables[0];
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            Search(cmbSearch.SelectedValue.ToString());
        }
    }
}