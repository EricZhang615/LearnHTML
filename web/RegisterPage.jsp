<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/18
  Time: 7:39 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="basicStyle.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Kosugi+Maru&family=Montserrat:ital,wght@0,600;1,600&family=Noto+Serif+JP:wght@300&family=Raleway&family=Sawarabi+Mincho&display=swap" rel="stylesheet">
</head>
<body id="main" style="opacity: 0">
<div style="height: 0;box-shadow: 0 60px 120px 50px #281A14;" id="top"></div>
<ul class="topnav">
    <li><a href="index.jsp">Home</a></li>
</ul>

<div id="indexBkgImg">
    <div id="bkgImg1" style="opacity: 1;z-index: -1"></div>
    <div id="bkgImg2" style="opacity: 1;z-index: -2"></div>
    <div class="registerWindow">
        <form id="loginForm" action="Register.jsp" method="post">
            <div>Username:</div>
            <input id="user" type="text" name="username" placeholder="Username...">
            <div>Password:</div>
            <input id="pass" type="password" name="password" placeholder="Password...">
            <div>Confirm:</div>
            <input id="confirm" type="password" placeholder="Confirm...">
        </form>
        <button id="regButton" onclick="verifyLogin()">Register</button>
        <script>
            function verifyLogin(){
                var receivedUser=document.getElementById("user").value;
                var receivedPass=document.getElementById("pass").value;
                var receivedPassConf=document.getElementById("confirm").value;

                if ( receivedUser.trim().length > 0 && receivedPass.trim().length > 0 ){
                    if ( receivedPass === receivedPassConf){
                        document.getElementById("loginForm").submit();}
                    else {
                        window.alert("两次输入密码不同，请检查");
                    }
                }
                else {
                    window.alert("用户名和密码不能为空");
                }
            }
        </script>
    </div>
</div>

<div id="pageBand"></div>

</body>
</html>
<script>
    setTimeout(function (){document.getElementById("main").setAttribute('class','opacity2')},500)
</script>
<script src="SwitchBkgImg.js"></script>

<% if (request.getSession().getAttribute("errState") == "existUsername"){ %>
<script>
    window.alert("用户名已存在 请重试")
</script>
<%request.getSession().setAttribute("errState",null);}%>
