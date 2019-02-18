<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="roominfo.aspx.cs" Inherits="Dynamic.roominfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link rel="stylesheet" href="assets\css\sweetalert.min.css">
    <link rel="stylesheet" href="assets\css\sweetalert-overrides.css">

    <section class="main--content">

        <div class="panel">
            <div class="records--header">
                <div class="title fa-cube">
                    <h3 class="h3">Өрөөний бүртгэл</h3>
                </div>
                <div class="actions" style="width: 100%;">
                    <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="Өрөөний дугаар..."></asp:TextBox>
                    <button id="btnSearch" runat="server" type="submit" class="btn btn-rounded btn-dark" onserverclick="Search_ServerClick"><i class="fa fa-search"></i></button>
                    <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ өрөөний бүртгэл үүсгэх</a>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Өрөөний бүртгэлийн жагсаалт">

                <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">
                    <div class="table-responsive">
                        <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size: 11px; width: 100%;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Бүлэг">Бүлэг</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Ангилал">Ангилал</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Орны тоо">Орны тоо</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Дугаар">Дугаар</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Давхар">Давхар</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Дотуур холбоо">Дотуур холбоо</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Тайлбар">Тайлбар</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Минибартай эсэх">Минибартай эсэх</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Мини барны загвар">Мини барны загвар</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Жигүүр">Жигүүр</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Зочны тоо">Зочны тоо</th>
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (System.Data.DataRow rw in dtRoomInfo.Rows)
                                    {
                                %>
                                <tr data-value="<%=rw["RoomPkID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                    <td><%=rw["GroupName"].ToString() %></td>
                                    <td><%=rw["TypeName"].ToString() %></td>
                                    <td><%=rw["RoomBedSpace"].ToString() %></td>
                                    <td><%=rw["RoomNumber"].ToString() %></td>
                                    <td><%=rw["RoomFloor"].ToString() %></td>
                                    <td><%=rw["RoomPhone"].ToString() %></td>
                                    <td><%=rw["RoomDescr"].ToString() %></td>
                                    <td><%=rw["IsMiniBar"].ToString() %></td>
                                    <td><%=rw["MiniBarTypeName"].ToString() %></td>
                                    <td><%=rw["FactionName"].ToString() %></td>
                                    <td><%=rw["GuestSpace"].ToString() %></td>
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft">
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                <div class="dropdown-menu">
                                                    <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["RoomPkID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["RoomPkID"].ToString() %>">Устгах</a>
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
                    <h5 class="modal-title">Өрөөний бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Өрөөний бүлэг</h5>
                                    <select class="form-control" id="cmbGroupInfo">
                                        <% foreach (System.Data.DataRow rw in dtRoomGroupInfo.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["GroupPkID"].ToString() %>"><%=rw["GroupName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <h5>Өрөөний ангилал</h5>
                                    <select class="form-control" id="cmbTypeInfo">
                                        <% foreach (System.Data.DataRow rw in dtRoomTypeInfo.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["RoomTypePkID"].ToString() %>"><%=rw["TypeName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Орны тоо</h5>
                                    <input class="form-control" type="number" id="numRoomBedSpace" />
                                </div>
                                <div class="col-md-4">
                                    <h5>Өрөөний дугаар</h5>
                                    <input class="form-control" type="number" id="numRoomNumber" />
                                </div>  
                                <div class="col-md-4">
                                    <h5>Өрөөний давхарын дугаар</h5>
                                    <input class="form-control" type="number" id="numRoomFloor" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Өрөөний дотуур холбоо</h5>
                                    <input class="form-control" type="text" id="txtRoomPhone" />
                                </div>  
                                <div class="col-md-6">
                                    <h5>Өрөөний тайлбар</h5>
                                    <input class="form-control" type="text" id="txtRoomDescr" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Минибартай эсэх</h5>
                                    <label class="form-check">
                                        <input id="chkIsMiniBar" type="checkbox" class="form-check-input">
                                        <span id="lblIsMiniBar" class="form-check-label">Минибар байхгүй</span>
                                    </label>
                                </div> 
                                <div class="col-md-6">
                                    <h5>Мини барны загвар</h5>
                                    <select class="form-control" id="cmbMiniBarTypeInfo" disabled>
                                        <% foreach (System.Data.DataRow rw in dtMiniBarTypeInfo.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["MiniBarTypeInfoPkID"].ToString() %>"><%=rw["MiniBarTypeName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                 <div class="col-md-6">
                                    <h5>Жигүүр</h5>
                                    <select class="form-control" id="cmbFactionInfo">
                                        <% foreach (System.Data.DataRow rw in dtFactionInfo.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["FactionInfoPkID"].ToString() %>"><%=rw["FactionName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div> 
                                <div class="col-md-6">
                                    <h5>Байрлах зочны тоо</h5>
                                    <input class="form-control" type="number" id="numGuestSpace" />
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
                    <h5>Энэ өрөөний бүртгэлийг устгах уу ?</h5>
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
            $('#cmbGroupInfo').val("");
            $('#cmbTypeInfo').val("");
            $('#numRoomBedSpace').val("");
            $('#numRoomNumber').val("");
            $('#numRoomFloor').val("");
            $('#txtRoomPhone').val("");
            $('#txtRoomDescr').val("");
            $('#chkIsMiniBar').prop('checked', false);
            $('#cmbMiniBarTypeInfo').val("");
            $('#cmbMiniBarTypeInfo').attr("disabled", true); 
            $('#cmbFactionInfo').val("");
            $('#numGuestSpace').val("");
            act = 1;
            selid = 0;
        }
        
        $('#chkIsMiniBar').change(function() {
            if (this.checked) {
                document.getElementById("lblIsMiniBar").innerHTML = "Минибар байгаа";
                $('#cmbMiniBarTypeInfo').attr("disabled", false); 

            } else {
                document.getElementById("lblIsMiniBar").innerHTML = "Минибар байхгүй";
                $('#cmbMiniBarTypeInfo').attr("disabled", true); 
            }
        });
        
        $('.editRow').on('click', function () {
            act = 0;
            selid = $(this).attr('data-id');
            document.getElementById("btnSave").innerHTML = "Засах";

            $.ajax({
                url: 'post.aspx/GetRoomInfo',
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
                    
                    $('#cmbGroupInfo').val(response.d.GroupPkID);
                    $('#cmbTypeInfo').val(response.d.RoomTypePkID);
                    $('#numRoomBedSpace').val(response.d.RoomBedSpace);
                    $('#numRoomNumber').val(response.d.RoomNumber);
                    $('#numRoomFloor').val(response.d.RoomFloor);
                    $('#txtRoomPhone').val(response.d.RoomPhone);
                    $('#txtRoomDescr').val(response.d.RoomDescr);
                    $('#cmbMiniBarTypeInfo').val(response.d.MiniBarTypeInfoPkID);
                    $('#cmbFactionInfo').val(response.d.FactionInfoPkID);
                    $('#numGuestSpace').val(response.d.GuestSpace);
                    
                    if (response.d.IsMiniBar == "T")
                    {
                        $('#chkIsMiniBar').prop('checked', true);
                        $('#cmbMiniBarTypeInfo').attr("disabled", false);
                    }
                    else
                    {
                        $('#chkIsMiniBar').prop('checked', false);
                        $('#cmbMiniBarTypeInfo').attr("disabled", true);
                    }
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
            var grp = $('#cmbGroupInfo option:selected').val();
            var typ = $('#cmbTypeInfo option:selected').val();
            var bed = $('#numRoomBedSpace').val();
            var num = $('#numRoomNumber').val();
            var flr = $('#numRoomFloor').val();
            var phn = $('#txtRoomPhone').val().trim();
            var dsc = $('#txtRoomDescr').val().trim();
            var isb = $('#chkIsMiniBar:checked').is(":checked");
            var btp = $('#cmbMiniBarTypeInfo option:selected').val();
            var fac = $('#cmbFactionInfo option:selected').val();
            var gst = $('#numGuestSpace').val();

            if (grp == undefined) {
                swal('Анхааруулга', 'Өрөөний бүлгээ сонгоно уу !', 'warning');
                return;
            }
            if (typ == undefined) {
                swal('Анхааруулга', 'Өрөөний ангилалаа сонгоно уу !', 'warning');
                return;
            }
            if (bed == '') {
                swal('Анхааруулга', 'Орны тоогоо оруулна уу !', 'warning');
                return;
            }
            if (num == '') {
                swal('Анхааруулга', 'Өрөөний дугаараа оруулна уу !', 'warning');
                return;
            }
            if (flr == '') {
                swal('Анхааруулга', 'Өрөөний давхарын дугаараа оруулна уу !', 'warning');
                return;
            }
            if (phn == '') {
                swal('Анхааруулга', 'Өрөөний дотуур холбоогоо оруулна уу !', 'warning');
                return;
            }
            if (dsc == '') {
                swal('Анхааруулга', 'Өрөөний тайлбараа оруулна уу !', 'warning');
                return;
            }
            if (isb == true && btp == undefined) {
                swal('Анхааруулга', 'Мини барны загвараа сонгоно уу !', 'warning');
                return;
            }
            if (fac == undefined) {
                swal('Анхааруулга', 'Жигүүрээ сонгоно уу !', 'warning');
                return;
            }
            if (gst == '') {
                swal('Анхааруулга', 'Байрлах зочны тоогоо оруулна уу !', 'warning');
                return;
            }
            if (isb == false) {
                btp = "";
            }
            
            $.ajax({
                url: 'post.aspx/SaveRoomInfo',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    type: act,
                    id: selid,
                    GroupPkID: grp,
                    RoomTypePkID: typ,
                    RoomBedSpace: bed,
                    RoomNumber: num,
                    RoomFloor: flr,
                    RoomPhone: phn,
                    RoomDescr: dsc,
                    IsMiniBar: isb,
                    MiniBarTypeInfoPkID: btp,
                    FactionInfoPkID: fac,
                    GuestSpace: gst
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
                url: 'post.aspx/DeleteRoomInfo',
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
