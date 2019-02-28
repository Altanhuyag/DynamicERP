<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pos.aspx.cs" Inherits="Dynamic.pos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

     <script src="assets\js\jquery.min.js"></script>
   	<script src="assets\js\jquery-ui.min.js"></script>
    <script src="assets\js\bootstrap.bundle.min.js"></script>
    <script src="assets\js\perfect-scrollbar.min.js"></script>
	<script src="assets\js\jquery.sparkline.min.js"></script>
    <script src="assets\js\raphael.min.js"></script>
    <script src="assets\js\morris.min.js"></script>
    <script src="assets\js\select2.min.js"></script>
	<script src="assets\js\jquery-jvectormap.min.js"></script>
    <script src="assets\js\jquery-jvectormap-world-mill.min.js"></script>
    <script src="assets\js\horizontal-timeline.min.js"></script>
	<script src="assets\js\jquery.validate.min.js"></script>
    <script src="assets\js\jquery.steps.min.js"></script>
	<script src="assets\js\dropzone.min.js"></script>
	<script src="assets\js\ion.rangeSlider.min.js"></script>
	<script src="assets\js\datatables.min.js"></script>
</head>
<body>
    <div class="wrapper">
        <header class="navbar navbar-fixed">
                       
            <div class="navbar--search">
                <form action="search-results.html">
                    <input type="search" name="search" class="form-control" placeholder="Хайх утгаа оруулна уу..." required="">
                    <button class="btn-link"><i class="fa fa-search"></i></button>
                </form>
            </div>
            <div class="navbar--nav ml-auto">
                <ul class="nav">
                    <li class="nav-item">
                        <a href="#" class="nav-link"> <i class="fa fa-bell"></i> <span class="badge text-white bg-blue">7</span> </a>
                    </li>
                    <li class="nav-item">
                        <a href="mailbox_inbox.html" class="nav-link"> <i class="fa fa-envelope"></i> <span class="badge text-white bg-blue">4</span> </a>
                    </li>
                    <li class="nav-item dropdown nav-language">
                        <a href="#" class="nav-link" data-toggle="dropdown"> <img src="assets\img\flags\us.png" alt=""> <span>Монгол</span> <i class="fa fa-angle-down"></i> </a>
                        <ul class="dropdown-menu">                            
                            <li>
                                <a href=""> <img src="assets\img\flags\fr.png" alt=""> <span>Монгол</span> </a>
                            </li>
                            <li>
                                <a href=""> <img src="assets\img\flags\us.png" alt=""> <span>English</span> </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown nav--user online">
                        <a href="#" class="nav-link" data-toggle="dropdown"> <img src="assets\img\avatars\01_80x80.png" alt="" class="rounded-circle"> <span>res</span> <i class="fa fa-angle-down"></i> </a>
                        <ul class="dropdown-menu">
                            <li><a href="profile.html"><i class="far fa-user"></i>Хувийн мэдээлэл</a></li>
                            <li><a href="mailbox_inbox.html"><i class="far fa-envelope"></i>Ирсэн захиа</a></li>
                            <li><a href="#"><i class="fa fa-cog"></i>Тохиргоо</a></li>
                            <li class="dropdown-divider"></li>
                            <li><a href="lock-screen.html"><i class="fa fa-lock"></i>Дэлгэц түгжих</a></li>
                            <li><a href="logout.aspx"><i class="fa fa-power-off"></i>Гарах</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </header>
        </div>
    <script src="assets\js\main.js"></script>
</body>
</html>
