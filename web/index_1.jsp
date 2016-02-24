<%-- 
    Document   : index_1
    Created on : Dec 15, 2015, 5:07:35 PM
    Author     : xuanli
--%>


    <!DOCTYPE html>
    <% 
    if(session.getAttribute("username")==null)
        response.sendRedirect("index.jsp");
    else if(!session.getAttribute("type").equals("customer"))
        response.sendRedirect("staffindex.jsp");
%> 
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <html lang="en">

            <head>
                <title>LoungeHotel</title>
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
                    <div class="bg2">
                        <div class="main">
                            <!-- header -->
                            <header>
                                <h1><a href="index_1.jsp" id="logo">STAR TREK HOTEL</a></h1>
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

                            </header>
                            <div class="box">
                                <nav>
                                    <ul id="menu">
                                        <li class="active"><a href="index.jsp">HOME</a></li>
                                        <li><a href="diningPreorder.jsp">DINING</a></li>
                                        <li><a href="roomPreorder.jsp">ROOM</a></li>
                                        <li><a href="contacts.html">CONTACT</a></li>
                                    </ul>
                                </nav>
                                <!-- header end -->
                                <!-- content -->
                                <article id="content">
                                    <div class="box1">
                                        <div class="wrapper">

                                            <div class="kwicks-wrapper marg_bot1">
                                                <ul class="kwicks horizontal">
                                                    <li><img src="images/p1.jpg" alt=""></li>
                                                    <li><img src="images/p2.png" alt=""></li>
                                                    <li><img src="images/pic3.jpg" alt=""></li>
                                                    <li><img src="images/img1.jpg" alt=""></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="pad">
                                            <div class="line1">
                                                <div class="wrapper line2">
                                                    <div class="col1">
                                                        <h2><img src="images/title_marker1.jpg" alt="">AMAZING </h2>
                                                        <p class="pad_bot1">Unique Star Trek Film Experiences</p>
                                                        <a href="contacts.html" class="color1">Contact Us</a> </div>
                                                    <div class="col1 pad_left1">
                                                        <h2><img src="images/title_marker2.jpg" alt="">COMFORT</h2>
                                                        <p class="pad_bot1">5-star hotel comfort as home.</p>
                                                        <a href="contacts.html" class="color1">Contact Us</a> </div>
                                                    <div class="col1 pad_left1">
                                                        <h2><img src="images/title_marker3.jpg" alt="">CLASSIC</h2>
                                                        <p class="pad_bot1">Vow to star trek Classic.</p>
                                                        <a href="contacts.html" class="color1">Contact Us/a> </div>
                </div>
              </div>
            </div>
          </div>
          <div class="pad">
            <div class="wrapper line3">
              <div class="col2">
                <h2>Welcome to Star Trek Hotel!</h2>
                <p class="pad_bot1">LIVE LONG AND PROSPER!!<strong class="color2"></strong><br>
                  Our “Star Trek” Hotel is for satisfying millions of Star Trek fans—trekkies—around the world who jump at every innovation or novel idea in Star Trek TV shows, movies or conventions</p>
                <p class="pad_bot2"> Our hotel includes four separate buildings, three of which will have 100 rooms each, one for humans, one for Vulcans, and one for Klingons. The other building includes a dining hall with separate seating areas for the three races. Clients can freely choose which “World” you want to live in. You will have a fantastic experience!!!!</p>
                <a href="contacts.html" class="button1">Contact Us</a> </div>
                                                    <div class="col1 pad_left1">
                                                        <h2>About Us</h2>
                                                        <div class="wrapper">
                                                            <figure class="left marg_right1"><img src="images/contact.png" alt=""></figure>
                                                            <p class="pad_bot1"><strong class="color2">MoneyNet</strong></p>
                                                            <p class="pad_bot2"> We are world 500 fortune chain hotel provide unique experiences for customer</p>
                                                        </div>
                                                        <a href="contacts.html" class="button1">Contact Us</a> </div>
                                                </div>
                                            </div>
                                </article>
                                <!--content end-->
                                </div>
                                </div>
                            </div>
                        </div>
                        <footer>
                            <div class="main">
                                <!-- footer -->

                                <nav>
                                    <ul id="footer_menu">

                                        <li class="active"><a href="index.jsp">About Us</a></li>
                                        <li><a href="roomPreorder.jsp">Booking</a></li>
                                        <li><a href="diningPreorder.jsp">Dining</a></li>
                                        <li><a href="contacts.html">Contact</a></li>
                                    </ul>
                                </nav>
                            </div>
                            <div class="col1 pad_left1">
                                <ul id="icons">
                                    <li>
                                        <a href="https://www.facebook.com/" class="normaltip"><img src="images/icon1.jpg" alt=""></a>
                                    </li>
                                    <li>
                                        <a href="https://www.facebook.com/" class="normaltip"><img src="images/icon2.jpg" alt=""></a>
                                    </li>
                                    <li>
                                        <a href="https://www.facebook.com/" class="normaltip"><img src="images/icon3.jpg" alt=""></a>
                                    </li>
                                    <li>
                                        <a href="https://www.facebook.com/" class="normaltip"><img src="images/icon4.jpg" alt=""></a>
                                    </li>
                                </ul>
                            </div>
                            <!-- {%FOOTER_LINK} -->
                        </footer>
                        <!-- footer end -->
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