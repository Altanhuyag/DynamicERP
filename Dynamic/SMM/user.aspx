<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="Dynamic.userSMM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    

    <section class="main--content">    
        <div class="panel">
    <div class="records--header">
        <div class="title fa-shopping-bag">
            <h3 class="h3">Хэрэглэгчийн жагсаалт <a href="usergroup.aspx" class="btn btn-sm btn-outline-info">Хэрэглэгч эрх удирдах</a></h3>
            <p>Нийт <%=dtSearch.Rows.Count.ToString() %> хэрэглэгч олдлоо</p>
        </div>
        <div class="actions" style="width:100%;">                            
                <asp:TextBox ID="txtSearchText" runat="server" class="form-control" placeholder="Хайх талбар" required=""></asp:TextBox>                
                <button type="submit" id="btnSearch" runat="server" class="btn btn-rounded btn-dark" onserverclick="btnSearch_ServerClick"><i class="fa fa-search"></i></button>                       
                <a href="#myModal" class="btn btn-rounded btn-warning newButton" data-toggle="modal" style="margin-left:10px;">Шинэ хэрэглэгч үүсгэх</a> 
        </div>
    </div>
</div>
        <asp:ScriptManager ID="script1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="panel1" runat="server"><ContentTemplate>
            <div class="panel">
        
        <div class="records--list" data-title="Хэрэглэгчийн жагсаалт">
            
            <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">                 
                <div class="table-responsive">
                    <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size:11px;" role="grid">
                        <thead>
                            <tr role="row">
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Хэрэглэгчийн бүлэг: activate to sort column ascending" style="width: 58px;">Үүсгэсэн програм</th>
                                <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Image" style="width: 80px;">Нэвтрэх нэр</th>
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Хэрэглэгчийн нэр: activate to sort column ascending" style="width: 89px;">Хэрэглэгчийн нэр</th>
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ажилтны нэр: activate to sort column ascending" style="width: 89px;">Ажилтнын эр</th>
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Идэвхитэй эсэх: activate to sort column ascending" style="width: 87px;">Идэвхитэй эсэх</th>
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үүсгэсэн огноо: activate to sort column ascending" style="width: 44px;">Үүсгэсэн огноо</th>
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Нууц үг сольсон огноо: activate to sort column ascending" style="width: 63px;">Нууц үг солисон огноо</th>
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Хамгийн сүүлд холбогдсон: activate to sort column ascending" style="width: 83px;">Хамгийн сүүлд холбогдсон</th>                                
                                <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions" style="width: 53px;">Үйлдэл</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (System.Data.DataRow rw in dtSearch.Rows)
                                {
                                    %>
                                <tr role="row" class="odd">
                                <td> <a href="#" class="btn-link"><% Response.Write(rw["ProgName"].ToString()); %></a> </td>
                                <td>
                                    <a href="#" class="btn-link"> <% Response.Write(rw["UserID"].ToString()); %> </a>
                                </td>
                                <td> <% Response.Write(rw["UserName"].ToString()); %> </td>
                                    <td> <% Response.Write(rw["EmployeeName"].ToString()); %> </td>
                                <td> <% if (rw["IsValid"].ToString() == "1") Response.Write("Идэвхитэй".ToString()); else Response.Write("Идэвхигүй"); %> </td>
                                <td class=""><% Response.Write(Convert.ToDateTime(rw["CreatedDate"]).ToString("yyyy-MM-dd HH:mm")); %></td>
                                <td class=""><% Response.Write(Convert.ToDateTime(rw["PasswordChangedDate"]).ToString("yyyy-MM-dd HH:mm")); %></td>
                                <td class=""><% Response.Write(Convert.ToDateTime(rw["LastConnectedTime"]).ToString("yyyy-MM-dd HH:mm")); %></td>                                
                                <td>
                                    <div data-todoapp="item">
                                    <div class="todo--actions dropleft"> 
                                        <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                        <div class="dropdown-menu"> 
                                            <a href="#" class="dropdown-item ProgramRow" data-id="<%=rw["UserPkID"].ToString() %>">Ажиллах програм</a> 
                                            <a href="#" class="dropdown-item editRow" data-id="<%=rw["UserPkID"].ToString() %>">Засах</a> 
                                            <a href="#confirmDelete" class="dropdown-item deleteRow" data-message="Та уг <<%=rw["UserName"].ToString() %>> бичлэгийг устгахыг хүсэж байна уу" data-title="Анхааруулга" data-toggle="modal" data-id="<%=rw["UserPkID"].ToString() %>">Устгах</a> 

                                        </div>
                                    </div>
                                        </div>
                                </td>
                            </tr>
                                <%
                                }%>
                            
                            
                            
                        </tbody>
                    </table>
                </div>                
            </div>
        </div>
    </div>
                                                    </ContentTemplate></asp:UpdatePanel>
    
