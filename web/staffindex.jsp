<%-- 
    Document   : staffindex
    Created on : Dec 11, 2015, 9:15:01 PM
    Author     : Kehao Xu
--%>
    <% 
    if(session.getAttribute("username")==null)
        response.sendRedirect("index.jsp");
    else if(session.getAttribute("type").equals("customer"))
        response.sendRedirect("index_1.jsp");
%>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <!DOCTYPE html>

            <head>
                <title>Star Trek Hotel| Staff System</title>
                <meta charset="utf-8">
                <link rel="stylesheet" href="css/reset.css" type="text/css" media="all">
                <link rel="stylesheet" href="css/layout.css" type="text/css" media="all">
                <link rel="stylesheet" href="css/style.css" type="text/css" media="all">
                <script type="text/javascript" src="js/jquery-1.6.js"></script>
                <script type="text/javascript" src="js/cufon-yui.js"></script>
                <script type="text/javascript" src="js/cufon-replace.js"></script>
                <script type="text/javascript" src="js/Adamina_400.font.js"></script>
                <script type="text/javascript" src="js/jquery.jqtransform.js"></script>
                <script type="text/javascript" src="js/script.js"></script>
                <script type="text/javascript" src="js/kwicks-1.5.1.pack.js"></script>
                <script type="text/javascript" src="js/atooltip.jquery.js"></script>
                <!--[if lt IE 9]>
<script type="text/javascript" src="js/html5.js"></script>
<link rel="stylesheet" href="css/ie.css" type="text/css" media="all">
<![endif]-->
            </head>

            <body id="page1">
                <div class="bg1">
                    <div class="main">
                        <!-- header -->
                        <header>
                            <h1><a href="staffindex.jsp" id="logo">STAR TREK HOTEL</a></h1>
                            <div class="department">
                                <span>
              <a class="scroll" href="history.jsp">View Order History</a></span>
                                <div id="welcome">
                                    <div id="logout"></div>
                                    <a href="login.jsp?state=logout">logout</a>
                                </div>
                            </div>

                            <script type="text/javascript">
                                $(document).ready(function() {
                                    $.post(
                                        "/HotelSystem/getloginfo", {
                                            "state": "sessioninfo"
                                        },
                                        function(data) {
                                            if (data == "@-@") {
                                                $("#log").show();
                                                $("#welcome").hide();
                                            } else {
                                                var username = data.split("@-@")[0];
                                                var type = data.split("@-@")[1];
                                                $("#log").hide();
                                                $("#welcome").show();
                                                $("#logout").html("<p>" + username + "</p>");
                                            }

                                        },
                                        "text");

                                });
                            </script>
                    </div>
                    </header>
                    <div class="box">
                        <nav>
                            <ul id="menu">
                                <li class="active"><a href="staffindex.jsp">Home</a></li>
                                <li><a href="checkinonline.jsp">Check In</a></li>
                                <li><a href="checkout.jsp">Check Out</a></li>
                                <li><a href="orderdinner.jsp"> Reserve Dinning</a></li>
                                <li><a href="reserveRoom.jsp">Book Room</a></li>
                                <li><a href="changeRoom.jsp">Change Room</a></li>
                                <li><a href="roomstatement.jsp">Statement(Manager)</a></li>
                            </ul>
                        </nav>
                        <!-- header end -->
                        <!-- content -->
                        <article id="content">
                            <div class="box1">
                                <div class="wrapper">

                                    <div class="kwicks-wrapper marg_bot1">
                                        <ul class="kwicks horizontal">
                                            <li><img src="images/staff1.jpg" alt=""></li>
                                            <li><img src="images/staff2.jpg" alt=""></li>
                                            <li><img src="images/staff3.jpg" alt=""></li>
                                            <li><img src="images/staff4.jpg" alt=""></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="pad">
                                    <div class="line1">
                                        <div class="wrapper line2">
                                            <div class="col1">
                                                <h2><img src="images/title_marker1.jpg" alt=""> PROFESSIONAL </h2>
                                                <p class="pad_bot1">We are professional,we provide professional service</p>
                                                <a href="www.google.com" class="color1">Contact Manager</a> </div>
                                            <div class="col1 pad_left1">
                                                <h2><img src="images/title_marker2.jpg" alt="">LOVE</h2>
                                                <p class="pad_bot1">Love Clients, Love your work.</p>
                                                <a href="www.google.com" class="color1">Contact Manager</a> </div>
                                            <div class="col1 pad_left1">
                                                <h2><img src="images/title_marker3.jpg" alt="">SMELL</h2>
                                                <p class="pad_bot1">Don't forget your smell in work.</p>
                                                <a href="www.google.com" class="color1">Contact Manager</a> </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <script type="text/javascript">
                                Cufon.now();
                            </script>
                            <script type="text/javascript">
                                $(document).ready(function() {
                                    $('.kwicks').kwicks({
                                        max: 500,
                                        spacing: 0,
                                        event: 'mouseover'
                                    });
                                })
                            </script>
            </body>

            </html>