<%-- 
    Document   : roomstatement
    Created on : Dec 12, 2015, 6:26:52 AM
    Author     : Kehao Xu
--%>
    <% 
    if(session.getAttribute("username")==null)
        response.sendRedirect("index.jsp");
    else if(!session.getAttribute("type").equals("manager") || !session.getAttribute("type").equals("general")){
        if (session.getAttribute("type").equals("customer")) {
             response.sendRedirect("index_1.jsp");
        }else if(session.getAttribute("type").equals("staff")){
          response.sendRedirect("staffindex.jsp");
        }
    }
      
%>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Star Trek Hotel| Manager Statement </title>
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
                <link rel="stylesheet" href="css/kalendae.css" type="text/css" charset="utf-8">
                <script src="js/kalendae.standalone.min.js" type="text/javascript"></script>
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            </head>

            <body id="page1">
                <div class="bg1">
                    <div class="main">
                        <!-- header -->
                        <header>
                            <h1><a href="index.jsp" id="logo">STAR TREK HOTEL</a></h1>
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
                                <li><a href="staffindex.jsp">Home</a></li>
                                <li><a href="checkinonline.jsp">Check In</a></li>
                                <li><a href="checkout.jsp">Check Out</a></li>
                                <li><a href="orderdinner.jsp"> Reserve Dinner</a></li>
                                <li><a href="reserveRoom.jsp">Book Room</a></li>
                                <li><a href="changeRoom.jsp">Change Room</a></li>
                                <li class="active"><a href="roomstatement.jsp">Statement(Manager)</a></li>
                            </ul>
                        </nav>
                        <article id="content">

                            <div class="pad" style="alignment-adjust: center;font-size: 20px">
                                <div id="statement">

                                </div>
                            </div>
                        </article>
            </body>
            <script type="text/javascript">
                $(document).ready(function() {
                    $.post(
                        "/HotelSystem/checkstatement", {
                            "state": "history"
                        },
                        function(data) {
                            if (data != null)
                                $("#statement").html(data);
                            else
                                $("#statement").html("<h1>There is no statement to view</h1>");
                        },
                        "text");

                });
            </script>

            </html>