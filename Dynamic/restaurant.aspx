<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="restaurant.aspx.cs" Inherits="Dynamic.restaurant" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    
    <section class="main--content">
        
        <div class="panel">
            <div class="records--header">
                <div class="title fa-utensils">
                    <h3 class="h3">Рестароны бүртгэл</h3>
                </div>
                <div class="actions" style="width:100%;">            
                    <input type="text" class="form-control" placeholder="Рестораны нэр..." required="">
                    <button type="submit" class="btn btn-rounded btn-dark"><i class="fa fa-search"></i></button>
                    <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" style="margin-left:10px;">Шинэ ресторан үүсгэх</a> 
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Хэрэглэгчийн жагсаалт">
            
                <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">                 
                    <div class="table-responsive">
                        <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size:11px;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Рестораны нэр">Рестораны нэр</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Толгой текст">Толгой текст</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Хөлийн текст">Хөлийн текст</th>
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Image" style="width: 80px;">Лого</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Татвар %">Татвар %</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Хотын татвар %">Хотын татвар %</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үйлчилгээний төлбөр %">Үйлчилгээний төлбөр %</th>                                
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (System.Data.DataRow rw in dtRestaurants.Rows)
                                    {
                                        %>
                                    <tr role="row" class="odd">
                                    <td><%=rw["RestaurantName"].ToString() %></td>
                                    <td><%=rw["HeaderText"].ToString() %></td>
                                    <td><%=rw["FooterText"].ToString() %></td>
                                    <td></td>
                                    <td><%=Convert.ToDecimal(rw["Tax"]).ToString("n0") %></td>
                                    <td><%=Convert.ToDecimal(rw["CityTax"]).ToString("n0") %></td>
                                    <td><%=Convert.ToDecimal(rw["ServiceChargeTax"]).ToString("n0") %></td>                          
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft"> 
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-ellipsis-v"></i></a>
                                                <div class="dropdown-menu"> 
                                                    <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["RestaurantPkID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["RestaurantPkID"].ToString() %>">Устгах</a> 
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    </tr>
                                    <%
                                    }
                                    %>
                            </tbody>
                        </table>
                    </div>                
                </div>
            </div>
        </div>

    </section>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                
                <div class="modal-header">
                    <h5 class="modal-title">Рестораны бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Рестораны нэр</h5>
                                    <input class="form-control" type="text" id="txtName" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Толгой текст</h5>
                                    <input class="form-control" type="text" id="txtHeader" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Хөлийн текст</h5>
                                    <input class="form-control" type="text" id="txtFooter" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Лого</h5>
                                    <input class="form-control" type="image" id="imgLogo" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Татвар %</h5>
                                    <input class="form-control" type="number" id="numTax" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Хотын татвар %</h5>
                                    <input class="form-control" type="number" id="numCityTax" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Үйлчилгээний төлбөр %</h5>
                                    <input class="form-control" type="number" id="numServiceCharge" />
                                </div>          
                            </div>                             
                        </div>
                    </p>                                    
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Хаах</button>
                    <button type="button" class="btn btn-primary" onclick="SaveRes()">Хадгалах</button>                                
                    <div class="row"> 
                        <asp:Label ID="Label1" CssClass="label1" runat="server" Text=""></asp:Label>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="RemoveModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                
                <div class="modal-header">
                <h5 class="modal-title">Анхааруулга</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                </div>
                
                <div class="modal-body">
                    Энэ рестораныг устгах уу ?
                </div>
                
                <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Үгүй</button>
                <button type="button" class="btn btn-danger" onclick="DeleteRes()">Тийм</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="assets\js\datatables.min.js"></script>

    <script type = "text/javascript">

        function SaveRes() {
            var nam = $('#txtName').val().trim();
            var hdr = $('#txtHeader').val().trim();
            var ftr = $('#txtFooter').val().trim();
            var tx = $('#numTax').val().trim();
            var ctx = $('#numCityTax').val().trim();
            var scr = $('#numServiceCharge').val().trim();

            if (nam == '') {
                toastr.warning('Рестораны нэрээ оруулна уу !');
                return;
            }
            if (hdr == '') {
                toastr.warning('Толгой текстээ оруулна уу !');
                return;
            }
            if (ftr == '') {
                toastr.warning('Хөлийн текстээ оруулна уу !');
                return;
            }
            if (tx == '' || tx <= 0) {
                toastr.warning('Татвараа оруулна уу !');
                return;
            }
            if (ctx == '' || ctx <= 0) {
                toastr.warning('Хотын татвараа оруулна уу !');
                return;
            }
            if (sch == '' || scr <= 0) {
                toastr.warning('Үйлчилгээний төлбөрөө оруулна уу !');
                return;
            }
            
            $.ajax({
                url: 'post.aspx/SaveRestaurant',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    type: 1,
                    name: nam,
                    header: hdr,
                    footer: ftr,
                    tax: tx,
                    citytax: ctx,
                    servicecharge: sch
                }),
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (msg) {
                    $('#OrderModal').hide();
                    if (msg.d == false) {
                        alert('Амжилтгүй боллоо !');
                    }
                    else {
                        alert('Амжилттай нэмэгдлээ !');
                        window.location.reload();
                    }
                }
            });
        }

        function DeleteRes() {

        }
    
    </script>

</asp:Content>
