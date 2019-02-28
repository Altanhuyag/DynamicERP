<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="usergroup.aspx.cs" Inherits="Dynamic.usergroupSMM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="main--content">    
        <div class="panel">
    <div class="records--header">
        <div class="title fa-shopping-bag">
            <h3 class="h3">Хэрэглэгчийн бүлгийн жагсаалт <a href="usergroup.aspx" class="btn btn-sm btn-outline-info">Хэрэглэгч эрх удирдах</a></h3>
            <p>Нийт <%=dtSearch.Rows.Count.ToString() %> хэрэглэгч олдлоо</p>
        </div>
        <div class="actions" style="width:100%;">                            
                <asp:TextBox ID="txtSearchText" runat="server" class="form-control" placeholder="Хайх талбар" required=""></asp:TextBox>                
                <button type="submit" id="btnSearch" runat="server" class="btn btn-rounded btn-dark" onserverclick="btnSearch_ServerClick"><i class="fa fa-search"></i></button>                       
                <a href="usergroup_new.aspx" class="btn btn-rounded btn-warning newButton" style="margin-left:10px;">Шинэ бичлэг үүсгэх</a> 
        </div>
    </div>
</div>
        <asp:ScriptManager ID="script1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="panel1" runat="server"><ContentTemplate>
            <div class="panel">
        
        <div class="records--list" data-title="Хэрэглэгчийн бүлгийн жагсаалт">
            
            <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">                 
                <div class="table-responsive">
                    <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size:11px;" role="grid">
                        <thead>
                            <tr role="row">
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Хэрэглэгчийн бүлэг: activate to sort column ascending" style="width: 58px;">Хэрэглэгчийн бүлэг</th>                                                                                                                                
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үүсгэсэн огноо: activate to sort column ascending" style="width: 44px;">Ажиллах программ</th>                                
                                
                                <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions" style="width: 53px;">Үйлдэл</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (System.Data.DataRow rw in dtSearch.Rows)
                                {
                                    %>
                                <tr role="row" class="odd">
                                <td> <% Response.Write(rw["UserGroupName"].ToString()); %> </td>
                                <td>
                                    <% Response.Write(rw["ProgName"].ToString()); %> 
                                </td>
                                    <td>
                                        <a href="usergroup_new.aspx?uId=<% Response.Write(rw["UserGroupID"].ToString()); %>" class="btn btn-rounded btn-info editButton">Засах</a>
                                        <button class="btn btn-rounded btn-danger deleteButton" type="button" data-toggle="modal" data-id="<% Response.Write(rw["UserGroupID"].ToString()); %>" data-target="#confirmDelete" data-title="Мэдээлэл устгах" data-message="Та уг <<% Response.Write(rw["UserGroupName"].ToString()); %>> бичлэгийг устгахыг зөвшөөрч байна уу ?">
                                            <i class="glyphicon glyphicon-trash"></i> Устгах
                                        </button>
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
    
</section>

  <script type = "text/javascript">
        
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

        $.ajax({
            url: '../post.aspx/DeleteUserGroupInfo',
            type: 'POST',
            data: JSON.stringify({
                UserGroupID: txtID,
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
