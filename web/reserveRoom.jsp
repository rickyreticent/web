<%-- 
    Document   : roomPreorder
    Created on : Dec 11, 2015, 2:49:10 PM
    Author     : Kehao Xu
--%>
    <% 
    if(session.getAttribute("username")==null)
        response.sendRedirect("index.jsp");
    else if(session.getAttribute("type").equals("customer"))
        response.sendRedirect("roomPreorder.jsp");
%>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <!DOCTYPE html>
            <html>

            <head>
                <title> Star Teck Hotel| Booking</title>
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

            <body id="page1">
                <div class="bg2">
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


                           
                        </header>

                    </div>
                </div>

                <div class="box">
                    <nav>
                        <ul id="menu">
                            <li><a href="staffindex.jsp">Home</a></li>
                            <li><a href="checkinonline.jsp">Check In</a></li>
                            <li><a href="checkout.jsp">Check Out</a></li>
                            <li><a href="orderdinner.jsp"> Reserve Dinner</a></li>
                            <li class="active"><a href="reserveRoom.jsp">Book Room</a></li>
                            <li><a href="changeRoom.jsp">Change Room</a></li>
                            <li><a href="roomstatement.jsp">Statement(Manager)</a></li>
                        </ul>
                        </ul>
                    </nav>



                    <div class="box1">
                        <div class="wrapper">
                            <div id="info">
                                <div  id="form1">

                                    <div id="checkinfo">

                                        <h2>Book a Room</h2>
                                        <fieldset>
                                            <div class="row">
                                                <span>Number of People </span>
                                                <input id="number" type="text" />
                                            </div>
                                            <div class="row">
                                                <span>Start Date</span>
                                                <input id="startdate" type="text" class="auto-kal" readonly="readonly" />
                                            </div>
                                            <div class="row">
                                                <span>End Date</span>
                                                <input id="enddate" type="text" class="auto-kal" readonly="readonly" />
                                            </div>
                                            <div class="row">
                                                <div class="select1">
                                                    <span>The type of room :</span>
                                                    <select id="type">
                                                        <option value="human">Human</option>
                                                        <option value="vulcan">Vulcan</option>
                                                        <option value="klingons">Klingons</option>
                                                    </select>
                                                </div>

                                                <div class="wrapper">
                                                    <button id="check">Check now</button>
                                                </div>
                                        </fieldset>
                                </div>
                                </div>



                                <div id="personalinfo">
                                    <h1 id="roominfo"></h1>
                                    </br>
                                    <div  id="form1">

                                        <h1>Please enter check in information :</h1>
                                        </br>

                                        <fieldset>
                                            <div class="row">
                                                <span>Name :</span>
                                                <input id="name" type="text" />
                                            </div>
                                            <div class="row">
                                                <span>Phone number (could be blank):</span>
                                                <input id="phonenumber" type="text" />
                                            </div>
                                            </br>
                                            </br>

                                            <div class="wrapper">
                                                <button id="preorder">Preorder</button>
                                            </div>

                                            </br>

                                            <div class="wrapper">
                                                <button id="cancel">Cancel</button>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>



            </body>
            <script type="text/javascript">
                $(document).ready(function() {
                    $("#personalinfo").hide();
                    $("#check").click(function() {
                        var sd = new Date();
                        var ed = new Date();
                        var today = new Date();
                        var number = $("#number").val();
                        number = parseInt(number);
                        var startdate = $("#startdate").val();
                        var enddate = $("#enddate").val();
                        var type = $("#type").val();
                        sd.setFullYear(parseInt(startdate.split("/")[2]), parseInt(startdate.split("/")[0]) - 1, parseInt(startdate.split("/")[1]));
                        ed.setFullYear(parseInt(enddate.split("/")[2]), parseInt(enddate.split("/")[0]) - 1, parseInt(enddate.split("/")[1]));

                        if (number == "" || startdate == "" || enddate == "" || type == "")
                            alert("Please finish all information!");
                        else if (sd < today)
                            alert("please enter a right start date")
                        else if (sd >= ed)
                            alert("please enter the right date");
                        else if (isNaN(parseInt(number)) || parseInt(number) > 7 || parseInt(number) < 0)
                            alert("Please enter right number of people!");
                        else {
                            $.post(
                                "/HotelSystem/roomcheck", {
                                    "number": number,
                                    "startdate": startdate,
                                    "enddate": enddate,
                                    "type": type
                                },
                                function(data) {
                                    if (parseInt(data) == -1)
                                        alert("There is no room available at those time.");
                                    else {
                                        $("#personalinfo").show();
                                        $("#checkinfo").hide();
                                        $("#roominfo").html("The room is available for $" + data);
                                        if (session.getAttribute("username") == null) {
                                            alert("You have to log in to reserve the room!!!");
                                            response.sendRedirect("login.jsp");

                                        };
                                    }
                                },
                                "text");
                        }
                    });
                    $("#preorder").click(function() {
                        var name = $("#name").val();
                        var phonenumber = $("#phonenumber").val();
                        if (name == "")
                            alert("please enter check in name.");
                        else if (phonenumber != "" && (isNaN(phonenumber) || phonenumber.length > 20))
                            alert("please enter the phone number right.");
                        else if (name.length > 30)
                            alert("please enter name less than 30 characters");
                        else {
                            $.post(
                                "/HotelSystem/makepreorder", {
                                    "name": name,
                                    "phonenumber": phonenumber
                                },
                                function(data) {
                                    if (data == "success") {
                                        alert("preorder success.");
                                        window.location.href = "paySubscription.jsp";
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
                                "/HotelSystem/cancelpreorder", {
                                    "cancel": cancel
                                },
                                function(data) {
                                    if (data == "success") {
                                        $("#personalinfo").hide();
                                        $("#checkinfo").show();
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