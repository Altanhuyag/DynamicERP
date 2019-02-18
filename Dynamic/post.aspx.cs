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

        [WebMethod]
        public static string SaveRestaurant(int type, string id, string name, string header, string footer, decimal tax, decimal citytax, decimal servicecharge)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name><header>" + header + "</header><footer>" + footer + "</footer><tax>" + tax + "</tax><citytax>" + citytax + "</citytax><servicecharge>" + servicecharge + "</servicecharge></BusinessObject></NewDataSet>";
                string retid = "0";
                retid = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantInfo_UPD", XML).Tables[0].Rows[0][0].ToString();
                return retid;
            }
            catch (Exception ex)
            {
                return "0";
            }
        }

        [WebMethod]
        public static bool DeleteRestaurant(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "spres_RestaurantInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveGroupInfo(int type, string id, string name)
        {
            try
            {
                string XML = "" + type + "" + id + "" + name + "";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomGroupInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteGroupInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomGroupInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveRoomTypeInfo(int type, string id, string name)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomTypeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteRoomTypeInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomTypeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveFactionInfo(int type, string id, string name)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_FactionInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteFactionInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_FactionInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveMiniBarTypeInfo(int type, string id, string name)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_MiniBarTypeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteMiniBarTypeInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_MiniBarTypeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveReasonInfo(int type, string id, string name, int start, int finish, int mstr)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name><start>" + start + "</start><finish>" + finish + "</finish><mstr>" + mstr + "</mstr></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_ReasonInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteReasonInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_ReasonInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveRoomInfo(int type, string id, string GroupPkID, string RoomTypePkID, int RoomBedSpace, int RoomNumber, int RoomFloor, string RoomPhone, string RoomDescr, string IsMiniBar, string MiniBarTypeInfoPkID, string FactionInfoPkID, int GuestSpace)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><GroupPkID>" + GroupPkID + "</GroupPkID><RoomTypePkID>" + RoomTypePkID + "</RoomTypePkID><RoomBedSpace>" + RoomBedSpace + "</RoomBedSpace><RoomNumber>" + RoomNumber + "</RoomNumber><RoomFloor>" + RoomFloor + "</RoomFloor><RoomPhone>" + RoomPhone + "</RoomPhone><RoomDescr>" + RoomDescr + "</RoomDescr><IsMiniBar>" + IsMiniBar + "</IsMiniBar><MiniBarTypeInfoPkID>" + MiniBarTypeInfoPkID + "</MiniBarTypeInfoPkID><FactionInfoPkID>" + FactionInfoPkID + "</FactionInfoPkID><GuestSpace>" + GuestSpace + "</GuestSpace></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteRoomInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

    }
}