<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/14
  Time: 5:16 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%--<%@include file="homepage.html"%>--%>
<html>
<head>
    <meta charset="UTF-8">
    <title>KyotoAnimation Unofficial Fanclub</title>
    <link rel="stylesheet" type="text/css" href="basicStyle.css">
</head>

<body>
<div style="height: 60px;box-shadow: 0 0 120px 50px #281A14;" id="top"></div>
<ul class="topnav">
    <li><a href="index.jsp">Home</a></li>
    <li><a href="#1">Memo</a></li>
    <li><a href="#2">Shop</a></li>
    <li><a href="#3">Contact us</a></li>
    <li style="float: right"><a href="#4">Sign in</a></li>
</ul>

<div class="backToTop">
    <a class="info" href="#top">Top</a>
</div>

<div id="indexBkgImg">
    <!--        <img src="../src/Image/Img1.jpg" style="width: 100%;height: auto;" alt="bkg">-->
    <div id="bkgImg1" style="opacity: 1;z-index: -1"></div>
    <div id="bkgImg2" style="opacity: 1;z-index: -2"></div>
    <!--        <div id="bkgImg3" style="opacity: 0;z-index: -3"></div>-->
    <!--        <div id="bkgImg4" style="opacity: 0;z-index: -4"></div>-->
    <!--        <div id="bkgImg5" style="opacity: 0;z-index: -5"></div>-->
    <!--        <div id="bkgImg6" style="opacity: 0;z-index: -6"></div>-->

    <div class="loginWindow">
        <form id="loginForm" action="LoginVerifyPage.jsp" method="post">
            <div>Username:</div>
            <input id="user" type="text" name="username" placeholder="Username...">
            <div>Password:</div>
            <input id="pass" type="password" name="password" placeholder="Password...">
        </form>
        <button onclick="verifyLogin()">Login</button>
        <script>
            function verifyLogin(){
                var receivedUser=document.getElementById("user").value;
                var receivedPass=document.getElementById("pass").value;
                if ( receivedUser.trim().length > 0 && receivedPass.trim().length > 0){
                    document.getElementById("loginForm").submit();
                }
                else {
                    window.alert("用户名和密码不能为空");
                }
            }
        </script>
        <div>还没有账号？<a href="#">注册一个</a></div>
    </div>
</div>

<div id="pageBand">
    <div class="music">
        <audio src="" id="audiosrc"></audio>
        <div class="musicControl">
            <div class="musicControl prev" onclick="prevMusic()"></div>
            <div id="musicPlay" class="musicControl play" onclick="playMusic()"></div>
            <div class="musicControl next" onclick="nextMusic()"></div>
        </div>
        <div class="musicTitle">
            <span id="TrackTitle"></span>
        </div>
    </div>
</div>

<div id="indexSponsorTable">
    <table border="0">
        <tr>
            <td><span id="sponsorTitle">Sponsor</span></td>
            <td><span id="amountsTitle">Amounts</span></td>
        </tr>
        <tr>
            <td><a href="#" class="sponsorName">Eric</a></td>
            <td>10$</td>
        </tr>
        <tr>
            <td><a href="#" class="sponsorName">AnotherEric</a></td>
            <td>20$</td>
        </tr>
    </table>
</div>

<div id="indexNewsTab">
    <iframe id="newsFrame" src="news.html"></iframe>
</div>

<div class="footer">
    <div class="footer_left">
        <span class="info">Designed By Eric.</span>
    </div>
    <div class="footer_right">
    </div>
</div>
</body>
</html>
<script src="music.js"></script>
<script src="SwitchBkgImg.js"></script>
