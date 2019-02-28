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
            public string EmployeeInfoPkID { get; set; }

        }

        [WebMethod]
        public static UserInfo GetUserInfo(string UserPkID, string ProgId)
        {
            UserInfo Roles = new UserInfo();
            DataTable dt = SystemGlobals.DataBase.ExecuteSQL("select * from smmUserInfo A inner join smmUserProgInfo B on A.UserPkID=B.UserPkID and B.ModuleID='" + ProgId + "' where  A.UserPkID='" + UserPkID + "'").Tables[0];

            Roles.UserGroupID = dt.Rows[0]["UserGroupID"].ToString();
            Roles.UserPkID = dt.Rows[0]["UserPkID"].ToString();
            Roles.UserID = dt.Rows[0]["UserID"].ToString();
            Roles.UserName = dt.Rows[0]["UserName"].ToString();
            Roles.IsValid = dt.Rows[0]["IsValid"].ToString();
            Roles.CreatedProgID = dt.Rows[0]["CreatedProgID"].ToString();
            Roles.EmployeeInfoPkID = dt.Rows[0]["EmployeeInfoPkID"].ToString();
            Roles.Password = SystemGlobals.decrypt(dt.Rows[0]["Password"].ToString());

            return Roles;
        }


        [WebMethod]
        public static UserInfo GetUserInfoSMM(string UserPkID)
        {
            UserInfo Roles = new UserInfo();
            DataTable dt = SystemGlobals.DataBase.ExecuteSQL("select * from smmUserInfo  where UserPkID='" + UserPkID + "'").Tables[0];

            Roles.UserGroupID = "";
            Roles.UserPkID = dt.Rows[0]["UserPkID"].ToString();
            Roles.UserID = dt.Rows[0]["UserID"].ToString();
            Roles.UserName = dt.Rows[0]["UserName"].ToString();
            Roles.IsValid = dt.Rows[0]["IsValid"].ToString();
            Roles.CreatedProgID = dt.Rows[0]["CreatedProgID"].ToString();
            Roles.EmployeeInfoPkID = dt.Rows[0]["EmployeeInfoPkID"].ToString();
            Roles.Password = SystemGlobals.decrypt(dt.Rows[0]["Password"].ToString());

            return Roles;
        }

        public class BuffetInfo
        {
            public string BufetInfoPkID { get; set; }
            public string BufetInfoName { get; set; }
        }

        [WebMethod]
        public static BuffetInfo GetBuffetInfo(string BufetInfoPkID)
        {
            BuffetInfo Roles = new BuffetInfo();
            string XML = "<NewDataSet><BusinessObject><BufetInfoPkID>" + BufetInfoPkID + "</BufetInfoPkID></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_ItemBufetInfo_GET", XML).Tables[0];

            Roles.BufetInfoPkID = dt.Rows[0]["BufetInfoPkID"].ToString();
            Roles.BufetInfoName = dt.Rows[0]["BufetInfoName"].ToString();

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

        [WebMethod]
        public static string DeleteUserInfoSMM(string UserPkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><UserPkID>" + UserPkID + "</UserPkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spsmm_UserInfo_WEB_DEL", XML);
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
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserGroup_WEB_UPD", XML).Tables[0];
                return dt.Rows[0]["UserGroupID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string PostUserInfo(string Adding, string UserPkID, string UserGroupID, string UserName, string UserID, string Password, string IsValid, string ProgID,string EmployeeInfoPkID)
        {
            try
            {
                Password = SystemGlobals.encrypt(Password);
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><UserPkID>" + UserPkID + "</UserPkID><UserID>" + UserID + "</UserID><UserGroupID>" + UserGroupID + "</UserGroupID><Password>" + Password + "</Password><UserName>" + UserName + "</UserName><IsValid>" + IsValid + "</IsValid><EmployeeInfoPkID>"+ EmployeeInfoPkID + "</EmployeeInfoPkID><CreatedProgID>" + ProgID + "</CreatedProgID></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserInfo_UPD", XML).Tables[0];
                return dt.Rows[0]["UserPkID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string PostUserInfo(string Adding, string UserPkID, string UserName, string UserID, string Password, string IsValid, string ProgID, string EmployeeInfoPkID)
        {
            try
            {
                Password = SystemGlobals.encrypt(Password);
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><UserPkID>" + UserPkID + "</UserPkID><UserID>" + UserID + "</UserID><Password>" + Password + "</Password><UserName>" + UserName + "</UserName><IsValid>" + IsValid + "</IsValid><EmployeeInfoPkID>" + EmployeeInfoPkID + "</EmployeeInfoPkID><CreatedProgID>" + ProgID + "</CreatedProgID></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserInfo_WEB_UPD", XML).Tables[0];
                return dt.Rows[0]["UserPkID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string PostBuffetInfo(string Adding, string BufetInfoPkID, string BufetInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><BufetInfoPkID>" + BufetInfoPkID + "</BufetInfoPkID><BufetInfoName>" + BufetInfoName + "</BufetInfoName></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_ItemBufetInfo_UPD", XML).Tables[0];
                return dt.Rows[0]["BufetInfoPkID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string DeleteBuffetInfo(string BufetInfoPkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><BufetInfoPkID>" + BufetInfoPkID + "</BufetInfoPkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spres_ItemBufetInfo_DEL", XML);
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        public class OrderTypeInfo
        {
            public string OrderTypePkID { get; set; }
            public string OrderTypeName { get; set; }
        }

        [WebMethod]
        public static OrderTypeInfo GetOrderTypeInfo(string OrderTypePkID)
        {
            OrderTypeInfo Roles = new OrderTypeInfo();
            string XML = "<NewDataSet><BusinessObject><OrderTypePkID>" + OrderTypePkID + "</OrderTypePkID></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_OrderTypeInfo_GET", XML).Tables[0];

            Roles.OrderTypePkID = dt.Rows[0]["OrderTypePkID"].ToString();
            Roles.OrderTypeName = dt.Rows[0]["OrderTypeName"].ToString();

            return Roles;
        }

        [WebMethod]
        public static string PostOrderTypeInfo(string Adding, string OrderTypePkID, string OrderTypeName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><OrderTypePkID>" + OrderTypePkID + "</OrderTypePkID><OrderTypeName>" + OrderTypeName + "</OrderTypeName></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_OrderTypeInfo_UPD", XML).Tables[0];
                return dt.Rows[0]["OrderTypePkID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string DeleteOrderTypeInfo(string OrderTypePkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><OrderTypePkID>" + OrderTypePkID + "</OrderTypePkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spres_OrderTypeInfo_DEL", XML);
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        public class CategroyInfo
        {
            public string CategoryPkID { get; set; }
            public string CategoryName { get; set; }

            public string RestaurantPkID { get; set; }
        }

        [WebMethod]
        public static CategroyInfo GetCategroyInfo(string CategoryPkID)
        {
            CategroyInfo Roles = new CategroyInfo();
            string XML = "<NewDataSet><BusinessObject><CategoryPkID>" + CategoryPkID + "</CategoryPkID></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantCategory_GET", XML).Tables[0];

            Roles.RestaurantPkID = dt.Rows[0]["RestaurantPkID"].ToString();
            Roles.CategoryPkID = dt.Rows[0]["CategoryPkID"].ToString();
            Roles.CategoryName = dt.Rows[0]["CategoryName"].ToString();

            return Roles;
        }

        [WebMethod]
        public static string PostCategoryInfo(string Adding, string CategoryPkID, string CategoryName, string RestaurantPkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><CategoryPkID>" + CategoryPkID + "</CategoryPkID><CategoryName>" + CategoryName + "</CategoryName><RestaurantPkID>" + RestaurantPkID + "</RestaurantPkID></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantCategory_UPD", XML).Tables[0];
                return dt.Rows[0]["CategoryPkID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string DeleteCategoryInfo(string CategoryPkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><CategoryPkID>" + CategoryPkID + "</CategoryPkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantCategory_DEL", XML);
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string PostTableInfo(string Adding, string CategoryPkID, string TablePkID, string TableID, string TableCapacity, string IsTime, string ItemPkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><CategoryPkID>" + CategoryPkID + "</CategoryPkID><TablePkID>" + TablePkID + "</TablePkID><TableID>" + TableID + "</TableID><TableCapacity>" + TableCapacity + "</TableCapacity><IsTime>" + IsTime + "</IsTime><ItemPkID>" + ItemPkID + "</ItemPkID></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantTable_UPD", XML).Tables[0];
                return dt.Rows[0]["TablePkID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }



        public class TableInfo
        {
            public string CategoryPkID { get; set; }
            public string TablePkID { get; set; }

            public string TableID { get; set; }

            public int TableCapacity { get; set; }

            public string IsTime { get; set; }
            public string ItemPkID { get; set; }

            public string RestaurantPkID { get; set; }
        }

        [WebMethod]
        public static TableInfo GetTableInfo(string TablePkID)
        {
            TableInfo Roles = new TableInfo();
            string XML = "<NewDataSet><BusinessObject><TablePkID>" + TablePkID + "</TablePkID></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantTable_GET", XML).Tables[0];

            Roles.TablePkID = dt.Rows[0]["TablePkID"].ToString();
            Roles.CategoryPkID = dt.Rows[0]["CategoryPkID"].ToString();
            Roles.TableID = dt.Rows[0]["TableID"].ToString();
            Roles.TableCapacity = (int)dt.Rows[0]["TableCapacity"];

            Roles.IsTime = dt.Rows[0]["IsTime"].ToString();
            Roles.ItemPkID = dt.Rows[0]["ItemPkID"].ToString();
            Roles.RestaurantPkID = dt.Rows[0]["RestaurantPkID"].ToString();

            return Roles;
        }

        [WebMethod]
        public static string DeleteTableInfo(string TablePkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><TablePkID>" + TablePkID + "</TablePkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantTable_DEL", XML);
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static List<ListItem> GetCategoryList(string RestaurantPkID)
        {
            List<ListItem> customers = new List<ListItem>();
            DataTable dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from resRestaurantCategory where RestaurantPkID='" + RestaurantPkID + "' ").Tables[0];
            foreach (DataRow rw in dt.Rows)
            {
                customers.Add(new ListItem
                {
                    Value = rw["CategoryPkID"].ToString(),
                    Text = rw["CategoryName"].ToString()
                });
            }
            //var jsonSerialiser = new JavaScriptSerializer();
            //var json = jsonSerialiser.Serialize(customers);
            return customers;
        }

        [WebMethod]
        public static string PostMenuInfo(string Adding, string RestaurantMenuPkID, string RestaurantPkID, string MenuName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><RestaurantMenuPkID>" + RestaurantMenuPkID + "</RestaurantMenuPkID><RestaurantPkID>" + RestaurantPkID + "</RestaurantPkID><MenuName>" + MenuName + "</MenuName></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantMenu_UPD", XML).Tables[0];
                return dt.Rows[0]["RestaurantMenuPkID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        public class MenuInfo
        {
            public string RestaurantMenuPkID { get; set; }
            public string RestaurantPkID { get; set; }

            public string MenuName { get; set; }

            public string MenuImageFile { get; set; }
        }

        [WebMethod]
        public static MenuInfo GetMenuInfo(string RestaurantMenuPkID)
        {
            MenuInfo Roles = new MenuInfo();
            string XML = "<NewDataSet><BusinessObject><RestaurantMenuPkID>" + RestaurantMenuPkID + "</RestaurantMenuPkID></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantMenu_GET", XML).Tables[0];

            Roles.RestaurantMenuPkID = dt.Rows[0]["RestaurantMenuPkID"].ToString();
            Roles.RestaurantPkID = dt.Rows[0]["RestaurantPkID"].ToString();
            Roles.MenuName = dt.Rows[0]["MenuName"].ToString();
            Roles.MenuImageFile = dt.Rows[0]["MenuImageFile"].ToString();
            return Roles;
        }

        [WebMethod]
        public static string DeleteMenuInfo(string RestaurantMenuPkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><RestaurantMenuPkID>" + RestaurantMenuPkID + "</RestaurantMenuPkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantMenu_DEL", XML);
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        public class UnitInfo
        {
            public string UnitID { get; set; }
            public string UnitName { get; set; }
        }

        [WebMethod]
        public static UnitInfo GetUnitInfo(string UnitID)
        {
            UnitInfo Roles = new UnitInfo();
            string XML = "<NewDataSet><BusinessObject><UnitID>" + UnitID + "</UnitID></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spinv_UnitInfo_GET", XML).Tables[0];

            Roles.UnitID = dt.Rows[0]["UnitID"].ToString();
            Roles.UnitName = dt.Rows[0]["UnitName"].ToString();

            return Roles;
        }

        [WebMethod]
        public static string PostUnitInfo(string Adding, string UnitID, string UnitName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + Adding + "</Adding><UnitID>" + UnitID + "</UnitID><UnitName>" + UnitName + "</UnitName></BusinessObject></NewDataSet>";
                DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spinv_UnitInfo_UPD", XML).Tables[0];
                return dt.Rows[0]["UnitID"].ToString();
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string DeleteUnitInfo(string UnitID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><UnitID>" + UnitID + "</UnitID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spinv_UnitInfo_DEL", XML);
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static List<ListItem> GetVatList(string TaxTypeID)
        {
            List<ListItem> customers = new List<ListItem>();
            DataTable dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from invVATExemptionInfo where TaxTypeID='" + TaxTypeID + "'").Tables[0];
            foreach (DataRow rw in dt.Rows)
            {
                customers.Add(new ListItem
                {
                    Value = rw["VATEInfoID"].ToString(),
                    Text = rw["VATEInfoName"].ToString()
                });
            }
            //var jsonSerialiser = new JavaScriptSerializer();
            //var json = jsonSerialiser.Serialize(customers);
            return customers;
        }

        [WebMethod]
        public static string DeleteItemInfo(string ItemPkID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><ItemPkID>" + ItemPkID + "</ItemPkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spres_ItemInfo_DEL", XML);
                return "Амжилттай устгалаа";
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
        public static bool SaveHTLRoomGroupInfo(int type, string id, string name)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomGroupInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHTLRoomGroupInfo(string id)
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
        public static bool SaveSeasonInfo(int type, string id, string name, int start, int finish, string mstr)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name><start>" + start + "</start><finish>" + finish + "</finish><mstr>" + mstr + "</mstr></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_SeasonInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteSeasonInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_SeasonInfo_DEL", XML);
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

        public class HTLRoomInfo
        {
            public string RoomPkID { get; set; }
            public string GroupPkID { get; set; }
            public string RoomTypePkID { get; set; }
            public int RoomBedSpace { get; set; }
            public int RoomNumber { get; set; }
            public int RoomFloor { get; set; }
            public string RoomPhone { get; set; }
            public string RoomDescr { get; set; }
            public string IsMiniBar { get; set; }
            public string MiniBarTypeInfoPkID { get; set; }
            public string FactionInfoPkID { get; set; }
            public int GuestSpace { get; set; }
        }

        [WebMethod]
        public static HTLRoomInfo GetRoomInfo(string id)
        {
            try
            {
                HTLRoomInfo room = new HTLRoomInfo();

                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                DataTable dtRoomInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_RoomInfoGET_SEL", XML).Tables[0];

                room.RoomPkID = dtRoomInfo.Rows[0]["RoomPkID"].ToString();
                room.GroupPkID = dtRoomInfo.Rows[0]["GroupPkID"].ToString();
                room.RoomTypePkID = dtRoomInfo.Rows[0]["RoomTypePkID"].ToString();
                room.RoomBedSpace = Convert.ToInt32(dtRoomInfo.Rows[0]["RoomBedSpace"]);
                room.RoomNumber = Convert.ToInt32(dtRoomInfo.Rows[0]["RoomNumber"]);
                room.RoomFloor = Convert.ToInt32(dtRoomInfo.Rows[0]["RoomFloor"]);
                room.RoomPhone = dtRoomInfo.Rows[0]["RoomPhone"].ToString();
                room.RoomDescr = dtRoomInfo.Rows[0]["RoomDescr"].ToString();
                room.IsMiniBar = dtRoomInfo.Rows[0]["IsMiniBar"].ToString();
                room.MiniBarTypeInfoPkID = dtRoomInfo.Rows[0]["MiniBarTypeInfoPkID"].ToString();
                room.FactionInfoPkID = dtRoomInfo.Rows[0]["FactionInfoPkID"].ToString();
                room.GuestSpace = Convert.ToInt32(dtRoomInfo.Rows[0]["GuestSpace"]);
                return room;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public class ResRestaurantInfo
        {
            public string RestaurantPkID { get; set; }
            public string RestaurantName { get; set; }
            public string HeaderText { get; set; }
            public string FooterText { get; set; }
            public int Tax { get; set; }
            public int CityTax { get; set; }
            public int ServiceChargeTax { get; set; }
        }

        [WebMethod]
        public static ResRestaurantInfo GetRestaurantInfo(string id)
        {
            try
            {
                ResRestaurantInfo rest = new ResRestaurantInfo();

                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                DataTable dtRoomInfo = SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantInfoGET_SEL", XML).Tables[0];

                rest.RestaurantPkID = dtRoomInfo.Rows[0]["RestaurantPkID"].ToString();
                rest.RestaurantName = dtRoomInfo.Rows[0]["RestaurantName"].ToString();
                rest.HeaderText = dtRoomInfo.Rows[0]["HeaderText"].ToString();
                rest.FooterText = dtRoomInfo.Rows[0]["FooterText"].ToString();
                rest.Tax = Convert.ToInt32(dtRoomInfo.Rows[0]["Tax"]);
                rest.CityTax = Convert.ToInt32(dtRoomInfo.Rows[0]["CityTax"]);
                rest.ServiceChargeTax = Convert.ToInt32(dtRoomInfo.Rows[0]["ServiceChargeTax"]);
                return rest;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [WebMethod]
        public static bool SaveHRMYearInfo(int adding, string id, string Year1, int Year2)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><YearPkID>" + id + "</YearPkID><Year1>" + Year1 + "</Year1><Year2>" + Year2 + "</Year2></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_Year_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHRMYearInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><YearPkID>" + id + "</YearPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_Year_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveHRMeventinfo(int adding, string id, string eventinfo)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><EventInfoPkID>" + id + "</EventInfoPkID><EventInfoName>" + eventinfo + "</EventInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_EventInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHRMeventinfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><EventInfoPkID>" + id + "</EventInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_EventInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMLocationCodeInfo(int adding, string id, string LocationCodeName, string IsEnabled)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><LocationCodePkID>" + id + "</LocationCodePkID><LocationCodeName>" + LocationCodeName + "</LocationCodeName><IsEnabled>" + IsEnabled + "</IsEnabled></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_LocationCodeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHRMLocationCodeInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><LocationCodePkID>" + id + "</LocationCodePkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_LocationCodeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMPositionGroup(int adding, string id, string PositionGroupName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><PositionGroupPkID>" + id + "</PositionGroupPkID><PositionGroupName>" + PositionGroupName + "</PositionGroupName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_PositionGroup_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMPositionGroup(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><PositionGroupPkID>" + id + "</PositionGroupPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_PositionGroup_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMPositionInfo(int adding, string id, string PositionName )
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><PositionPkID>" + id + "</PositionPkID><PositionName>" + PositionName + "</PositionName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_PositionInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMPositionInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><PositionPkID>" + id + "</PositionPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_PositionInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMProfessionInfo(int adding, string id, string ProfessionName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><ProfessionPkID>" + id + "</ProfessionPkID><ProfessionName>" + ProfessionName + "</ProfessionName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ProfessionInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMProfessionInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><ProfessionPkID>" + id + "</ProfessionPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ProgramInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMEducationInfo(int adding, string id, string EducationName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><EducationPkID>" + id + "</EducationPkID><EducationName>" + EducationName + "</EducationName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_EducationInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMEducationInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><EducationPkID>" + id + "</EducationPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_EducationInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMDegreeInfo(int adding, string id, string DegreeInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><DegreeInfoPkID>" + id + "</DegreeInfoPkID><DegreeInfoName>" + DegreeInfoName + "</DegreeInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_DegreeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMDegreeInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><DegreeInfoPkID>" + id + "</DegreeInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_DegreeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMAwardTypeInfo(int adding, string id, string AwardTypeInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><AwardTypeInfoPkID>" + id + "</AwardTypeInfoPkID><AwardTypeInfoName>" + AwardTypeInfoName + "</AwardTypeInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_AwardTypeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMAwardTypeInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><AwardTypeInfoPkID>" + id + "</AwardTypeInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_AwardTypeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMAdvertenceTypeInfo(int adding, string id, string AdvertenceTypeName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><AdvertenceTypeInfoPkID>" + id + "</AdvertenceTypeInfoPkID><AdvertenceTypeName>" + AdvertenceTypeName + "</AdvertenceTypeName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_AdvertenceTypeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMAdvertenceTypeInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><AdvertenceTypeInfoPkID>" + id + "</AdvertenceTypeInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_AdvertenceTypeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMAdvertenceInfo(int adding, string id, string AdvertenceName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><AdvertenceInfoPkID>" + id + "</AdvertenceInfoPkID><AdvertenceName>" + AdvertenceName + "</AdvertenceName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_AdvertenceInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMAdvertenceInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><AdvertenceInfoPkID>" + id + "</AdvertenceInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_AdvertenceInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMDegree(int adding, string id, string emppkid, string degpkid, string subject, string date)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><DegreePkID>" + id + "</DegreePkID><EmployeeInfoPkID>" + emppkid + "</EmployeeInfoPkID><DegreeInfoPkID>" + degpkid + "</DegreeInfoPkID><DegreeSubject>" + subject + "</DegreeSubject><DegreeDate>" + date + "</DegreeDate></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_Degree_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMDegree(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><DegreePkID>" + id + "</DegreePkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_Degree_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMBreachInfo(int adding, string id, string BreachName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><BreachPkID>" + id + "</BreachPkID><BreachName>" + BreachName + "</BreachName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_BreachInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMBreachInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><BreachPkID>" + id + "</BreachPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_BreachInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMLanguageInfo(int adding, string id, string LanguageName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><LanguagePkID>" + id + "</LanguagePkID><LanguageName>" + LanguageName + "</LanguageName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_LanguageInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMLanguageInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><LanguagePkID>" + id + "</LanguagePkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_LanguageInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMSkillTypeInfo(int adding, string id, string SkillTypeName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><SkillTypePkID>" + id + "</SkillTypePkID><SkillTypeName>" + SkillTypeName + "</SkillTypeName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_SkillTypeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMSkillTypeInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><SkillTypePkID>" + id + "</SkillTypePkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_SkillTypeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMDeduceInfo(int adding, string id, string DeduceInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><DeduceInfoPkID>" + id + "</DeduceInfoPkID><DeduceInfoName>" + DeduceInfoName + "</DeduceInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_DeduceInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMDeduceInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><DeduceInfoPkID>" + id + "</DeduceInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_DeduceInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMFamilyMemberInfo(int adding, string id, string FamilyMemberName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><FamilyMemberPkID>" + id + "</FamilyMemberPkID><FamilyMemberName>" + FamilyMemberName + "</FamilyMemberName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_FamilyMemberInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMFamilymemberInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><FamilyMemberPkID>" + id + "</FamilyMemberPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_FamilyMemberInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMExperienceInfo(int adding, string id, string ExperienceInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><ExperienceInfoPkID>" + id + "</ExperienceInfoPkID><ExperienceInfoName>" + ExperienceInfoName + "</ExperienceInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ExperienceInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMExperienceInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><ExperienceInfoPkID>" + id + "</ExperienceInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ExperienceInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMExtraRequirementInfo(int adding, string id, string ExtraRequirementName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><ExtraRequirementPkID>" + id + "</ExtraRequirementPkID><ExtraRequirementName>" + ExtraRequirementName + "</ExtraRequirementName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ExtraRequirement_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMExtraRequirementInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><ExtraRequirementPkID>" + id + "</ExtraRequirementPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ExtraRequirement_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMOfficeToolsInfo(int adding, string id, string OfficeToolsInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><OfficeToolsInfoPkID>" + id + "</OfficeToolsInfoPkID><OfficeToolsInfoName>" + OfficeToolsInfoName + "</OfficeToolsInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_OfficeToolsInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMOfficeToolsInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><OfficeToolsInfoPkID>" + id + "</OfficeToolsInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_OfficeToolsInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMExpertInfo(int adding, string id, string ExpertInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><ExpertInfoPkID>" + id + "</ExpertInfoPkID><ExpertInfoName>" + ExpertInfoName + "</ExpertInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ExpertInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMExpertInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><ExpertInfoPkID>" + id + "</ExpertInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ExpertInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMResponseInfo(int adding, string id, string ResponseInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><ResponseInfoPkID>" + id + "</ResponseInfoPkID><ResponseInfoName>" + ResponseInfoName + "</ResponseInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ResponseInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMResponseInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><ResponseInfoPkID>" + id + "</ResponseInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_ResponseInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMDocumentInfo(int adding, string id, string DocumentInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><DocumentInfoPkID>" + id + "</DocumentInfoPkID><DocumentInfoName>" + DocumentInfoName + "</DocumentInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_DocumentInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMDocumentInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><DocumentInfoPkID>" + id + "</DocumentInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_DocumentInfo_DEL", XML);
            }
            catch (Exception )
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMJobFugureInfo(int adding, string id, string JobFugureInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><JobFugureInfoPkID>" + id + "</JobFugureInfoPkID><JobFugureInfoName>" + JobFugureInfoName + "</JobFugureInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_JobFugureInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMJobFugureInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><JobFugureInfoPkID>" + id + "</JobFugureInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_JobFugureInfo_DEL", XML);
            }
            catch (Exception)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool SaveHRMJobTimeTableInfo(int adding, string id, string JobTimeTableInfoName)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + adding + "</Adding><JobTimeTableInfoPkID>" + id + "</JobTimeTableInfoPkID><JobTimeTableInfoName>" + JobTimeTableInfoName + "</JobTimeTableInfoName></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_JobTimeTableInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        [WebMethod]
        public static bool DeleteHRMJobTimeTableInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><JobTimeTableInfoPkID>" + id + "</JobTimeTableInfoPkID></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphrm_JobTimeTableInfo_DEL", XML);
            }
            catch (Exception)
            {
                return false;
            }
        }
     

        [WebMethod]
        public static bool SaveHTLServiceInfo(int type, string id, string name, string description, string ischange)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name><description>" + description + "</description><ischange>" + ischange + "</ischange></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_ServiceInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHTLServiceInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_ServiceInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static string SaveACCCurrencyInfo(int type, string id, string name, string ismain)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><Adding>" + type + "</Adding><CurrencyID>" + id + "</CurrencyID><CurrencyName>" + name + "</CurrencyName><IsMainCurrency>" + ismain + "</IsMainCurrency><CreatedProgID>HTL</CreatedProgID><CreatedDate>"+DateTime.Now.ToString()+ "</CreatedDate><LastUpdate>" + DateTime.Now.ToString() + "</LastUpdate><IPAddress></IPAddress><LastUserName></LastUserName><MACAddress></MACAddress></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spacc_CurrencyInfo_UPD", XML);
                return "Амжилттай";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        [WebMethod]
        public static string DeleteACCCurrencyInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><CurrencyID>" + id + "</CurrencyID><ProgID>HTL</ProgID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteQuery("spacc_CurrencyInfo_DEL", XML);
                return "Амжилттай";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        [WebMethod]
        public static bool SaveHTLGuestInfo(int type, string id, string name, string currency)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name><currencyid>" + currency + "</currencyid></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_GuestTypeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHTLGuestInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_GuestTypeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public class ServiceDetailInfo
        {
            public string ServiceInfoPkID { get; set; }
            public string ServiceDetailInfoPkID { get; set; }
            public string GuestTypeID { get; set; }
            public string CurrencyID { get; set; }
            public decimal ServicePrice { get; set; }
        }

        [WebMethod]
        public static ServiceDetailInfo GetHTLServiceDetailInfo(string id)
        {
            try
            {
                ServiceDetailInfo srv = new ServiceDetailInfo();

                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                DataTable dtRoomInfo = SystemGlobals.DataBase.ExecuteQuery("sphtl_ServiceDetailInfo_SEL", XML).Tables[0];

                srv.ServiceInfoPkID = dtRoomInfo.Rows[0]["ServiceInfoPkID"].ToString();
                srv.ServiceDetailInfoPkID = dtRoomInfo.Rows[0]["ServiceDetailInfoPkID"].ToString();
                srv.GuestTypeID = dtRoomInfo.Rows[0]["GuestTypeID"].ToString();
                srv.CurrencyID = dtRoomInfo.Rows[0]["CurrencyID"].ToString();
                srv.ServicePrice = Convert.ToDecimal(dtRoomInfo.Rows[0]["ServicePrice"]);
                return srv;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [WebMethod]
        public static string GetHTLServiceDetailCustomer(string id)
        {
            try
            {
                return SystemGlobals.DataBase.ExecuteSQL("select CurrencyID from htlGuestTypeInfo where GuestTypeID = N'" + id + "'").Tables[0].Rows[0][0].ToString();
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [WebMethod]
        public static bool SaveHTLServiceDetailInfo(int type, string id, string service, string guest, string currency, decimal price)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><service>" + service + "</service><guest>" + guest + "</guest><currency>" + currency + "</currency><price>" + price + "</price></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_ServiceDetailInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHTLServiceDetailInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_ServiceDetailInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveHTLLifeTimeInfo(int type, string id, string name, int dayst, int dayfn, int timest, int timefn)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><type>" + type + "</type><id>" + id + "</id><name>" + name + "</name><dayst>" + dayst + "</dayst><dayfn>" + dayfn + "</dayfn><timest>" + timest + "</timest><timefn>" + timefn + "</timefn></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_LifeTimeInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHTLLifeTimeInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_LifeTimeInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool SaveHTLRoomPriceInfo(string passvalue)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><passvalue>" + passvalue + "</passvalue></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomPriceInfo_UPD", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        [WebMethod]
        public static bool DeleteHTLRoomPriceInfo(string id)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><id>" + id + "</id></BusinessObject></NewDataSet>";
                return SystemGlobals.DataBase.ExecuteNonQuery("", "sphtl_RoomPriceInfo_DEL", XML);
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        

        [WebMethod]
        public static List<ListItem> GetProgUserGroup(string ProgID)
        {
            List<ListItem> customers = new List<ListItem>();
            DataTable dt = SystemGlobals.DataBase.ExecuteSQL(@"select * from smmUserGroup where ProgID='" + ProgID + "' ").Tables[0];
            foreach (DataRow rw in dt.Rows)
            {
                customers.Add(new ListItem
                {
                    Value = rw["UserGroupID"].ToString(),
                    Text = rw["UserGroupName"].ToString()
                });
            }
            //var jsonSerialiser = new JavaScriptSerializer();
            //var json = jsonSerialiser.Serialize(customers);
            return customers;
        }

        [WebMethod]
        public static string GetProgramDetailList(string UserPkID)
        {
            try
            {
                string innerHTML = "";              
                DataTable dtRoomInfo = SystemGlobals.DataBase.ExecuteSQL(@"select A.*,B.ValueStr1 ProgName,UG.UserGroupName from smmUserProgInfo A
                                                                            inner join (select * from smmConstants where ConstType='smmProg') B on A.ModuleID=B.ConstKey
                                                                            inner join smmUserGroup UG on A.UserGroupID = UG.UserGroupID and A.ModuleID = UG.ProgID where A.UserPkID='" + UserPkID+"'").Tables[0];
                foreach (DataRow rw in dtRoomInfo.Rows)
                {
                    innerHTML = innerHTML + "<tr class='odd'><td>"+rw["ProgName"].ToString()+"</td><td>"+rw["UserGroupName"].ToString()+ "</td><td><button type='button' id='deleteRowProgram' data-id='" + rw["UserPkID"].ToString()+","+rw["ModuleID"].ToString()+ "' class='btn btn-rounded btn-danger deleteRowProgram' onclick='deleteProgram(this);'>Устгах</button></td></td></tr>";
                }
                return innerHTML;
            }
            catch (Exception ex)
            {
                return "Дараахи алдаа гарсан байна:"+ex.Message.ToString();
            }
        }

        [WebMethod]
        public static string DeleteProgramDetail(string UserPkID,string ProgID)
        {
            try
            {
                string XML = "<NewDataSet><BusinessObject><UserPkID>" + UserPkID + "</UserPkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteSQL("delete from smmUserProgInfo where UserPkID='"+UserPkID+"' and ModuleID='"+ProgID+"'");
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string PostProgramDetail(string Adding, string UserPkID, string UserGroupID, string ProgID)
        {
            try
            {               
                SystemGlobals.DataBase.ExecuteSQL("insert into smmUserProgInfo(UserPkID,ModuleID,UserGroupID) values(N'"+UserPkID+"',N'"+ProgID+"',N'"+UserGroupID+"')");
                return "Амжилттай хадгаллаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

        [WebMethod]
        public static string DeleteUserGroupInfo(string UserGroupID)
        {
            try
            {
               // string XML = "<NewDataSet><BusinessObject><UserPkID>" + UserPkID + "</UserPkID></BusinessObject></NewDataSet>";
                SystemGlobals.DataBase.ExecuteSQL("delete from smmUserGroup where UserGroupID='" + UserGroupID + "'");
                return "Амжилттай устгалаа";
            }
            catch (Exception ex)
            {
                return "Алдаа гарлаа:" + ex.ToString();
            }
        }

    }
}