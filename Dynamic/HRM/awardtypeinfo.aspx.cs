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
    public partial class awardtypeinfo : System.Web.UI.Page
    {
        public static DataTable dtAwardTypeInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            dtAwardTypeInfo = SystemGlobals.DataBase.ExecuteQuery("sphrm_AwardTypeInfo_SEL").Tables[0];
        }
    }
}