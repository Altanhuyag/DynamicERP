using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic
{
    public partial class login : System.Web.UI.Page
    {
        public string errorMsg = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        public void GetImage(object img, string ID)
        {
            //return "data:image/jpg;base64," + Convert.ToBase64String((byte[])img);
            if (System.DBNull.Value != img)
            {
                byte[] data = (byte[])img;

                System.IO.FileStream file = System.IO.File.Create(Server.MapPath(".\\images\\" + ID + ".jpg"));

                file.Write(data, 0, data.Length);
                file.Close();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string Password = SystemGlobals.encrypt(password.Text);
            errorMsg = "";
            string XML = "<NewDataSet><BusinessObject><UserID>" + username.Text + "</UserID><Password>" + Password + "</Password></BusinessObject></NewDataSet>";
            DataTable dt = SystemGlobals.DataBase.ExecuteQuery("spsmm_UserInfo_CHECK_WEB", XML).Tables[0];
            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow rw = dt.Rows[0];

                Session["UserPkID"] = rw["UserPkID"].ToString();

                if (System.DBNull.Value == rw["EmployeeInfoPkID"])
                    Session["EmployeeInfoPkID"] = "";
                else
                    Session["EmployeeInfoPkID"] = rw["EmployeeInfoPkID"].ToString();

                Session["UserName"] = username.Text;

                Session["YearPkID"] = "";
                Session["cYear"] = "";
                XML = "<NewDataSet><BusinessObject><EmployeeInfoPkID>" + Session["EmployeeInfoPkID"].ToString() + "</EmployeeInfoPkID></BusinessObject></NewDataSet>";
                dt = SystemGlobals.DataBase.ExecuteQuery("sphrm_EmployeeInfo_GET", XML).Tables[0];
                if (dt != null && dt.Rows.Count > 0)
                {
                    Session["LastName"] = dt.Rows[0]["LastName"].ToString();
                    Session["FirstName"] = dt.Rows[0]["FirstName"].ToString();
                    Session["DepartmentName"] = dt.Rows[0]["DepartmentName"].ToString();
                    Session["DepartmentPkID"] = dt.Rows[0]["DepartmentPkID"].ToString();
                    Session["Positionname"] = dt.Rows[0]["PositionName"].ToString();
                    Session["PositionPkID"] = dt.Rows[0]["PositionPkID"].ToString();
                    Session["TotalYear"] = dt.Rows[0]["WorkedYear"].ToString();
                    Session["CompanyYear"] = (dt.Rows[0]["cYear"]).ToString() + " жил " + (dt.Rows[0]["cMonth"]).ToString() + " сар ";
                    
                    GetImage(dt.Rows[0]["ImageFile"], dt.Rows[0]["EmployeeInfoPkID"].ToString());

                    DataTable dtYear = SystemGlobals.DataBase.ExecuteSQL("select * from smmConfig where ConfigID='YearPkID'").Tables[0];
                    if (dtYear != null && dtYear.Rows.Count > 0)
                        Session["YearPkID"] = dtYear.Rows[0]["ConfigValue"].ToString();

                    dtYear = SystemGlobals.DataBase.ExecuteSQL("select * from hrmYearInfo where YearPkID='" + Session["YearPkID"] + "'").Tables[0];
                    if (dtYear != null && dtYear.Rows.Count > 0)
                        Session["cYear"] = dtYear.Rows[0]["Year1"].ToString();

                    SystemGlobals.DataBase.ExecuteSQL("update smmUserInfo set IsOnline='Y',OnlineDate=getdate() where UserPkID='" + Session["UserPkID"].ToString() + "'");
                }

                DataTable dtUser = SystemGlobals.DataBase.ExecuteSQL(@"select A.*,C.ValueStr1 as ProgName,c.ValueStr2 from smmUserProgInfo A
                inner join smmConstants c on A.ModuleID = C.ConstKey and C.ConstType = 'smmProg' where A.UserPkID='" + rw["UserPkID"].ToString() + "'").Tables[0];
                if (dtUser != null && dtUser.Rows.Count > 1)
                    Response.Redirect("module.aspx");
                else
                {
                    Session["ProgID"] = dtUser.Rows[0]["ModuleID"].ToString();

                    switch (Session["ProgID"].ToString())
                    {
                        case "INT":
                            if (Session["FirstName"] == null)
                            {
                                Response.Redirect(ResolveUrl("INT/404.html"));
                            }
                            else
                            {
                                Response.Redirect(ResolveUrl("INT/index.aspx"));
                            }
                            break;
                        case "SMM":
                            Response.Redirect(ResolveUrl("SMM/index.aspx"));
                            break;
                        default:
                            Response.Redirect(ResolveUrl("index.aspx"));
                            break;
                    }
                    
                }
            }
            else
            {
                Response.Write("<script>toastr.error('АЛДАА - ТАНЫ НЭВТРЭХ НЭР ЭСВЭЛ НУУЦ ҮГ БУРУУ БАЙНА.');</script>");
                errorMsg= "АЛДАА - ТАНЫ НЭВТРЭХ НЭР ЭСВЭЛ НУУЦ ҮГ БУРУУ БАЙНА.";
                

            }
        }
    }
}