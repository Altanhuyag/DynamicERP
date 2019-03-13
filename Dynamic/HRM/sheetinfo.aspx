<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="sheetinfo.aspx.cs" Inherits="Dynamic.sheetinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <section class="main--content">

        <div class="panel">
            <div class="records--header">
                <div class="title fa-object-group">
                    <h3 class="h3">Маягт тодорхойлолтын бүртгэл</h3>
                </div>
                <div class="actions" style="width: 100%;">
                    <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ маягт тодорхойлолтын бүртгэл үүсгэх</a>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Маягт тодорхойлолтын бүртгэлийн жагсаалт">

                <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">
                    <div class="table-responsive">
                        <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size: 11px; width: 100%;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Маягт тодорхойолтын нэр">Маягт тодорхойолтын нэр</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Эрэмбэ">Эрэмбэ</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Файлын нэр">Файлын нэр</th>
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (System.Data.DataRow rw in dtSheetInfo.Rows)
                                    {
                                %>
                                <tr data-value="<%=rw["SheetInfoPkID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                    <td><%=rw["SheetInfoName"].ToString() %></td>
                                    <td><%=rw["SheetOrder"].ToString() %></td>
                                    <td><%=rw["SheetFileName"].ToString() %></td>
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft">
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                <div class="dropdown-menu">
                                                    <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["SheetInfoPkID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["SheetInfoPkID"].ToString() %>">Устгах</a>
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
                    <h5 class="modal-title">Маягт тодорхойлолтын бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Маягт тодорхойолтын нэр</h5>
                                    <input class="form-control" type="text" id="txtSheetInfoName" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Эрэмбэ</h5>
                                    <input class="form-control" type="text" id="txtSheetOrder" />
                                </div>          
                            </div>
                             <div class="row">
                                <div class="col-md-12">
                                    <h5>Файлын нэр</h5>
                                    <input class="form-control" type="text" id="txtSheetFileName" />
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
                    <h5>Энэ тодорхойлолтын бүртгэлийг устгах уу ?</h5>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Болих</button>
                    <button type="button" class="btn btn-rounded btn-danger" onclick="Delete()">Устгах</button>
                </div>
            </div>
        </div>
    </div>
    
    <script type = "text/javascript">

        var act = 0;
        var selid = 0;
        var rid = 0;
        
        function Clear() {
            $('#txtSheetInfoName').val("");
            $('#txtSheetOrder').val("");
            $('#txtSheetFileName').val("");
            act = 0;
            selid = 0;
        }

        $('.editRow').on('click', function () {
            act = 1;
            selid = $(this).attr('data-id');
            $('#txtSheetInfoName').val(document.getElementById("recordsListView").rows[rid].cells[0].innerHTML);
            $('#txtSheetOrder').val(document.getElementById("recordsListView").rows[rid].cells[1].innerHTML);
            $('#txtSheetFileName').val(document.getElementById("recordsListView").rows[rid].cells[2].innerHTML);
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
            var info = $('#txtSheetInfoName').val().trim();
            var order = $('#txtSheetOrder').val().trim();
            var file = $('#txtSheetFileName').val().trim();

            if (info == '') {
                swal('Анхааруулга', 'Тодорхойлолтын нэрээ оруулна уу !', 'warning');
                return;
            }
            if (order == '') {
                swal('Анхааруулга', 'Эрэмбээ оруулна уу !', 'warning');
                return;
            }
            if (file == '') {
                swal('Анхааруулга', 'Файлын нэрээ оруулна уу !', 'warning');
                return;
            }

            
            $.ajax({
                url: '../post.aspx/SaveHRMSheetInfo',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    adding: act,
                    id: selid,
                    SheetInfoName: info,
                    SheetOrder: order,
                    SheetFileName: file
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
                url: '../post.aspx/DeleteHRMSheetInfo',
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
