<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="usergroup.aspx.cs" Inherits="Dynamic.usergroup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="normalheader ">
    <div class="hpanel">
        <div class="panel-body">
            <a class="small-header-action" href="#">
                <div class="clip-header">
                    <i class="fa fa-arrow-up"></i>
                </div>
            </a>

            <div id="hbreadcrumb" class="pull-right m-t-lg">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="index-2.html">Администратор</a></li>
                    <li>
                        <span>Хэрэглэгчийн эрх үүсгэх</span>
                    </li>                    
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                Хэрэглэгчийн эрх үүсгэх
            </h2>
            <small>Аливаа нэвтрэх хэрэглэгч бүр өөрийн гэсэн эрхтэй байх ёстой. Тэрхүү бүртгэлийг энд хөтлөнө</small>
        </div>
    </div>
</div>
    <div class="content">
        <div class="panel-section">
                    <div class="input-group">
                        <a href="usergroup_new.aspx" class="btn btn-default text-success" ><i class="glyphicon glyphicon-plus small"></i> ШИНЭ БИЧЛЭГ НЭМЭХ </a>
                    </div>
                    <button type="button" data-toggle="collapse" data-target="#notes" class="btn-sm visible-xs visible-sm collapsed btn-default btn btn-block m-t-sm">
                        All notes <i class="fa fa-angle-down"></i>
                    </button>
                </div>
    <div class="table-responsive">
    <table class="table table-bordered table-striped" id="myTable">
        <thead>
            <tr>
                <th>Хэрэглэгчийн эрх</th>
                <th>Ажиллах програм</th>
                <th>Үйлдэл</th>
            </tr>
        </thead>
        <tbody>
            <% foreach (System.Data.DataRow rw in List().Rows)
                {
                            %>
                    <tr>
                        <td><% Response.Write(rw["UserGroupName"].ToString()); %></td>
                        <td><% Response.Write(rw["ProgID"].ToString()); %></td>
                    <td>
                    <a href="usergroup_new.aspx?uId=<% Response.Write(rw["UserGroupID"].ToString()); %>" class="btn btn-xs btn-info editButton">Засах</a>
                    <button class="btn btn-xs btn-danger deleteButton" type="button" data-toggle="modal" data-id="<% Response.Write(rw["UserGroupID"].ToString()); %>" data-target="#confirmDelete" data-title="Мэдээлэл устгах" data-message="Та уг <<% Response.Write(rw["UserGroupName"].ToString()); %>> бичлэгийг устгахыг зөвшөөрч байна уу ?">
        <i class="glyphicon glyphicon-trash"></i> Устгах
    </button>
                </td>
            </tr>
            <%
                } %>
            
            
        </tbody>
    </table>
        </BR>
</div>
         <div class="modal fade" id="confirmDelete" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">Delete Parmanently</h4>
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
        
<!-- The form which is used to populate the item data -->

        </div>
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
            url: 'post.aspx/DeleteUserGroupInfo',
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
