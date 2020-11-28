<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/22
  Time: 11:59 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%
    if (request.getSession().getAttribute("uid") == "0" ||request.getSession().getAttribute("uid") == null){
        request.getSession().setAttribute("errState","unauthenticated");
        response.sendRedirect("index.jsp");
    }
    request.setCharacterEncoding("UTF-8");

%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Memo</title>
    <link rel="stylesheet" type="text/css" href="basicStyle.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Kosugi+Maru&family=Montserrat:ital,wght@0,600;1,600&family=Noto+Serif+JP:wght@300&family=Raleway&family=Sawarabi+Mincho&display=swap" rel="stylesheet">
</head>
<body id="main" style="opacity: 0">
<div style="height: 0;box-shadow: 0 60px 120px 50px #281A14;" id="top"></div>
<ul class="topnav">
    <li><a href="index.jsp">Home</a></li>
    <li><a href="Memo.jsp">Memo</a></li>
    <li><a href="#2">Shop</a></li>
    <li><a href="#3">Contact us</a></li>
    <li><span>京都动画非官方FanClub</span></li>
    <li style="float: right"><a href="Logout.jsp">Log Out</a></li>
</ul>



<div id="indexBkgImg">
    <div style="position: relative;z-index: -1;width: 100%;height: 0;overflow:visible;border: 0;padding: 0;margin: 0;filter: brightness(70%)">
        <div id="bkgImg1" style="opacity: 1;z-index: -1"></div>
        <div id="bkgImg2" style="opacity: 1;z-index: -2"></div>
    </div>
    <div style="position: relative;z-index: 1;width: 100%;height: 700px;overflow: hidden;border: 0;padding: 0;margin: 0">
        <div style="float: left;width: 15%;height: 100%"></div>
        <div style="float: left;width: 70%;height: 85%;">
            <form id="memoForm" action="MemoSubmit.jsp" method="post">
                <textarea id="memo" name="memo" placeholder="Speak your mind freely..."></textarea>
            </form>
            <button id="memoSubmitButton" class="memoButton" onclick="checkMemo()">Submit</button>
            <script>
                function checkMemo(){
                    var receivedMemo=document.getElementById("memo").value;

                    if ( receivedMemo.trim().length > 0 ){
                        document.getElementById("memoForm").submit();
                    }
                    else {
                        window.alert("留言内容不能为空");
                    }
                }
            </script>
        </div>
        <div style="float: left;width: 15%;height: 100%"></div>
    </div>
</div>

<div id="pageBand">
    <div class="music" style="top: -100px">
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

</body>
</html>
<script>
    setTimeout(function (){document.getElementById("main").setAttribute('class','opacity2')},500)
</script>
<script src="SwitchBkgImg.js"></script>
<script src="music.js"></script>
