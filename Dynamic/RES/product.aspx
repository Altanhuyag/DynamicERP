<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="Dynamic.product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <section class="main--content">    
        <div class="panel">
    <div class="records--header">
        <div class="title fa-shopping-bag">
            <h3 class="h3">Бэлэн бүтээгдэхүүний бүртгэл <a href="item.aspx" class="btn btn-sm btn-outline-info">Меню удирдах</a></h3>
            <p>Нийт <%=dtSearch.Rows.Count.ToString() %> бичлэг олдлоо</p>
        </div>
        <div class="actions" style="width:100%;">                            
                <asp:TextBox ID="txtSearchText" runat="server" class="form-control" placeholder="Бүтээгдэхүүний нэр..." required=""></asp:TextBox>
                <asp:dropdownlist runat="server" class="form-control" placeholder="Ресторан..."></asp:dropdownlist>
                <asp:dropdownlist runat="server" class="form-control" placeholder="Цэс..."></asp:dropdownlist>
                <button type="submit" id="btnSearch" runat="server" class="btn btn-rounded btn-dark" onserverclick="btnSearch_ServerClick"><i class="fa fa-search"></i></button>                       
                <a href="RES/product-new.aspx" class="btn btn-rounded btn-warning newButton" style="margin-left:10px;">Шинэ бүтээгдэхүүн</a> 
        </div>
    </div>
</div>
        <asp:ScriptManager ID="script1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="panel1" runat="server"><ContentTemplate>
            <div class="panel">
        
        <div class="records--list" data-title="Рестораны меню жагсаалт">
            
            <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">                 
                <div class="table-responsive">
                    <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size:10px;width:100%;" role="grid">
                        <thead>
                            <tr role="row">
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending">Ресторан</th>                                
                                <th class="sorting" tabindex="1" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Меню нэр: activate to sort column ascending">Меню нэр</th>                                
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending">Дотоод №</th>                                
                                <th class="sorting" tabindex="1" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Меню нэр: activate to sort column ascending" style="width:120px;">Нэр</th>                                
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending">Хэмжих нэгж</th>                                
                                <th class="sorting" tabindex="1" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Меню нэр: activate to sort column ascending">Үнэ</th>                                
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending">Төрөл</th>                                
                                <th class="sorting" tabindex="1" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Меню нэр: activate to sort column ascending">Экви ашиглах эсэх</th>                                
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending">Экви нэгж</th>                                
                                <th class="sorting" tabindex="1" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Меню нэр: activate to sort column ascending">Экви үнэ</th>                                
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending">Мин хэмжээ</th>                              
                                
                                <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions" style="width: 53px;">Үйлдэл</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (System.Data.DataRow rw in dtSearch.Rows)
                                {
                                    %>
                                <tr role="row" class="odd">
                                <td> <a href="#" class="btn-link"><% Response.Write(rw["RestaurantName"].ToString()); %></a> </td>                                                          
                                <td> <a href="#" class="btn-link"><% Response.Write(rw["MenuName"].ToString()); %></a> </td>                                                          
                                <td><%=rw["ItemID"].ToString()%> </td>                                       
                                <td><%=rw["ItemName"].ToString()%> </td>                                       
                                <td><%=rw["UnitName"].ToString()%> </td>                                       
                                <td><%=Convert.ToDecimal(rw["OutPrice"]).ToString("n2")%> </td>                                       
                                    <td><%=rw["BufetInfoName"].ToString()%> </td>                                       
                                    <td><%=rw["IsEqRelated"].ToString()%> </td>                                       
                                    <td><%=rw["EqUnitName"].ToString()%> </td>                                       
                                    <td><%=Convert.ToDecimal(rw["EqUnitPrice"]).ToString("n2")%> </td>                                       
                                    <td><%=rw["EqMinUnitQty"].ToString()%> </td>                                       
                                <td>
                                    <div data-todoapp="item">
                                    <div class="todo--actions dropleft"> 
                                        <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                        <div class="dropdown-menu"> 
                                            <a href="product-new.aspx?pId=<%=rw["ItemPkID"].ToString() %>" class="dropdown-item">Засах</a> 
                                            <a href="#confirmDelete" class="dropdown-item deleteRow" data-message="Та уг <<%=rw["ItemName"].ToString() %>> бичлэгийг устгахыг хүсэж байна уу" data-title="Анхааруулга" data-toggle="modal" data-id="<%=rw["ItemPkID"].ToString() %>">Устгах</a> 

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
                                    <h5 class="modal-title">Рестораны заалны ширээний бүртгэл</h5>      
                                    <button type="button" class="close" data-dismiss="modal">×</button>
                                </div>
                                <div class="modal-body">                                    
                                    <p>
                                        <div class="form-group">                                        
                                        
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h5>Ресторан</h5>                                                
                                                <asp:DropDownList ID="cmbRestaurant" CssClass="form-control cmbRestaurant" runat="server"></asp:DropDownList>
                                            </div>                                           
                                             <div class="col-md-6">
                                                <h5>Менюны бүлгийн нэр</h5>                                                
                                                <input id="txtMenuName" class="form-control txtMenuName" type="text" />
                                                 <input id="RestaurantMenuPkID" value="" type="hidden" />
                                            </div>                                            
                                            <div class="col-md-12">                                                
                                                <h5>Зураг</h5>              
                                                <label class="custom-file"> <input type="file" id="picImage" name="picImage" class="custom-file-input" accept="image/x-png,image/gif,image/jpeg" > <span class="custom-file-label">Зурган файл сонгох</span> </label>
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
            url: '../post.aspx/DeleteItemInfo',
            type: 'POST',
            data: JSON.stringify({
                ItemPkID: txtID,
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
