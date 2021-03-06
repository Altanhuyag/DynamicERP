﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Dynamic.login" %>

<!DOCTYPE html>
<html dir="ltr" lang="en" class="no-outlines">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title><% Response.Write(Dynamic.Models.SystemGlobals.HeaderTitleText); %> </title>
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
    <link rel="stylesheet" href="assets\css\style.css"> </head>

<body>
    <div class="wrapper">
        <div class="m-account-w">
            <div class="m-account">
                <div class="row no-gutters">
                    <div class="col-md-6">
                        <div class="m-account--content-w" data-bg-img="assets/img/account/content-bg.jpg">
                            <div class="m-account--content">
                                <h2 class="h2">Танд эрх байхгүй бол энд ханд?</h2>
                                <p>Бүртгүүлэх замаар шинэ эрх авах хүсэлтээ илгээх боломжтой.</p><a href="register.html" class="btn btn-rounded">Бүртгүүлэх</a> </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="m-account--form-w">
                            <div class="m-account--form">
                                <div class="logo"> <img src="assets\img\logo.png" alt=""> </div>
                                <form action="#" method="post" runat="server">
                                    <label class="m-account--title">Та өөрийн эрхээ нэвтэрч орно уу</label>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend"> <i class="fas fa-user"></i> </div>                                            
                                            <asp:TextBox ID="username" name="username" runat="server" placeholder="Нэвтрэх нэр" class="form-control" autocomplete="off" required></asp:TextBox>  
                                            </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend"> <i class="fas fa-key"></i> </div>                                            
                                             <asp:TextBox ID="password" name="password" type="password" placeholder="Нууц үг" class="form-control" autocomplete="off" required runat="server"></asp:TextBox>
                                            </div>
                                    </div>
                                    <div class="m-account--actions"> <a href="#" class="btn-link">Нууц үгээ мартсан бол?</a>                                        
                                        <asp:Button ID="btnLogin" class="btn btn-rounded btn-warning" runat="server" Text="Нэвтрэх" OnClick="btnLogin_Click" />
                                        
                                    </div>                                                                            
                                    <div class="m-account--footer">
                                        <p>&copy; 2018 GegaNET</p>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
    <script src="assets\js\main.js"></script>
</body>

</html>