<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="group.aspx.cs" Inherits="Minj.group" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="normalheader ">
    <div class="hpanel">
        <div class="panel-body">
            <a class="small-header-action" href="#">
                <div class="clip-header">
                    <i class="fa fa-arrow-up"></i>
                </div>
            </a>

            <h2 class="font-light m-b-xs">
                Байшин /блок/-ийн жагсаалт
            </h2>
            <small>Энэ хэсэгт компанийн барьсан хотхоны блок барилгуудын жагсаалт харагдана. Блок барилгын бүртгэлийг програмд "байшин" хэмээн нэрийдсэн болно. /Жишээлэхэд Парк Таун хотхоны 105-р байрны бүртгэлийг "байшин"-гийн бүртгэл гэх нэрийн доор оруулна./</small>
        </div>
    </div>
</div>
    <div class="content">
        <div class="panel-section">
                    <div class="input-group">
                        <button class="btn btn-default text-success" data-toggle="modal" data-target="#myModal" type="button"><i class="glyphicon glyphicon-plus small"></i> ШИНЭ БИЧЛЭГ НЭМЭХ </button>
                    </div>
                    <button type="button" data-toggle="collapse" data-target="#notes" class="btn-sm visible-xs visible-sm collapsed btn-default btn btn-block m-t-sm">
                        All notes <i class="fa fa-angle-down"></i>
                    </button>
                </div>
    <div class="table-responsive">
    <table class="table table-bordered table-striped" id="myTable">
        <thead>
            <tr>
                <th>д/д</th>
                <th>Төсөл</th>
                <th>Байшин</th>
                <th>А.Жил</th>
                <th>Баталгаат хугацаа</th>
                <th>Давхрын тоо</th>
                <th>Орц</th>
                <th>План зураг</th>
                <th>Эрэмбэлэлт</th>
                <th>Төлөв</th>
                <th>Үйлдэл</th>
            </tr>
        </thead>
        <tbody>
            <% 
				int i=0;
                foreach (System.Data.DataRow rw in List().Rows)
                {
					i++;
                            %>
                    <tr>
                        <td><%=i.ToString()%></td>
                        <td><% Response.Write(rw["ProjectGroupName"].ToString()); %></td>
                        <td><% Response.Write(rw["HouseGroupName"].ToString()); %></td>                        
                        <td><% Response.Write(rw["cYear"].ToString()); %></td>
                        <td><% Response.Write(rw["WarrantyYear"].ToString()); %></td>
                        <td><% Response.Write(rw["FloorCnt"].ToString()); %></td>
                        <td><% Response.Write(rw["OrtsCnt"].ToString()); %></td>
                        <td><img src="../Minj-order/<% Response.Write(rw["ImgPlanSrc"].ToString()); %>" width="70px;"/></td>
                        <td><% Response.Write(rw["SortOrder"].ToString()); %></td>
                        <td><% Response.Write(rw["StatusName"].ToString()); %></td>
                    <td>
                    <button type="button" data-toggle="modal" data-target="#myModal" data-id="<% Response.Write(rw["HouseGroupPkID"].ToString()); %>" class="btn btn-xs btn-info editButton">Засах</button>
                    <button class="btn btn-xs btn-danger deleteButton" type="button" data-toggle="modal" data-id="<% Response.Write(rw["HouseGroupPkID"].ToString()); %>" data-target="#confirmDelete" data-title="Мэдээлэл устгах" data-message="Та уг <<% Response.Write(rw["HouseGroupName"].ToString()); %>> бичлэгийг устгахыг зөвшөөрч байна уу ?">
        <i class="glyphicon glyphicon-trash"></i> Устгах
    </button>
                </td>
            </tr>
            <%
                } %>
            
            
        </tbody>
    </table>
        </BR>
</div>
         <div class="modal fade" id="confirmDelete" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">Delete Parmanently</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure about this ?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Болих</button>
        <button type="button" class="btn btn-danger" id="confirm" >Устгах</button>
          <input id="txtDeleteID" value="" type="hidden" />
      </div>
    </div>
  </div>
