<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="docout.aspx.cs" Inherits="Dynamic.docout" %>
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
                <h3 class="panel-title">Явсан бичгийн бүртгэл</h3>
            </div>
            <div id="toolbar" style="margin-right:15px">
                <a href="#edtModal" class="btn btn-rounded btn-warning" data-toggle="modal" onclick="addRow()" style="margin-left: 10px;">Шинэ явсан бичиг үүсгэх</a>
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
                        <th data-sortable="true" data-field="CompanyName">Хаана, хэнд</th>
                        <th data-sortable="true" data-field="Subject">Товч утга</th>
                        <th data-sortable="true" data-field="PageCnt">Хуудасны тоо</th>
                        <th data-sortable="true" data-field="CreatedDate">Үүсгэсэн огноо</th>
                        <th data-sortable="true" data-field="StatusName">Төлөв</th>
                        <th data-sortable="true" data-field="DepartmentName">Аль хэлтсээс</th>
                        <th data-sortable="true" data-field="Action">Үйлдэл</th>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (System.Data.DataRow rw in dtDocuments.Rows)
                        {
                    %>
                    <tr>
                        <td style="text-align:center"><%=rw["DocumentDate"].ToString() %></td>
                        <td style="text-align:center"><%=rw["DocumentNo"].ToString() %></td>
                        <td style="text-align:left" title="<%=rw["CompanyName"].ToString() %>"><%=rw["CompanyName"].ToString() %></td>
                        <td style="text-align:left" title="<%=rw["Subject"].ToString() %>"><%=rw["Subject"].ToString() %></td>
                        <td style="text-align:center"><%=rw["PageCnt"].ToString() %></td>
                        <td style="text-align:center"><%=Convert.ToDateTime(rw["CreatedDate"]).ToString("yyyy-MM-dd") %></td>
                        <td style="text-align:center"><%=rw["StatusName"].ToString() %></td>
                        <td style="text-align:left" title="<%=rw["DepartmentName"].ToString() %>"><%=rw["DepartmentName"].ToString() %></td>
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
                                        <a href="#edtModal" class="dropdown-item" data-toggle="modal" onclick="editRow('<%=rw["DocumentPkID"].ToString() %>', '<%=Convert.ToDateTime(rw["DocumentDate"]).ToString("yyyy-MM-dd") %>', '<%=rw["DocumentNo"].ToString() %>', '<%=rw["CompanyName"].ToString() %>', '<%=rw["Subject"].ToString() %>', <%=rw["PageCnt"].ToString() %>, '<%=rw["DocumentFilePath"].ToString() %>', '<%=rw["StatusID"].ToString() %>', '<%=rw["ReturnDepartmentPkID"].ToString() %>')">Засах</a>
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
                    <h5 class="modal-title">Явсан бичгийн бүртгэл</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">         
                    <div class="form-group">      
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Хаана, хэнд</h5>
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
                            <div class="col-md-6">
                                <h5>Дугаар</h5>
                                <input autocomplete="off" class="form-control" type="text" id="txtDocumentNo"/>
                            </div> 
                            <div class="col-md-6">
                                <h5>Хуудасны тоо</h5>
                                <input autocomplete="off" class="form-control" type="number" value="0" min="0" id="numPageCnt"/>
                            </div>          
                        </div>
                        <div class="row">         
                            <div class="col-md-6">
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
                            <div class="col-md-6">
                                <h5>Аль хэлтсээс</h5>
                                <select class="form-control" id="cmbDepartments">
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
                    <h5>Энэ явсан бичгийг устгах уу ?</h5>
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
                <h5 class="modal-title">Явсан бичгийн файл</h5>
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

    <script type = "text/javascript">

        var act = 1;
        var selid = 0;
        var usrid = '<%= Session["UserPkID"] %>';
        var delfile = '';

        $('#dteDocument').datetimepicker({
            format: 'YYYY-MM-DD',
            date: moment()
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
    
        function editRow(id, docdate, docno, compname, subj, page, file, stts, retdep) {
            act = 0;
            selid = id;
            document.getElementById("btnSave").innerHTML = "Засах";
            $('#dteDocument').datetimepicker('date', docdate);
            $('#txtDocumentNo').val(docno);
            $('#txtCompanyName').val(compname);
            $('#txtSubject').val(subj);
            $('#numPageCnt').val(page);
            $('#txtFilePath').val(file);
            $('#cmbStatus').val(stts);
            $('#cmbDepartments').val(retdep);
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
            var page = $('#numPageCnt').val().trim();
            //var filep = $('#pdfFile').val();
            var stat = $('#cmbStatus').val();
            var dep = $('#cmbDepartments').val();
            var retmsg = '0';
            
            if (cname == '') {
                swal('Анхааруулга', 'Хаана, хэнд явуулж буйгаа оруулна уу !', 'warning');
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
            if (stat == '') {
                swal('Анхааруулга', 'Төлөвөө сонгоно уу !', 'warning');
                return;
            }
            if (dep == '') {
                swal('Анхааруулга', 'Явуулж буй хэлтэсээ сонгоно уу !', 'warning');
                return;
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
                    dateret: moment().format('YYYY-MM-DD'),
                    dprt: dep,
                    empl: '',
                    desc: '',
                    isr: 'N',
                    tp: '2',
                    isa: 'N',
                    ise: 'N'
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
    
    </script>

</asp:Content>
