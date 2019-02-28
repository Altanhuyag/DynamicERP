<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="usergroup_new.aspx.cs" Inherits="Dynamic.usergroup_newSMM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="main--content">   
        <div class="row gutter-20">
    <div class="col-md-12">
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Хэрэглэгчийн эрхийн тохиргоо</h3> </div>
            <div class="panel-content">
                <div class="form-group">
                    <label> <span class="label-text">Эрхийн нэр</span>
                                                    <asp:TextBox ID="txtUserGroupName" runat="server" class="form-control  txtUserGroupName" required></asp:TextBox>
                            <input id="UserGroupID" value="<% if (Request.QueryString["uId"] != null) Response.Write(Request.QueryString["uId"].ToString()); %>" type="hidden" />

                </div>
                <div class="form-group">
                    <label> <span class="label-text">Ажиллах програм</span>
                        <asp:DropDownList ID="cmbProgID" CssClass="form-control cmbProgID" runat="server"></asp:DropDownList>
                </div>

                <table class="table table-bordered table-striped" id="myTable">
        <thead>
            <tr>
                <th style="width:60px;">Цэсний дугаар</th>
                <th>Цэс</th>
                <th style="text-align:center"><input id="chkSelectAll" type="checkbox" class="chkSelectAll" />Харах</th>
                <th style="text-align:center"><input id="chkInsertAll" type="checkbox" class="chkInsertAll" />Нэмэх</th>
                <th style="text-align:center"><input id="chkEditAll" type="checkbox" class="chkEditAll" />Засах</th>
                <th style="text-align:center"><input id="chkDeleteAll" type="checkbox" class="chkDeleteAll" />Устгах</th>
            </tr>
        </thead>
        <tbody>
            <% 
                System.Data.DataTable dt = Dynamic.Models.SystemGlobals.DataBase.ExecuteSQL("select * from smmWebMenuInfo where CreatedModuleID='"+cmbProgID.SelectedValue.ToString()+"' and Len(MenuInfoCode)=2").Tables[0];
                foreach (System.Data.DataRow rw in dt.Rows)
                {
                            %>
                    <tr>
                        <td style="font-weight:bold"><% Response.Write(rw["MenuInfoCode"].ToString()); %></td>
                        <td style="font-weight:bold"><% Response.Write(rw["MenuInfoName"].ToString()); %></td>
                        <td style="text-align:center">
                            <input id="chkSelect_<% Response.Write(rw["MenuInfoCode"].ToString()); %>" name="chkSelect[]" type="checkbox" class="chkSelect" />
                            </td>
                        <td style="text-align:center"><input id="chkInsert_<% Response.Write(rw["MenuInfoCode"].ToString()); %>" name="chkInsert[]" type="checkbox" class="chkInsert" /></td>
                        <td style="text-align:center"><input id="chkEdit_<% Response.Write(rw["MenuInfoCode"].ToString()); %>" name="chkEdit[]" type="checkbox" class="chkEdit" /></td>
                        <td style="text-align:center"><input id="chkDelete_<% Response.Write(rw["MenuInfoCode"].ToString()); %>" name="chkDelete[]" type="checkbox" class="chkDelete" /></td>
                   
            </tr>
           <% System.Data.DataTable dts = Dynamic.Models.SystemGlobals.DataBase.ExecuteSQL("select * from smmWebMenuInfo where CreatedModuleID='"+cmbProgID.SelectedValue.ToString()+"' and MenuInfoCode like '"+rw["MenuInfoCode"].ToString()+"%' and len(MenuInfoCode)>2").Tables[0];
            foreach (System.Data.DataRow rws in dts.Rows)
            {
                %>
            <tr>
                        <td><% Response.Write(rws["MenuInfoCode"].ToString()); %></td>
                        <td><% Response.Write(rws["MenuInfoName"].ToString()); %></td>
                        <td style="text-align:center">
                            <input id="chkSelect1_<% Response.Write(rws["MenuInfoCode"].ToString()); %>" name="chkSelect1[]" type="checkbox" class="chkSelect" /></td>
                        <td style="text-align:center"><input id="chkInsert1_<% Response.Write(rws["MenuInfoCode"].ToString()); %>" name="chkInsert1[]" type="checkbox" class="chkInsert" /></td>
                        <td style="text-align:center"><input id="chkEdit1_<% Response.Write(rws["MenuInfoCode"].ToString()); %>" name="chkEdit1[]" type="checkbox" class="chkEdit" /></td>
                        <td style="text-align:center"><input id="chkDelete1_<% Response.Write(rws["MenuInfoCode"].ToString()); %>" name="chkDelete1[]" type="checkbox" class="chkDelete" /></td>
                   
            </tr>
            <%
            }
             %>
             

            <%
                } %>
            
            
        </tbody>
    </table>
                 <div class="form-group">                        
                        <div class="col-sm-10">
                            <asp:Label ID="Label1" CssClass="Label1" runat="server" Text=""></asp:Label>    
                        </div>                        
                    </div>
                <input type="button" onclick="SaveForm();" value="Хадгалах" class="btn btn-sm btn-rounded btn-success">
                <button type="button"  class="btn btn-sm btn-rounded btn-outline-secondary">Гарах</button>
            </div>
        </div>
    </div>
        
    
    
