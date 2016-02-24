<%-- 
    Document   : checkinonline
    Created on : Dec 12, 2015, 2:04:02 AM
    Author     : Xuan Li
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
                                <li class="active"><a href="checkinonline.jsp">Check In</a></li>
                                <li><a href="checkout.jsp">Check Out</a></li>
                                <li><a href="orderdinner.jsp"> Reserve Dinner</a></li>
                                <li><a href="reserveRoom.jsp">Book Room</a></li>
                                <li><a href="changeRoom.jsp">Change Room</a></li>
                                <li><a href="roomstatement.jsp">Statement(Manager)</a></li>
                            </ul>
                        </nav>
                        <article id="content">

                            <div class="pad" style="alignment-adjust: center;font-size: 20px">
                                <div id="info">
                                    <div id="searchinfo">
                                        <span>Please check the availability of room :</span>
                                        <br>
                                        <br>
                                        <span>The Name :</span>
                                        <input id="name" type="text" />
                                        <br>
                                        <br>
                                        <span>The phone number :</span>
                                        <input id="phonenumber" type="text" />
                                        <br>
                                        <br>
                                        <span>The member id :</span>
                                        <input id="memberid" type="text" />
                                        <br>
                                        <br>
                                        <button id="search">Search</button>
                                        <br>
                                    </div>
                                    <div id="searchresult"></div>
                                    <div id="personalinfo">
                                        <span>Identification Type :</span>
                                        <input id="indentificationtype" type="text" />
                                        <span>Identification code:</span>
                                        <input id="indentificationcode" type="text" />
                                        <button id="checkin">Check in</button>
                                        <button id="cancel">Cancel</button>
                                    </div>
                                </div>
                            </div>
                        </article>
            </body>
            <script type="text/javascript">
                $(document).ready(function() {
                    $("#personalinfo").hide();
                    $("#search").click(function() {
                        var name = $("#name").val();
                        var phonenumber = $("#phonenumber").val();
                        var memberid = $("#memberid").val();
                        if (name == "" && phonenumber == "" && memberid == "")
                            alert("Please finish at least one information!");
                        else if (phonenumber != "" && (isNaN(parseInt(phonenumber)) || parseInt(phonenumber) < 0))
                            alert("Please enter right phone number!");
                        else if (name.length > 30 || memberid.length > 30 || phonenumber.length > 30)
                            alert("Please enter right length of information.");
                        else {
                            $.post(
                                "/HotelSystem/searchpre", {
                                    "name": name,
                                    "phonenumber": phonenumber,
                                    "memberid": memberid
                                },
                                function(data) {
                                    if (data == "")
                                        $("#searchresult").html("<p> no result !</p>");
                                    else {
                                        $("#searchinfo").hide();
                                        $("#searchresult").html(data);
                                        $("#personalinfo").show();
                                    }
                                },
                                "text");
                        }
                    });
                    $("#checkin").click(function() {
                        var indentificationtype = $("#indentificationtype").val();
                        var indentificationcode = $("#indentificationcode").val();
                        var index = -1;
                        $(".check").each(function(i, input) {
                            if (input.checked == true) {
                                index = i;
                                return false;
                            }
                        });
                        if (indentificationtype == "" || indentificationcode == "")
                            alert("please enter check in name.");
                        else if (index == -1)
                            alert("please select one.");
                        else if (indentificationtype.length > 20 || indentificationcode.lenth > 20)
                            alert("please enter code and type less than 30 characters");
                        else {
                            $.post(
                                "/HotelSystem/checkinonline", {
                                    "indentificationtype": indentificationtype,
                                    "indentificationcode": indentificationcode,
                                    "index": index
                                },
                                function(data) {
                                    if (data == "success") {
                                        alert("check in success.");
                                        window.location.href = "staffindex.jsp";
                                    } else {
                                        alert("Sorry, something wrong happened.");
                                    }
                                },
                                "text"
                            );

                        }

                    });
                    $("#cancel").click(function() {
                        var r = confirm("Are you sure you want to cancel preorder?");
                        if (r) {
                            var cancel = "yes";
                            $.post(
                                "/HotelSystem/cancelcheckin", {
                                    "cancel": cancel
                                },
                                function(data) {
                                    if (data == "success") {
                                        window.location.href = "checkinonline.jsp";
                                    } else {
                                        alert("Sorry, something worng.");
                                    }
                                },
                                "text"
                            );
                        }
                    });


                });
            </script>

            </html>