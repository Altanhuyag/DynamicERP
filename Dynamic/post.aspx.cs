using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic
{
    public partial class post : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class UserInfo
        {
            public string UserPkID { get; set; }
            public string UserGroupID { get; set; }

            public string UserID { get; set; }
            public string UserName { get; set; }
            public string IsValid { get; set; }
            public string Password { get; set; }
            public string CreatedProgID { get; set; }
            public string CompanyPkID { get; set; }

        }

        [WebMethod]
        public static UserInfo GetUserInfo(string UserPkID)
        {
            UserInfo Roles = new UserInfo();
            DataTable dt = SystemGlobals.DataBase.ExecuteSQL("select * from smmUserInfo where  UserPkID='" + UserPkID + "'").Tables[0];

            Roles.UserGroupID = dt.Rows[0]["UserGroupID"].ToString();
            Roles.UserPkID = dt.Rows[0]["UserPkID"].ToString();
            Roles.UserID = dt.Rows[0]["UserID"].ToString();
            Roles.UserName = dt.Rows[0]["UserName"].ToString();
            Roles.IsValid = dt.Rows[0]["IsValid"].ToString();
            Roles.CreatedProgID = dt.Rows[0]["CreatedProgID"].ToString();
            Roles.Password = SystemGlobals.decrypt(dt.Rows[0]["Password"].ToString());
            Roles.CompanyPkID = dt.Rows[0]["CompanyPkID"].ToString();

            return Roles;
        }

        public class UserInPermission
        {
            public string UserGroupID { get; set; }

            public string MenuInfoID { get; set; }

            public string IsSelect { get; set; }
            public string IsInsert { get; set; }
            public string IsDelete { get; set; }
            public string IsUpdate { get; set; }

        }

        [WebMethod]
        public static List<UserInPermission> GetUserGroupInfo(string UserGroupID)
        {
            List<UserInPermission> GroupInfos = new List<UserInPermission>();

            DataTable dtDetail = SystemGlobals.DataBase.ExecuteSQL("select * from smmUserInPermission where UserGroupID='" + UserGroupID + "'").Tables[0];
            List<UserInPermission> t = new List<UserInPermission>();

            foreach (DataRow rwDetail in dtDetail.Rows)
            {
                UserInPermission u = new UserInPermission();
                u.MenuInfoID = rwDetail["MenuInfoID"].ToString();
                u.UserGroupID = rwDetail["UserGroupID"].ToString();
                u.IsSelect = rwDetail["IsSelect"].ToString();
                u.IsInsert = rwDetail["IsInsert"].ToString();
                u.IsDelete = rwDetail["IsDelete"].ToString();
                u.IsUpdate = rwDetail["IsUpdate"].ToString();
                GroupInfos.Add(u);
            }
            return GroupInfos;
        }

        [WebMethod]
        public static string DeleteUserInfo(string UserPkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><UserPkID>" + UserPkID + "</UserPkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spsmm_UserInfo_DEL", XML);
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        //Start UserGroup
        [WebMethod]
        public static string PostUserGroupInfo(string Adding, string UserGroupID, string UserGroupName,
            string ProgID, string CheckListSelect, string CheckListInsert, string CheckListEdit, string CheckListDelete)
        {
            try
            {
                if (UserGroupID != "")
                    Adding = "1";
                string XML = @"<NewDataSet><BusinessObject>
                        <Adding>" + Adding + "</Adding> " +
                    "<UserGroupID>" + UserGroupID + "</UserGroupID>" +
                    "<UserGroupName>" + UserGroupName + "</UserGroupName>" +
                    "<ProgID>" + ProgID + "</ProgID>" +
                    "<CheckListSelect>" + CheckListSelect + "</CheckListSelect>" +
                    "<CheckListInsert>" + CheckListInsert + "</CheckListInsert>" +
                    "<CheckListEdit>" + CheckListEdit + "</CheckListEdit>" +
                    "<CheckListDelete>" + CheckListDelete + "</CheckListDelete>" +

                    "</BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserGroup_UPD", XML).Tables[0];
                return dt.Rows[0]["UserGroupID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string PostUserInfo(string Adding, string UserPkID, string UserGroupID, string UserName, string UserID, string Password, string IsValid, string ProgID)
        {
            try
            {
                Password = SystemGlobals.encrypt(Password);
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><UserPkID>" + UserPkID + "</UserPkID><UserID>" + UserID + "</UserID><UserGroupID>" + UserGroupID + "</UserGroupID><Password>" + Password + "</Password><UserName>" + UserName + "</UserName><IsValid>" + IsValid + "</IsValid><CreatedProgID>" + ProgID + "</CreatedProgID></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserInfo_UPD", XML).Tables[0];
                return dt.Rows[0]["UserPkID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }
    }
}