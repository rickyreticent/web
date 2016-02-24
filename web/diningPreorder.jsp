<%-- 
    Document   : roomPreorder
    Created on : Dec 11, 2015, 2:49:10 PM
    Author     : Kehao Xu
--%>

        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <!DOCTYPE html>
            <html>

            <head>
                <title> Star Trek Hotel| Customer Dining</title>
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
                                <h1><a href="index.jsp" id="logo">STAR TECK HOTEL</a></h1>
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
                                        <li class="active"><a href="diningPreorder.jsp">DINING</a></li>
                                        <li><a href="roomPreorder.jsp">ROOM</a></li>
                                        <li><a href="contacts.html">CONTACT</a></li>
                                    </ul>
                                    </ul>
                                </nav>



                                <div class="box1">
                                    <div class="wrapper">
                                        <div id="info">
                                            <div  id="form1">

                                                <div id="checkinfo">

                                                    <h2>Book a Dining Table</h2>
                                                    <fieldset>
                                                        <div class="row">
                                                            <span>Number of People </span>
                                                            <input id="number" type="text" />
                                                        </div>
                                                        <div class="row">


                                                            <span>Start Date :</span>
                                                            <input id="startdate" type="text" class="auto-kal" readonly="readonly" />
                                                        </div>
                                                        <div class="row">
                                                            <span>  Hour: </span>
                                                            <input placeholder="8-21" id="hour" type="text" />
                                                        </div>
                                                        <div class="row">
                                                            <span> Minute: </span>
                                                            <input placeholder="0-59" id="minute" type="text" />
                                                        </div>
                                                        <div class="row">
                                                            <div class="select1">
                                                                <span>Dining Room:</span>
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
                                </div>



                                <script type="text/javascript">
                                    $(document).ready(function() {
                                        $("#personalinfo").hide();
                                        $("#check").click(function() {
                                            var sd = new Date();
                                            var today = new Date();
                                            var number = $("#number").val();
                                            var startdate = $("#startdate").val();
                                            var hour = $("#hour").val();
                                            var minute = $("#minute").val();
                                            var type = $("#type").val();
                                            hour = parseInt(hour);
                                            minute = parseInt(minute);
                                            number = parseInt(number);
                                            if (isNaN(parseInt(hour)) || parseInt(hour) < 8 || parseInt(hour) >= 22 || isNaN(parseInt(minute)) || parseInt(minute) < 0 || parseInt(minute) >= 60)
                                                alert("we open from 8 to 21,please enter right time.");
                                            else {
                                                sd.setFullYear(parseInt(startdate.split("/")[2]), parseInt(startdate.split("/")[0]) - 1, parseInt(startdate.split("/")[1]));
                                                sd.setHours(hour);
                                                sd.setMinutes(minute);
                                                if (number == "" || startdate == "" || hour == "" || type == "" || minute == "")
                                                    alert("Please finish all information!");
                                                else if (sd < today)
                                                    alert("please enter a right start date")
                                                else if (isNaN(parseInt(number)) || parseInt(number) > 20 || parseInt(number) < 0)
                                                    alert("Please enter right number of people!");
                                                else {
                                                    $.post(
                                                        "/HotelSystem/diningcheck", {
                                                            "number": number,
                                                            "startdate": startdate,
                                                            "hour": hour,
                                                            "minute": minute,
                                                            "type": type
                                                        },
                                                        function(data) {
                                                            if (parseInt(data) == -1)
                                                                alert("There is no dining available at those time.");
                                                            else {
                                                                $("#personalinfo").show();
                                                                $("#checkinfo").hide();
                                                                $("#roominfo").html("The dining is available");
                                                            }
                                                        },
                                                        "text");
                                                }
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
                                                    "/HotelSystem/diningpreorder", {
                                                        "name": name,
                                                        "phonenumber": phonenumber
                                                    },
                                                    function(data) {
                                                        if (data == "success") {
                                                            alert("preorder success.");
                                                            window.location.href = "index.jsp";
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
                                                    "/HotelSystem/canceldining", {
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
                            </div>
                        </div>
                    </div>


            </body>

            </html>