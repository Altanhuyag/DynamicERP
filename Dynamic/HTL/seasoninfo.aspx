<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="seasoninfo.aspx.cs" Inherits="Dynamic.seasoninfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="main--content">

        <div class="panel">
            <div class="records--header">
                <div class="title fa-snowflake">
                    <h3 class="h3">Улирлын бүртгэл</h3>
                </div>
                <div class="actions" style="width: 100%;">
                    <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="Улирлын нэр..."></asp:TextBox>
                    <button id="btnSearch" runat="server" type="submit" class="btn btn-rounded btn-dark" onserverclick="Search_ServerClick"><i class="fa fa-search"></i></button>
                    <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ улирал үүсгэх</a>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Улирлын жагсаалт">

                <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">
                    <div class="table-responsive">
                        <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size: 11px; width: 100%;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Улирлын нэр">Улирлын нэр</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Эхлэх сар">Эхлэх сар</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Дуусах сар">Дуусах сар</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Сар">Сар</th>
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (System.Data.DataRow rw in dtSeasonInfo.Rows)
                                    {
                                %>
                                <tr data-value="<%=rw["SeasonInfoPkID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                    <td><%=rw["SeasonName"].ToString() %></td>
                                    <td><%=rw["StartMonth"].ToString() %></td>
                                    <td><%=rw["FinishMonth"].ToString() %></td>
                                    <td><%=rw["MonthStr"].ToString() %></td>
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft">
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                <div class="dropdown-menu">
                                                    <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["SeasonInfoPkID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["SeasonInfoPkID"].ToString() %>">Устгах</a>
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
                    <h5 class="modal-title">Улирлын бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Улирлын нэр</h5>
                                    <input class="form-control" type="text" id="txtName" />
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Эхлэх сар</h5>
                                    <input class="form-control" type="number" id="numStart" />
                                </div>          
                                <div class="col-md-4">
                                    <h5>Дуусах сар</h5>
                                    <input class="form-control" type="number" id="numFinish" />
                                </div>          
                                <div class="col-md-4">
                                    <h5>Сар</h5>
                                    <input class="form-control" type="text" id="numMstr" disabled />
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
                    <h5>Улирлын бүртгэлийг устгах уу ?</h5>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Болих</button>
                    <button type="button" class="btn btn-rounded btn-danger" onclick="Delete()">Устгах</button>
                </div>
            </div>
        </div>
    </div>
    
    <script type = "text/javascript">

        var act = 1;
        var selid = 0;
        var rid = 0;
        
        $("#numStart").focusout(function () {
            GetMontsBetween();
        });

        $("#numFinish").focusout(function () {
            GetMontsBetween();
        });

        function GetMontsBetween() {
            var months = "";
            var str = $('#numStart').val().trim();
            var fns = $('#numFinish').val().trim();

            if (str != "" && fns != "") {
                while (str != fns) {
                    months += padDigits(str, 2) + ",";
                    if (str < 12) {
                        str++;
                    }
                    else {
                        str = 1;
                    }
                }
                months += padDigits(fns, 2);
            }

            $('#numMstr').val(months);
        }

        function padDigits(number, digits) {
            return Array(Math.max(digits - String(number).length + 1, 0)).join(0) + number;
        }
        
        function Clear() {
            $('#txtName').val("");
            $('#numStart').val("");
            $('#numFinish').val("");
            $('#numMstr').val("");
            act = 1;
            selid = 0;
        }

        $('.editRow').on('click', function () {
            act = 0;
            selid = $(this).attr('data-id');
            $('#txtName').val(document.getElementById("recordsListView").rows[rid].cells[0].innerHTML);
            $('#numStart').val(document.getElementById("recordsListView").rows[rid].cells[1].innerHTML);
            $('#numFinish').val(document.getElementById("recordsListView").rows[rid].cells[2].innerHTML);
            $('#numMstr').val(document.getElementById("recordsListView").rows[rid].cells[3].innerHTML);
            document.getElementById("btnSave").innerHTML = "Засах";
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
            var nam = $('#txtName').val().trim();
            var str = $('#numStart').val().trim();
            var fns = $('#numFinish').val().trim();
            var mst = $('#numMstr').val().trim();

            if (nam == '') {
                swal('Анхааруулга', 'Улирлын нэрээ оруулна уу !', 'warning');
                return;
            }
            if (str == '') {
                swal('Анхааруулга', 'Эхлэх сараа оруулна уу !', 'warning');
                return;
            }
            if (fns == '') {
                swal('Анхааруулга', 'Дуусах сараа оруулна уу !', 'warning');
                return;
            }
            if (mst == '') {
                swal('Анхааруулга', 'Сараа оруулна уу !', 'warning');
                return;
            }
            
            $.ajax({
                url: '../post.aspx/SaveSeasonInfo',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    type: act,
                    id: selid,
                    name: nam,
                    start: str,
                    finish: fns,
                    mstr: mst
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
                url: '../post.aspx/DeleteSeasonInfo',
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
