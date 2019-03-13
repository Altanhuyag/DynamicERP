<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="unit.aspx.cs" Inherits="Dynamic.unit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="main--content">    
        <div class="panel">
    <div class="records--header">
        <div class="title fa-shopping-bag">
            <h3 class="h3">Бараа материалын хэмжих нэгж <a href="item.aspx" class="btn btn-sm btn-outline-info">Бараа материал удирдах</a></h3>
            <p>Нийт <%=dtSearch.Rows.Count.ToString() %> бичлэг олдлоо</p>
        </div>
        <div class="actions" style="width:100%;">                            
                <asp:TextBox ID="txtSearchText" runat="server" class="form-control" placeholder="Хайх талбар" required=""></asp:TextBox>                
                <button type="submit" id="btnSearch" runat="server" class="btn btn-rounded btn-dark" onserverclick="btnSearch_ServerClick"><i class="fa fa-search"></i></button>                       
                <a href="#myModal" class="btn btn-rounded btn-warning newButton" data-toggle="modal" style="margin-left:10px;">Шинэ хэмжих нэгж үүсгэх</a> 
        </div>
    </div>
</div>
        <asp:ScriptManager ID="script1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="panel1" runat="server"><ContentTemplate>
            <div class="panel">
        
        <div class="records--list" data-title="Бараа материалын хэмжих нэгжийн жагсаалт">
            
            <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">                 
                <div class="table-responsive">
                    <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size:11px;" role="grid">
                        <thead>
                            <tr role="row">
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Захиалгын төрлийн нэр: activate to sort column ascending" style="width: 58px;">Захиалгын төрлийн нэр</th>                                
                                <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions" style="width: 53px;">Үйлдэл</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (System.Data.DataRow rw in dtSearch.Rows)
                                {
                                    %>
                                <tr role="row" class="odd">
                                <td> <a href="#" class="btn-link"><% Response.Write(rw["UnitName"].ToString()); %></a> </td>                                                          
                                <td>
                                    <div data-todoapp="item">
                                    <div class="todo--actions dropleft"> 
                                        <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                        <div class="dropdown-menu"> 
                                            <a href="#" class="dropdown-item editRow" data-id="<%=rw["UnitID"].ToString() %>">Засах</a> 
                                            <a href="#confirmDelete" class="dropdown-item deleteRow" data-message="Та уг <<%=rw["UnitName"].ToString() %>> бичлэгийг устгахыг хүсэж байна уу" data-title="Анхааруулга" data-toggle="modal" data-id="<%=rw["UnitID"].ToString() %>">Устгах</a> 

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
                                    <h5 class="modal-title">Рестораны захиалгын төрөл</h5>      
                                    <button type="button" class="close" data-dismiss="modal">×</button>
                                </div>
                                <div class="modal-body">                                    
                                    <p>
                                        <div class="form-group">                                        
                                        
                                        <div class="row">
                                            <div class="col-md-12">
                                                <h5>Хэмжих нэгж</h5>
                                                <input id="txtUnitName" class="form-control txtUnitName" type="text" />
                                                <input id="UnitID" value="" type="hidden" />
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
        
<script type = "text/javascript">

    $('.newButton').on('click', function() {
        $("#UnitID").val("");       
        $("#txtUnitName").val("");
        $(".label1").val("");
    })
    
    
    $('.editRow').on('click', function () {
        // Get the record's ID via attribute    
        var txtID = $(this).attr('data-id');
        $("#UnitID").val(txtID);
        $.ajax({
            url: '../post.aspx/GetUnitInfo',
            type: 'POST',
            data: JSON.stringify({
                UnitID: txtID,
            }),
            dataType: 'json',
            contentType: 'application/json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (response) {
                var msg = (JSON.stringify(response));
                // Populate the form fields with the data returned from server
                $("#UnitID").val(response.d.UnitID);               
                $("#txtUnitName").val(response.d.UnitName);
               
                $("#myModal").modal('show');
               
            }
        })
    });

      
    

    function SaveForm() {
       
        var Adding = 0;
        var UnitName = $("#txtUnitName").val();       
        var UnitID = $("#UnitID").val();        
              

        if (UnitID!="")
            Adding=1;

        if (UnitName == "") {
                $(".label1").text("Та заавал нэрийг оруулах ёстой.");
                return;
            }
            $('.label1').text("");

            $.ajax({
                url: '../post.aspx/PostUnitInfo',
                type: 'POST',
                data: JSON.stringify({
                    Adding:Adding,
                    UnitID: UnitID,
                    UnitName: UnitName,                    
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
                        
                        $("#UnitID").val('');
                        $("#txtUnitName").val('');
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
            url: '../post.aspx/DeleteUnitInfo',
            type: 'POST',
            data: JSON.stringify({
                UnitID: txtID,
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
