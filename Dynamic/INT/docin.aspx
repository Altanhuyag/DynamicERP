<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="docin.aspx.cs" Inherits="Dynamic.docin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="../assets/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
    <script src="../assets/js/moment.js"></script>
    <script src="../assets/js/tempusdominus-bootstrap-4.min.js"></script>

    <link href="../assets/css/bootstrap-table.min.css" rel="stylesheet" />

    <script src="../assets/js/tableExport.min.js"></script>
    <script src="../assets/js/jspdf.min.js"></script>
    <script src="../assets/js/jspdf.plugin.autotable.js"></script>
    <script src="../assets/js/xlsx.core.min.js"></script>

    <script src="../assets/js/bootstrap-table.min.js"></script>
    <script src="../assets/js/bootstrap-table-export.min.js"></script>
    <script src="../assets/js/bootstrap-table-locale-all.min.js"></script>  
    
    <style> td { max-width: 130px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; } </style>

    <section class="main--content">

        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Ирсэн бичгийн бүртгэл</h3>
            </div>
            <div id="toolbar" style="margin-right:15px">
                <a href="#edtModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ ирсэн бичиг үүсгэх</a>
            </div>
            <div style="margin-right:10px; margin-left:10px">
                <table 
                    id="tbMain"
                    data-toggle="table" 
                    data-toolbar="#toolbar"
                    data-locale="mn-MN"
                    data-show-columns="true" 
                    data-minimum-count-columns="3" 
                    data-search="true"
                    data-search-align="left" 
                    data-pagination="true" 
                    data-pagination-pre-text="Өмнөх" 
                    data-pagination-next-text="Дараах"
                    data-show-pagination-switch="true"
                    data-show-toggle="true" 
                    data-show-fullscreen="true"
                    data-show-export="true"
                    data-export-types="['excel']"
                    data-export-data-type="all"
                    data-resizable="true"
                    data-export-options='{
                      "fileName": "docin"
                    }'
                    >
                <thead>
                    <tr>
                        <th data-sortable="true" data-field="DocumentDate">Бичгийн огноо</th>
                        <th data-sortable="true" data-field="DocumentNo">Дугаар</th>
                        <th data-sortable="true" data-field="CompanyName">Хаанаас, хэнээс</th>
                        <th data-sortable="true" data-field="Subject">Товч утга</th>
                        <th data-sortable="true" data-field="PageCnt">Хуудасны тоо</th>
                        <th data-sortable="true" data-field="CreatedDate">Үүсгэсэн огноо</th>
                        <th data-sortable="true" data-field="StatusName">Төлөв</th>
                        <th data-sortable="true" data-field="IsReturnName">Буцах эсэх</th>
                        <th data-sortable="true" data-field="ReturnDate">Хариу өгөх огноо</th>
                        <th data-sortable="true" data-field="ReturnDescr">Хариуны товч тайлбар</th>
                        <th data-sortable="true" data-field="Action">Үйлдэл</th>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (System.Data.DataRow rw in dtDocuments.Rows)
                        {
                    %>
                    <tr>
                        <td style="text-align:center"><%=rw["DocumentDate"].ToString() %></td>
                        <td style="text-align:center">
                            <%--<span class="label label-green">--%>
                                <a href="doc_detail.aspx?dId=<%=rw["DocumentPkID"].ToString() %>" target="_blank"><%=rw["DocumentNo"].ToString() %></a>
                            <%--</span>--%>
                        </td>
                        <td style="text-align:left" title="<%=rw["CompanyName"].ToString() %>"><%=rw["CompanyName"].ToString() %></td>
                        <td style="text-align:left" title="<%=rw["Subject"].ToString() %>"><%=rw["Subject"].ToString() %></td>
                        <td style="text-align:center"><%=rw["PageCnt"].ToString() %></td>
                        <td style="text-align:center"><%=Convert.ToDateTime(rw["CreatedDate"]).ToString("yyyy-MM-dd") %></td>
                        <td style="text-align:center"><%=rw["StatusName"].ToString() %></td>
                        <td style="text-align:center"><%=rw["IsReturnName"].ToString() %></td>
                        <td style="text-align:center"><%=Convert.ToDateTime(rw["ReturnDate"]).ToString("yyyy-MM-dd HH:mm") %></td>
                        <td style="text-align:left" title="<%=rw["ReturnDescr"].ToString() %>"><%=rw["ReturnDescr"].ToString() %></td>
                        <td>
                            <div class="row">
                                <div class="todo--actions">
                                    <a href="JavaScript:Void(0);" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                    <div class="dropdown-menu">
                                        <a href="#" class="dropdown-item" onclick="viewRow('<%=rw["DocumentFilePath"].ToString() %>');return false;">Файл үзэх</a>
                                        <%
                                            if(rw["UserPkID"].ToString() == Session["UserPkID"].ToString())
                                            { 
                                        %>
                                        <a href="#empModal" class="dropdown-item" data-toggle="modal" onclick="addEmpRow('<%=rw["DocumentPkID"].ToString() %>', '<%=Convert.ToDateTime(rw["ReturnDate"]).ToString("yyyy-MM-dd HH:mm") %>', '<%=rw["ReturnDescr"].ToString() %>', '<%=rw["Emps"].ToString() %>', '<%=rw["Deps"].ToString() %>', '<%=rw["IsReturn"].ToString() %>', '<%=Convert.ToDateTime(rw["DocumentDate"]).ToString("yyyy-MM-dd") %>')">Шилжүүлэх</a>
                                        <a href="#edtModal" class="dropdown-item" data-toggle="modal" onclick="editRow('<%=rw["DocumentPkID"].ToString() %>', '<%=Convert.ToDateTime(rw["DocumentDate"]).ToString("yyyy-MM-dd") %>', '<%=rw["DocumentNo"].ToString() %>', '<%=rw["CompanyName"].ToString() %>', '<%=rw["Subject"].ToString() %>', <%=rw["PageCnt"].ToString() %>, '<%=rw["DocumentFilePath"].ToString() %>', '<%=rw["StatusID"].ToString() %>', '<%=rw["IsReturn"].ToString() %>', '<%=Convert.ToDateTime(rw["ReturnDate"]).ToString("yyyy-MM-dd HH:mm") %>', '<%=rw["ReturnDescr"].ToString() %>', '<%=rw["Emps"].ToString() %>', '<%=rw["Deps"].ToString() %>')">Засах</a>
                                        <a href="#remModal" class="dropdown-item" data-toggle="modal" onclick="deleteRow('<%=rw["DocumentPkID"].ToString() %>', '<%=rw["DocumentFilePath"].ToString() %>')">Устгах</a>
                                        <%
                                            }
                                        %>
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
            <br />
        </div>

    </section>

    <div class="modal fade" id="edtModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                
                <div class="modal-header">
                    <h5 class="modal-title">Ирсэн бичгийн бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">        
                    <div class="form-group">  
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Хаанаас, хэнээс</h5>
                                <input autocomplete="off" class="form-control" type="text" id="txtCompanyName"/>
                            </div>          
                            <div class="col-md-6">
                                <h5>Товч утга</h5>
                                <input autocomplete="off" class="form-control" type="text" id="txtSubject"/>
                            </div>          
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Бичгийн огноо</h5>
                                <div class="input-group date" id="dteDocument" data-target-input="nearest">
                                    <input type="text" id="txtDocument" class="form-control datetimepicker-input" data-target="#dteDocument" />
                                    <div class="input-group-append" data-target="#dteDocument" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-md-6">
                                <h5>Файл</h5>
                                <label class="custom-file"> 
                                    <input type="file" id="pdfFile" name="pdfFile" class="custom-file-input" accept="application/pdf" /> 
                                    <span id="txtUploadedFile" class="custom-file-label" style="overflow:hidden">PDF Файл сонгох</span> 
                                </label>
                            </div>       
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <h5>Дугаар</h5>
                                <input autocomplete="off" class="form-control" type="text" id="txtDocumentNo"/>
                            </div>  
                            <div class="col-md-4">
                                <h5>Хуудасны тоо</h5>
                                <input autocomplete="off" class="form-control" type="number" value="0" min="0" id="numPageCnt"/>
                            </div>   
                            <div class="col-md-4">
                                <h5>Төлөв</h5>
                                <select class="form-control" id="cmbStatus">
                                    <% foreach (System.Data.DataRow rw in dtDocumentsStatus.Rows)
                                        {
                                    %>
                                        <option value="<%=rw["ConstKey"].ToString() %>"><%=rw["ValueStr1"].ToString() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div> 
                        </div> 
                        <div class="row">
                            <div class="col-md-6">
                                <br />
                                <div class="form-group pt-1 pb-1">
                                    <label class="form-check">
                                        <input type="checkbox" id="chkIsAll" class="form-check-input">
                                        <span class="form-check-label IsAll" style="color:rgb(153, 153, 153);">Бүх ажилчидад мэдэгдэх</span>
                                    </label>
                                </div>
                            </div> 
                            <div class="col-md-6">
                                <br />
                                <div class="form-group pt-1 pb-1">
                                    <label class="form-check">
                                        <input type="checkbox" id="chkIsEmp" class="form-check-input" checked="checked">
                                        <span class="form-check-label IsEmp" style="color:rgb(153, 153, 153);">Сонгогдсон ажилчидад мэдэгдэх</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row"> 
                            <div class="col-md-6">
                                <div class="form-group pt-1 pb-1">
                                    <label class="form-check">
                                        <input type="checkbox" id="chkIsReturn" class="form-check-input">
                                        <span class="form-check-label" style="color:rgb(153, 153, 153);">Хариу өгөх эсэх</span>
                                    </label>
                                </div>
                            </div> 
                                  
                            <div class="col-md-6">
                                <div class="form-group pt-1 pb-1">
                                    <label class="form-check">
                                        <input type="checkbox" id="chkIsDep" class="form-check-input" checked="checked">
                                        <span class="form-check-label IsDep" style="color:rgb(153, 153, 153);">Хариуг хэлтсүүдээр өгүүлэх</span>
                                    </label>
                                </div>
                            </div>          
                        </div> 
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Хэлтсүүд</h5>
                                <select class="form-control js-example-basic-multiple" style="width:100%" id="cmbRetDeps" multiple="multiple">
                                    <% foreach (System.Data.DataRow rw in dtDepartments.Rows)
                                        {
                                    %>
                                        <option value="<%=rw["DepartmentPkID"].ToString() %>"><%=rw["DepartmentName"].ToString() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <h5>Ажилчид</h5>
                                <select class="form-control js-example-basic-multiple" style="width:100%" id="cmbRetEmps" multiple="multiple" disabled="disabled">
                                    <% foreach (System.Data.DataRow rw in dtDepartments.Rows)
                                        {
                                    %>
                                        <optgroup label="<%=rw["DepartmentName"].ToString() %>">
                                            <%
                                                foreach(System.Data.DataRow row in dtEmployees.Select("DepartmentPkID = " + rw["DepartmentPkID"].ToString()))
                                                { 
                                            %>
                                                    <option value="<%=row["EmployeeInfoPkID"].ToString() %>"><%=row["FullName"].ToString() %></option>
                                            <%
                                                }
                                            %>
                                        </optgroup>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="row">      
                            <div class="col-md-6">
                                <h5>Хариу өгөх огноо</h5>
                                <div class="input-group date" id="dteReturnDate" data-target-input="nearest">
                                    <input type="text" id="txtReturnDate" class="form-control datetimepicker-input" data-target="#dteReturnDate" />
                                    <div class="input-group-append" data-target="#dteReturnDate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h5>Хариуны товч тайлбар</h5>
                                <%--<input autocomplete="off" class="form-control" type="text" id="txtReturnDescr"/>--%>
                                <textarea class="form-control" id="txtReturnDescr"></textarea>
                            </div>   
                        </div>
                    </div>                            
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                    <button id="btnSave" type="button" class="btn btn-rounded btn-warning" onclick="Save()">Бүртгэх</button>                                
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="remModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                
                <div class="modal-header">
                <h5 class="modal-title">Анхааруулга</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                </div>
                
                <div class="modal-body">
                    <h5>Энэ ирсэн бичгийг устгах уу ?</h5>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Болих</button>
                    <button type="button" class="btn btn-rounded btn-danger" onclick="Delete()">Устгах</button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                
                <div class="modal-header">
                <h5 class="modal-title">Ирсэн бичгийн файл</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                </div>
                
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row" id="divPDFviewer">

                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="empModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                
                <div class="modal-header">
                <h5 class="modal-title">Ирсэн бичиг шилжүүлэх</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                </div>
                
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group pt-1 pb-1">
                                    <label class="form-check">
                                        <input type="checkbox" id="chkAssDep" class="form-check-input" checked="checked">
                                        <span class="form-check-label IsAssDep" style="color: rgb(153, 153, 153);">Хариуг хэлтсүүдээр өгүүлэх</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h5>Хэлтсүүд</h5>
                                <select class="form-control js-example-basic-multiple" style="width: 100%" id="cmbAssDeps" multiple="multiple">
                                    <% foreach (System.Data.DataRow rw in dtDepartments.Rows)
                                        {
                                    %>
                                    <option value="<%=rw["DepartmentPkID"].ToString() %>"><%=rw["DepartmentName"].ToString() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h5>Ажилчид</h5>
                                <select class="form-control js-example-basic-multiple" style="width: 100%" id="cmbAssEmps" multiple="multiple" disabled="disabled">
                                    <% foreach (System.Data.DataRow rw in dtDepartments.Rows)
                                        {
                                    %>
                                    <optgroup label="<%=rw["DepartmentName"].ToString() %>">
                                        <%
                                            foreach (System.Data.DataRow row in dtEmployees.Select("DepartmentPkID = " + rw["DepartmentPkID"].ToString()))
                                            {
                                        %>
                                        <option value="<%=row["EmployeeInfoPkID"].ToString() %>"><%=row["FullName"].ToString() %></option>
                                        <%
                                            }
                                        %>
                                    </optgroup>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h5>Хариу өгөх огноо</h5>
                                <div class="input-group date" id="dteAssDate" data-target-input="nearest">
                                    <input type="text" id="txtAssDate" class="form-control datetimepicker-input" data-target="#dteAssDate" />
                                    <div class="input-group-append" data-target="#dteAssDate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h5>Хариуны товч тайлбар</h5>
                                <%--<input autocomplete="off" class="form-control" type="text" id="txtAssDescr" />--%>
                                <textarea class="form-control" id="txtAssDescr"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                    <button type="button" class="btn btn-rounded btn-warning" onclick="SaveEmp()">Шилжүүлэх</button>                                
                </div>
            </div>
        </div>
    </div>
        
    <script type = "text/javascript">

        var act = 1;
        var selid = 0;
        var usrid = '<%= Session["UserPkID"] %>';
        var delfile = '';
        var seldate = '';
        //var selfile = '';

        $(document).ready(function () {
            $('#cmbRetDeps').select2(); 
            $('#cmbRetEmps').select2();
            $('#cmbAssDeps').select2();
            $('#cmbAssEmps').select2();
        });

        $('#dteDocument').datetimepicker({
            format: 'YYYY-MM-DD',
            date: moment()
        });
        
        $('#dteReturnDate').datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            date: moment(),
            sideBySide: true
        });

        $('#dteAssDate').datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            date: moment(),
            sideBySide: true
        });
        
        $("#chkIsReturn").change(function () {
            if ($('#chkIsReturn').is(":checked")) {
                $('#chkIsAll').prop('checked', false);
                $('#chkIsEmp').prop('disabled', 'disabled');
                $('#chkIsEmp').prop('checked', false);
                $('.IsEmp').css("color", "rgba(215, 215, 215, 0.74)");
                $('#chkIsDep').prop('disabled', false);
                $('.IsDep').css("color", "rgb(153, 153, 153)");
                $('#txtReturnDate').prop('disabled', false);
                $('#txtReturnDescr').prop('disabled', false);
                $('#chkIsDep').prop('checked', true);
                $('#cmbRetDeps').prop('disabled', false);
                $('#cmbRetEmps').prop('disabled', 'disabled');
                $('.IsDep').text("Хариуг хэлтсүүдээр өгүүлэх");
                $('#cmbRetEmps').val("");
                $('#cmbRetEmps').trigger('change');
            }
            else {
                $('#chkIsEmp').prop('disabled', false);
                $('.IsEmp').css("color", "rgb(153, 153, 153)");
                $('#chkIsDep').prop('disabled', 'disabled');
                $('#chkIsDep').prop('checked', false);
                $('.IsDep').css("color", "rgba(215, 215, 215, 0.74)");
                $('#cmbRetDeps').prop('disabled', 'disabled');
                $('#cmbRetDeps').val("");
                $('#cmbRetDeps').trigger('change');
                $('#cmbRetEmps').prop('disabled', 'disabled');
                $('#cmbRetEmps').val("");
                $('#cmbRetEmps').trigger('change');
                $('#txtReturnDate').prop('disabled', 'disabled');
                $('#dteReturnDate').datetimepicker('date', moment().format('YYYY-MM-DD HH:mm'));
                $('#txtReturnDescr').prop('disabled', 'disabled');
                $('#txtReturnDescr').val("");
            }
        });

        $("#chkIsAll").change(function () {
            if ($('#chkIsAll').is(":checked")) {
                $('#chkIsEmp').prop('disabled', 'disabled');
                $('#chkIsEmp').prop('checked', false);
                $('.IsEmp').css("color", "rgba(215, 215, 215, 0.74)");
                $('#chkIsReturn').prop('checked', false);
                $('#chkIsDep').prop('disabled', 'disabled');
                $('#chkIsDep').prop('checked', false);
                $('.IsDep').css("color", "rgba(215, 215, 215, 0.74)");
                $('#cmbRetDeps').prop('disabled', 'disabled');
                $('#cmbRetDeps').val("");
                $('#cmbRetDeps').trigger('change');
                $('#cmbRetEmps').prop('disabled', 'disabled');
                $('#cmbRetEmps').val("");
                $('#cmbRetEmps').trigger('change');
                $('#txtReturnDate').prop('disabled', 'disabled');
                $('#dteReturnDate').datetimepicker('date', moment().format('YYYY-MM-DD HH:mm'));
                $('#txtReturnDescr').prop('disabled', 'disabled');
                $('#txtReturnDescr').val("");
            }
            else {
                $('#chkIsEmp').prop('disabled', false);
                $('.IsEmp').css("color", "rgb(153, 153, 153)");
            }
        });

        $("#chkIsDep").change(function () {
            if ($('#chkIsDep').is(":checked")) {
                $('#cmbRetDeps').prop('disabled', false);
                $('#cmbRetEmps').prop('disabled', 'disabled');
                $('.IsDep').text("Хариуг хэлтсүүдээр өгүүлэх");
                $('#cmbRetEmps').val("");
                $('#cmbRetEmps').trigger('change');
            }
            else {
                $('#cmbRetDeps').prop('disabled', 'disabled');
                $('#cmbRetEmps').prop('disabled', false);
                $('.IsDep').text("Хариуг ажилчидаар өгүүлэх");
                $('#cmbRetDeps').val("");
                $('#cmbRetDeps').trigger('change');
            }
        });

        $("#chkIsEmp").change(function () {
            if ($('#chkIsEmp').is(":checked")) {
                $('#cmbRetEmps').prop('disabled', false);
            }
            else {
                $('#cmbRetEmps').prop('disabled', 'disabled');
                $('#cmbRetEmps').val("");
                $('#cmbRetEmps').trigger('change');
            }
        });

        $("#chkAssDep").change(function () {
            if ($('#chkAssDep').is(":checked")) {
                $('#cmbAssDeps').prop('disabled', false);
                $('#cmbAssEmps').prop('disabled', 'disabled');
                $('.IsAssDep').text("Хариуг хэлтсүүдээр өгүүлэх");
                $('#cmbAssEmps').val("");
                $('#cmbAssEmps').trigger('change');
            }
            else {
                $('#cmbAssDeps').prop('disabled', 'disabled');
                $('#cmbAssEmps').prop('disabled', false);
                $('.IsAssDep').text("Хариуг ажилчидаар өгүүлэх");
                $('#cmbAssDeps').val("");
                $('#cmbAssDeps').trigger('change');
            }
        });
        
        function Clear() {
            act = 1;
            selid = 0;
            $('#dteDocument').datetimepicker('date', moment().format('YYYY-MM-DD'));
            $('#txtDocumentNo').val("");
            $('#txtCompanyName').val("");
            $('#txtSubject').val("");
            $('#numPageCnt').val("");
            $('#pdfFile').val(null);
            document.getElementById("txtUploadedFile").innerHTML = "PDF Файл сонгох";
            $('#cmbStatus').val("");
            $('#cmbDepartments').val("");
            $('#dteReturnDate').datetimepicker('date', moment().format('YYYY-MM-DD HH:mm'));
            $('#txtReturnDescr').val("");

            $('#chkIsAll').prop('checked', false);
            $('#chkIsEmp').prop('disabled', false);
            $('#chkIsEmp').prop('checked', false);
            $('.IsEmp').css("color", "rgb(153, 153, 153)");
            $('#chkIsReturn').prop('checked', false);
            $('#chkIsDep').prop('disabled', 'disabled');
            $('#chkIsDep').prop('checked', false);
            $('.IsDep').css("color", "rgba(215, 215, 215, 0.74)");
            $('#cmbRetDeps').prop('disabled', 'disabled');
            $('#cmbRetDeps').val("");
            $('#cmbRetDeps').trigger('change');
            $('#cmbRetEmps').prop('disabled', 'disabled');
            $('#cmbRetEmps').val("");
            $('#cmbRetEmps').trigger('change');
            $('#txtReturnDate').prop('disabled', 'disabled');
            $('#dteReturnDate').datetimepicker('date', moment().format('YYYY-MM-DD HH:mm'));
            $('#txtReturnDescr').prop('disabled', 'disabled');
            $('#txtReturnDescr').val("");
        }

        function addRow() {
            document.getElementById("btnSave").innerHTML = "Бүртгэх";
            act = 1;
            selid = 0;
            Clear();
        }

        function viewRow(path) {
            if (path != '') {
                var intViewportHeight = window.innerHeight / 5 * 3;
                $('#divPDFviewer').empty();
                $('#divPDFviewer').append('<iframe src="' + path + '" height="' + intViewportHeight + '" width="100%"></iframe>');
                $('#viewModal').modal('show');
            }
            else {
                swal('Анхааруулга', 'Файл оруулаагүй байна !', 'warning');
            }
        }
    
        function editRow(id, docdate, docno, compname, subj, page, file, stts, isret, retdate, retdesc, retemp, retdep) {
            act = 0;
            selid = id;
            document.getElementById("btnSave").innerHTML = "Засах";
            $('#txtCompanyName').val(compname);
            $('#txtSubject').val(subj);
            $('#dteDocument').datetimepicker('date', docdate);
            $('#pdfFile').val(null);
            document.getElementById("txtUploadedFile").innerHTML = "PDF Файл сонгох";
            //selfile = file;
            $('#txtDocumentNo').val(docno);
            $('#numPageCnt').val(page);
            $('#cmbStatus').val(stts);
            
            var arremp = [];
            var arrdep = [];

            if (retemp != null && retemp != '') {
                retemp = retemp.slice(0, -1);
                arremp = retemp.split(",");
            }
            if (retdep != null && retdep != '') {
                retdep = retdep.slice(0, -1);
                arrdep = retdep.split(",");
            }
                        
            if (retdep == '1' && retemp == '1') {
                $('#chkIsAll').prop('checked', true);
                $('#chkIsReturn').prop('checked', false);
                $('#chkIsEmp').prop('disabled', 'disabled');
                $('#chkIsEmp').prop('checked', false);
                $('.IsEmp').css("color", "rgba(215, 215, 215, 0.74)");
                $('#chkIsDep').prop('disabled', 'disabled');
                $('#chkIsDep').prop('checked', false);
                $('.IsDep').css("color", "rgba(215, 215, 215, 0.74)");
                $('#cmbRetDeps').prop('disabled', 'disabled');
                $('#cmbRetDeps').val("");
                $('#cmbRetDeps').trigger('change');
                $('#cmbRetEmps').prop('disabled', 'disabled');
                $('#cmbRetEmps').val("");
                $('#cmbRetEmps').trigger('change');
                $('#txtReturnDate').prop('disabled', 'disabled');
                $('#dteReturnDate').datetimepicker('date', moment().format('YYYY-MM-DD HH:mm'));
                $('#txtReturnDescr').prop('disabled', 'disabled');
                $('#txtReturnDescr').val("");
                return;
            }
            if (isret == 'N' && retemp != '') {
                $('#chkIsAll').prop('checked', false);
                $('#chkIsReturn').prop('checked', false);
                $('#chkIsEmp').prop('disabled', false);
                $('#chkIsEmp').prop('checked', true);
                $('.IsEmp').css("color", "rgb(153, 153, 153)");
                $('#chkIsDep').prop('disabled', 'disabled');
                $('#chkIsDep').prop('checked', false);
                $('.IsDep').css("color", "rgba(215, 215, 215, 0.74)");
                $('#cmbRetDeps').prop('disabled', 'disabled');
                $('#cmbRetDeps').val("");
                $('#cmbRetDeps').trigger('change');
                $('#cmbRetEmps').prop('disabled', false);
                $('#cmbRetEmps').val(arremp);
                $('#cmbRetEmps').trigger('change');
                $('#txtReturnDate').prop('disabled', 'disabled');
                $('#dteReturnDate').datetimepicker('date', moment().format('YYYY-MM-DD HH:mm'));
                $('#txtReturnDescr').prop('disabled', 'disabled');
                $('#txtReturnDescr').val("");
                return;
            }
            if (isret == 'Y') {
                $('#chkIsAll').prop('checked', false);
                $('#chkIsReturn').prop('checked', true);
                $('#chkIsEmp').prop('disabled', 'disabled');
                $('#chkIsEmp').prop('checked', false);
                $('.IsEmp').css("color", "rgba(215, 215, 215, 0.74)");
                if (retdep != "") {
                    $('#chkIsDep').prop('disabled', false);
                    $('#chkIsDep').prop('checked', true);
                    $('.IsDep').css("color", "rgb(153, 153, 153)");
                    $('.IsDep').text("Хариуг хэлтсүүдээр өгүүлэх");
                    $('#cmbRetDeps').prop('disabled', false);
                    $('#cmbRetEmps').prop('disabled', 'disabled');
                    $('#cmbRetDeps').val(arrdep);
                    $('#cmbRetEmps').val("");
                }
                else {
                    $('#chkIsDep').prop('disabled', false);
                    $('#chkIsDep').prop('checked', false);
                    $('.IsDep').css("color", "rgb(153, 153, 153)");
                    $('.IsDep').text("Хариуг ажилчидаар өгүүлэх");
                    $('#cmbRetDeps').prop('disabled', 'disabled');
                    $('#cmbRetEmps').prop('disabled', false);
                    $('#cmbRetDeps').val("");
                    $('#cmbRetEmps').val(arremp);
                }
                $('#cmbRetDeps').trigger('change');
                $('#cmbRetEmps').trigger('change');
                $('#txtReturnDate').prop('disabled', false);
                $('#dteReturnDate').datetimepicker('date', retdate);
                $('#txtReturnDescr').prop('disabled', false);
                $('#txtReturnDescr').val(retdesc);
                return;
            }

            $('#chkIsAll').prop('checked', false);
            $('#chkIsReturn').prop('checked', false);
            $('#chkIsEmp').prop('disabled', 'disabled');
            $('#chkIsEmp').prop('checked', false);
            $('.IsEmp').css("color", "rgba(215, 215, 215, 0.74)");
            $('#chkIsDep').prop('disabled', 'disabled');
            $('#chkIsDep').prop('checked', false);
            $('.IsDep').css("color", "rgba(215, 215, 215, 0.74)");
            $('#cmbRetDeps').prop('disabled', 'disabled');
            $('#cmbRetDeps').val("");
            $('#cmbRetDeps').trigger('change');
            $('#cmbRetEmps').prop('disabled', 'disabled');
            $('#cmbRetEmps').val("");
            $('#cmbRetEmps').trigger('change');
            $('#txtReturnDate').prop('disabled', 'disabled');
            $('#dteReturnDate').datetimepicker('date', moment().format('YYYY-MM-DD HH:mm'));
            $('#txtReturnDescr').prop('disabled', 'disabled');
            $('#txtReturnDescr').val("");
        }

        function deleteRow(id, path) {
            selid = id;
            delfile = path;
        }
        
        function Save() {
            var dtdoc = moment($('#dteDocument').datetimepicker('viewDate')).format('YYYY-MM-DD');
            var txdoc = $('#txtDocument').val().trim();
            var docno = $('#txtDocumentNo').val().trim();
            var cname = $('#txtCompanyName').val().trim();
            var subj = $('#txtSubject').val().trim();
            var page = parseInt($('#numPageCnt').val());
            //var filep = $('#pdfFile').val().trim();
            var stat = $('#cmbStatus').val();
            var deps = $('#cmbRetDeps').val();
            var emps = $('#cmbRetEmps').val();
            var dtret = moment($('#dteReturnDate').datetimepicker('viewDate')).format('YYYY-MM-DD HH:mm');
            var txret = $('#txtReturnDate').val().trim();
            var descr = $('#txtReturnDescr').val().trim();
            var retmsg = '0';
            var isretval = '';
            
            if ($('#chkIsReturn').is(":checked")) {
                isretval = 'Y';
            }
            else {
                isretval = 'N';
            }
            var isallval = '';
            if ($('#chkIsAll').is(":checked")) {
                isallval = 'Y';
            }
            else {
                isallval = 'N';
            }
            var isdepval = '';
            if ($('#chkIsDep').is(":checked")) {
                isdepval = 'Y';
            }
            else {
                isdepval = 'N';
            }
            var isempval = '';
            if ($('#chkIsEmp').is(":checked")) {
                isempval = 'Y';
            }
            else {
                isempval = 'N';
            }

            if (cname == '') {
                swal('Анхааруулга', 'Хаанаас, хэнээс ирсэн бичигээ оруулна уу !', 'warning');
                return;
            }
            if (subj == '') {
                swal('Анхааруулга', 'Товч утгаа оруулна уу !', 'warning');
                return;
            }
            if (dtdoc == '' || txdoc == '') {
                swal('Анхааруулга', 'Бичгийн огноогоо сонгоно уу !', 'warning');
                return;
            }
            //if (filep == '') {
            //    swal('Анхааруулга', 'Файлаа сонгоно уу !', 'warning');
            //    return;
            //}
            if (docno == '') {
                swal('Анхааруулга', 'Дугаараа оруулна уу !', 'warning');
                return;
            }
            if (page == '' || page == 0) {
                swal('Анхааруулга', 'Хуудасны тоогоо оруулна уу !', 'warning');
                return;
            }
            if (stat == '' || stat == null) {
                swal('Анхааруулга', 'Төлөвөө сонгоно уу !', 'warning');
                return;
            }
            if ((deps == '' || deps == null) && isretval == 'Y' && isallval == 'N' && isdepval == 'Y') {
                swal('Анхааруулга', 'Хэлтсүүдээ сонгоно уу !', 'warning');
                return;
            }
            if (isempval == 'Y') {
                if (emps == '' || emps == null) {
                    swal('Анхааруулга', 'Ажилчидаа сонгоно уу !', 'warning');
                    return;
                }
            }
            else {
                if ((emps == '' || emps == null) && isretval == 'Y' && isallval == 'N' && isdepval == 'N') {
                    swal('Анхааруулга', 'Ажилчидаа сонгоно уу !', 'warning');
                    return;
                }
            }
            if ((dtret == '' || txret == '') && isretval == 'Y') {
                swal('Анхааруулга', 'Хариу өгөх огноогоо сонгоно уу !', 'warning');
                return;
            }
            if ((dtret != '' || txret != '') && isretval == 'Y' && dtdoc >= dtret) {
                swal('Анхааруулга', 'Хариу өгөх огноо бичгийн огноогоос хойш байх ёстой !', 'warning');
                return;
            }
            if (descr == '' && isretval == 'Y') {
                swal('Анхааруулга', 'Хариуны товч тайлбараа оруулна уу !', 'warning');
                return;
            }

            deps = "\"" + deps + "\"";
            emps = "\"" + emps + "\"";
                        
            if (isallval == "Y") {
                deps = '';
                dtret = moment().format('YYYY-MM-DD');
                descr = '';
                emps = '';
            }
            else {
                if (isretval == 'Y') {
                    if (isdepval == 'Y') {
                        emps = '';
                    }
                    else {
                        deps = '';
                    }
                }
                else {
                    deps = '';
                    descr = '';
                    dtret = moment().format('YYYY-MM-DD');
                    if (isempval == 'N') {
                        emps = '';
                    }
                }
            }
            
            $.ajax({
                url: '../post.aspx/SaveINTDocument',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    type: act,
                    id: selid,
                    datedocmnt: dtdoc,
                    docmntno: docno,
                    compname: cname,
                    sub: subj,
                    pgno: page,
                    usr: usrid,
                    sttus: stat,
                    dateret: dtret,
                    dprt: deps,
                    empl: emps,
                    desc: descr,
                    isr: isretval,
                    tp: '1',
                    isa: isallval,
                    ise: isempval
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
                    var files = document.getElementById('pdfFile').files;
                    if (files.length > 0) {
                        var formData = new FormData();
                        for (var i = 0; i < files.length; i++) {                            
                            formData.append(files[i].name, files[i]);                            
                        }
                        $.ajax({
                            url: '../uploadfile.ashx?DocumentPkID=' + retmsg,
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

                            $('#edtModal').modal('hide');

                            window.location.reload();
                        })
                    }
                    else {
                        //$.ajax({
                        //    url: '../post.aspx/DeleteINTDocumentFile',
                        //    type: 'POST',
                        //    dataType: 'json',
                        //    data: JSON.stringify({
                        //        delf: selfile
                        //    }),
                        //    contentType: 'application/json',
                        //    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //        swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                        //    },
                        //    success: function (msg) {
                        //        if (act == 1)
                        //            swal('Амжилттай', 'Амжилттай нэмэгдлээ !', 'success');
                        //        else if (act == 0)
                        //            swal('Амжилттай', 'Амжилттай засагдлаа !', 'success');

                        //        $('#edtModal').modal('hide');

                        //        window.location.reload();
                        //    }
                        //});

                        if (act == 1)
                            swal('Амжилттай', 'Амжилттай нэмэгдлээ !', 'success');
                        else if (act == 0)
                            swal('Амжилттай', 'Амжилттай засагдлаа !', 'success');

                        $('#edtModal').modal('hide');

                        window.location.reload();
                    }
                }
            });
        }

        function Delete() {
            $.ajax({
                url: '../post.aspx/DeleteINTDocument',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    id: selid,
                    delf: delfile
                }),
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    $('#remModal').modal('hide');

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
    
        function addEmpRow(id, assdte, assdesc, assemp, assdep, assret, docdate) {
            selid = id;
            seldate = docdate;
            
            var arrassemp = [];
            var arrassdep = [];

            if (assemp != null && assemp != '') {
                assemp = assemp.slice(0, -1);
                arrassemp = assemp.split(",");
            }
            if (assdep != null && assdep != '') {
                assdep = assdep.slice(0, -1);
                arrassdep = assdep.split(",");
            }
            
            if (assret == 'Y') {
                if (assdep != "") {
                    $('#chkAssDep').prop('checked', true);
                    $('.IsAssDep').text("Хариуг хэлтсүүдээр өгүүлэх");
                    $('#cmbAssDeps').prop('disabled', false);
                    $('#cmbAssEmps').prop('disabled', 'disabled');
                    $('#cmbAssDeps').val(arrassdep);
                    $('#cmbAssEmps').val("");
                }
                else {
                    $('#chkAssDep').prop('checked', false);
                    $('.IsAssDep').text("Хариуг ажилчидаар өгүүлэх");
                    $('#cmbAssDeps').prop('disabled', 'disabled');
                    $('#cmbAssEmps').prop('disabled', false);
                    $('#cmbAssDeps').val("");
                    $('#cmbAssEmps').val(arrassemp);
                }
                
                $('#cmbAssDeps').trigger('change');
                $('#cmbAssEmps').trigger('change');
                $('#dteAssDate').datetimepicker('date', assdte);
                $('#txtAssDescr').val(assdesc);
            }
            else {
                $('#chkAssDep').prop('checked', true);
                $('.IsAssDep').text("Хариуг хэлтсүүдээр өгүүлэх");
                $('#cmbAssDeps').prop('disabled', false);
                $('#cmbAssEmps').prop('disabled', 'disabled');
                $('#cmbAssDeps').val("");
                $('#cmbAssEmps').val("");
                $('#cmbAssDeps').trigger('change');
                $('#cmbAssEmps').trigger('change');
                $('#dteAssDate').datetimepicker('date', moment().format('YYYY-MM-DD HH:mm'));
                $('#txtAssDescr').val("");
            }
        }

        function SaveEmp() {
            var depid = $('#cmbAssDeps').val();
            var empid = $('#cmbAssEmps').val();
            var txret = $('#txtAssDate').val().trim();
            var dtret = moment($('#dteAssDate').datetimepicker('viewDate')).format('YYYY-MM-DD HH:mm');
            var descr = $('#txtAssDescr').val().trim();
            var isdepval = '';
            if ($('#chkAssDep').is(":checked")) {
                isdepval = 'Y';
            }
            else {
                isdepval = 'N';
            }

            if ((depid == '' || depid == null) && isdepval == 'Y') {
                swal('Анхааруулга', 'Шилжүүлэх хэлтэсээ сонгоно уу !', 'warning');
                return;
            }

            if ((empid == '' || empid == null) && isdepval == 'N') {
                swal('Анхааруулга', 'Ажилтанаа сонгоно уу !', 'warning');
                return;
            }
            if (dtret == '' || txret == '') {
                swal('Анхааруулга', 'Хариу өгөх огноогоо сонгоно уу !', 'warning');
                return;
            }
            if (seldate >= dtret) {
                swal('Анхааруулга', 'Хариу өгөх огноо бичгийн огноогоос ('+seldate+') хойш байх ёстой !', 'warning');
                return;
            }
            if (descr == '') {
                swal('Анхааруулга', 'Хариуны товч тайлбараа оруулна уу !', 'warning');
                return;
            }

            depid = "\"" + depid + "\"";
            empid = "\"" + empid + "\"";

            if (isdepval == 'Y') {
                empid = '';
            }
            else {
                depid = '';
            }

            $.ajax({
                url: '../post.aspx/SaveINTDocumentEmployee',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    id : selid,
                    dep: depid,
                    emp: empid,
                    dte: dtret,
                    des: descr
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
                        $('#empModal').modal('hide');
                        swal('Амжилттай', 'Амжилттай шилжүүллээ !', 'success');

                        window.location.reload();
                    }
                }
            });
        }

    </script>

</asp:Content>
