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
    }
}