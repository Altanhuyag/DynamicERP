<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="servicedetailinfo.aspx.cs" Inherits="Dynamic.servicedetailinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link rel="stylesheet" href="assets\css\sweetalert.min.css">
    <link rel="stylesheet" href="assets\css\sweetalert-overrides.css">

    <section class="main--content">

        <div class="panel">
            <div class="records--header">
                <div class="title fa-cube">
                    <h3 class="h3">Үйлчилгээний дэлгэрэнгүй мэдээлэл</h3>
                </div>
                <div class="actions" style="width: 100%;">
                    <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="Үйлчилгээний нэр..."></asp:TextBox>
                    <button id="btnSearch" runat="server" type="submit" class="btn btn-rounded btn-dark" onserverclick="Search_ServerClick"><i class="fa fa-search"></i></button>
                    <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ үйлчилгээний дэлгэрэнгүй мэдээлэл үүсгэх</a>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Үйлчилгээний дэлгэрэнгүй мэдээллийн жагсаалт">

                <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">
                    <div class="table-responsive">
                        <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size: 11px; width: 100%;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үйлчилгээний нэр">Үйлчилгээ</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Зочны төрөл">Зочны төрөл</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Валют">Валют</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үйлчилгээний үнэ">Үйлчилгээний үнэ</th>
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (System.Data.DataRow rw in dtServiceDetailInfo.Rows)
                                    {
                                %>
                                <tr data-value="<%=rw["ServiceDetailInfoPkID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                    <td><%=rw["ServiceName"].ToString() %></td>
                                    <td><%=rw["GuestTypeName"].ToString() %></td>
                                    <td><%=rw["CurrencyName"].ToString() %></td>
                                    <td><%=rw["ServicePrice"].ToString() %></td>
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft">
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                <div class="dropdown-menu">
                                                    <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["ServiceDetailInfoPkID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["ServiceDetailInfoPkID"].ToString() %>">Устгах</a>
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
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                
                <div class="modal-header">
                    <h5 class="modal-title">Үйлчилгээний дэлгэрэнгүй мэдээллийн бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Үйлчилгээ</h5>
                                    <select class="form-control" id="cmbServiceInfo">
                                        <% foreach (System.Data.DataRow rw in dtServiceInfo.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["ServiceInfoPkID"].ToString() %>"><%=rw["ServiceName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <h5>Зочны төрөл</h5>
                                    <select class="form-control" id="cmbGuestTypeInfo">
                                        <% foreach (System.Data.DataRow rw in dtGuestTypeInfo.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["GuestTypeID"].ToString() %>"><%=rw["GuestTypeName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Вальт</h5>
                                    <select class="form-control" id="cmbCurrencyInfo">
                                        <% foreach (System.Data.DataRow rw in dtCurrencyInfo.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["CurrencyID"].ToString() %>"><%=rw["CurrencyName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <h5>Үйлчилгээний үнэ</h5>
                                    <input class="form-control" type="number" id="numPrice" />
                                </div>  
                            </div>
                        </div>
                    </p>                                    
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                    <button id="btnSave" type="button" class="btn btn-rounded btn-warning" onclick="Save()">Бүртгэх</button>                                
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
                    <h5>Энэ үйлчилгээний дэлгэрэнгүй мэдээллийг устгах уу ?</h5>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Болих</button>
                    <button type="button" class="btn btn-rounded btn-danger" onclick="Delete()">Устгах</button>
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
            $('#cmbServiceInfo').val("");
            $('#cmbGuestTypeInfo').val("");
            $('#cmbCurrencyInfo').val("");
            $('#numPrice').val("");
            act = 1;
            selid = 0;
        }
                
        $("#cmbGuestTypeInfo").change(function () {
            $.ajax({
                url: 'post.aspx/GetHTLServiceDetailCustomer',
                type: 'POST',
                data: JSON.stringify({
                    id: $('#cmbGuestTypeInfo option:selected').val(),
                }),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    if (msg.d != null) {
                        $('#cmbCurrencyInfo').val(msg.d);
                    }
                }
            });
        });

        $('.editRow').on('click', function () {
            act = 0;
            selid = $(this).attr('data-id');
            document.getElementById("btnSave").innerHTML = "Засах";

            $.ajax({
                url: 'post.aspx/GetHTLServiceDetailInfo',
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
                    
                    $('#cmbServiceInfo').val(response.d.GroupPkID);
                    $('#cmbGuestTypeInfo').val(response.d.RoomTypePkID);
                    $('#cmbCurrencyInfo').val(response.d.RoomBedSpace);
                    $('#numPrice').val(response.d.RoomNumber);
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

        function Save() {
            var srv = $('#cmbServiceInfo option:selected').val();
            var gst = $('#cmbGuestTypeInfo option:selected').val();
            var cur = $('#cmbCurrencyInfo option:selected').val();
            var prc = $('#numPrice').val();

            if (srv == undefined) {
                swal('Анхааруулга', 'Үйлчилгээгээ сонгоно уу !', 'warning');
                return;
            }
            if (gst == undefined) {
                swal('Анхааруулга', 'Зочны төрөлөө сонгоно уу !', 'warning');
                return;
            }
            if (cur == undefined) {
                swal('Анхааруулга', 'Валютаа оруулна уу !', 'warning');
                return;
            }
            if (prc == '') {
                swal('Анхааруулга', 'Үйлчилгээний үнээ оруулна уу !', 'warning');
                return;
            }
                        
            $.ajax({
                url: 'post.aspx/SaveHTLServiceDetailInfo',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    type: act,
                    id: selid,
                    service: srv,
                    guest: gst,
                    currency: cur,
                    price: prc
                }),
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    if (msg.d == false) {
                        swal('Анхааруулга', 'Амжилтгүй боллоо !', 'warning');
                    }
                    else {
                        if (act == 1)
                            swal('Амжилттай', 'Амжилттай нэмэгдлээ !', 'success');
                        else if (act == 0) 
                            swal('Амжилттай', 'Амжилттай засагдлаа !', 'success');

                        $('#myModal').modal('hide');
                        Clear();

                        window.location.reload();
                    }
                }
            });
        }

        function Delete() {
            $.ajax({
                url: 'post.aspx/DeleteHTLServiceDetailInfo',
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

                        window.location.reload();
                    }
                }
            });
        }
    
    </script>

</asp:Content>
