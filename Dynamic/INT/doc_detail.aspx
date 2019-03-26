<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="doc_detail.aspx.cs" Inherits="Dynamic.doc_detail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="main--content">

        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Ирсэн бичгийн мэдээлэл</h3>
            </div>
            <div class="panel-content">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <h5>Хаанаас, хэнээс</h5>
                                <input autocomplete="off" class="form-control" type="text" disabled="disabled" value="<%= dtDocuments.Rows[0]["CompanyName"].ToString() %>"/>
                            </div>
                            <div class="col-md-4">
                                <h5>Товч утга</h5>
                                <input autocomplete="off" class="form-control" type="text" disabled="disabled" value="<%= dtDocuments.Rows[0]["Subject"].ToString() %>"/>
                            </div>
                            <div class="col-md-4">
                                <h5>Бичгийн огноо</h5>
                                <input autocomplete="off" class="form-control" type="text" disabled="disabled" value="<%= dtDocuments.Rows[0]["DocumentDate"].ToString() %>"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <h5>Дугаар</h5>
                                <input autocomplete="off" class="form-control" type="text" disabled="disabled" value="<%= dtDocuments.Rows[0]["DocumentNo"].ToString() %>"/>
                            </div>
                            <div class="col-md-4">
                                <h5>Хуудасны тоо</h5>
                                <input autocomplete="off" class="form-control" type="text" disabled="disabled" value="<%= dtDocuments.Rows[0]["PageCnt"].ToString() %>"/>
                            </div>
                            <div class="col-md-4">
                                <h5>Хариу өгөх огноо</h5>
                                <input autocomplete="off" class="form-control" type="text" disabled="disabled" value="<%= Convert.ToDateTime(dtDocuments.Rows[0]["ReturnDate"]).ToString("yyyy-MM-dd HH:mm") %>"/>
                            </div>
                        </div>
                        <div class="row">
                            <a href="#" class="btn btn-rounded btn-warning" style="margin-left:15px; margin-top:15px" onclick="viewRow('<%= dtDocuments.Rows[0]["DocumentFilePath"].ToString() %>');return false;"">Файл үзэх</a>
                        </div>
                    </div>
            </div>
        </div>

        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Ирсэн бичгийн саналууд</h3>
            </div>
            <div class="panel-content">
                <div class="chat">
                    <div class="chat--items" data-trigger="scrollbar">
                        <%
                            if (dtDocuments.Rows[0]["CanComment"].ToString() == "Y")
                            {
                        %>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <textarea class="form-control" placeholder="Таны санал" id="txtDescr"></textarea>
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top:10px">
                                        <div class="col-md-12">
                                            <label class="custom-file">
                                                <input type="file" id="wrdFile" name="wrdFile" class="custom-file-input" accept=".doc,.docx,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document" />
                                                <span id="txtUploadedFile" class="custom-file-label" style="overflow: hidden">WORD Файл сонгох</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top:10px">
                                        <div class="col-md-1">
                                            <button class="btn btn-rounded btn-warning" type="button" onclick="Save('<%= Request.QueryString["dId"].ToString() %>', '<%= Session["EmployeeInfoPkID"].ToString() %>')">Санал өгөх</button>
                                        </div>
                                    </div>
                                </div>
                        <%
                            }
                        
                            foreach (System.Data.DataRow rw in dtComments.Rows)
                            {
                                if (Session["EmployeeInfoPkID"].ToString() == rw["EmployeeInfoPkID"].ToString())
                                {
                        %>
                                    <div class="chat--item chat--left" style="margin-top:15px">
                        <%
                                }
                                else
                                {
                        %>
                                    <div class="chat--item chat--right" style="margin-top:15px">
                        <%
                                }
                        %>
                                        <div class="chat--avatar">
                                            <img src="assets\img\avatars\01_40x40.png" alt="" class="rounded-circle">
                                        </div>
                                        <div class="chat--content">
                                            <div class="chat--info">
                                                <h6 class="chat--user h6"><%= rw["FullName"].ToString() %></h6>
                                                <span class="chat--time"><%= Convert.ToDateTime(rw["CommentDate"]).ToString("yyyy-MM-dd HH:mm") %></span>
                                            </div>
                                            <div class="chat--text">
                                                <p><%= rw["CommentDescr"].ToString() %></p>
                        <%
                                if(rw["CommentFilePath"].ToString() != "")
                                {
                        %>
                                                <a href="<%= rw["CommentFilePath"].ToString() %>" target="_blank">Хавсралт файл татах..</a>
                        <%
                                }
                        %>
                                            </div>
                                        </div>
                                    </div>
                        <%
                            }
                        %>
                    </div>
                </div>
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
        
        function Clear() {
            $('#txtDescr').val("");
            $('#wrdFile').val(null);
            document.getElementById("txtUploadedFile").innerHTML = "WORD Файл сонгох";
        }

        Clear();

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

        function Save(docid, empid) {
            var desc = $('#txtDescr').val();
            var retmsg = "0";

            if (desc == '') {
                swal('Анхааруулга', 'Саналаа оруулна уу !', 'warning');
                return;
            }

            $.ajax({
                url: '../post.aspx/SaveINTDocumentComment',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    did: docid,
                    eid: empid,
                    des: desc
                }),
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    retmsg = msg.d;
                }
            }).done(function () {
                if (retmsg == "0") {
                    swal('Анхааруулга', 'Амжилтгүй боллоо !', 'warning');
                }
                else {
                    var files = document.getElementById('wrdFile').files;
                    if (files.length > 0) {
                        var formData = new FormData();
                        for (var i = 0; i < files.length; i++) {
                            formData.append(files[i].name, files[i]);
                        }
                        $.ajax({
                            url: '../uploadfile.ashx?CommentPkID=' + retmsg,
                            method: 'POST',
                            data: formData,
                            contentType: false,
                            processData: false,
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                            }
                        }).done(function () {
                            swal('Амжилттай', 'Амжилттай нэмэгдлээ !', 'success');

                            window.location.reload();
                        })
                    }
                    else {
                        swal('Амжилттай', 'Амжилттай нэмэгдлээ !', 'success');

                        window.location.reload();
                    }
                }
            });
        }
        
    </script>

</asp:Content>
