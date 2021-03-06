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
    public partial class skilltypeinfo : System.Web.UI.Page
    {
        public static DataTable dtSkillTypeInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserPkID"] == null)
            {
                Response.Redirect("../login.aspx");
                return;
            }
            dtSkillTypeInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_SkillTypeInfo_SEL").Tables[0];
        }
    }
}