</section>

  <div class="modal fade" id="confirmDelete" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
          <h4 class="modal-title">Delete Parmanently</h4>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>        
      </div>
      <div class="modal-body">
        <p>Are you sure about this ?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Болих</button>
        <button type="button" class="btn btn-danger" id="confirm" >Устгах</button>
          <input id="txtDeleteID" value="" type="hidden" />
      </div>
    </div>
  </div>
</div>
   
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="color-line"></div>
                                <div class="modal-header">
                                    <h5 class="modal-title">Хэрэглэгчийн бүртгэл</h5>      
                                    <button type="button" class="close" data-dismiss="modal">×</button>
                                </div>
                                <div class="modal-body">                                    
                                    <p>
                                        <div class="form-group">                                        
                                            <div class="row">
                                                 <div class="col-sm-6">
                                                <h5>Хэрэглэгчийн ашиглах програм</h5>
                                                <asp:DropDownList ID="cmbProgID" CssClass="form-control cmbProgID" runat="server" disabled></asp:DropDownList>
                                            </div>
                                              <div class="col-md-6">
                                                <h5>Ажилтанг холбох</h5>
                                                  <asp:DropDownList ID="cmbEmployeeInfo" CssClass="form-control cmbEmployeeInfo" runat="server"></asp:DropDownList>
                                             </div>
                                                
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h5>Нэвтрэх нэр</h5>
                                                <input id="txtUserID" class="form-control txtUserID" type="text" />
                                                <input id="UserPkID" value="" type="hidden" />
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Нууц үг</h5>
                                                <input id="txtPassword" class="form-control txtPassword" type="password" />
                                            </div>
                                            
                                        </div>
                                        <div class="row">
                                               <div class="col-md-6">
                                                <h5>Хэрэглэгчийн нэр</h5>
                                                <input id="txtUserName" class="form-control txtUserName" type="text" />
                                            </div>
                                            <div class="col-md-6">
                                               <label>  
                                                   <br>
                                                   <input id="chkIsValid" class="icheckbox_square-green chkIsValid" type="checkbox" />
                                                   Идэвхигүй бол тэмдэглэ                                              
                                              </label>
                                            </div>
                                                                               
                                        </div>                                          
                                        </div>
                                    </p>                                    
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                                    <button type="button" class="btn btn-rounded btn-warning" onclick="SaveForm()">Хадгалах</button>                                    
                                    <div class="row"> 
                                        <asp:Label ID="Label1" CssClass="label1" runat="server" Text=""></asp:Label>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>

    <div class="modal fade" id="myModalProgram" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="color-line"></div>
                                <div class="modal-header">
                                    <h5 class="modal-title">Ашиглах програмын бүртгэл</h5>      
                                    <button type="button" class="close" data-dismiss="modal">×</button>
                                </div>
                                <div class="modal-body">                                    
                                    <p>
                                        <div class="form-group">                                        
                                            <div class="row">
                                                 <div class="col-sm-6">
                                                <h5>Хэрэглэгчийн ашиглах програм</h5>
                                                <asp:DropDownList ID="cmbProgID1" CssClass="form-control cmbProgID1" runat="server"></asp:DropDownList>
                                            </div>
                                              <div class="col-md-6">
                                                <h5>Хэрэглэгчийн эрх</h5>
                                                  <asp:DropDownList ID="cmbUserGroup" CssClass="form-control cmbUserGroup" runat="server"></asp:DropDownList>
                                                  <input id="UserPkID1" value="" type="hidden" />
                                             </div>
                                                
                                        </div>  
                                            <table id="recordsListView1" class="table table-bordered table-striped" style="font-size:11px;">
                                                <thead>
                                                    <tr role="row">
                                                        <th>Ашиглах програм</th>                                
                                                        <th>Хэрэглэгчийн эрх</th>                                
                                                        <th>Үйлдэл</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                            
                            
                                                </tbody>
                                            </table>
                                        </div>
                                    </p>                                    
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                                    <button type="button" class="btn btn-rounded btn-warning" onclick="SaveFormProgram()">Хадгалах</button>                                    
                                    <div class="row"> 
                                        <asp:Label ID="Label2" CssClass="label2" runat="server" Text=""></asp:Label>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
        
