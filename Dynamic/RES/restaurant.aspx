<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="restaurant.aspx.cs" Inherits="Dynamic.restaurant" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    
    <link rel="stylesheet" href="assets\css\sweetalert.min.css">
    <link rel="stylesheet" href="assets\css\sweetalert-overrides.css">

    <%--<asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>--%>
            <section class="main--content">

                <div class="panel">
                    <div class="records--header">
                        <div class="title fa-utensils">
                            <h3 class="h3">Рестораны бүртгэл</h3>
                        </div>
                        <div class="actions" style="width: 100%;">
                            <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="Рестораны нэр..."></asp:TextBox>
                            <button id="btnSearch" runat="server" type="submit" class="btn btn-rounded btn-dark" onserverclick="Search_ServerClick"><i class="fa fa-search"></i></button>
                            <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ ресторан үүсгэх</a>
                        </div>
                    </div>
                </div>

                <div class="panel">
                    <div class="records--list" data-title="Хэрэглэгчийн жагсаалт">

                        <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">
                            <div class="table-responsive">
                                <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size: 11px; width: 100%;" role="grid">
                                    <thead>
                                        <tr role="row">
                                            <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Рестораны нэр">Рестораны нэр</th>
                                            <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Толгой текст">Толгой текст</th>
                                            <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Хөлийн текст">Хөлийн текст</th>
                                            <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Image" style="width: 80px;">Лого</th>
                                            <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="НӨАТ %">НӨАТ %</th>
                                            <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Хотын татвар %">Хотын татвар %</th>
                                            <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үйлчилгээний төлбөр %">Үйлчилгээний төлбөр %</th>
                                            <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% foreach (System.Data.DataRow rw in dtRestaurants.Rows)
                                            {
                                        %>
                                        <tr data-value="<%=rw["RestaurantPkID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                            <td><%=rw["RestaurantName"].ToString() %></td>
                                            <td><%=rw["HeaderText"].ToString() %></td>
                                            <td><%=rw["FooterText"].ToString() %></td>
                                            <td>
                                                <% 
                                                    //int i = 1;
                                                    if (rw["LogoFile"].ToString() != "")
                                                    {

                                                        Image t = new Image();
                                                        //t.ID = "asdf"+i.ToString();
                                                        t.ImageUrl = rw["LogoFile"].ToString();
                                                        t.Width = 60;
                                                        imgLink.Controls.Add(t);
                                                    }
                                                    //i++;
                                                %>                                                 
                                               <div id="imgLink" runat="server"></div>  
                                            </td>
                                            <td><%=rw["Tax"].ToString() %></td>
                                            <td><%=rw["CityTax"].ToString() %></td>
                                            <td><%=rw["ServiceChargeTax"].ToString() %></td>
                                            <td>
                                                <div data-todoapp="item">
                                                    <div class="todo--actions dropleft">
                                                        <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                        <div class="dropdown-menu">
                                                            <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["RestaurantPkID"].ToString() %>">Засах</a>
                                                            <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["RestaurantPkID"].ToString() %>">Устгах</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <%
                                                imgLink.Controls.Clear();
                                            }
                                        %>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>

            </section>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
                    

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                
                <div class="modal-header">
                    <h5 class="modal-title">Рестораны бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Рестораны нэр</h5>
                                    <input class="form-control" type="text" id="txtName" />
                                </div>          
                                <div class="col-md-6">
                                    <h5>Лого</h5>
                                    <%--<input class="form-control" type="text" id="imgLogo" />--%>
                                    <label class="custom-file"> 
                                        <input type="file" id="imgLogo" name="imgLogo" class="custom-file-input" accept="image/x-png,image/gif,image/jpeg" /> 
                                        <span id="txtUploadedFile" class="custom-file-label">Зурган файл сонгох</span> 
                                    </label>
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Толгой текст</h5>
                                    <input class="form-control" type="text" id="txtHeader" />
                                </div>          
                                <div class="col-md-6">
                                    <h5>Хөлийн текст</h5>
                                    <input class="form-control" type="text" id="txtFooter" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>НӨАТ %</h5>
                                    <input class="form-control" type="number" id="numTax" />
                                </div>          
                                <div class="col-md-4">
                                    <h5>Хотын татвар %</h5>
                                    <input class="form-control" type="number" id="numCityTax" />
                                </div>          
                                <div class="col-md-4">
                                    <h5>Үйлчилгээний төлбөр %</h5>
                                    <input class="form-control" type="number" id="numServiceCharge" />
                                </div>          
                            </div>
                        </div>
                    </p>                                    
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                    <button id="btnSave" type="button" class="btn btn-rounded btn-warning" onclick="SaveRes()">Бүртгэх</button>                                
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="RemoveModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                
                <div class="modal-header">
                <h5 class="modal-title">Анхааруулга</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                </div>
                
                <div class="modal-body">
                    <h5>Энэ рестораныг устгах уу ?</h5>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Болих</button>
                    <button type="button" class="btn btn-rounded btn-danger" onclick="DeleteRes()">Устгах</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="assets\js\datatables.min.js"></script>
    <script src="assets\js\sweetalert.min.js"></script>
    <script src="assets\js\sweetalert-init.js"></script>

    <script type = "text/javascript">

        var act = 1;
        var selid = 0;
        var rid = 0;
        
        function Clear() {
            $('#txtName').val("");
            $('#txtHeader').val("");
            $('#txtFooter').val("");
            $('#imgLogo').val(null);
            document.getElementById("txtUploadedFile").innerHTML = "Зурган файл сонгох";
            $('#numTax').val("");
            $('#numCityTax').val("");
            $('#numServiceCharge').val("");
            act = 1;
            selid = 0;
        }

        $('.editRow').on('click', function () {
            act = 0;
            selid = $(this).attr('data-id');
            document.getElementById("btnSave").innerHTML = "Засах";

            $.ajax({
                url: '../post.aspx/GetRestaurantInfo',
                type: 'POST',
                data: JSON.stringify({
                    id: selid,
                }),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (response) {
                    var msg = (JSON.stringify(response));
                    
                    $('#txtName').val(response.d.RestaurantName);
                    $('#txtHeader').val(response.d.HeaderText);
                    $('#txtFooter').val(response.d.FooterText);
                    $('#numTax').val(response.d.Tax);
                    $('#numCityTax').val(response.d.CityTax);
                    $('#numServiceCharge').val(response.d.ServiceChargeTax);
                }
            });
        });

        $('.deleteRow').on('click', function () {
            selid = $(this).attr('data-id');
        });

        function OnRowClick(row) {
            rid = row.sectionRowIndex + 1;
        }

        function addRow() {
            Clear();
            document.getElementById("btnSave").innerHTML = "Бүртгэх";
            act = 1;
            selid = 0;
        }

        function SaveRes() {
            var nam = $('#txtName').val().trim();
            var hdr = $('#txtHeader').val().trim();
            var ftr = $('#txtFooter').val().trim();
            var img = $('#imgLogo').val().trim();
            var tx = $('#numTax').val().trim();
            var ctx = $('#numCityTax').val().trim();
            var scr = $('#numServiceCharge').val().trim();
            var retmsg = '0';

            if (nam == '') {
                swal('Анхааруулга', 'Рестораны нэрээ оруулна уу !', 'warning');
                return;
            }
            if (img == '') {
                swal('Анхааруулга', 'Логогоо сонгоно уу !', 'warning');
                return;
            }
            if (hdr == '') {
                swal('Анхааруулга', 'Толгой текстээ оруулна уу !', 'warning');
                return;
            }
            if (ftr == '') {
                swal('Анхааруулга', 'Хөлийн текстээ оруулна уу !', 'warning');
                return;
            }
            if (tx == '' || tx <= 0) {
                swal('Анхааруулга', 'НӨАТ-ын хувиа оруулна уу !', 'warning');
                return;
            }
            if (ctx == '' || ctx <= 0) {
                swal('Анхааруулга', 'Хотын татварын хувиа оруулна уу !', 'warning');
                return;
            }
            if (scr == '' || scr <= 0) {
                swal('Анхааруулга', 'Үйлчилгээний төлбөрийн хувиа оруулна уу !', 'warning');
                return;
            }
            
            $.ajax({
                url: '../post.aspx/SaveRestaurant',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    type: act,
                    id: selid,
                    name: nam,
                    header: hdr,
                    footer: ftr,
                    tax: tx,
                    citytax: ctx,
                    servicecharge: scr
                }),
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    retmsg = msg.d;
                }
            }).done(function () {
                if (retmsg == '0') {
                    swal('Анхааруулга', 'Амжилтгүй боллоо !', 'warning');
                }
                else {
                    var files = document.getElementById('imgLogo').files;
                    if (files.length > 0) {
                        var formData = new FormData();
                        for (var i = 0; i < files.length; i++) {
                            formData.append(files[i].name, files[i]);
                        }
                        $.ajax({
                            url: 'uploadfile.ashx?RestaurantPkID=' + retmsg,
                            method: 'POST',
                            data: formData,
                            contentType: false,
                            processData: false,
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                            }
                        }).done(function () {
                            if (act == 1)
                                swal('Амжилттай', 'Амжилттай нэмэгдлээ !', 'success');
                            else if (act == 0)
                                swal('Амжилттай', 'Амжилттай засагдлаа !', 'success');

                            $('#myModal').modal('hide');
                            Clear();
                            window.location.reload();
                        })
                    }
                    
                    //$.ajax({
                    //    url: 'restaurant.aspx/RefreshRestaurants',
                    //    type: 'POST',
                    //    dataType: 'json',
                    //    data: '{}',
                    //    contentType: 'application/json',
                    //    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //        swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                    //    }
                    //});

                    
                }
            });
        }

        function DeleteRes() {
            $.ajax({
                url: '../post.aspx/DeleteRestaurant',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    id: selid
                }),
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    $('#RemoveModal').modal('hide');
                    if (msg.d == false) {
                        swal('Анхааруулга', 'Амжилтгүй боллоо !', 'warning');
                    }
                    else {
                        swal('Амжилттай', 'Амжилттай устгагдлаа !', 'success');

                        //$.ajax({
                        //    url: 'restaurant.aspx/RefreshRestaurants',
                        //    type: 'POST',
                        //    dataType: 'json',
                        //    data: '{}',
                        //    contentType: 'application/json',
                        //    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //        swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                        //    }
                        //});
                    }
                }
            }).done(function () {
                window.location.reload();
            });
        }
    
    </script>

</asp:Content>