</div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="color-line"></div>
                                <div class="modal-header text-center">
                                    <h4 class="modal-title">Байшин /блок/-ийн бүртгэл</h4>
                                    <small class="font-bold">Энэ хэсэгт компанийн барьсан хотхоны блок барилгуудын бүртгэлийг хийнэ.</small>
                                </div>
                                <div class="modal-body">
                                    
                                    <p>
                                        <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h5>Төсөл</h5>
                                                <asp:DropDownList ID="cmbProjectGroup" runat="server" CssClass =" form-control cmbProjectGroup" ></asp:DropDownList>
                                                
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Байрны дугаар<span style="color:#F00"> *</span></h5>
                                                <input id="txtHouseGroupName" class="form-control txtHouseGroupName" type="text" />
                                                <input id="HouseGroupPkID" value="" type="hidden" />
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Ашиглалтанд орох жил</h5>
                                                <input id="txtcYear" class="form-control txtcYear" type="number" />
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Баталгаат хугацаа</h5>
                                                <input id="txtWarrantyYear" class="form-control txtWarrantyYear" type="number" />
                                            </div>
                                             <div class="col-md-6">
                                                <h5>Давхрын тоо</h5>
                                                <input id="txtFloorCnt" class="form-control txtFloorCnt" type="number" />
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Орцны тоо</h5>
                                                <input id="txtOrtsCnt" class="form-control txtOrtsCnt" type="number" />
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Байшингийн зураг</h5>
                                                <input type="file" id="EditFile" name="filePicker" class="file" data-show-upload="false" data-show-caption="false" />
                                                <img alt="" id="myImg" src="" />
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Эрэмбэлэлт</h5>
                                                <input id="txtSortOrder" class="form-control txtSortOrder" type="number" />
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Төлөв</h5>
                                                <asp:DropDownList ID="cmbStatus" runat="server" CssClass =" form-control cmbStatus" ></asp:DropDownList>
                                                
                                            </div>
                                        </div>
                                                                            
                                        </div>
                                    </p>                                    
                                </div>
 <span style="color:#F00; padding-left:20px;">Тайлбар: '*' тэмдэглэгээтэй талбарын утгыг заавал оруулна.</span><br><br>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Хаах</button>
                                    <button type="button" class="btn btn-primary" onclick="SaveForm()">Хадгалах</button>                                    
                                    <div class="row"> 
                                        <asp:Label ID="lbllabel1" runat="server" Text=""></asp:Label>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>

<!-- The form which is used to populate the item data -->

        </div>
