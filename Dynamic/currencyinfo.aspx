﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="currencyinfo.aspx.cs" Inherits="Dynamic.currencyinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link rel="stylesheet" href="assets\css\sweetalert.min.css">
    <link rel="stylesheet" href="assets\css\sweetalert-overrides.css">

    <section class="main--content">

        <div class="panel">
            <div class="records--header">
                <div class="title fa-object-group">
                    <h3 class="h3">Валютын бүртгэл</h3>
                </div>
                <div class="actions" style="width: 100%;">
                    <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="Валютын нэр..."></asp:TextBox>
                    <button id="btnSearch" runat="server" type="submit" class="btn btn-rounded btn-dark" onserverclick="Search_ServerClick"><i class="fa fa-search"></i></button>
                    <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ валютын үүсгэх</a>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Валютын жагсаалт">

                <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">
                    <div class="table-responsive">
                        <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size: 11px; width: 100%;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Валют">Валют</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Валютын нэр">Валютын нэр</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үндсэн валют эсэх">Үндсэн валют эсэх</th>
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (System.Data.DataRow rw in dtCurrencyInfo.Rows)
                                    {
                                %>
                                <tr data-value="<%=rw["CurrencyID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                    <td><%=rw["CurrencyID"].ToString() %></td>
                                    <td><%=rw["CurrencyName"].ToString() %></td>
                                    <td><%=rw["IsMainCurrency"].ToString() %></td>
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft">
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                <div class="dropdown-menu">
                                                    <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["CurrencyID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["CurrencyID"].ToString() %>">Устгах</a>
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
                    <h5 class="modal-title">Валютын бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Валют</h5>
                                    <input class="form-control" type="text" id="txtID" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Валютын нэр</h5>
                                    <input class="form-control" type="text" id="txtName" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Үндсэн валют эсэх</h5>
                                    <%--<input class="form-control" type="text" id="chkIsMainCurrency" />--%>
                                    <label class="form-check">
                                        <input id="chkIsMainCurrency" type="checkbox" class="form-check-input">
                                        <span id="lblIsMainCurrency" class="form-check-label">Үндсэн валют биш</span>
                                    </label>
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
                    <h5>Энэ валютыг устгах уу ?</h5>
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

        var act = 0;
        var selid = 0;
        var rid = 0;
        
        function Clear() {
            $('#txtID').val("");
            $('#txtName').val("");
            $('#chkIsMainCurrency').prop('checked', false);
            act = 0;
            selid = 0;
        }

        $('#chkIsMainCurrency').change(function () {
            if (this.checked) {
                document.getElementById("lblIsMainCurrency").innerHTML = "Үндсэн валют мөн";

            } else {
                document.getElementById("lblIsMainCurrency").innerHTML = "Үндсэн валют биш";
            }
        });

        $('.editRow').on('click', function () {
            act = 1;
            selid = $(this).attr('data-id');
            $('#txtID').val(document.getElementById("recordsListView").rows[rid].cells[0].innerHTML);
            $('#txtID').attr("disabled", true);
            $('#txtName').val(document.getElementById("recordsListView").rows[rid].cells[1].innerHTML);
            if (document.getElementById("recordsListView").rows[rid].cells[2].innerHTML == 'Тийм') {
                $('#chkIsMainCurrency').prop('checked', true);
                document.getElementById("lblIsMainCurrency").innerHTML = "Үндсэн валют мөн";
            }
            else {
                $('#chkIsMainCurrency').prop('checked', false);
                document.getElementById("lblIsMainCurrency").innerHTML = "Үндсэн валют биш";
            }
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
            act = 0;
            selid = 0;
        }

        function Save() {
            var cid = $('#txtID').val().trim();
            var nam = $('#txtName').val().trim();
            var isc = $('#chkIsMainCurrency:checked').is(":checked");
            if (isc == true) {
                isc = 'Y';
            }
            else {
                isc = 'N';
            }

            if (cid == '') {
                swal('Анхааруулга', 'Валютаа оруулна уу !', 'warning');
                return;
            }
            if (nam == '') {
                swal('Анхааруулга', 'Валютын нэрээ оруулна уу !', 'warning');
                return;
            }
            
            $.ajax({
                url: 'post.aspx/SaveACCCurrencyInfo',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    type: act,
                    id: cid,
                    name: nam,
                    ismain: isc
                }),
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    if (msg.d != "Амжилттай") {
                        swal('Анхааруулга', 'Амжилтгүй боллоо ! ' + msg.d, 'warning');
                    }
                    else {
                        if (act == 0)
                            swal('Амжилттай', 'Амжилттай нэмэгдлээ !', 'success');
                        else if (act == 1) 
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
                url: 'post.aspx/DeleteACCCurrencyInfo',
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
                    if (msg.d != "Амжилттай") {
                        swal('Анхааруулга', 'Амжилтгүй боллоо ! ' + msg.d, 'warning');
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
