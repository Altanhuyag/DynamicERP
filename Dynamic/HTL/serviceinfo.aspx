<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="serviceinfo.aspx.cs" Inherits="Dynamic.serviceinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="main--content">

        <div class="panel">
            <div class="records--header">
                <div class="title fa-hand-paper ">
                    <h3 class="h3">Үйлчилгээний бүртгэл</h3>
                </div>
                <div class="actions" style="width: 100%;">
                    <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="Үйлчилгээний нэр..."></asp:TextBox>
                    <button id="btnSearch" runat="server" type="submit" class="btn btn-rounded btn-dark" onserverclick="Search_ServerClick"><i class="fa fa-search"></i></button>
                    <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ үйлчилгээ үүсгэх</a>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Үйлчилгээний жагсаалт">

                <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">
                    <div class="table-responsive">
                        <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size: 11px; width: 100%;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үйлчилгээний нэр">Үйлчилгээний нэр</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үйлчилгээний тайлбар">Үйлчилгээний тайлбар</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Үнэ өөрчлөгдөх эсэх">Үнэ өөрчлөгдөх эсэх</th>
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (System.Data.DataRow rw in dtServiceInfo.Rows)
                                    {
                                %>
                                <tr data-value="<%=rw["ServiceInfoPkID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                    <td><%=rw["ServiceName"].ToString() %></td>
                                    <td><%=rw["ServiceDescr"].ToString() %></td>
                                    <td><%=rw["IsChangePrice"].ToString() %></td>
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft">
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                <div class="dropdown-menu">
                                                    <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["ServiceInfoPkID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["ServiceInfoPkID"].ToString() %>">Устгах</a>
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
                    <h5 class="modal-title">Үйлчилгээний бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Үйлчилгээний нэр</h5>
                                    <input class="form-control" type="text" id="txtName" />
                                </div>          
                                <div class="col-md-6">
                                    <h5>Үнэ өөрчлөгдөх эсэх</h5>
                                    <label class="form-check">
                                        <input id="chkIsChangePrice" type="checkbox" class="form-check-input">
                                        <span id="lblIsChangePrice" class="form-check-label">Үнэ өөрчлөгдөхгүй</span>
                                    </label>
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Үйлчилгээний тайлбар</h5>
                                    <input class="form-control" type="text" id="txtDesc" />
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
                    <h5>Энэ үйлчилгээг устгах уу ?</h5>
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
        
        function Clear() {
            $('#txtName').val("");
            $('#txtDesc').val("");
            $('#chkIsChangePrice').prop('checked', false);
            act = 1;
            selid = 0;
        }

        $('#chkIsChangePrice').change(function () {
            if (this.checked) {
                document.getElementById("lblIsChangePrice").innerHTML = "Үнэ өөрчлөгдөнө";

            } else {
                document.getElementById("lblIsChangePrice").innerHTML = "Үнэ өөрчлөгдөхгүй";
            }
        });

        $('.editRow').on('click', function () {
            act = 0;
            selid = $(this).attr('data-id');
            $('#txtName').val(document.getElementById("recordsListView").rows[rid].cells[0].innerHTML);
            $('#txtDesc').val(document.getElementById("recordsListView").rows[rid].cells[1].innerHTML);
            if (document.getElementById("recordsListView").rows[rid].cells[2].innerHTML == 'Тийм') {
                $('#chkIsChangePrice').prop('checked', true);
                document.getElementById("lblIsChangePrice").innerHTML = "Үнэ өөрчлөгдөнө";
            }
            else {
                $('#chkIsChangePrice').prop('checked', false);
                document.getElementById("lblIsChangePrice").innerHTML = "Үнэ өөрчлөгдөхгүй";
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
            act = 1;
            selid = 0;
        }

        function Save() {
            var nam = $('#txtName').val().trim();
            var dsc = $('#txtDesc').val().trim();
            var isc = $('#chkIsChangePrice:checked').is(":checked");

            if (nam == '') {
                swal('Анхааруулга', 'Үйлчилгээний нэрээ оруулна уу !', 'warning');
                return;
            }
            if (dsc == '') {
                swal('Анхааруулга', 'Үйлчилгээний тайлбараа оруулна уу !', 'warning');
                return;
            }
            
            $.ajax({
                url: '../post.aspx/SaveHTLServiceInfo',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    type: act,
                    id: selid,
                    name: nam,
                    description: dsc,
                    ischange: isc
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
                url: '../post.aspx/DeleteHTLServiceInfo',
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