<script type = "text/javascript">

    $('.newButton').on('click', function () {        
        $("#UserPkID").val("");
        $("#txtUserName").val("");
        $("#txtUserID").val("");
        $("#txtPassword").val("");
        $("#chkIsValid").removeAttr('checked');
        $(".cmbProgID").removeAttr('disabled');
        $(".label1").val("");
    })

    function deleteProgram(form) {
        
        var value = $(form).attr('data-id').split(",");
        var UserPkID = value[0];
        var ProgID = value[1];
        
        $.ajax({
            url: '../post.aspx/DeleteProgramDetail',
            type: 'POST',
            data: JSON.stringify({
                UserPkID: UserPkID,
                ProgID: ProgID,
            }),
            dataType: 'json',
            contentType: 'application/json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (msg) {                
                $('[data-id="' + UserPkID + ',' + ProgID + '"]').parents("tr").remove();
                alert("Амжилттай устгагдлаа");    
            }
        })
    }

    $('.deleteRowProgram').on('click', function () {
        alert("class");
    });


     $('.ProgramRow').on('click', function () {
        // Get the record's ID via attribute    
         var txtID = $(this).attr('data-id');                          
         $("#UserPkID1").val(txtID);         
        $.ajax({
            url: '../post.aspx/GetProgramDetailList',
            type: 'POST',
            data: JSON.stringify({
                UserPkID: txtID,
            }),
            dataType: 'json',
            contentType: 'application/json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (response) {                
                $("#recordsListView1").find("tbody").empty();
                $("#recordsListView1").find("tbody").append(response.d.toString());                
                // Populate the form fields with the data returned from server                                             
                $("#myModalProgram").modal('show');               
            }
        })
    });

    $(".cmbProgID1").change(function(){
            var ProgID = $(".cmbProgID1").val();        
             $.ajax({
                url: '../post.aspx/GetProgUserGroup',
                 type: 'POST',
                 data: JSON.stringify({ ProgID: ProgID }),
                dataType: 'json',                
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (msg) {

                    $(".cmbUserGroup").empty();
                    $.each(msg.d, function () {                        
                        $(".cmbUserGroup").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        });

    
    $('.editRow').on('click', function () {
        // Get the record's ID via attribute    
        var txtID = $(this).attr('data-id');        
        $("#UserPkID").val(txtID);
        $(".cmbProgID").prop('disabled', true);
        $.ajax({
            url: '../post.aspx/GetUserInfoSMM',
            type: 'POST',
            data: JSON.stringify({
                UserPkID: txtID,
            }),
            dataType: 'json',
            contentType: 'application/json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (response) {
                var msg = (JSON.stringify(response));
                // Populate the form fields with the data returned from server
                $("#UserPkID").val(response.d.UserPkID);
                $("#txtUserName").val(response.d.UserName);                
                $("#txtUserID").val(response.d.UserID);
                $("#txtPassword").val(response.d.Password);
                $(".cmbProgID").val(response.d.CreatedProgID);
                $(".cmbEmployeeInfo").val(response.d.EmployeeInfoPkID);                
                if (response.d.IsValid == "1")
                    $("#chkIsValid").removeAttr('checked');
                else
                    $("#chkIsValid").prop('checked',true);
                $("#myModal").modal('show');
               
            }
        })
    });

      function SaveFormProgram() {        
        var Adding = 0;
        var UserPkID = $("#UserPkID1").val();       
        var ProgID = $(".cmbProgID1").val();        
        var UserGroupID = $(".cmbUserGroup").val();

            $('.label2').text("");

            $.ajax({
                url: '../post.aspx/PostProgramDetail',
                type: 'POST',
                data: JSON.stringify({
                    Adding:Adding,
                    UserPkID: UserPkID,        
                    UserGroupID: UserGroupID,                   
                    ProgID: ProgID,
                }),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (msg) {
                    if (msg.d.indexOf("Алдаа") == -1)
                    {
                        alert("Амжилттай хадгаллаа");
                        $('#myModalProgram').modal('hide');
                        
                    }
                    else
                        $(".label2").text(msg.d);
                }
            });
    }
    

    function SaveForm() {
        var UserName = $(".txtUserName").val();
        var Adding = 0;
        var UserID = $("#txtUserID").val();
        var Password = $("#txtPassword").val();
        var EmployeeInfoPkID = $(".cmbEmployeeInfo").val();        
        var ProgID = $(".cmbProgID").val();
        var UserPkID = $("#UserPkID").val();
        var IsValid = "1";

        if (UserID == "") {
            alert("Та заавал нэвтрэх нэр оруулна уу");
            return;
        }

        if (UserName == "") {
            alert("Та заавал хэрэглэгчийн нэрийг оруулна уу");
            return;
        }

        if ($('#chkIsValid').is(":checked") == true)
            IsValid = "0";
        if (UserPkID!="")
            Adding=1;

            if (txtUserName == "") {
                $(".label1").text("Та заавал нэрийг оруулах ёстой.");
                return;
            }
            $('.label1').text("");

            $.ajax({
                url: '../post.aspx/PostUserInfo',
                type: 'POST',
                data: JSON.stringify({
                    Adding:Adding,
                    UserPkID: UserPkID,        
                    UserName: UserName,
                    UserID: UserID,
                    Password: Password,
                    IsValid: IsValid,
                    ProgID: ProgID,
                    EmployeeInfoPkID: EmployeeInfoPkID,
                }),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (msg) {
                    if (msg.d.indexOf("Алдаа") == -1)
                    {
                        alert("Амжилттай хадгаллаа");
                        $('#myModal').modal('hide');
                        
                        $("#txtUserName").val('');
                        $("#txtUserPkID").val('');
                        $("#txtSortedOrder").val('1');
                    }
                    else
                        $(".label1").text(msg.d);
                }
            });
    }

    $('#confirmDelete').on('show.bs.modal', function (e) {
        $message = $(e.relatedTarget).attr('data-message');
        $("#txtDeleteID").val($(e.relatedTarget).attr('data-id'));
        $(this).find('.modal-body p').text($message);

        $title = $(e.relatedTarget).attr('data-title');
        $(this).find('.modal-title').text($title);

        // Pass form reference to modal for submission on yes/ok
        var form = $(e.relatedTarget).closest('form');
        $(this).find('.modal-footer #confirm').data('form', form);
    });

    $('#confirmDelete').find('.modal-footer #confirm').on('click', function () {
        var txtID = $("#txtDeleteID").val();
        $('.label1').text("");

        $.ajax({
            url: '../post.aspx/DeleteUserInfoSMM',
            type: 'POST',
            data: JSON.stringify({
                UserPkID: txtID,
            }),
            dataType: 'json',
            contentType: 'application/json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (msg) {
                    $('#confirmDelete').modal('hide');
                    $('[data-id=' + txtID + ']').parents("tr").remove();
                
            }
        });
        
    });
</script>
    

</asp:Content>
