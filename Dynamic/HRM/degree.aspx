<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="degree.aspx.cs" Inherits="Dynamic.degree" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="main--content">

        <div class="panel">
            <div class="records--header">
                <div class="title fa-object-group">
                    <h3 class="h3">Эрдмийн зэрэг</h3>
                </div>
                <div class="actions" style="width: 100%;">
                    <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ эрдмийн зэрэг бүртгэл үүсгэх</a>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Эрдмийн зэргийн жагсаалт">

                <div id="recordsListView_wrapper" class="dataTables_wrapper no-footer">
                    <div class="table-responsive">
                        <table id="recordsListView" class="dataTable no-footer" aria-describedby="recordsListView_info" style="font-size: 11px; width: 100%;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" hidden aria-label="EmployeeInfoPkID">EmployeeInfoPkID</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Нэр">Нэр</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Регистр">Регистр</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" hidden aria-label="DegreeInfoPkID">DegreeInfoPkID</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Зэрэг цол">Зэрэг цол</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Сэдэв">Сэдэв</th>
                                    <th class="sorting" tabindex="0" aria-controls="recordsListView" rowspan="1" colspan="1" aria-label="Авсан огноо">Авсан огноо</th>
                                    <th class="not-sortable sorting_disabled" rowspan="1" colspan="1" aria-label="Actions">Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% foreach (System.Data.DataRow rw in dtdegree.Rows)
                                    {
                                %>
                                <tr data-value="<%=rw["DegreePkID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                    <td hidden><%=rw["EmployeeInfoPkID"].ToString() %></td>
                                    <td><%=rw["FirstName"].ToString() %></td>
                                    <td><%=rw["RegisterNo"].ToString() %></td>
                                    <td hidden><%=rw["DegreeInfoPkID"].ToString() %></td>
                                    <td><%=rw["DegreeInfoName"].ToString() %></td>
                                    <td><%=rw["DegreeSubject"].ToString() %></td>
                                    <td><%=rw["DegreeDate"].ToString() %></td>
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft">
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                <div class="dropdown-menu">
                                                    <a href="#myModal" class="dropdown-item editRow" data-toggle="modal" data-id="<%=rw["DegreePkID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal" class="dropdown-item deleteRow" data-toggle="modal" data-todoapp="del:item" data-id="<%=rw["DegreePkID"].ToString() %>">Устгах</a>
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
                    <h5 class="modal-title">Эрдминй цол зэрэгийн бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>
                
                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Регистрийн дугаар</h5>
                                    <select class="form-control" id="cmbEmployeeInfo">
                                        <% foreach (System.Data.DataRow rw in dtemployees.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["EmployeeInfoPkID"].ToString() %>"><%=rw["FullName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                     <h5>Эрдмийн зэрэг</h5>
                                    <select class="form-control" id="cmbDegreeInfo">
                                        <% foreach (System.Data.DataRow rw in dtdegreeInfo.Rows)
                                            {
                                        %>
                                            <option value="<%=rw["DegreeInfoPkID"].ToString() %>"><%=rw["DegreeInfoName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Эрдмийн зэрэг авсан сэдэв</h5>
                                    <input class="form-control" type="text" id="txtSubject" />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>Эрдмийн зэргийн огноо</h5>
                                    <%--<input class="form-control" type="datetime" id="txtDate" />--%>
                                    <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
                                        <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1"/>
                                        <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
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
                    <h5>Энэ эрдмийн цол зэргийг устгах уу ?</h5>
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
        
        $(function () {
            $('#datetimepicker1').datetimepicker({
                format: 'YYYY-MM-DD',
                date: moment()
            });
        });

        function Clear() {
            $('#cmbEmployeeInfo').val("");
            $('#cmbDegreeInfo').val("");
            $('#txtSubject').val("");
            $('#datetimepicker1').val("");
            act = 0;
            selid = 0;
        }

        $('.editRow').on('click', function () {
            act = 1;
            selid = $(this).attr('data-id');
            $('#cmbEmployeeInfo').val(document.getElementById("recordsListView").rows[rid].cells[0].innerHTML);
            $('#cmbDegreeInfo').val(document.getElementById("recordsListView").rows[rid].cells[3].innerHTML);
            $('#txtSubject').val(document.getElementById("recordsListView").rows[rid].cells[5].innerHTML);
            $('#datetimepicker1').val(document.getElementById("recordsListView").rows[rid].cells[6].innerHTML);
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
            var emp = $('#cmbEmployeeInfo').val().trim();
            var deg = $('#cmbDegreeInfo').val().trim();
            var sub = $('#txtSubject').val().trim();
            var dat = moment($('#datetimepicker1').datetimepicker('viewDate')).format('YYYY-MM-DD');

            if (emp == '') {
                swal('Анхааруулга', 'Регистрийн дугаар оруулна уу !', 'warning');
                return;
            }
            if (deg == '') {
                swal('Анхааруулга', 'Эрдмийн зэрэгээ оруулна уу !', 'warning');
                return;
            }
            if (sub == '') {
                swal('Анхааруулга', 'Эрдмийн зэрэг авсан сэдэвээ оруулна уу !', 'warning');
                return;
            }
            if (dat == '') {
                swal('Анхааруулга', 'Эрдмийн зэргийн огноогоо оруулна уу !', 'warning');
                return;
            }
            
            $.ajax({
                url: '../post.aspx/SaveHRMDegree',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    adding: act,
                    id: selid,
                    emppkid: emp,
                    degpkid: deg,
                    subject: sub,
                    date: dat
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
                url: '../post.aspx/DeleteHRMDegree',
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
