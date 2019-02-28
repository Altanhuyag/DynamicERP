<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="product-new.aspx.cs" Inherits="Dynamic.productnew" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="main--content">
    <div class="panel">
        <div class="records--header">
            <div class="title fa-shopping-bag">
                <h3 class="h3">Бэлэн бүтээгдэхүүн <a href="product.aspx?m=010203" class="btn btn-sm btn-outline-info">Бүтээгдэхүүн удирдах</a></h3> </div>
        </div>
    </div>
    <div class="panel">
        <div class="records--body">
            <div class="title">
                <h6 class="h6">Бэлэн бүтээгдэхүүний дэлгэрэнгүй</h6>  </div>
            <ul class="nav nav-tabs">
                <li class="nav-item"> <a href="#tab01" data-toggle="tab" class="nav-link active show">Ерөнхий мэдээлэл</a> </li>
                <li class="nav-item"> <a href="#tab02" data-toggle="tab" class="nav-link">Орцын мэдээлэл</a> </li>
                <li class="nav-item"> <a href="#tab03" data-toggle="tab" class="nav-link">Нэмэгдэл</a> </li>
                <li class="nav-item"> <a href="#tab04" data-toggle="tab" class="nav-link">Нэгтгэх</a> </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active show" id="tab01">
                    <form action="#">
                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Код: *</span>
                            <div class="col-md-4">                                
                                <asp:TextBox ID="txtItemID" runat="server" class="form-control" required=""></asp:TextBox></div>

                            <span class="label-text col-md-2 col-form-label">Нэр: *</span>
                            <div class="col-md-4">                                
                                <asp:TextBox ID="txtItemName" class="form-control" required="" runat="server"></asp:TextBox>

                            </div>
                        </div>

                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Нэмэлт код: *</span>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtExtraID" class="form-control txtExtraID" disabled required="" runat="server"></asp:TextBox>
                                                              </div>

                            <span class="label-text col-md-2 col-form-label">ББ нэгдсэн код: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbProduct" CssClass="form-control cmbProduct" runat="server"></asp:DropDownList>
                                 </div>
                        </div>

                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Ресторан: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbRestaurant" CssClass="form-control cmbRestaurant" runat="server"></asp:DropDownList>                                </div>

                            <span class="label-text col-md-2 col-form-label">Меню: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbMenu" CssClass="form-control" runat="server"></asp:DropDownList>
                                 </div>
                        </div>

                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Хэмжих нэгж: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbUnitInfo" CssClass="form-control cmbUnitInfo" runat="server"></asp:DropDownList>                                </div>

                            <span class="label-text col-md-2 col-form-label">Орлогын төрөл: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbBuffet" CssClass="form-control cmbBuffet" runat="server"></asp:DropDownList>
                                 </div>
                        </div>

                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Орлого үнэ: *</span>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtInPrice" runat="server" type="number" class="form-control txtInPrice" required=""></asp:TextBox>
                                                               </div>

                            <span class="label-text col-md-2 col-form-label">Борлуулалт үнэ: *</span>
                            <div class="col-md-4"> 
                                <asp:TextBox ID="txtOutPrice" runat="server" type="number" class="form-control txtOutPrice" required=""></asp:TextBox>                                
                                 </div>
                        </div>

                         <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Татварын төрөл: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbTaxType" CssClass="form-control cmbTaxType" runat="server"></asp:DropDownList>                                </div>

                            <span class="label-text col-md-2 col-form-label">Чөлөөлөгдөх бараа: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbVAT" CssClass="form-control cmbVAT" runat="server" disabled ></asp:DropDownList>
                                 </div>
                        </div>

                        <div class="form-group row"> <span class="label-text col-md-2 col-form-label">Танилцуулга:</span>
                            <div class="col-md-10">                                
                                <asp:TextBox ID="txtDescr" runat="server" TextMode="MultiLine" class="form-control txtDescr" Rows="5"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row"> <span class="label-text col-md-2 col-form-label"></span>
                            <div class="col-md-10">

                                <label class="form-check"> 
                                                    <input type="checkbox" name="chkIsCityTax" id="chkIsCityTax" runat="server" value="1" class="form-check-input chkIsCityTax"> 
                                                    <span class="form-check-label">Хотын татвар тооцох бол тэмдэглэ</span> </label> </div>
                        </div>
                        <div class="form-group row"> <span class="label-text col-md-2 col-form-label"></span>
                            <div class="col-md-10">

                                <label class="form-check"> 
                                                    <input type="checkbox" name="chkIsEqRelated" id="chkIsEqRelated" runat="server" value="1" class="form-check-input chkIsEqRelated">                                                                                          
                                                    <span class="form-check-label">Эквивалент нэгж ашиглах бол тэмдэглэ</span> </label> </div>
                        </div>
                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Экви нэгж: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbEqUnitID" CssClass="form-control cmbEqUnitID" runat="server" disabled></asp:DropDownList>                              </div>

                            <span class="label-text col-md-2 col-form-label">Экви тоо: *</span>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtEqUnitQty" class="form-control txtEqUnitQty" type="number" required="" disabled runat="server"></asp:TextBox>                                
                                 </div>
                        </div>
                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Алхам: *</span>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtEqMinUnitQty" runat="server" type="number" class="form-control txtEqMinUnitQty" required="" disabled></asp:TextBox>
                                                               </div>

                            <span class="label-text col-md-2 col-form-label">Алхам үнэ: *</span>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtEqUnitPrice" type="number" class="form-control txtEqUnitPrice" required="" disabled runat="server"></asp:TextBox>                                
                                 </div>
                        </div>
                        
                        
                    </form>
                </div>
                <div class="tab-pane fade" id="tab02">
                    <form action="#">
                        <div class="records--list" data-title="Норм, орцын мэдээлэл">
            
            <div id="recordsListView_wrapper1" class="dataTables_wrapper no-footer">                 
                <div class="table-responsive">
                    <table id="recordsListView1" class="dataTable no-footer recordsListView" aria-describedby="recordsListView_info" style="font-size:11px;" role="grid">
                        <thead>
                            <tr role="row">
                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending" style="width: 58px;">Ресторан</th>                                
                                <th class="sorting" tabindex="1" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Заал: activate to sort column ascending" style="width: 58px;">Заал</th>                                
                                <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions" style="width: 53px;">Үйлдэл</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (System.Data.DataRow rw in List("").Rows)
                                {
                                    %>
                                <tr role="row" class="odd">
                                <td> <a href="#" class="btn-link"><% Response.Write(rw["RestaurantName"].ToString()); %></a> </td>                                                          
                                <td> <a href="#" class="btn-link"><% Response.Write(rw["CategoryName"].ToString()); %></a> </td>                                                          
                                <td>
                                    <div data-todoapp="item">
                                    <div class="todo--actions dropleft"> 
                                        <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                        <div class="dropdown-menu">                                             
                                            <a href="#confirmDelete" class="dropdown-item deleteRow" data-message="Та уг <<%=rw["CategoryName"].ToString() %>> бичлэгийг устгахыг хүсэж байна уу" data-title="Анхааруулга" data-toggle="modal" data-id="<%=rw["CategoryPkID"].ToString() %>">Устгах</a> 

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
                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Бүлэг: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="DropDownList8" CssClass="form-control" runat="server"></asp:DropDownList>                                </div>

                            <span class="label-text col-md-2 col-form-label">Бараа материал: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="DropDownList9" CssClass="form-control" runat="server"></asp:DropDownList>
                                 </div>
                        </div>
                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Хэмжих нэгж: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="DropDownList10" CssClass="form-control" runat="server"></asp:DropDownList>                                </div>

                            <span class="label-text col-md-2 col-form-label">Бараа материал: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="DropDownList11" CssClass="form-control" runat="server"></asp:DropDownList>
                                 </div>
                        </div>
                        <div class="form-group row"> <span class="label-text col-md-3 col-form-label">Short Description: *</span>
                            <div class="col-md-9">
                                <input type="text" name="text" class="form-control" required=""> </div>
                        </div>
                        <div class="form-group row"> <span class="label-text col-md-3 col-form-label">Category:</span>
                            <div class="col-md-9">
                                <input type="text" name="text" class="form-control"> </div>
                        </div>
                        <div class="row mt-3"> 
                            <div class="col-md-2 offset-md-3"> <input type="submit" value="Жагсаалт нэмэх" class="btn btn-rounded btn-success"> </div>
                            <div class="col-md-2 offset-md--3"> <input type="submit" value="Хагсаалт хасах" class="btn btn-rounded btn-success"> </div></div>
                        <div class="row mt-3"> </div>
                        
                    </form>
                </div>
                <div class="tab-pane fade" id="tab03">
                    <form action="#">
                        <div class="records--list" data-title="Дагалдах бүтээгдэхүүний жагсаалт">
            
                            <div id="recordsListView_wrapper2" class="dataTables_wrapper no-footer">                 
                                <div class="table-responsive">
                                    <table id="recordsListView2" class="dataTable no-footer recordsListView" aria-describedby="recordsListView_info" style="font-size:11px;" role="grid">
                                        <thead>
                                            <tr role="row">
                                                <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ресторан: activate to sort column ascending" style="width: 58px;">Ресторан</th>                                
                                                <th class="sorting" tabindex="1" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Заал: activate to sort column ascending" style="width: 58px;">Заал</th>                                
                                                <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions" style="width: 53px;">Үйлдэл</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% foreach (System.Data.DataRow rw in List("").Rows)
                                                {
                                                    %>
                                                <tr role="row" class="odd">
                                                <td> <a href="#" class="btn-link"><% Response.Write(rw["RestaurantName"].ToString()); %></a> </td>                                                          
                                                <td> <a href="#" class="btn-link"><% Response.Write(rw["CategoryName"].ToString()); %></a> </td>                                                          
                                                <td>
                                                    <div data-todoapp="item">
                                                    <div class="todo--actions dropleft"> 
                                                        <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                        <div class="dropdown-menu">                                                             
                                                            <a href="#confirmDelete" class="dropdown-item deleteRow" data-message="Та уг <<%=rw["CategoryName"].ToString() %>> бичлэгийг устгахыг хүсэж байна уу" data-title="Анхааруулга" data-toggle="modal" data-id="<%=rw["CategoryPkID"].ToString() %>">Устгах</a> 

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
                        <div class="form-group row"> <span class="label-text col-md-3 col-form-label">Product Name: *</span>
                            <div class="col-md-9">
                                <input type="text" name="text" class="form-control" required=""> </div>
                        </div>
                        <div class="form-group row"> <span class="label-text col-md-3 col-form-label">Long Description:</span>
                            <div class="col-md-9">
                                <textarea name="textarea" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="form-group row"> <span class="label-text col-md-3 col-form-label">Short Description: *</span>
                            <div class="col-md-9">
                                <input type="text" name="text" class="form-control" required=""> </div>
                        </div>
                        <div class="form-group row"> <span class="label-text col-md-3 col-form-label">Category:</span>
                            <div class="col-md-9">
                                <input type="text" name="text" class="form-control"> </div>
                        </div>
                        <div class="row mt-3"> 
                            <div class="col-md-2 offset-md-3"> <input type="submit" value="Жагсаалт нэмэх" class="btn btn-rounded btn-success"> </div>
                            <div class="col-md-2 offset-md--3"> <input type="submit" value="Хагсаалт хасах" class="btn btn-rounded btn-success"> </div></div>
                        
                    </form>
                </div>
                <div class="tab-pane fade" id="tab04">
                    <form action="#">
                        <div class="form-group row"> <span class="label-text col-md-2 col-form-label"></span>
                            <div class="col-md-10">

                                <label class="form-check"> 
                                                    <input type="checkbox" name="chkIsMerge" id="chkIsMerge" value="1" class="form-check-input chkIsMerge"> 
                                                    <span class="form-check-label">Тухайн бараанд нэгтгэл ашиглах бол тэмдэглэ</span> </label> </div>
                        </div>
                        <div class="form-group row"> 
                            <span class="label-text col-md-2 col-form-label">Нэгтгэх бараа: *</span>
                            <div class="col-md-4">
                                <asp:DropDownList ID="cmbMergeItem" CssClass="form-control cmbMergeItem" runat="server"></asp:DropDownList>                                </div>
                           
                        </div>
                        
                    </form>
                </div>
                
            </div>
            <div class="row">
                    <div class="row mt-3">
                            <div class="col-md-3 offset-md-1">
                                <asp:Button ID="btnSave" runat="server" Text="ХАДГАЛАХ" OnClick="btnSave_Click" class="btn btn-rounded btn-warning"/>                                                               
                                </div>
                                <div class="col-md-3 offset-md-3">
                                <input type="submit" value="БУЦАХ" class="btn btn-rounded btn-default"> 

                                </div> 
                                
                    </div>
                        </div>
                
                
        </div>
    </div>
</section>

    <script type = "text/javascript">
        
        $(".chkIsEqRelated").change(function () {            
            if ($('.chkIsEqRelated').is(":checked") == true) {                
            
                $(".cmbEqUnitID").removeAttr('disabled');
                $(".txtEqUnitQty").removeAttr('disabled');
                $(".txtEqMinUnitQty").removeAttr('disabled');
                $(".txtEqUnitPrice").removeAttr('disabled');
            }
            else {
                $(".cmbEqUnitID").prop('disabled', true);
                $(".txtEqUnitQty").prop('disabled', true);
                $(".txtEqMinUnitQty").prop('disabled', true);
                $(".txtEqUnitPrice").prop('disabled', true);
            }
        });

        $(".cmbTaxType").change(function(){
            var TaxTypeID = $(".cmbTaxType").val();
            if (TaxTypeID == 2 || TaxTypeID==3) {
                $(".cmbVAT").removeAttr('disabled');
            }
            else
                $(".cmbVAT").prop('disabled', true);

             $.ajax({
                url: '../post.aspx/GetVatList',
                 type: 'POST',
                 data: JSON.stringify({ TaxTypeID: TaxTypeID }),
                dataType: 'json',                
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (msg) {

                    $(".cmbVAT").empty();
                    $.each(msg.d, function () {                        
                        $(".cmbVAT").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        });

        $(".cmbProduct").change(function(){
            var ProductID = $(".cmbProduct").val();
            $(".txtExtraID").val(ProductID);

             
        });
    </script>

</asp:Content>
