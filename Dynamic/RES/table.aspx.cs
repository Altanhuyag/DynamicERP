﻿using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic
{
    public partial class table : System.Web.UI.Page
    {
        public DataTable dtSearch = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }

            DataTable dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from resRestaurantInfo").Tables[0];
            cmbRestaurant.DataSource = dt;
            cmbRestaurant.DataTextField = "RestaurantName";
            cmbRestaurant.DataValueField = "RestaurantPkID";
            cmbRestaurant.DataBind();

            if (dt != null && dt.Rows.Count > 0)
            {
                dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from resRestaurantCategory where RestaurantPkID='"+cmbRestaurant.SelectedValue.ToString()+"'").Tables[0];
                cmbCategory.DataSource = dt;
                cmbCategory.DataTextField = "CategoryName";
                cmbCategory.DataValueField = "CategoryPkID";
                cmbCategory.DataBind();
            }

            dtSearch = List("");
        }

        public DataTable List(string SearchString)
        {
            string XML = "";
            if (SearchString != "")           
                XML = "<NewDataSet><BusinessObject><TableID>" + SearchString + "</TableID></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantTable_SEL", XML).Tables[0];
            return dt;
        }
        protected void btnSearch_ServerClick(object sender, EventArgs e)
        {
            dtSearch = List(txtSearchText.Text);
        }
    }
}