<script type = "text/javascript">
    $("#txtHouseGroupName").val('');
    $("#txtOrtsCnt").val(0);
    $("#txtFloorCnt").val(0);
    $("#txtWarrantyYear").val(0);
    $("#txtcYear").val(0);
    $("#txtSortOrder").val(0);
    $("#HouseGroupPkID").val('');

    $('.editButton').on('click', function() {
        // Get the record's ID via attribute
        var txtID = $(this).attr('data-id');
        $("#HouseGroupPkID").val(txtID);
        $.ajax({
            url: 'post.aspx/GetHouseGroupInfo',
            type: 'POST',
            data: JSON.stringify({
                HouseGroupPkID: txtID
            }),
            dataType: 'json',
            contentType: 'application/json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (response) {
                var msg = (JSON.stringify(response));
                // Populate the form fields with the data returned from server
                $("#HouseGroupPkID").val(response.d.HouseGroupPkID);
                $("#txtHouseGroupName").val(response.d.HouseGroupName);
                $("#txtOrtsCnt").val(response.d.OrtsCnt);
                $("#txtFloorCnt").val(response.d.FloorCnt);
                $(".cmbProjectGroup").val(response.d.ProjectGroupPkID);
                $(".cmbStatus").val(response.d.StatusID);
                $("#txtSortOrder").val(response.d.SortOrder);
                $("#txtcYear").val(response.d.cYear);
                $("#txtWarrantyYear").val(response.d.WarrantyYear);
                $('#myImg').attr('src', response.d.ImgPlanSrc);
                $("#myModal").modal('show');
            }
        })

        
    });

     function img() {
        var url = inputToURL(document.getElementById("EditFile"));         
        document.getElementById("myImg").src = url;
    }

    function SaveForm() {
        var txtHouseGroupName = $(".txtHouseGroupName").val();
        var txtOrtsCnt = $(".txtOrtsCnt").val();
        var txtFloorCnt = $(".txtFloorCnt").val();
        var txtSortOrder = $(".txtSortOrder").val();
        var ProjectGroupPkID = $(".cmbProjectGroup").val();
        var StatusID = $(".cmbStatus").val();
        var txtWarrantyYear = $(".txtWarrantyYear").val();
        var txtcYear = $(".txtcYear").val();
        var ProjectGroupName = $(".cmbProjectGroup").children("option").filter(":selected").text();
        var StatusName = $(".cmbStatus").children("option").filter(":selected").text();
        var Adding = 0;
        var HouseGroupPkID = $("#HouseGroupPkID").val();
        var ext = $("#EditFile").val().split('.').pop();
        if (HouseGroupPkID!="")
            Adding=1;

            if (txtHouseGroupName == "") {
                $(".lbllabel1").text("Та заавал нэрийг оруулах ёстой.");
                return;
            }
            $('.lbllabel1').text("");

            $.ajax({
                url: 'post.aspx/PostHouseGroupInfo',
                type: 'POST',
                data: JSON.stringify({
                    Adding: Adding,
                    ProjectGroupPkID:ProjectGroupPkID,
                    HouseGroupPkID: HouseGroupPkID,
                    HouseGroupName: txtHouseGroupName,
                    WarrantyYear: txtWarrantyYear,
                    cYear: txtcYear,
                    FloorCnt:txtFloorCnt,
                    OrtsCnt: txtOrtsCnt,
                    SortOrder: txtSortOrder,
                    ImgPlanSrc: ext,
                    StatusID:StatusID,
                }),
                dataType: 'json',
                contentType: 'application/json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (msg) {
                    if (msg.d.indexOf("Алдаа") == -1)
                    {

                        var files = document.getElementById('EditFile').files;
                        
                        var formData = new FormData();
                        for (var i = 0; i < files.length; i++) {
                            formData.append(files[i].name, files[i]);
                        }

                        $.ajax({
                            url: 'uploadfile.ashx?ImageType=Plan&HouseGroupPkID='+msg.d,
                            method: 'POST',
                            data: formData,
                            contentType: false,
                            processData: false,
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                            },
                            success: function () {
                                //alert(msg.d);
                            }
                        });

                        alert("Амжилттай хадгаллаа"); 
                        $('#myModal').modal('hide');
                        
                        if (Adding == 1)
                            $('[data-id=' + HouseGroupPkID + ']').parents("tr").remove();
                        $("#myTable").find('tbody').append("<tr><td>" + ProjectGroupName + "</td><td>" + $("#txtHouseGroupName").val() + "</td><td>" + $("#txtWarrantyYear").val() + "</td><td>" + $("#txtcYear").val() + "</td><td>" + $("#txtFloorCnt").val() + "</td><td>" + $("#txtOrtsCnt").val() + "</td><td></td><td>" + $("#txtSortOrder").val() + "</td><td>" + StatusName + "</td><td><button type='button' data-toggle='modal' data-target='#myModal' data-id='" + msg.d + "' class='btn btn-xs btn-info editButton'>Засах</button></td></tr>");
                        $("#txtHouseGroupName").val('');
                        $("#txtFloorCnt").val(0);
                        $("#txtOrtsCnt").val(0);
                        $("#txtWarrantyYear").val(0);
                        $("#txtcYear").val(0);
                        $("#txtSortOrder").val(0);
                        $("#HouseGroupPkID").val('');
                        window.localtion.reload();
                    }
                    else
                        $(".lbllabel1").text(msg.d);
                }
            });

            
    }

    $('#confirmDelete').on('show.bs.modal', function (e) {
        $message = $(e.relatedTarget).attr('data-message');
        $("#txtDeleteID").val($(e.relatedTarget).attr('data-id'));
        $(this).find('.modal-body p').text($message);

        $title = $(e.relatedTarget).attr('data-title');
        $(this).find('.modal-title').text($title);

        // Pass form reference to modal for submission on yes/ok
        var form = $(e.relatedTarget).closest('form');
        $(this).find('.modal-footer #confirm').data('form', form);
    });

    $('#confirmDelete').find('.modal-footer #confirm').on('click', function () {
        var txtID = $("#txtDeleteID").val();
        $('.lbllabel1').text("");

        $.ajax({
            url: 'post.aspx/DeleteHouseGroupInfo',
            type: 'POST',
            data: JSON.stringify({
                HouseGroupPkID: txtID,
            }),
            dataType: 'json',
            contentType: 'application/json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (msg) {
                    $('#confirmDelete').modal('hide');
                    $('[data-id=' + txtID + ']').parents("tr").remove();
                
            }
        });
        
    });
</script>
</asp:Content>
