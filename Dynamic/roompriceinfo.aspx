<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="roompriceinfo.aspx.cs" Inherits="Dynamic.roompriceinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link rel="stylesheet" href="assets\css\sweetalert.min.css">
    <link rel="stylesheet" href="assets\css\sweetalert-overrides.css">

    <section class="main--content">

        <div class="panel">
            <div class="records--header">
                <div class="title fa-cube">
                    <h3 class="h3">Өрөөний үнэ</h3>
                </div>
                <div class="actions" style="width: 100%;">
                    <asp:DropDownList ID="cmbSearch" CssClass="form-control" runat="server"></asp:DropDownList>
                    <button id="btnSearch" runat="server" type="submit" class="btn btn-rounded btn-dark" onserverclick="Search_ServerClick"><i class="fa fa-search"></i></button>
                </div>
            </div>
        </div>

        <div class="panel">
            <div class="records--list" data-title="Өрөөний үнийн жагсаалт">

                <table id="datatable1" class="dataTable" style="font-size: 11px; width: 100%;" role="grid">
                            <thead>
                                <tr role="row">
                                    <th hidden>RoomPricePkID</th>
                                    <th hidden>RoomTypePkID</th>
                                    <th>Өрөөний ангилал</th>
                                    <th hidden>SeasonInfoPkID</th>
                                    <th>Улирал</th>
                                    <th hidden>GuestTypeID</th>
                                    <th>Зочны төрөл</th>
                                    <th hidden>LifeTimePkID</th>
                                    <th>Байрлах хугацаа</th>
                                    <th hidden>CurrencyID</th>
                                    <th>Валют</th>
                                    <th>Үнэ</th>
                                    <th hidden>OldPrice</th>
                                    <th>Үйлдэл</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    foreach (System.Data.DataRow rw in dtPriceInfo.Rows)
                                    {
                                %>
                                <tr data-value="<%=rw["RoomPricePkID"].ToString() %>" role="row" onclick="OnRowClick(this)" class="odd">
                                    <td hidden><%=rw["RoomPricePkID"].ToString() %></td>
                                    <td hidden><%=rw["RoomTypePkID"].ToString() %></td>
                                    <td><%=rw["TypeName"].ToString() %></td>
                                    <td hidden><%=rw["SeasonInfoPkID"].ToString() %></td>
                                    <td><%=rw["SeasonName"].ToString() %></td>
                                    <td hidden><%=rw["GuestTypeID"].ToString() %></td>
                                    <td><%=rw["GuestTypeName"].ToString() %></td>
                                    <td hidden><%=rw["LifeTimePkID"].ToString() %></td>
                                    <td><%=rw["LifeTimeName"].ToString() %></td>
                                    <td hidden><%=rw["CurrencyID"].ToString() %></td>
                                    <td><%=rw["CurrencyName"].ToString() %></td>
                                    <td>
                                        <input type="number" autocomplete="off" class="form-control" value="<%=rw["Price"].ToString() %>" min="0" />
                                    </td>
                                    <td hidden><%=rw["Price"].ToString() %></td>
                                    <td>
                                        <div data-todoapp="item">
                                            <div class="todo--actions dropleft">
                                                <a href="#" class="btn-link" data-toggle="dropdown"><i class="fa fa-tasks"></i></a>
                                                <div class="dropdown-menu">
                                                    <a href="#myModal"  class="dropdown-item addRow" data-id="<%=rw["RoomPricePkID"].ToString() %>">Нэмэх</a>
                                                    <a href="#myModal"  class="dropdown-item editRow" data-id="<%=rw["RoomPricePkID"].ToString() %>">Засах</a>
                                                    <a href="#RemoveModal"  class="dropdown-item deleteRow" data-todoapp="del:item" data-id="<%=rw["RoomPricePkID"].ToString() %>">Устгах</a>
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

                    <br />
                    
                    <a href="#" class="btn btn-rounded btn-warning" style="margin-left:30px" onclick="SaveAllTable()">Хадгалах</a>
            </div>
        </div>

    </section>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                
                <div class="modal-header">
                    <h5 class="modal-title">Өрөөний үнэ</h5>      
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">                                    
                    <p>
                        <div class="form-group">                                        
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Өрөөний ангилал</h5>
                                    <input class="form-control" type="text" disabled id="txtRoomType" />
                                </div>
                                <div class="col-md-6">
                                    <h5>Улирал</h5>
                                    <input class="form-control" type="text" disabled id="txtSeason" />
                                </div> 
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Зочны төрөл</h5>
                                    <input class="form-control" type="text" disabled id="txtGuestType" />
                                </div>
                                <div class="col-md-6">
                                    <h5>Байрлах хугацаа</h5>
                                    <input class="form-control" type="text" disabled id="txtLifeTime" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Валют</h5>
                                    <input class="form-control" type="text" disabled id="txtCurrency" />
                                </div>  
                                <div class="col-md-6">
                                    <h5>Үнэ</h5>
                                    <input class="form-control" autocomplete="off" type="number" id="numPrice" />
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
                    <h5>Энэ өрөөний үнийг устгах уу ?</h5>
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

        var roomtypeid;
        var seasonid;
        var guesttypeid;
        var lifetimeid;
        var currencyid;
        
        function Clear() {
            $('#txtRoomType').val("");
            $('#txtSeason').val("");
            $('#txtGuestType').val("");
            $('#txtLifeTime').val("");
            $('#txtCurrency').val("");
            $('#numPrice').val("");
            roomtypeid = "";
            seasonid = "";
            guesttypeid = "";
            lifetimeid = "";
            currencyid = "";
            act = 1;
            selid = 0;
        }
        
        function SaveAllTable() {
            var table = document.getElementById("datatable1");
            var result = "";
            var ret;

            for (var i = 1, row; row = table.rows[i]; i++) {
                var nid = row.cells[0].innerHTML;
                var val = row.cells[11].children[0].value;
                var oldval = row.cells[12].innerHTML;

                if (val != 0 && val != "") {
                    if (nid != 0 && nid != "") {
                        //update
                        act = 0;
                    }
                    else {
                        //insert
                        act = 1;
                    }
                    if (oldval != val) {
                        result += act + "," + nid + "," + row.cells[1].innerHTML + "," + row.cells[3].innerHTML + "," + row.cells[5].innerHTML + "," + row.cells[7].innerHTML + "," + row.cells[9].innerHTML + "," + val + ";";
                    }
                }
            }

            if (result != "") {
                result = result.slice(0, -1);

                $.ajax({
                    url: 'post.aspx/SaveHTLRoomPriceInfo',
                    type: 'POST',
                    dataType: 'json',
                    data: JSON.stringify({
                        passvalue: result
                    }),
                    contentType: 'application/json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                    },
                    success: function (msg) {
                        ret = msg.d;
                    }
                }).done(function () {
                    swal('Амжилттай', 'Амжилттай хадгаллаа !', 'success');
                    window.location.reload();

                    if (msg.d == false) {
                        swal('Анхааруулга', 'Амжилтгүй боллоо !', 'warning');
                    }
                    else {
                        swal('Амжилттай', 'Амжилттай хадгаллаа !', 'success');
                        window.location.reload();
                    }
                });
            }
            else {
                swal('Анхааруулга', 'Хадгалах өөрчлөлт олдсонгүй !', 'warning');
            }
        }

        $('.addRow').on('click', function () {
            selid = $(this).attr('data-id');
            if (selid != 0) {
                swal('Анхааруулга', 'Нэмэгдсэн бичлэг байна засна уу !', 'warning');
            }
            else {
                roomtypeid = document.getElementById("datatable1").rows[rid].cells[1].innerHTML;
                $('#txtRoomType').val(document.getElementById("datatable1").rows[rid].cells[2].innerHTML);
                seasonid = document.getElementById("datatable1").rows[rid].cells[3].innerHTML;
                $('#txtSeason').val(document.getElementById("datatable1").rows[rid].cells[4].innerHTML);
                guesttypeid = document.getElementById("datatable1").rows[rid].cells[5].innerHTML;
                $('#txtGuestType').val(document.getElementById("datatable1").rows[rid].cells[6].innerHTML);
                lifetimeid = document.getElementById("datatable1").rows[rid].cells[7].innerHTML;
                $('#txtLifeTime').val(document.getElementById("datatable1").rows[rid].cells[8].innerHTML);
                currencyid = document.getElementById("datatable1").rows[rid].cells[9].innerHTML;
                $('#txtCurrency').val(document.getElementById("datatable1").rows[rid].cells[10].innerHTML);

                act = 1;
                document.getElementById("btnSave").innerHTML = "Бүртгэх";

                $('#myModal').modal('show');
            }
        });

        $('.editRow').on('click', function () {
            selid = $(this).attr('data-id');
            if (selid == 0) {
                swal('Анхааруулга', 'Эхлээд нэмнэ үү !', 'warning');
            }
            else {
                roomtypeid = document.getElementById("datatable1").rows[rid].cells[1].innerHTML;
                $('#txtRoomType').val(document.getElementById("datatable1").rows[rid].cells[2].innerHTML);
                seasonid = document.getElementById("datatable1").rows[rid].cells[3].innerHTML;
                $('#txtSeason').val(document.getElementById("datatable1").rows[rid].cells[4].innerHTML);
                guesttypeid = document.getElementById("datatable1").rows[rid].cells[5].innerHTML;
                $('#txtGuestType').val(document.getElementById("datatable1").rows[rid].cells[6].innerHTML);
                lifetimeid = document.getElementById("datatable1").rows[rid].cells[7].innerHTML;
                $('#txtLifeTime').val(document.getElementById("datatable1").rows[rid].cells[8].innerHTML);
                currencyid = document.getElementById("datatable1").rows[rid].cells[9].innerHTML;
                $('#txtCurrency').val(document.getElementById("datatable1").rows[rid].cells[10].innerHTML);
                $('#numPrice').val(document.getElementById("datatable1").rows[rid].cells[11].children[0].value);

                act = 0;
                document.getElementById("btnSave").innerHTML = "Засах";

                $('#myModal').modal('show');
            }
        });

        $('.deleteRow').on('click', function () {
            selid = $(this).attr('data-id');

            if (selid == 0) {
                swal('Анхааруулга', 'Эхлээд нэмнэ үү !', 'warning');
            }
            else {
                $('#RemoveModal').modal('show');
            }
        });

        function OnRowClick(row) {
            rid = row.sectionRowIndex + 1;
        }
        
        function Save() {
            var prc = $('#numPrice').val();
            var res;

            if (prc == '' && prc <= 0) {
                swal('Анхааруулга', 'Үнээ оруулна уу !', 'warning');
                return;
            }

            res = act + "," + selid + "," + roomtypeid + "," + seasonid + "," + guesttypeid + "," + lifetimeid + "," + currencyid + "," + prc + "";
            
            $.ajax({
                url: 'post.aspx/SaveHTLRoomPriceInfo',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    passvalue: res
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
                url: 'post.aspx/DeleteHTLRoomPriceInfo',
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
