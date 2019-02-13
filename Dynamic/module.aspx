<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="module.aspx.cs" Inherits="Dynamic.module" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title><% Response.Write(Dynamic.Models.SystemGlobals.HeaderTitleText); %></title>
    <meta name="author" content="">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link rel="icon" href="favicon.png" type="image/png">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700%7CMontserrat:400,500">
    <link rel="stylesheet" href="assets\css\bootstrap.min.css">
	<link rel="stylesheet" href="assets\css\fontawesome-all.min.css">
    <link rel="stylesheet" href="assets\css\jquery-ui.min.css">
	<link rel="stylesheet" href="assets\css\perfect-scrollbar.min.css">
	<link rel="stylesheet" href="assets\css\morris.min.css">
	<link rel="stylesheet" href="assets\css\select2.min.css">
	<link rel="stylesheet" href="assets\css\jquery-jvectormap.min.css">
	<link rel="stylesheet" href="assets\css\horizontal-timeline.min.css">
    <link rel="stylesheet" href="assets\css\weather-icons.min.css">
    <link rel="stylesheet" href="assets\css\dropzone.min.css">
    <link rel="stylesheet" href="assets\css\ion.rangeSlider.min.css">
    <link rel="stylesheet" href="assets\css\ion.rangeSlider.skinFlat.min.css">
    <link rel="stylesheet" href="assets\css\datatables.min.css">
    <link rel="stylesheet" href="assets\css\fullcalendar.min.css">
    <link rel="stylesheet" href="assets\css\style.css">
    <style>
        a:hover {
          color:white;
        }
    </style>
</head>
<body>
    <section class="main--content">
    <div class="row gutter-20">
        
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-heading">
                    <h3 class="panel-title">Ашиглагдаж буй програм хангамж</h3> </div>
                <div class="panel-content">                    
                    <div class="row mb-2">        
                        <%
                            foreach (System.Data.DataRow rw in UserProgList(Session["UserPkID"].ToString()).Rows)
                            {
                            %>
                        <div class="col-md-3" style="padding-top:15px;">
                            <a class="btn btn-rounded btn-outline-warning" href="module.aspx?pId=<%=rw["ModuleID"].ToString() %>" style="width:100%; height:120px;">
                                <h4 class="text-uppercase mb-0" style="font-size:30px;margin-top:20px;"><%=rw["ModuleID"].ToString() %></h4>
                                <span style="font-size:14px;"><%=rw["ProgName"].ToString() %></span>
                            </a>
                        </div>
                        <%
                            }
                            %>
                        
                    </div>                    
                </div>
            </div>
        </div>
        
    </div>
</section>
</body>
</html>
