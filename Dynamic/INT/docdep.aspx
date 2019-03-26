<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="docdep.aspx.cs" Inherits="Dynamic.docdep" %>
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
                <h3 class="panel-title">Ирсэн, явсан бичгийн жагсаалт</h3>
            </div>
            <div style="margin-right:10px; margin-left:10px">
                <table 
                    id="tbMain"
                    data-toggle="table" 
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
                        <th data-sortable="true" data-field="DepartmentName">Хэлтэс</th>
                        <th data-sortable="true" data-field="DocTypeName">Төрөл</th>
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
                        <td style="text-align:center"><%=rw["IsReturnName"].ToString() %></td>
                        <td style="text-align:center"><%=Convert.ToDateTime(rw["ReturnDate"]).ToString("yyyy-MM-dd HH:mm") %></td>
                        <td style="text-align:left" title="<%=rw["ReturnDescr"].ToString() %>"><%=rw["ReturnDescr"].ToString() %></td>
                        <td style="text-align:left" title="<%=rw["DepartmentName"].ToString() %>"><%=rw["DepartmentName"].ToString() %></td>
                        <td style="text-align:left" title="<%=rw["DocTypeName"].ToString() %>"><%=rw["DocTypeName"].ToString() %></td>
                        <td>
                            <div class="row">
                                <div class="todo--actions">
                                    <a href="JavaScript:Void(0);" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                    <div class="dropdown-menu">
                                        <a href="#" class="dropdown-item" onclick="viewRow('<%=rw["DocumentFilePath"].ToString() %>');return false;">Файл үзэх</a>
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

    </section>

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
  
    <script type = "text/javascript">

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
    
    </script>

</asp:Content>
