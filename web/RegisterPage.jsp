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
</head>
<body>
<div style="height: 60px;box-shadow: 0 0 120px 50px #281A14;" id="top"></div>
<ul class="topnav">
    <li><a href="index.jsp">Home</a></li>
    <li><a href="#1">Memo</a></li>
    <li><a href="#2">Shop</a></li>
    <li><a href="#3">Contact us</a></li>
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
<script src="SwitchBkgImg.js"></script>
<% if (request.getSession().getAttribute("errState") == "existUsername"){ %>
<script>
    window.alert("用户名已存在 请重试")
</script>
<%request.getSession().setAttribute("errState",null);}%>
