<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="rescheckout.aspx.cs" Inherits="Dynamic.rescheckout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="main--content">
        
        <div class="row">

            <div class="col-md-6">
                <div class="panel" style="height:700px; overflow-y:auto">
                    <div class="panel-heading">
                        <h3 class="panel-title">Танхим</h3>
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
                                            <div class="btn btn-rounded btn-outline-warning" onclick="tableclick(<%= dtTables.Rows[k]["TablePkID"].ToString() %>)" style="width: 140px; height: 140px; margin-top:10px; margin-right:5px">
                                                <div class="d-flex justify-content-center" style="margin-top:10px">
                                                    <img src="../upload/table.png" width="50px" height="50px" />
                                                </div>
                                                <div class="d-flex justify-content-center">
                                                    <h6>Дугаар - <%= dtTables.Rows[k]["TableID"].ToString() %></h6>
                                                </div>
                                                <div class="d-flex justify-content-center">
                                                    <h6>Суудал - <%= dtTables.Rows[k]["TableCapacity"].ToString() %></h6>
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

            <div class="col-md-6">
                <div class="panel" style="height:700px; overflow-y:auto">
                    <div class="panel-heading">
                        <h3 class="panel-title">Тооцоо</h3>
                    </div>
                    <div class="panel-content">
                        
                        <div class="d-flex flex-row">
                            <a href="#myModal" class="btn btn-rounded btn-warning" data-toggle="modal">Бүтээгдэхүүн нэмэх</a>
                        </div>

                        <br />

                        <div class="row" style="height:300px; overflow-y:auto">
                            <table id="tbMain" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr role="row">
                                        <th style="text-align: center" hidden>ID</th>
                                        <th style="text-align: center">Бүтээгдэхүүн</th>
                                        <th style="text-align: center">Үнэ</th>
                                        <th style="text-align: center">Тоо ширхэг</th>
                                        <th style="text-align: center">Дүн</th>
                                        <th style="text-align: center"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--<tr>
                                        <td style="text-align: center; width:0%" hidden>2019021500000010</td>
                                        <td style="text-align: left; width:50%">Гурилтай өндөгтэй үхрийн махан шөл</td>
                                        <td style="text-align: right; width:10%; padding-right: 10px">15000</td>
                                        <td style="text-align: center; width:20%">
                                            <div class="d-flex justify-content-center">
                                                <a class="sub_btn" href="#" data-id="1"><i class="fas fa-minus-square"></i></a>
                                                <p>&nbsp;&nbsp;</p>
                                                <p>1</p>
                                                <p>&nbsp;&nbsp;</p>
                                                <a class="add_btn" href="#" data-id="1"><i class="fas fa-plus-square"></i></a>
                                            </div>
                                        </td>
                                        <td style="text-align: right; width:10%; padding-right: 10px">150</td>
                                        <td style="text-align: center; width:10%">
                                            <a class="del_btn" href="#" data-id="1"><i class="fas fa-trash-alt"></i></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center; width:0%" hidden>2019021500000002</td>
                                        <td style="text-align: left; width:50%">Үхрийн махтай хар мөөгтэй хуурга</td>
                                        <td style="text-align: right; width:10%; padding-right: 10px">15000</td>
                                        <td style="text-align: center; width:20%">
                                            <div class="d-flex justify-content-center">
                                                <a class="sub_btn" href="#" data-id="2"><i class="fas fa-minus-square"></i></a>
                                                <p>&nbsp;&nbsp;</p>
                                                <p>1</p>
                                                <p>&nbsp;&nbsp;</p>
                                                <a class="add_btn" href="#" data-id="2"><i class="fas fa-plus-square"></i></a>
                                            </div>
                                        </td>
                                        <td style="text-align: right; width:10%; padding-right: 10px">150</td>
                                        <td style="text-align: center; width:10%">
                                            <a class="del_btn" href="#" data-id="2"><i class="fas fa-trash-alt"></i></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center; width:0%" hidden>2019021500000006</td>
                                        <td style="text-align: left; width:50%">Хуурай шарсан хонины хавирга</td>
                                        <td style="text-align: right; width:10%; padding-right: 10px">25000</td>
                                        <td style="text-align: center; width:20%">
                                            <div class="d-flex justify-content-center">
                                                <a class="sub_btn" href="#" data-id="3"><i class="fas fa-minus-square"></i></a>
                                                <p>&nbsp;&nbsp;</p>
                                                <p>1</p>
                                                <p>&nbsp;&nbsp;</p>
                                                <a class="add_btn" href="#" data-id="3"><i class="fas fa-plus-square"></i></a>
                                            </div>
                                        </td>
                                        <td style="text-align: right; width:10%; padding-right: 10px">150</td>
                                        <td style="text-align: center; width:10%">
                                            <a class="del_btn" href="#" data-id="3"><i class="fas fa-trash-alt"></i></a>
                                        </td>
                                    </tr>--%>
                                </tbody>
                            </table>
                        </div>
                        
                        <br />

                        <div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>Том хүний тоо</h6>
                                    <input class="form-control" min="0" type="number" id="numAdult" />
                                </div>
                                <div class="col-md-6">
                                    <h6>Хүүхдийн тоо</h6>
                                    <input class="form-control" min="0" type="number" id="numChildren" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>Баримтын дугаар</h6>
                                    <input class="form-control" type="text" id="txtReceiptNo" />
                                </div>
                                <div class="col-md-6">
                                    <h6>Огноо</h6>
                                    <input class="form-control" type="datetime" id="dateOrder" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>Харилцагч</h6>
                                    <input class="form-control" type="text" id="txtCustomer" />
                                </div>
                                <div class="col-md-6">
                                    <h6>Хөнгөлтийн карт</h6>
                                    <input class="form-control" type="text" id="txtCardNo" />
                                </div>
                            </div>
                        </div>

                        <br />

                        <div class="row">
                            <table id="tbSummary" class="table table-striped" style="width: 100%">
                                <tbody>
                                    <tr>
                                        <td style="text-align: left; padding-left: 10px">Дүн</td>
                                        <td style="text-align: left; padding-left: 10px">0 бүтээгдэхүүн</td>
                                        <td style="text-align: right; padding-right: 10px">0₮</td>
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
                                        <td style="text-align: left; padding-left: 10px">Хөнгөлөлт</td>
                                        <td style="text-align: left; padding-left: 10px">0%</td>
                                        <td style="text-align: right; padding-right: 10px">0₮</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; padding-left: 10px">Нийт дүн</td>
                                        <td style="text-align: left; padding-left: 10px"></td>
                                        <td style="text-align: right; padding-right: 10px">0₮</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <br />

                        <div class="d-flex flex-row">
                            <button type="button" style="padding-left:0px" class="btn btn-rounded btn-success p-2">Тооцоо гаргах</button>
                            <p>&nbsp;&nbsp;</p>
                            <button type="button" style="padding-left:15px" class="btn btn-rounded btn-primary p-2">Түр хадгалах</button>
                            <p>&nbsp;&nbsp;</p>
                            <button type="button" style="padding-left:15px" class="btn btn-rounded btn-info p-2">Баримт хэвлэх</button>
                            <p>&nbsp;&nbsp;</p>
                            <button type="button" style="padding-left:15px" class="btn btn-rounded btn-danger p-2">Цуцлах</button>
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

                <div class="modal-body" style="height:500px; overflow-y:auto">
                        <ul class="nav nav-tabs">
                            <% for (int i = 0; i < dtMenu.Rows.Count; i++)
                                {
                                    if (i == 0)
                                    {
                            %>
                            <li class="nav-item"><a href="#prodtab<%= i.ToString() %>" data-toggle="tab" class="nav-link active"><%= dtMenu.Rows[i]["MenuName"].ToString() %></a></li>
                            <%
                                    }
                                    else
                                    {
                            %>
                            <li class="nav-item"><a href="#prodtab<%= i.ToString() %>" data-toggle="tab" class="nav-link"><%= dtMenu.Rows[i]["MenuName"].ToString() %></a></li>
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
                                <div class="btn btn-rounded btn-outline-warning" onclick="itemclick('<%= dtItem.Rows[k]["ItemPkID"].ToString() %>','<%= dtItem.Rows[k]["ItemName"].ToString() %>', <%= dtItem.Rows[k]["OutPrice"].ToString() %>)" style="width: 220px; height: 140px; margin-top: 10px; margin-right: 5px">
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

                <div class="modal-footer">
                    <button type="button" class="btn btn-rounded btn-default" data-dismiss="modal">Хаах</button>
                    <button id="btnSave" type="button" class="btn btn-rounded btn-warning" onclick="Save()">Бүртгэх</button>
                </div>

            </div>
        </div>
    </div>

    <script type = "text/javascript">
        
        var rid = 0;
        var total = 0;
        var tax = 0;
        var taxamnt = 0;
        var citytax = 0;
        var citytaxamnt = 0;
        var servicetax = 0;
        var servicetaxamnt = 0;

        function tableclick(id) {
            alert(id);
        }

        function itemclick(id, name, price) {
            var table = document.getElementById("tbMain");
            var isExist = false;
            for (var i = 1, row; row = table.rows[i]; i++) {
                if (id == row.cells[0].innerHTML) {
                    isExist = true;
                    break;
                }
            }

            if (!isExist) {
                var rownum = table.rows.length;
                $('#tbMain tr:last').after('<tr>' +
                                        '<td style="text-align: center; width:0%" hidden>' + id + '</td>' +
                                        '<td style="text-align: left; width:50%">' + name + '</td>' +
                                        '<td style="text-align: right; width:10%; padding-right: 10px">' + price + '</td>' +
                                        '<td style="text-align: center; width:20%">' +
                                            '<div class="d-flex justify-content-center">' +
                                                '<a class="sub_btn" href="#" data-id="' + rownum + '"><i class="fas fa-minus-square"></i></a>' +
                                                '<p>&nbsp;&nbsp;</p>' +
                                                '<p>1</p>' +
                                                '<p>&nbsp;&nbsp;</p>' +
                                                '<a class="add_btn" href="#" data-id="' + rownum + '"><i class="fas fa-plus-square"></i></a>' +
                                            '</div>' +
                                        '</td>' +
                                        '<td style="text-align: right; width:10%; padding-right: 10px">' + price + '</td>' +
                                        '<td style="text-align: center; width:10%">' +
                                            '<a class="del_btn" href="#" data-id="' + rownum + '"><i class="fas fa-trash-alt"></i></a>' +
                                        '</td>' +
                                    '</tr>');
                CalcSummary();
            }
            else {
                swal('Анхааруулга', 'Энэ бараа нэмэгдсэн байна !', 'warning');
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
            tax = 0;
            taxamnt = 0;
            citytax = 0;
            citytaxamnt = 0;
            servicetax = 0;
            servicetaxamnt = 0;

            var table = document.getElementById("tbMain");
            for (var i = 1, row; row = table.rows[i]; i++) {
                var subtotal = parseInt(row.cells[4].innerHTML);
                total += subtotal;
            }

            //////// tatvariin huvi bodoj nemeh heseg UURCHLUGDUNU !!! 
            document.getElementById("tbSummary").rows[0].cells[1].innerHTML = (table.rows.length - 1).toString() + " бүтээгдэхүүн";
            document.getElementById("tbSummary").rows[0].cells[2].innerHTML = total.toString() + "₮";
            tax = parseFloat(document.getElementById("tbSummary").rows[1].cells[1].innerHTML.slice(0, -1));
            taxamnt = total / 100 * tax;
            document.getElementById("tbSummary").rows[1].cells[2].innerHTML = (taxamnt).toString() + "₮";
            citytax = parseFloat(document.getElementById("tbSummary").rows[2].cells[1].innerHTML.slice(0, -1));
            citytaxamnt = total / 100 * citytax;
            document.getElementById("tbSummary").rows[2].cells[2].innerHTML = (citytaxamnt).toString() + "₮";
            servicetax = parseFloat(document.getElementById("tbSummary").rows[3].cells[1].innerHTML.slice(0, -1));
            servicetaxamnt = total / 100 * servicetax;
            document.getElementById("tbSummary").rows[3].cells[2].innerHTML = (servicetaxamnt).toString() + "₮";

            total = total + taxamnt + citytaxamnt + servicetaxamnt;
            document.getElementById("tbSummary").rows[5].cells[2].innerHTML = (total).toString() + "₮";
            ///////////////////////////////////////////////////////////////
        }
        
        $(document).ready(function () {
            CalcSummary();
        });
        
    </script>

</asp:Content>
