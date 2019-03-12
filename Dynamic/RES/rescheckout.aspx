<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="rescheckout.aspx.cs" Inherits="Dynamic.rescheckout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="main--content">
        
        <div class="row">

            <div class="col-md-6">
                <div class="panel" style="height:700px; overflow-y:auto">
                    <div class="panel-heading">
                        <h3 class="panel-title">Ширээ</h3>
                    </div>
                    <div class="panel-content">
                        
                        <ul class="nav nav-tabs">
                            <% for (int i = 0; i < dtResCategory.Rows.Count; i++)
                                {
                                    if (i == 0)
                                    {
                                        %>
                                            <li class="nav-item"><a href="#tab<%= i.ToString() %>" data-toggle="tab" class="nav-link active"><%= dtResCategory.Rows[i]["CategoryName"].ToString() %></a></li>
                                        <%
                                    }
                                    else
                                    {
                                        %>
                                            <li class="nav-item"><a href="#tab<%= i.ToString() %>" data-toggle="tab" class="nav-link"><%= dtResCategory.Rows[i]["CategoryName"].ToString() %></a></li>
                                        <%
                                    }
                                }
                            %>
                        </ul>
                        <div class="tab-content">
                            <% for (int i = 0; i < dtResCategory.Rows.Count; i++)
                                {
                                    if (i == 0)
                                    {
                                        %>
                                        <div class="tab-pane fade show active" id="tab<%= i.ToString() %>">    
                                        <%
                                    }
                                    else
                                    {
                                        %>
                                        <div class="tab-pane fade" id="tab<%= i.ToString() %>">
                                        <%
                                    }
                                    LoadTables(dtResCategory.Rows[i]["CategoryPkID"].ToString());
                                    for (int k = 0; k < dtTables.Rows.Count; k++)
                                    {
                                        %>
                                            <div class="btn btn-rounded btn-outline-warning tablelist" id="table<%= dtTables.Rows[k]["TablePkID"].ToString() %>" onclick="tableclick('table<%= dtTables.Rows[k]["TablePkID"].ToString() %>', '<%= dtTables.Rows[k]["TableID"].ToString() %>', '<%= dtTables.Rows[k]["TableCapacity"].ToString() %>')" style="width: 120px; height: 120px; margin-top:10px; margin-right:5px">
                                                <%
                                                    if (dtTables.Rows[k]["OrderSum"] != DBNull.Value)
                                                    {%>
                                                        <div class="d-flex justify-content-center">
                                                            <h1><%= dtTables.Rows[k]["TableID"].ToString() %></h1>
                                                        </div>
                                                        <div class="d-flex justify-content-center">
                                                            <p><%= Convert.ToInt32(dtTables.Rows[k]["OrderSum"]).ToString() %>₮ (<%= dtTables.Rows[k]["OrderCnt"].ToString() %>)</p>
                                                        </div>
                                                        <div class="d-flex justify-content-center">
                                                            <p class="table-date-label" id="tblbl<%= dtTables.Rows[k]["TablePkID"].ToString() %>" data-id="tblbl<%= dtTables.Rows[k]["TablePkID"].ToString() %>"><%= dtTables.Rows[k]["OrderDate"].ToString() %></p>
                                                        </div>
                                                    <%}
                                                    else
                                                    {%>
                                                        <div class="d-flex justify-content-center">
                                                            <h1><%= dtTables.Rows[k]["TableID"].ToString() %></h1>
                                                        </div>
                                                    <%}
                                                %>
                                            </div>
                                        <%
                                    }
                                        %>
                                        </div> 
                                <%
                                }
                                %>
                        </div>

                    </div>
                </div>
                
            </div>

            <div class="col-md-6">
                <div class="panel" style="height:700px">
                    <div style="height:640px; overflow-y:auto">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-md-4">
                                    <h3 class="panel-title" id="calcTitle">Захиалга</h3>
                                </div>
                                <div class="col-md-8">
                                    <h3 class="panel-title" id="lblTime"></h3>
                                </div>
                            </div>                           
                        </div>
                        <div class="panel-content">
                        
                            <div class="row" style="height:255px; overflow-y:auto">
                                <table id="tbMain" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr role="row">
                                            <th style="text-align: center" hidden>ID</th>
                                            <th style="text-align: center">Бүтээгдэхүүн</th>
                                            <th style="text-align: center">Үнэ</th>
                                            <th style="text-align: center">Тоо ширхэг</th>
                                            <th style="text-align: center">Дүн</th>
                                            <th style="text-align: center"></th>
                                            <th style="text-align: center" hidden>Төрөл</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        
                            <br />

                            <div class="row">
                                <table id="tbSummary" class="table table-striped" style="width: 100%">
                                    <tbody>
                                        <tr id="trroot" hidden>
                                            <td style="text-align: left; padding-left: 10px"></td>
                                            <td style="text-align: left; padding-left: 10px"></td>
                                            <td style="text-align: left" hidden><%= dtRestaurant.Rows[0]["IsTaxIncluded"].ToString() %></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left; padding-left: 10px">НӨАТ</td>
                                            <td style="text-align: left; padding-left: 10px"><%= dtRestaurant.Rows[0]["Tax"].ToString() %>%</td>
                                            <td style="text-align: right; padding-right: 10px">30₮</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left; padding-left: 10px">Хотын татвар</td>
                                            <td style="text-align: left; padding-left: 10px"><%= dtRestaurant.Rows[0]["CityTax"].ToString() %>%</td>
                                            <td style="text-align: right; padding-right: 10px">3₮</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left; padding-left: 10px">Үйлчилгээний хураамж</td>
                                            <td style="text-align: left; padding-left: 10px"><%= dtRestaurant.Rows[0]["ServiceChargeTax"].ToString() %>%</td>
                                            <td style="text-align: right; padding-right: 10px">3₮</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left; padding-left: 10px">Нийт дүн</td>
                                            <td style="text-align: left; padding-left: 10px"></td>
                                            <td style="text-align: right; padding-right: 10px">0₮</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            

                        </div>
                    </div>

                    <div>
                        <div class="row d-flex flex-row" style="margin-left:10px; margin-top:10px; margin-bottom:10px">
                            <div class="d-flex flex-row">
                                <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal">Бүтээгдэхүүн нэмэх</a>
                            </div>
                            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                            <button type="button" id="btnCheck" style="padding-left:0px" class="btn btn-rounded btn-success p-2" onclick="Checkout()">Тооцоо гаргах</button>
                            <p>&nbsp;&nbsp;</p>
                            <button type="button" id="btnSave" style="padding-left:15px" class="btn btn-rounded btn-primary p-2" onclick="SaveOrder()">Хадгалах</button>
                            <p>&nbsp;&nbsp;</p>
                            <button type="button" id="btnPrint" style="padding-left:15px" class="btn btn-rounded btn-info p-2" onclick="PrintOrder()">Баримт хэвлэх</button>
                            <p>&nbsp;&nbsp;</p>
                            <button type="button" id="btnCancel" style="padding-left:15px" class="btn btn-rounded btn-danger p-2" onclick="CancelOrder()">Цуцлах</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        
    </section>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Бүтээгдэхүүн нэмэх</h5>
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body" id="tabitems" style="height:500px; overflow-y:auto">
                        <ul class="nav nav-tabs">
                            <% for (int i = 0; i < dtMenu.Rows.Count; i++)
                                {
                                    if (i == 0)
                                    {
                            %>
                            <li class="nav-item"><a id="prodtablink<%= i.ToString() %>" href="#prodtab<%= i.ToString() %>" data-toggle="tab" class="nav-link active"><%= dtMenu.Rows[i]["MenuName"].ToString() %></a></li>
                            <%
                                    }
                                    else
                                    {
                            %>
                            <li class="nav-item"><a id="prodtablink<%= i.ToString() %>" href="#prodtab<%= i.ToString() %>" data-toggle="tab" class="nav-link"><%= dtMenu.Rows[i]["MenuName"].ToString() %></a></li>
                            <%
                                    }
                                }
                            %>
                        </ul>

                        <div class="tab-content">
                            <% for (int i = 0; i < dtMenu.Rows.Count; i++)
                                {
                                    if (i == 0)
                                    {
                            %>
                                        <div class="tab-pane fade show active" id="prodtab<%= i.ToString() %>">
                            <%
                                    }
                                    else
                                    {
                            %>
                                        <div class="tab-pane fade" id="prodtab<%= i.ToString() %>">
                            <%
                                    }
                            %>
                            <% 
                                LoadItems(dtMenu.Rows[i]["RestaurantMenuPkID"].ToString());
                                for (int k = 0; k < dtItem.Rows.Count; k++)
                                {
                            %>
                                <div class="btn btn-rounded btn-outline-warning itemlist" id="<%= dtItem.Rows[k]["ItemPkID"].ToString() %>" onclick="itemclick('<%= dtItem.Rows[k]["ItemPkID"].ToString() %>','<%= dtItem.Rows[k]["ItemName"].ToString() %>', <%= dtItem.Rows[k]["OutPrice"].ToString() %>, '<%= dtItem.Rows[k]["BufetInfoName"].ToString() %>')" style="width: 220px; height: 140px; margin-top: 10px; margin-right: 5px">
                                    <div class="d-flex justify-content-center" style="margin-top: 0px">
                                        <img src="../upload/table.png" width="50px" height="50px" />
                                    </div>
                                    <div class="d-flex justify-content-center">
                                        <p>Үнэ - <%= Convert.ToInt64(dtItem.Rows[k]["OutPrice"]) %>₮</p>
                                    </div>
                                    <div class="d-flex justify-content-center" style="height: 50px">
                                        <p style="white-space: pre-line; overflow-y: hidden"><%= dtItem.Rows[k]["ItemName"].ToString() %></p>
                                    </div>
                                </div>
                            <%
                                }
                            %>
                                </div>
                            <%
                                }
                            %>
                        </div>
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
                    <h5>Энэ захиалгыг цуцлах уу ?</h5>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Болих</button>
                    <button type="button" class="btn btn-rounded btn-danger" onclick="Cancel()">Цуцлах</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="CheckoutModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Тооцоо гаргах</h5>
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <div class="row" style="margin-left:2px; margin-right:2px">
                            <table id="tbCheckout" class="table table-bordered" style="width:100%">
                                <tbody>
                                    <tr>
                                        <td class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6" style="text-align:left">
                                                    Нийт бүтээгдэхүүн
                                                </div>
                                                <div class="col-md-6" style="text-align:right">
                                                    <p style="color:black" id="lblQty"></p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6" style="text-align:left">
                                                    Нийт төлөх
                                                </div>
                                                <div class="col-md-6" style="text-align:right">
                                                    <p style="color:black" onclick="changesummaries()" id="lblSubtotal"></p>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6" style="text-align:left">
                                                    Хөнгөлөлт
                                                </div>
                                                <div class="col-md-6" style="text-align:right">
                                                    <p style="color:black" id="lblSavePerc">0%</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6" style="text-align:left">
                                                    Хөнгөлөлтийн дараа
                                                </div>
                                                <div class="col-md-6" style="text-align:right">
                                                    <p style="color:black" id="lblTotal"></p>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6" style="text-align:left">
                                                    Нийт төлсөн
                                                </div>
                                                <div class="col-md-6" style="text-align:right">
                                                    <p style="color:black" id="lblPaidAmt">0₮</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6" style="text-align:left">
                                                    <p id="lblBlncTitle">Үлдэгдэл</p>
                                                </div>
                                                <div class="col-md-6" style="text-align:right">
                                                    <p style="color:black" id="lblBalance"></p>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <br />

                        <div class="row">
                            <div class="col-md-6">
                                <h5>Том хүний тоо</h5>
                                <input class="form-control" min="0" autocomplete="off" type="number" id="numAdult" />
                            </div>
                            <div class="col-md-6">
                                <h5>Хүүхдийн тоо</h5>
                                <input class="form-control" min="0" autocomplete="off" type="number" id="numChildren" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <h5>Харилцагч</h5>
                                <select class="form-control" style="width: 100%" id="cmbCustomerInfo">
                                    <% foreach (System.Data.DataRow rw in dtCustomerInfo.Rows)
                                        {
                                    %>
                                    <option value="<%=rw["CustomerPkID"].ToString() %>" data-value="<%=rw["Discount"].ToString() %>"><%=rw["CustomerName"].ToString() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <h5 id="lblCardInfo">Хөнгөлтийн карт</h5>
                                <input type="text" class="form-control" onchange="loadcardinfo(this)" autocomplete="off" id="txtCardInfo"/>
                            </div>
                        </div>

                        <br />
                        
                        <div id="divPayment" style="border-left:6px solid #ff6a00; padding: 20px 20px 0 20px;"></div>

                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                    <button id="btnCoutPerson" type="button" class="btn btn-rounded btn-warning">Хувь хүн</button>
                    <button id="btnCoutComp" type="button" class="btn btn-rounded btn-warning">Байгууллага</button>
                </div>

            </div>
        </div>

    </div>

    <script type = "text/javascript">
        
        var rid = 0;
        var tableid = 0;
        var orderid = 0;
        var total = 0;
        var ftotal = 0;
        var istaxincluded = 'Y';
        var tax = 0;
        var taxamnt = 0;
        var citytax = 0;
        var citytaxamnt = 0;
        var servicetax = 0;
        var servicetaxamnt = 0;
        var adlt = 0;
        var chldrn = 0;
        var odate;
        var cardid = "";
        var cardperc = 0;
        var saveamount = 0;
        var customer = "";
        var prodcnt = 0;
        var totalpaid = 0;
        var balance = 0;
        var tmpttl = 0;
                
        function tableclick(id, no, cap) {
            if (tableid != id) {
                
                $(".tablelist").attr('class', 'btn btn-rounded btn-outline-warning tablelist');
                tableid = id;
                activetables();
                document.getElementById("calcTitle").innerHTML = "Захиалга ( " + no + "-р ширээ )";
                
                $.ajax({
                    url: '../post.aspx/GetRESTableOrders',
                    type: 'POST',
                    dataType: 'json',
                    data: JSON.stringify({
                        tbid: id
                    }),
                    contentType: 'application/json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                    },
                    success: function (response) {
                        if (response.d != null) {
                            orderid = response.d.OrderPkID;
                            adlt = response.d.AdultNum;
                            $('#numAdult').val(adlt);
                            chldrn = response.d.ChildrenNum;
                            $('#numChildren').val(chldrn);
                            cardid = response.d.RoyaltyNo;
                            $('#txtCardInfo').val(cardid);
                        }
                        else {
                            orderid = 0;
                            adlt = 0;
                            chldrn = 0;
                            $('#lblQty').text("0");
                            $('#tbModal').modal('show');
                            adlt = cap;
                            $('#numAdult').val(adlt);
                            chldrn = 0;
                            $('#numChildren').val(chldrn);
                            cardid = "";
                            $('#txtCardInfo').val(cardid);
                        }

                        totalpaid = 0;
                        $('#lblPaidAmt').text(totalpaid.toString() + "₮");
                        balance = 0;
                        $('#lblBlncTitle').text("Үлдэгдэл");
                        $('#lblBalance').text(balance.toString() + "₮");
                        $(".payment").each(function (index) {
                            $(this).val(0);
                        });

                        $(".itemlist").attr('class', 'btn btn-rounded btn-outline-warning itemlist');
                        $("#txtCardInfo").trigger("onchange");
                        $("#btnCheck").attr("disabled", false);
                        $("#btnSave").attr("disabled", false);
                        $("#btnPrint").attr("disabled", false);
                        $("#btnCancel").attr("disabled", false);
                        if ($('#tabitems >ul >li').length > 0) {
                            $('#prodtablink0').trigger('click');
                        }
                        Clear();
                    }
                }).done(function () {
                    if (orderid != 0) {
                        $.ajax({
                            url: '../post.aspx/GetRESOrderItems',
                            type: 'POST',
                            data: JSON.stringify({
                                ordid: orderid
                            }),
                            dataType: 'json',
                            contentType: 'application/json',
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                            },
                            success: function (msg) {
                                if (msg.d != null) {
                                    $.each(msg.d, function () {
                                        addorderrow(this['ItemPkID'], this['ItemName'], this['Price'], this['Qty'], this['BufetInfoName']);
                                    });
                                }
                                CalcSummary();
                            }
                        });
                    }
                    else {
                        CalcSummary();
                    }
                });
            }
        }
        
        function Clear() {
            $("#tbMain").find("tr:gt(0)").remove();
        }

        function addorderrow(idd, namee, pricee, qtyy, buffet) {
            var rownum = document.getElementById("tbMain").rows.length;
            $('#tbMain tr:last').after('<tr>' +
                                    '<td style="text-align: center; width:0%" hidden>' + idd + '</td>' +
                                    '<td style="text-align: left; width:50%">' + namee + '</td>' +
                                    '<td style="text-align: right; width:10%; padding-right: 10px">' + pricee + '</td>' +
                                    '<td style="text-align: center; width:20%">' +
                                        '<div class="d-flex justify-content-center">' +
                                            '<a class="sub_btn" href="#" data-id="' + rownum + '"><i class="fas fa-minus-square"></i></a>' +
                                            '<p>&nbsp;&nbsp;</p>' +
                                            '<p>' + qtyy + '</p>' +
                                            '<p>&nbsp;&nbsp;</p>' +
                                            '<a class="add_btn" href="#" data-id="' + rownum + '"><i class="fas fa-plus-square"></i></a>' +
                                        '</div>' +
                                    '</td>' +
                                    '<td style="text-align: right; width:10%; padding-right: 10px">' + pricee * qtyy + '</td>' +
                                    '<td style="text-align: center; width:10%">' +
                                        '<a class="del_btn" href="#" data-id="' + rownum + '"><i class="fas fa-trash-alt"></i></a>' +
                                    '</td>' +
                                    '<td style="text-align: center; width:0%" hidden>' + buffet + '</td>' +
                                '</tr>');
            $("#" + idd).attr('class', 'btn btn-rounded btn-outline-success itemlist');
        }

        function itemclick(id, name, price, bft) {
            if(tableid != 0){
                var table = document.getElementById("tbMain");
                var isExist = false;
                for (var i = 1, row; row = table.rows[i]; i++) {
                    if (id == row.cells[0].innerHTML) {
                        var qty = parseInt(row.cells[3].children[0].children[2].innerHTML);
                        qty += 1;
                        row.cells[3].children[0].children[2].innerHTML = qty;
                        var prc = parseInt(row.cells[2].innerHTML);
                        row.cells[4].innerHTML = prc * qty;
                        isExist = true;
                        break;
                    }
                }
                if (!isExist) {
                    addorderrow(id, name, price, 1, bft);
                }
                CalcSummary();
            }
            else {
                swal('Анхааруулга', 'Ширээгээ сонгоно уу !', 'warning');
            }
        }

        $("table").on("click", ".sub_btn", function (e) {
            rid = $(this).attr('data-id');
            var qty = parseInt(document.getElementById("tbMain").rows[rid].cells[3].children[0].children[2].innerHTML);
            if (qty > 0) {
                qty -= 1;
                document.getElementById("tbMain").rows[rid].cells[3].children[0].children[2].innerHTML = qty;
                var prc = parseInt(document.getElementById("tbMain").rows[rid].cells[2].innerHTML);
                document.getElementById("tbMain").rows[rid].cells[4].innerHTML = prc * qty;
            }
            CalcSummary();
            e.preventDefault();
        });

        $("table").on("click", ".add_btn", function (e) {
            rid = $(this).attr('data-id');
            var qty = parseInt(document.getElementById("tbMain").rows[rid].cells[3].children[0].children[2].innerHTML);
            qty += 1;
            document.getElementById("tbMain").rows[rid].cells[3].children[0].children[2].innerHTML = qty;
            var prc = parseInt(document.getElementById("tbMain").rows[rid].cells[2].innerHTML);
            document.getElementById("tbMain").rows[rid].cells[4].innerHTML = prc * qty;
            CalcSummary();
            e.preventDefault();
        });
        
        $("table").on("click", ".del_btn", function (e) {
            rid = $(this).attr('data-id');
            document.getElementById("tbMain").rows[rid].cells[3].children[0].children[2].innerHTML = 0;
            document.getElementById("tbMain").rows[rid].cells[4].innerHTML = 0;
            CalcSummary();
            e.preventDefault();
        });
        
        function CalcSummary() {
            total = 0;
            ftotal = 0;
            tax = 0;
            taxamnt = 0;
            citytax = 0;
            citytaxamnt = 0;
            servicetax = 0;
            servicetaxamnt = 0;
            
            istaxincluded = document.getElementById("tbSummary").rows[0].cells[2].innerHTML;

            var transfer = "";

            var table = document.getElementById("tbMain");
            for (var i = 1, row; row = table.rows[i]; i++) {
                transfer += row.cells[6].innerHTML + "," + row.cells[4].innerHTML + ";";
                total += parseInt(row.cells[4].innerHTML);
            }
                    
            var addedrowcnt = 0;
            $('.tradded').remove();

            if (transfer != '') {
                prodcnt = 0;
                $.ajax({
                    url: '../post.aspx/GroupItems',
                    type: 'POST',
                    data: JSON.stringify({
                        val: transfer
                    }),
                    dataType: 'json',
                    contentType: 'application/json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                    },
                    success: function (msg) {
                        if (msg.d != null) {
                            $.each(msg.d, function () {
                                //var table = document.getElementById("tbSummary");
                                //var isExist = false;
                                //for (var i = 1, row; row = table.rows[i]; i++) {
                                //    if (this['KeyValue'] == row.cells[0].innerHTML) {
                                //        isExist = true;
                                //        row.cells[1].innerHTML = this['CountValue'] + ' бүтээгдэхүүн';
                                //        row.cells[2].innerHTML = this['SumValue'] + '₮';
                                //        addedrowcnt++;
                                //        prodcnt += parseInt(this['CountValue']);
                                //        break;
                                //    }
                                //}
                                //if (!isExist) {
                                    $('#trroot').after('<tr class="tradded">' +
                                                        '<td style="text-align: left; padding-left: 10px">' + this['KeyValue'] + '</td>' +
                                                        '<td style="text-align: left; padding-left: 10px">' + this['CountValue'] + ' бүтээгдэхүүн</td>' +
                                                        '<td style="text-align: right; padding-right: 10px">' + this['SumValue'] + '₮</td>' +
                                                    '</tr>');
                                    addedrowcnt++;
                                    prodcnt += parseInt(this['CountValue']);
                                //}
                            });
                        }
                    }
                }).done(function () {
                    $('#lblQty').text(prodcnt);
                });
            }
            
            ftotal = total;
            if (istaxincluded == "Y") {
                tax = parseFloat(document.getElementById("tbSummary").rows[1 + addedrowcnt].cells[1].innerHTML.slice(0, -1));
                taxamnt = ftotal / 100 * tax;
                ftotal = ftotal - taxamnt;
                document.getElementById("tbSummary").rows[1 + addedrowcnt].cells[2].innerHTML = (taxamnt).toString() + "₮";
                citytax = parseFloat(document.getElementById("tbSummary").rows[2 + addedrowcnt].cells[1].innerHTML.slice(0, -1));
                citytaxamnt = ftotal / 100 * citytax;
                document.getElementById("tbSummary").rows[2 + addedrowcnt].cells[2].innerHTML = (citytaxamnt).toString() + "₮";
                servicetax = parseFloat(document.getElementById("tbSummary").rows[3 + addedrowcnt].cells[1].innerHTML.slice(0, -1));
                servicetaxamnt = ftotal / 100 * servicetax;
                document.getElementById("tbSummary").rows[3 + addedrowcnt].cells[2].innerHTML = (servicetaxamnt).toString() + "₮";
                ftotal = ftotal + taxamnt + citytaxamnt + servicetaxamnt;
                document.getElementById("tbSummary").rows[4 + addedrowcnt].cells[2].innerHTML = (ftotal).toString() + "₮";
            }
            else {
                tax = parseFloat(document.getElementById("tbSummary").rows[1 + addedrowcnt].cells[1].innerHTML.slice(0, -1));
                taxamnt = ftotal / 100 * tax;
                document.getElementById("tbSummary").rows[1 + addedrowcnt].cells[2].innerHTML = (taxamnt).toString() + "₮";
                citytax = parseFloat(document.getElementById("tbSummary").rows[2 + addedrowcnt].cells[1].innerHTML.slice(0, -1));
                citytaxamnt = ftotal / 100 * citytax;
                document.getElementById("tbSummary").rows[2 + addedrowcnt].cells[2].innerHTML = (citytaxamnt).toString() + "₮";
                servicetax = parseFloat(document.getElementById("tbSummary").rows[3 + addedrowcnt].cells[1].innerHTML.slice(0, -1));
                servicetaxamnt = ftotal / 100 * servicetax;
                document.getElementById("tbSummary").rows[3 + addedrowcnt].cells[2].innerHTML = (servicetaxamnt).toString() + "₮";
                ftotal = ftotal + taxamnt + citytaxamnt + servicetaxamnt;
                document.getElementById("tbSummary").rows[4 + addedrowcnt].cells[2].innerHTML = (ftotal).toString() + "₮";
            }
            
            //$('#lblTotal').text(ftotal.toString() + "₮");
            //$('#lblBalance').text(ftotal.toString() + "₮");
            $('#lblSubtotal').text(ftotal.toString() + "₮");
            changesummaries();
        }
        
        function Checkout() {
            tmpttl = ftotal;
            $('#CheckoutModal').modal('show');
        }

        function SaveOrder() {
            var itemcnt = document.getElementById("tbMain").rows.length;

            if (itemcnt == 0) {
                swal('Анхааруулга', 'Бүтээгдэхүүнээ сонгоно уу !', 'warning');
                return;
            }

            Save(orderid, tableid.substring(5, tableid.length), adlt, chldrn, '', odate, customer, '', 0);
        }

        function Save(id, tbid, adult, children, receipt, odate, customer, royalty, status) {

            var table = document.getElementById("tbMain");
            var result = "";

            for (var i = 1, row; row = table.rows[i]; i++) {
                result += row.cells[0].innerHTML + "," + row.cells[2].innerHTML + "," + row.cells[3].children[0].children[2].innerHTML + ";";
            }

            if (result != "") {
                result = result.slice(0, -1);
            }

            $.ajax({
                url: '../post.aspx/SaveRESOrderInfo',
                type: 'POST',
                data: JSON.stringify({
                    orderid: id,
                    tableid: tbid,
                    adultnum: adult,
                    childnum: children,
                    recpt: receipt,
                    date: odate,
                    custid: customer,
                    royltid: royalty,
                    stats: status,
                    items: result
                }),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    if (msg.d == false) {
                        swal('Анхааруулга', 'Амжилтгүй боллоо !', 'warning');
                    }
                    else {
                        swal('Амжилттай', 'Амжилттай хадгаллаа !', 'success');

                        //window.location.reload();
                    } 
                }
            });

        }

        function PrintOrder() {
            //print hiih uildel
            
        }

        function CancelOrder() {
            if (tableid != 0) {
                if (orderid != 0) {
                    $('#RemoveModal').modal('show');
                }
                else {
                    swal('Анхааруулга', 'Шинэ захиалга цуцлах боломжгүй !', 'warning');
                }
            }
            else {
                swal('Анхааруулга', 'Ширээгээ сонгоно уу !', 'warning');
            }
        }

        function Cancel() {
            $.ajax({
                url: '../post.aspx/DelRESOrderInfo',
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify({
                    ordid: orderid
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
                        swal('Амжилттай', 'Амжилттай цуцаллаа !', 'success');

                        window.location.reload();
                    }
                }
            })
        }

        function activetables() {
            $.ajax({
                url: '../post.aspx/GetRESActiveTables',
                type: 'POST',
                data: JSON.stringify({}),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    if (msg.d != null) {
                        $.each(msg.d, function () {
                            $("#table" + this['TablePkID']).attr('class', 'btn btn-rounded btn-outline-success tablelist');
                        });
                    }
                }
            }).done(function () {
                $("#" + tableid).attr('class', 'btn btn-rounded btn-success tablelist');
            });
        }

        function startTime() {
            $('#lblTime').text(moment().format('YYYY-MM-DD HH:mm:ss'));
            var t = setTimeout(startTime, 500);
        }

        function tabletimer() {
            //$(res).text(moment().format('YYYY-MM-DD HH:mm:ss'));
            //var t = setTimeout(tabletimer(res), 500);
            $(".table-date-label").each(function (index) {
                //alert($(this).attr('data-id'));
                document.getElementById($(this).attr('data-id')).onload = ticktime($(this).attr('data-id'), $(this).attr('data-id'))
            });
        }

        function ticktime(did, txt) {
            //alert(did + ' ' + txt);
            $(res).text(moment().format('YYYY-MM-DD HH:mm:ss'));
            var t = setTimeout(tabletimer(res), 500);
        }

        function loadpayment() {
            $.ajax({
                url: '../post.aspx/GetPaymentInfo',
                type: 'POST',
                data: JSON.stringify({}),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                },
                success: function (msg) {
                    if (msg.d != null) {
                        $.each(msg.d, function () {
                            var input = jQuery('<div class="row">'+
                                                    '<div class="col-md-6">' +
                                                        '<h5>' + this['PaymentName'] + '</h5>' +
                                                    '</div>'+
                                                    '<div class="col-md-6">' +
                                                        '<input type="number" onchange="calcpaidamt()" min="0" class="form-control payment" autocomplete="off" value="0"/>' +
                                                    '</div>'+
                                                '</div><br/>');
                            jQuery('#divPayment').append(input);
                        });
                    }
                }
            })
        }
        
        function loadcardinfo(par) {
            if (par.value != "") {
                $.ajax({
                    url: '../post.aspx/GetCardInfo',
                    type: 'POST',
                    data: JSON.stringify({
                        card: par.value
                    }),
                    dataType: 'json',
                    contentType: 'application/json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        swal('Алдаа', "Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown, 'warning');
                    },
                    success: function (msg) {
                        if (msg.d != null) {
                            $.each(msg.d, function () {
                                cardid = this['CardID'];
                                cardperc = parseInt(this['CardValue']);
                                $('#lblSavePerc').text(cardperc + "%");
                                document.getElementById('lblCardInfo').innerHTML = "Хөнгөлтийн карт (" + this['FirstName'] + ")";
                                $('#cmbCustomerInfo').select2({
                                    dropdownParent: $('#CheckoutModal')
                                }).val("0").trigger('change');
                            });
                        }
                        else {
                            $('#txtCardInfo').val("");
                            $("#txtCardInfo").trigger("onchange");
                            $('#cmbCustomerInfo').select2({
                                dropdownParent: $('#CheckoutModal')
                            }).val("0").trigger('change');
                        }
                    }
                }).done(function () {
                    tmpttl = ftotal;
                    saveamount = tmpttl / 100 * cardperc;
                    tmpttl = tmpttl - saveamount;
                    $('#lblTotal').text(tmpttl + "₮");
                    balance = tmpttl - totalpaid;
                    if (balance > 0) {
                        $('#lblBlncTitle').text("Үлдэгдэл");
                        $('#lblBalance').text(balance.toString() + "₮");
                    }
                    else {
                        $('#lblBlncTitle').text("Хариулт");
                        $('#lblBalance').text(Math.abs(balance).toString() + "₮");
                    }
                });
            }
            else {
                document.getElementById('lblCardInfo').innerHTML = "Хөнгөлтийн карт";
                cardperc = 0;
                $('#lblSavePerc').text(cardperc + "%");
                $('#cmbCustomerInfo').select2({
                    dropdownParent: $('#CheckoutModal')
                }).val("0").trigger('change');
                    changesummaries();
            }
        }
        
        function calcpaidamt() {
            totalpaid = 0;
            $(".payment").each(function (index) {
                if ($(this).val() != "") {
                    totalpaid += parseInt($(this).val());
                }
            });
            $('#lblPaidAmt').text(totalpaid.toString() + "₮");
            balance = tmpttl - totalpaid;
            if (balance > 0) {
                $('#lblBlncTitle').text("Үлдэгдэл");
                $('#lblBalance').text(balance.toString() + "₮");
            }
            else {
                $('#lblBlncTitle').text("Хариулт");
                $('#lblBalance').text(Math.abs(balance).toString() + "₮");
            }
        }

        function changesummaries() {
            tmpttl = ftotal;
            saveamount = tmpttl / 100 * cardperc;
            tmpttl = tmpttl - saveamount;
            $('#lblTotal').text(tmpttl + "₮");
            balance = tmpttl - totalpaid;
            if (balance > 0) {
                $('#lblBlncTitle').text("Үлдэгдэл");
                $('#lblBalance').text(balance.toString() + "₮");
            }
            else {
                $('#lblBlncTitle').text("Хариулт");
                $('#lblBalance').text(Math.abs(balance).toString() + "₮");
            }
        }

        $("#cmbCustomerInfo").change(function () {
            if ($(this).find('option:selected').val() != "0"){
                document.getElementById('lblCardInfo').innerHTML = "Хөнгөлтийн карт";
                $('#txtCardInfo').val("");
                cardperc = $(this).find('option:selected').attr("data-value");
                $('#lblSavePerc').text(cardperc + "%");
                changesummaries();
            }
        });

        $(document).ready(function () {
            tabletimer();
            CalcSummary();
            $('#cmbCustomerInfo').select2({
                dropdownParent: $('#CheckoutModal')
            });
            $("#btnCheck").attr("disabled", true);
            $("#btnSave").attr("disabled", true);
            $("#btnPrint").attr("disabled", true);
            $("#btnCancel").attr("disabled", true);
            odate = '<%= Session["PosDate"] %>';

            activetables();

            startTime();

            loadpayment();
        });
        
    </script>

</asp:Content>