</div>
        
    
</section>
    
       <script src="vendor/iCheck/icheck.min.js"></script>
    <script type="text/javascript">

        function SaveForm() {
            var txtUserGroupName = $(".txtUserGroupName").val();
            var Adding = 0;
            var UserGroupID = $("#UserGroupID").val();
            var ProgID = $(".cmbProgID").val();
            if (UserGroupID != "")
                Adding = 1;

            if (txtUserGroupName == "") {
                $(".Label1").text("Та заавал нэрийг оруулах ёстой.");
                return;
            }

            var CheckListSelect = "";
            var CheckListInsert = "";
            var CheckListEdit = "";
            var CheckListDelete = "";

            $('.chkSelect').each(function () {
                var subMenu = $(this).attr('id').split('_')[1];


                if ($("#chkSelect_" + subMenu).is(":checked") == true)
                {
                    CheckListSelect = CheckListSelect + subMenu + ",";
                }

                if ($("#chkSelect1_" + subMenu).is(":checked") == true) {
                    CheckListSelect = CheckListSelect + subMenu + ",";
                }
            });

            $('.chkInsert').each(function () {
                var subMenu = $(this).attr('id').split('_')[1];


                if ($("#chkInsert_" + subMenu).is(":checked") == true) {
                    CheckListInsert = CheckListInsert + subMenu + ",";
                }

                if ($("#chkInsert1_" + subMenu).is(":checked") == true) {
                    CheckListInsert = CheckListInsert + subMenu + ",";
                }
            });

            $('.chkEdit').each(function () {
                var subMenu = $(this).attr('id').split('_')[1];


                if ($("#chkEdit_" + subMenu).is(":checked") == true) {
                    CheckListEdit = CheckListEdit + subMenu + ",";
                }

                if ($("#chkEdit1_" + subMenu).is(":checked") == true) {
                    CheckListEdit = CheckListEdit + subMenu + ",";
                }
            });

            $('.chkDelete').each(function () {
                var subMenu = $(this).attr('id').split('_')[1];


                if ($("#chkDelete_" + subMenu).is(":checked") == true) {
                    CheckListDelete = CheckListDelete + subMenu + ",";
                }

                if ($("#chkDelete1_" + subMenu).is(":checked") == true) {
                    CheckListDelete = CheckListDelete + subMenu + ",";
                }
            });

            if (CheckListSelect == "" && CheckListInsert=="" && CheckListEdit=="" && CheckListDelete=="")
            {
                alert("Та заавал цэснээс сонголт хийх ёстой гэдгийг анхаарна уу");
                return;
            }

            $.ajax({
                url: '../post.aspx/PostUserGroupInfo',
                type: 'POST',
                data: JSON.stringify({
                    Adding: Adding,
                    UserGroupID: UserGroupID,
                    UserGroupName: txtUserGroupName,
                    ProgID, ProgID,
                    CheckListSelect: CheckListSelect,
                    CheckListInsert: CheckListInsert,
                    CheckListEdit: CheckListEdit,
                    CheckListDelete:CheckListDelete,
                }),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (msg) {
                    if (msg.d.indexOf("Алдаа") == -1) {
                        alert("Амжилттай хадгаллаа");
                        window.location = "usergroup.aspx";
                    }
                    else
                        $(".Label1").text(msg.d);
                }
            });
        }
        $(document).ready(function () {

            if ($('#UserGroupID').val() != "")
            {
                var txtID = $('#UserGroupID').val();
                
                $.ajax({
                    url: '../post.aspx/GetUserGroupInfo',
                    type: 'POST',
                    data: JSON.stringify({
                        UserGroupID: txtID
                    }),
                    dataType: 'json',
                    contentType: 'application/json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (response) {
                        var msg = response.d;
                        // Populate the form fields with the data returned from server
                        $.each(msg, function () {
                            if (this.IsSelect == "Y")
                            {
                                $("#chkSelect_" + this.MenuInfoID).prop("checked", true);
                                $("#chkSelect1_" + this.MenuInfoID).prop("checked", true);
                            }

                            if (this.IsInsert == "Y") {
                                $("#chkInsert_" + this.MenuInfoID).prop("checked", true);
                                $("#chkInsert1_" + this.MenuInfoID).prop("checked", true);
                            }

                            if (this.IsUpdate == "Y") {
                                $("#chkEdit_" + this.MenuInfoID).prop("checked", true);
                                $("#chkEdit1_" + this.MenuInfoID).prop("checked", true);
                            }

                            if (this.IsDelete == "Y") {
                                $("#chkDelete_" + this.MenuInfoID).prop("checked", true);
                                $("#chkDelete1_" + this.MenuInfoID).prop("checked", true);
                            }
                        });
                    }
                })
            }

            $('#chkSelectAll').click(function () {
                if ($(this).is(':checked') == true)
                    $(".chkSelect").prop("checked", true);
                else
                    $(".chkSelect").removeAttr("checked");
            });

            $('#chkInsertAll').click(function () {
                if ($(this).is(':checked') == true)
                    $(".chkInsert").prop("checked", true);
                else
                    $(".chkInsert").removeAttr("checked");
            });

            $('#chkEditAll').click(function () {
                if ($(this).is(':checked') == true)
                    $(".chkEdit").prop("checked", true);
                else
                    $(".chkEdit").removeAttr("checked");
            });

            $('#chkDeleteAll').click(function () {
                if ($(this).is(':checked') == true)
                    $(".chkDelete").prop("checked", true);
                else
                    $(".chkDelete").removeAttr("checked");
            });

            $('.chkSelect').click(function () {
                
                var number = $(this).attr('id').split('_')[1];
                
                if (number.length > 2) {
                    $("#chkSelect_" + number.substring(0, 2)).prop("checked", true);
                }
                $('.chkSelect').each(function () {
                    var subMenu = $(this).attr('id').split('_')[1];
                  
                    if (subMenu.substring(0, 2) == number) {
                        if ($("#chkSelect_" + number).is(":checked") == true) {
                            $("#chkSelect1_" + subMenu).prop("checked", true);
                            $("#chkSelect_" + number.substring(0,2)).prop("checked", true);
                        }
                        else
                        {
                                $("#chkSelect1_" + subMenu).removeAttr("checked");
                        }

                    }
                });
                $('.chkSelect').each(function () {
                    var subMenu = $(this).attr('id').split('_')[1];
                    
                    if ($("#chkSelect_" + subMenu.substring(0,2)).is(":checked") == true)
                    {
                        var i=0;
                        $('.chkSelect').each(function () {
                            var number = $(this).attr('id').split('_')[1];
                            if (number.length > 2 && number.substring(0, 2) == subMenu.substring(0, 2) && $("#chkSelect1_" + number).is(":checked") == true)
                                i = i + 1;
                        });
                        if (i == 0)
                        {
                            $("#chkSelect_" + subMenu.substring(0, 2)).removeAttr("checked");
                        }
                    }
                   
                });
            });

            $('.chkInsert').click(function () {

                var number = $(this).attr('id').split('_')[1];

                if (number.length > 2) {
                    $("#chkInsert_" + number.substring(0, 2)).prop("checked", true);
                }
                $('.chkInsert').each(function () {
                    var subMenu = $(this).attr('id').split('_')[1];

                    if (subMenu.substring(0, 2) == number) {
                        if ($("#chkInsert_" + number).is(":checked") == true) {
                            $("#chkInsert1_" + subMenu).prop("checked", true);
                            $("#chkInsert_" + number.substring(0, 2)).prop("checked", true);
                        }
                        else {
                            $("#chkInsert1_" + subMenu).removeAttr("checked");
                        }

                    }
                });
                $('.chkInsert').each(function () {
                    var subMenu = $(this).attr('id').split('_')[1];

                    if ($("#chkInsert_" + subMenu.substring(0, 2)).is(":checked") == true) {
                        var i = 0;
                        $('.chkInsert').each(function () {
                            var number = $(this).attr('id').split('_')[1];
                            if (number.length > 2 && number.substring(0, 2) == subMenu.substring(0, 2) && $("#chkInsert1_" + number).is(":checked") == true)
                                i = i + 1;
                        });
                        if (i == 0) {
                            $("#chkInsert_" + subMenu.substring(0, 2)).removeAttr("checked");
                        }
                    }

                });
            });

            $('.chkEdit').click(function () {

                var number = $(this).attr('id').split('_')[1];

                if (number.length > 2) {
                    $("#chkEdit_" + number.substring(0, 2)).prop("checked", true);
                }
                $('.chkEdit').each(function () {
                    var subMenu = $(this).attr('id').split('_')[1];

                    if (subMenu.substring(0, 2) == number) {
                        if ($("#chkEdit_" + number).is(":checked") == true) {
                            $("#chkEdit1_" + subMenu).prop("checked", true);
                            $("#chkEdit_" + number.substring(0, 2)).prop("checked", true);
                        }
                        else {
                            $("#chkEdit1_" + subMenu).removeAttr("checked");
                        }

                    }
                });
                $('.chkEdit').each(function () {
                    var subMenu = $(this).attr('id').split('_')[1];

                    if ($("#chkEdit_" + subMenu.substring(0, 2)).is(":checked") == true) {
                        var i = 0;
                        $('.chkEdit').each(function () {
                            var number = $(this).attr('id').split('_')[1];
                            if (number.length > 2 && number.substring(0, 2) == subMenu.substring(0, 2) && $("#chkEdit1_" + number).is(":checked") == true)
                                i = i + 1;
                        });
                        if (i == 0) {
                            $("#chkEdit_" + subMenu.substring(0, 2)).removeAttr("checked");
                        }
                    }

                });
            });

            $('.chkDelete').click(function () {

                var number = $(this).attr('id').split('_')[1];

                if (number.length > 2) {
                    $("#chkDelete_" + number.substring(0, 2)).prop("checked", true);
                }
                $('.chkDelete').each(function () {
                    var subMenu = $(this).attr('id').split('_')[1];

                    if (subMenu.substring(0, 2) == number) {
                        if ($("#chkDelete_" + number).is(":checked") == true) {
                            $("#chkDelete1_" + subMenu).prop("checked", true);
                            $("#chkDelete_" + number.substring(0, 2)).prop("checked", true);
                        }
                        else {
                            $("#chkDelete1_" + subMenu).removeAttr("checked");
                        }

                    }
                });
                $('.chkDelete').each(function () {
                    var subMenu = $(this).attr('id').split('_')[1];

                    if ($("#chkDelete_" + subMenu.substring(0, 2)).is(":checked") == true) {
                        var i = 0;
                        $('.chkDelete').each(function () {
                            var number = $(this).attr('id').split('_')[1];
                            if (number.length > 2 && number.substring(0, 2) == subMenu.substring(0, 2) && $("#chkDelete1_" + number).is(":checked") == true)
                                i = i + 1;
                        });
                        if (i == 0) {
                            $("#chkDelete_" + subMenu.substring(0, 2)).removeAttr("checked");
                        }
                    }

                });
            });
            
            

           
        });

    </script>
</asp:Content>
