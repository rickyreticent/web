<%-- 
    Document   : paySubscription
    Created on : Dec 11, 2015, 6:13:50 PM
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
                <title> Star Trek Hotel| Payment</title>
                <meta charset="utf-8">
                <link rel="stylesheet" href="css/reset.css" type="text/css" media="all">
                <link rel="stylesheet" href="css/layout.css" type="text/css" media="all">
                <link rel="stylesheet" href="css/style.css" type="text/css" media="all">
                <link rel="stylesheet" href="css/kalendae.css" type="text/css" charset="utf-8">
                <script src="js/kalendae.standalone.min.js" type="text/javascript"></script>
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
                <script type="text/javascript" src="js/jquery-1.6.js"></script>
                <script type="text/javascript" src="js/cufon-yui.js"></script>
                <script type="text/javascript" src="js/cufon-replace.js"></script>
                <script type="text/javascript" src="js/Adamina_400.font.js"></script>
                <script type="text/javascript" src="js/jquery.jqtransform.js"></script>
                <script type="text/javascript" src="js/script.js"></script>
                <script type="text/javascript" src="js/atooltip.jquery.js"></script>
            </head>

            <body id="page3">
                <div class="bg1">
                    <div class="bg2">
                        <div class="main">
                            <!-- header -->
                            <header>
                                <h1><a href="index.jsp" id="logo">STAR TREK HOTEL</a></h1>
                                <div class="department">
                                    <span>
               <a class="scroll" href="login.jsp">LOGIN IN</a>
               <a class="scroll" href="signin.jsp">New Customer?</a>
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
                                        <li class="active"><a href="roomPreorder.jsp">ROOM</a></li>
                                        <li><a href="contacts.html">CONTACT</a></li>
                                    </ul>
                                    </ul>
                                </nav>


                                <div id="waittopay">

                                </div>

                                <div id="payment">
                                    <h2>Choose the order to pay :</h2>
                                    </br>
                                    <span>Card Number:</span></br>
                                    <input id="cardnumber" type="text" />
                                    </br>
                                    <span>Expire date: (MM/YY)</span></br>
                                    <input id="month" type="text" /><span>-</span>
                                    <input id="year" type="text" />
                                    </br>
                                    <span>Name in card:</span></br>
                                    <input id="name" type="text" />
                                    </br>
                                    <span>VCC (3-digit)</span></br>
                                    <input id="vcc" type="password" />
                                    </br>
                                    <button id="pay">Pay</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
            <script type="text/javascript">
                $(document).ready(function() {
                    $.post(
                        "/HotelSystem/checksubscription", {
                            "state": "check"
                        },
                        function(data) {
                            if (data != "")
                                $("#waittopay").html(data);
                            else {
                                $("#payment").hide();
                                $("#waittopay").html("You do not have any subscription fue to pay.");
                            }
                        },
                        "text");


                    $("#pay").click(function() {
                        var cardnumber = $("#cardnumber").val();
                        var month = $("#month").val();
                        var year = $("#year").val();
                        var name = $("#name").val();
                        var vcc = $("#vcc").val();
                        var paying = new Array();
                        $(".check").each(function(i, input) {
                            if (input.checked == true)
                                paying.push(i);
                        });

                        if (cardnumber == "" || month == "" || year == "" || name == "" || vcc == "")
                            alert("Please finish all information!");
                        else if (paying.length == 0)
                            alert("please select at least one subscription.");
                        else if (isNaN(parseInt(cardnumber)) || parseInt(cardnumber) < 0)
                            alert("Please enter right number ");
                        else if (isNaN(parseInt(month)) || parseInt(month) < 0 || parseInt(month) > 12)
                            alert("Please enter right number ");
                        else if (isNaN(parseInt(year)) || parseInt(year) < 15)
                            alert("Please enter right number ");
                        else if (isNaN(parseInt(vcc)) || parseInt(vcc) < 0 || vcc.length != 3)
                            alert("Please enter right number ");
                        else {
                            $.post(
                                "/HotelSystem/paysubscription", {
                                    "paying": paying.join("-")
                                },
                                function(data) {
                                    if (data == "success") {
                                        alert("You have successful paid.");
                                        window.location.href = "index_1.jsp";
                                    } else {
                                        alert("Sorry, something wrong.");
                                    }
                                },
                                "text");
                        }
                    });

                });
            </script>

            </html>