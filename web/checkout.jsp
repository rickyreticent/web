<%-- 
    Document   : checkout
    Created on : Dec 12, 2015, 5:49:22 AM
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
            <html>

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
                                <li><a href="staffindex.jsp">Home</a></li>
                                <li><a href="checkinonline.jsp">Check In</a></li>
                                <li class="active"><a href="checkout.jsp">Check Out</a></li>
                                <li><a href="orderdinner.jsp"> Reserve Dinner</a></li>
                                <li><a href="reserveRoom.jsp">Book Room</a></li>
                                <li><a href="changeRoom.jsp">Change Room</a></li>
                                <li><a href="roomstatement.jsp">Statement(Manager)</a></li>
                            </ul>
                        </nav>
                        <article id="content">

                            <div class="pad" style="alignment-adjust: center;font-size: 20px">
                                <div id="searchinfo">
                                    <span>The Room number:</span>
                                    <br>
                                    <br>
                                    <input id="roomnumber" type="text" />
                                    <br>
                                    <br>
                                    <button id="search">Search</button>
                                </div>
                                <div id="payment">
                                    <span>You need to pay : </span>
                                    <p id="amount"></p>
                                    <button id="checkout">Check out</button>
                                    <button id="cancel">Cancel</button>
                                </div>
                            </div>
                        </article>
            </body>
            <script type="text/javascript">
                $(document).ready(function() {
                    $("#payment").hide();
                    $("#search").click(function() {
                        var roomnumber = $("#roomnumber").val();
                        if (roomnumber == "")
                            alert("Please finish at least one information!");
                        else if (roomnumber.length != 4 || (roomnumber.substr(0, 1) != "h" && roomnumber.substr(0, 1) != "v" && roomnumber.substr(0, 1) != "k"))
                            alert("Please enter right room number!");
                        else {
                            $.post(
                                "searchcheckinfo", {
                                    "roomnumber": roomnumber
                                },
                                function(data) {
                                    if (isNaN(parseInt(data.substr(0, 1))))
                                        alert(data);
                                    else {
                                        $("#searchinfo").hide();
                                        $("#amount").html(data);
                                        $("#payment").show();
                                    }
                                },
                                "text");
                        }
                    });

                    $("#checkout").click(function() {
                        $.post(
                            "/HotelSystem/checkout", {
                                "state": "checkout"
                            },
                            function(data) {
                                if (data == "success") {
                                    alert(" check-out successfully.");
                                    window.location.href = "staffindex.jsp";
                                } else {
                                    alert("Sorry, something wrong happened.");
                                }
                            },
                            "text"
                        );

                    });

                    $("#cancel").click(function() {
                        var r = confirm("Are you sure you want to cancel check out?");
                        if (r) {
                            window.location.href = "checkout.jsp";
                        }
                    });


                });
            </script>

            </html>