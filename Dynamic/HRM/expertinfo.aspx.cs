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
    public partial class expertinfo : System.Web.UI.Page
    {
        public static DataTable dtExpertInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            dtExpertInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_ExpertInfo_SEL").Tables[0];
        }
    }
}