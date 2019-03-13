<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="table.aspx.cs" Inherits="Dynamic.table" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <section class="main--content">    
        <div class="panel">
    <div class="records--header">
        <div class="title fa-shopping-bag">
            <h3 class="h3">Ширээний бүртгэл <a href="item.aspx" class="btn btn-sm btn-outline-info">Заал удирдах</a></h3>
            <p>Нийт <%=dtSearch.Rows.Count.ToString() %> бичлэг олдлоо</p>
        </div>
        <div class="actions" style="width:100%;">                            
                <asp:TextBox ID="txtSearchText" runat="server" class="form-control" placeholder="Хайх талбар" required=""></asp:TextBox>                
                <button type="submit" id="btnSearch" runat="server" class="btn btn-rounded btn-dark" onserverclick="btnSearch_ServerClick"><i class="fa fa-search"></i></button>                       
                <a href="#myModal" class="btn btn-rounded btn-warning newButton" data-toggle="modal" style="margin-left:10px;">Шинэ ширээ үүсгэх</a> 
        </div>
    </div>
</div>
        <asp:ScriptManager ID="script1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="panel1" runat="server"><ContentTemplate>
            <div class="panel">
        
        <div class="records--list" data-title="Рестораны заалны ширээний жагсаалт">
            
            <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">                 
                <div class="table-responsive">
                    <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size:11px;" role="grid">
                        <thead>
                            <tr role="row">
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending" style="width: 58px;">Ресторан</th>                                
                                <th class="sorting" tabindex="1" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Заал: activate to sort column ascending" style="width: 58px;">Заал</th>                                
                                <th class="sorting" tabindex="2" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ширээ №: activate to sort column ascending" style="width: 58px;">Ширээ №</th>                                 
                                <th class="sorting" tabindex="3" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ширээ Багтаамж: activate to sort column ascending" style="width: 58px;">Ширээ Багтаамж</th> 
                                <th class="sorting" tabindex="4" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Цагтай эсэх: activate to sort column ascending" style="width: 58px;">Цагтай эсэх</th> 
                                <th class="sorting" tabindex="5" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Холбоотой бүтээгдэхүүн: activate to sort column ascending" style="width: 58px;">Холбоотой бүтээгдэхүүн</th> 
                                <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions" style="width: 53px;">Үйлдэл</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (System.Data.DataRow rw in dtSearch.Rows)
                                {
                                    %>
                                <tr role="row" class="odd">
                                <td> <a href="#" class="btn-link"><% Response.Write(rw["RestaurantName"].ToString()); %></a> </td>                                                          
                                <td> <a href="#" class="btn-link"><% Response.Write(rw["CategoryName"].ToString()); %></a> </td>                                                          
                                    <td> <a href="#" class="btn-link"><% Response.Write(rw["TableID"].ToString()); %></a> </td>   
                                    <td> <a href="#" class="btn-link"><% Response.Write(rw["TableCapacity"].ToString()); %></a> </td>   
                                    <td> <a href="#" class="btn-link"><% Response.Write(rw["TimeName"].ToString()); %></a> </td>   
                                    <td> <a href="#" class="btn-link"><% Response.Write(rw["ItemName"].ToString()); %></a> </td>   

                                <td>
                                    <div data-todoapp="item">
                                    <div class="todo--actions dropleft"> 
                                        <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                        <div class="dropdown-menu"> 
                                            <a href="#" class="dropdown-item editRow" data-id="<%=rw["TablePkID"].ToString() %>">Засах</a> 
                                            <a href="#confirmDelete" class="dropdown-item deleteRow" data-message="Та уг <<%=rw["TableID"].ToString() %>> бичлэгийг устгахыг хүсэж байна уу" data-title="Анхааруулга" data-toggle="modal" data-id="<%=rw["TablePkID"].ToString() %>">Устгах</a> 

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
                                                <h5>Заалны нэр</h5>
                                                <asp:DropDownList ID="cmbCategory" CssClass="form-control cmbCategory" runat="server"></asp:DropDownList>
                                                <input id="TablePkID" value="" type="hidden" />
                                            </div> 
                                             <div class="col-md-6">
                                                <h5>Ширээний дугаар</h5>                                                
                                                <input id="txtTableID" class="form-control txtTableID" type="text" />
                                            </div> 
                                            <div class="col-md-6">
                                                <h5>Ширээний багтаамж</h5>                                                
                                                <input id="txtTableCapacity" class="form-control txtTableCapacity" type="number" />
                                            </div> 
                                            <div class="col-md-6">                                                
                                                <h5>Ширээ /Өрөө/ цагаар төлбөр гардаг бол</h5>              
                                                <label class="form-check"> 
                                                    <input type="checkbox" name="chkIsTime" id="chkIsTime" value="1" class="form-check-input chkIsTime"> 
                                                    <span class="form-check-label">Ширээ цагтай эсэх</span> </label>
                                            </div> 
                                            <div class="col-md-6">
                                                <h5>Холбоотой бүтээгдэхүүн/Цагтай/</h5>                                                
                                                <asp:DropDownList ID="cmbItem" CssClass="form-control cmbItem" disabled runat="server"></asp:DropDownList>
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
        $("#TablePkID").val("");       
        $("#txtTableID").val("");
        $("#txtTableCapacity").val("");
        $("#chkIsTime").removeAttr('checked');
        $(".label1").val("");
    })

    $(".chkIsTime").change(function() {
        if ($('#chkIsTime').is(":checked") == true) {
            $(".cmbItem").removeAttr('disabled');
        }
        else
            $(".cmbItem").prop('disabled', true);
});
     $(".cmbRestaurant").change(function(){
            var RestaurantPkID=$(".cmbRestaurant").val();
            $.ajax({
                url: '../post.aspx/GetCategoryList',
                type: 'POST',
                data: JSON.stringify({ RestaurantPkID: RestaurantPkID}),
                dataType: 'json',                
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (msg) {

                    $(".cmbCategory").empty();
                    $.each(msg.d, function () {                        
                        $(".cmbCategory").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        });

    
    $('.editRow').on('click', function () {
        // Get the record's ID via attribute    
        var txtID = $(this).attr('data-id');
        $("#TablePkID").val(txtID);
        $.ajax({
            url: '../post.aspx/GetTableInfo',
            type: 'POST',
            data: JSON.stringify({
                TablePkID: txtID,
            }),
            dataType: 'json',
            contentType: 'application/json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (response) {
                var msg = (JSON.stringify(response));
                // Populate the form fields with the data returned from server
                $("#TablePkID").val(response.d.TablePkID);               
                $(".cmbRestaurant").val(response.d.RestaurantPkID);


                var RestaurantPkID=$(".cmbRestaurant").val();
                $.ajax({
                    url: 'post.aspx/GetCategoryList',
                    type: 'POST',
                    data: JSON.stringify({ RestaurantPkID: RestaurantPkID}),
                    dataType: 'json',                
                    contentType: 'application/json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (msg) {

                        $(".cmbCategory").empty();
                        $.each(msg.d, function () {                        
                            $(".cmbCategory").append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }
                });



                $(".cmbCategory").val(response.d.CategoryPkID);   
                $("#txtTableID").val(response.d.TableID);
                $("#txtTableCapacity").val(response.d.TableCapacity);
                $(".cmbItem").val(response.d.ItemPkID);   
                if (response.d.IsTime = "N")
                    $("#chkIsTime").removeAttr('checked');
                else {
                    $("#chkIsTime").prop('checked', true);
                    $(".cmbItem").removeAttr('disabled');
                }

                
                $("#myModal").modal('show');
               
            }
        })
    });

      
    

    function SaveForm() {
       
        var Adding = 0;

        var TableID = $("#txtTableID").val();       
        var TablePkID = $("#TablePkID").val();             
        var TableCapacity = $("#txtTableCapacity").val();    
        var CategoryPkID = $(".cmbCategory").val();     
        
        var ItemPkID = ""; 

        var IsTime = "N";

        if ($('#chkIsTime').is(":checked") == true) {
            IsTime = "Y";
            ItemPkID = $(".cmbItem").val(); 
        }

        if (TablePkID!="")
            Adding=1;

        if (TableID == "") {
                $(".label1").text("Та заавал нэрийг оруулах ёстой.");
                return;
        }

        $('.label1').text("");
                
            $.ajax({
                url: '../post.aspx/PostTableInfo',
                type: 'POST',
                data: JSON.stringify({
                    Adding: Adding,
                    CategoryPkID:CategoryPkID,
                    TablePkID: TablePkID,
                    TableID: TableID, 
                    TableCapacity: TableCapacity,
                    IsTime: IsTime,
                    ItemPkID:ItemPkID,
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
                        
                        $("#TablePkID").val('');
                        $("#txtTableID").val('');
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
        alert(txtID);
        $('.label1').text("");

        $.ajax({
            url: '../post.aspx/DeleteTableInfo',
            type: 'POST',
            data: JSON.stringify({
                TablePkID: txtID,
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
