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
    public partial class productnew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
                Response.Redirect("login.aspx");

            if (!IsPostBack)
            {
                DataTable dt = SystemGlobals.DataBase.ExecuteSQL(@"select '' ProductInfoPkID,N'---СОНГО---' ProductInfoName union all select ProductInfoPkID,ProductInfoName from invProductInfo").Tables[0];
                cmbProduct.DataSource = dt;
                cmbProduct.DataTextField = "ProductInfoName";
                cmbProduct.DataValueField = "ProductInfoPkID";
                cmbProduct.DataBind();

                dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from resRestaurantInfo").Tables[0];
                cmbRestaurant.DataSource = dt;
                cmbRestaurant.DataTextField = "RestaurantName";
                cmbRestaurant.DataValueField = "RestaurantPkID";
                cmbRestaurant.DataBind();

                if (dt != null && dt.Rows.Count > 0)
                {
                    dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from resRestaurantMenu where RestaurantPkID='" + cmbRestaurant.SelectedValue.ToString() + "'").Tables[0];
                    cmbMenu.DataSource = dt;
                    cmbMenu.DataTextField = "MenuName";
                    cmbMenu.DataValueField = "RestaurantMenuPkID";
                    cmbMenu.DataBind();
                }

                dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from invUnitInfo").Tables[0];
                cmbUnitInfo.DataSource = dt;
                cmbUnitInfo.DataTextField = "UnitName";
                cmbUnitInfo.DataValueField = "UnitID";
                cmbUnitInfo.DataBind();

                dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from invUnitInfo").Tables[0];
                cmbEqUnitID.DataSource = dt;
                cmbEqUnitID.DataTextField = "UnitName";
                cmbEqUnitID.DataValueField = "UnitID";
                cmbEqUnitID.DataBind();




                dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from resItemBuffetInfo").Tables[0];
                cmbBuffet.DataSource = dt;
                cmbBuffet.DataTextField = "BufetInfoName";
                cmbBuffet.DataValueField = "BufetInfoPkID";
                cmbBuffet.DataBind();

                dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from smmConstants where ConstType='taxType'").Tables[0];
                cmbTaxType.DataSource = dt;
                cmbTaxType.DataTextField = "ValueStr1";
                cmbTaxType.DataValueField = "ConstKey";
                cmbTaxType.DataBind();

                if (dt != null && dt.Rows.Count > 0)
                {
                    dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from invVATExemptionInfo where TaxTypeID='" + cmbTaxType.SelectedValue.ToString() + "' order by VATEInfoName").Tables[0];
                    cmbVAT.DataSource = dt;
                    cmbVAT.DataTextField = "VATEInfoName";
                    cmbVAT.DataValueField = "VATEInfoID";
                    cmbVAT.DataBind();
                }

                if (Request.QueryString["pId"] != null)
                {
                    dt = SystemGlobals.DataBase.ExecuteSQL("select A.*,B.RestaurantPkID from resItemInfo A inner join resRestaurantMenu B on A.RestaurantMenuPkID=B.RestaurantMenuPkID where A.ItemPkID='" + Request.QueryString["pId"] .ToString()+ "'").Tables[0];
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        txtItemID.Text = dt.Rows[0]["ItemID"].ToString();
                        txtItemName.Text = dt.Rows[0]["ItemName"].ToString();

                        txtExtraID.Text = dt.Rows[0]["ExtraID"].ToString();
                        cmbProduct.SelectedValue = dt.Rows[0]["ExtraID"].ToString();

                        cmbRestaurant.SelectedValue = dt.Rows[0]["RestaurantPkID"].ToString(); 
                        cmbMenu.SelectedValue = dt.Rows[0]["RestaurantMenuPkID"].ToString();
                        cmbUnitInfo.SelectedValue = dt.Rows[0]["UnitID"].ToString(); 
                        cmbBuffet.SelectedValue = dt.Rows[0]["BufetInfoPkID"].ToString();
                        txtInPrice.Text = dt.Rows[0]["InPrice"].ToString();
                        txtOutPrice.Text = dt.Rows[0]["OutPrice"].ToString();
                        cmbTaxType.SelectedValue = dt.Rows[0]["TaxTypeID"].ToString();
                        cmbVAT.SelectedValue = dt.Rows[0]["VATEInfoCode"].ToString();

                        txtDescr.Text = dt.Rows[0]["Descr"].ToString();
                        if (dt.Rows[0]["IsCityTax"].ToString() == "Y")
                            chkIsCityTax.Checked = true;

                        if (dt.Rows[0]["IsEqRelated"].ToString() == "Y")
                            chkIsEqRelated.Checked = true;

                        cmbEqUnitID.SelectedValue = dt.Rows[0]["EqUnitID"].ToString();
                        txtEqUnitQty.Text = dt.Rows[0]["EqUnitQty"].ToString();

                        txtEqMinUnitQty.Text = dt.Rows[0]["EqMinUnitQty"].ToString();
                        txtEqUnitPrice.Text = dt.Rows[0]["EqUnitPrice"].ToString();

                    }
                }
            }
                       
        }

        public DataTable List(string SearchString)
        {
            string XML = "";
            if (SearchString != "")
                XML = "<NewDataSet><BusinessObject><CategoryName>" + SearchString + "</CategoryName></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantCategory_SEL", XML).Tables[0];
            return dt;
        }

        
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string ItemPkID = "";
            string Adding = "0";
            string IsCityTax = "N";
            string IsEqRelated = "N";
            string InPrice = "0";
            string OutPrice = "0";
            string EqUnitQty = "0";
            string EqMinUnitQty = "0";
            string EqUnitPrice = "0";

            if (txtInPrice.Text != "")
                InPrice = txtInPrice.Text;

            if (txtOutPrice.Text != "")
                OutPrice = txtOutPrice.Text;

            if (txtEqUnitQty.Text != "")
                EqUnitQty = txtEqUnitQty.Text;

            if (txtEqMinUnitQty.Text !="")
                EqMinUnitQty = txtEqMinUnitQty.Text;

            if (chkIsCityTax.Checked == true)
                IsCityTax = "Y";
            if (chkIsEqRelated.Checked == true)
                IsEqRelated = "Y";

            if (txtEqUnitPrice.Text != "")
                EqUnitPrice = txtEqUnitPrice.Text;

            if (Request.QueryString["pId"] != null)
            {
                ItemPkID = Request.QueryString["pId"].ToString();
                Adding = "1";
            }



            string XML = @"<NewDataSet><BusinessObject><RestaurantMenuPkID>"+cmbMenu.SelectedValue.ToString()+"</RestaurantMenuPkID>" +
                "<Adding>" + Adding + "</Adding>" +
            "<ItemPkID>" + ItemPkID + "</ItemPkID>" +
            "<ItemID>" + txtItemID.Text + "</ItemID> " +
            "<ItemName>" + txtItemName.Text  + "</ItemName> " +
            "<ExtraID>"+ cmbProduct.SelectedValue.ToString() + "</ExtraID> " +
            "<UnitID>"+cmbUnitInfo.SelectedValue.ToString()+"</UnitID> " +
            "<BufetInfoPkID>"+cmbBuffet.SelectedValue.ToString()+"</BufetInfoPkID> " +
            "<InPrice>"+Convert.ToDecimal(InPrice).ToString()+"</InPrice> " +
            "<OutPrice>"+ Convert.ToDecimal(OutPrice).ToString() +"</OutPrice> " +
            "<TaxTypeID>"+cmbTaxType.SelectedValue.ToString()+"</TaxTypeID> " +
            "<VATEInfoCode>"+cmbVAT.SelectedValue.ToString()+"</VATEInfoCode> " +
            "<Descr>"+txtDescr.Text+"</Descr> " +
            "<IsCityTax>"+IsCityTax+"</IsCityTax> " +
            "<IsEqRelated>"+ IsEqRelated + "</IsEqRelated> " +
            "<EqUnitID>"+cmbEqUnitID.SelectedValue.ToString()+"</EqUnitID> " +
            "<EqUnitQty>"+ Convert.ToDecimal(EqUnitQty).ToString() +"</EqUnitQty> " +
            "<EqMinUnitQty>"+ Convert.ToDecimal(EqMinUnitQty).ToString() +"</EqMinUnitQty> " +
            "<EqUnitPrice>"+ Convert.ToDecimal(EqUnitPrice).ToString() +"</EqUnitPrice> " +
            "<MergeItemPkID>"+ cmbMergeItem .SelectedValue.ToString()+ "</MergeItemPkID></BusinessObject></NewDataSet>";
            SystemGlobals.DataBase.ExecuteQuery("spres_ItemInfo_UPD", XML);
                      
            Response.Redirect("product-new.aspx", false);

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "showModal", "javascript:showModal(); ", true);

        }
    }
}