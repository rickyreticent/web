<%-- 
    Document   : history
    Created on : Dec 11, 2015, 9:42:02 PM
    Author     : Kehao Xu
--%>
    <% 
    if(session.getAttribute("username")==null)
        response.sendRedirect("index.jsp");
%>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <!DOCTYPE html>
            <html>

            <head>
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
                <title>Star Trek Hotel | View Order History </title>
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
            </head>

            <body>
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
                                    <li><a href="index.jsp">HOME</a></li>
                                    <li><a href="diningPreorder.jsp">DINING</a></li>
                                    <li><a href="roomPreorder.jsp">ROOM</a></li>
                                    <li><a href="contacts.html">CONTACT</a></li>
                                </ul>
                                </ul>
                            </nav>

                            <br>
                            <article id="content">

                                <div class="pad" style="alignment-adjust: center;font-size: 20px">

                                    <div id="history">

                                    </div>
                                </div>
                            </article>
                        </div>
            </body>
            <script type="text/javascript">
                $(document).ready(function() {
                    $.post(
                        "/HotelSystem/history", {
                            "state": "history"
                        },
                        function(data) {
                            if (data != null)
                                $("#history").html(data);
                            else
                                $("#history").html("<h1>You do no have any preorder history</h1>");

                        },
                        "text");

                });
            </script>

            </html>