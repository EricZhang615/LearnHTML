<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/20
  Time: 1:17 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%
    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/userlist?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String USER = "root";
    String PASS = "zzy20000615";
    request.setCharacterEncoding("UTF-8");

    if (request.getSession().getAttribute("uid") == "0" ||request.getSession().getAttribute("uid") == null){
        request.getSession().setAttribute("errState","unauthenticated");
        response.sendRedirect("index.jsp");
    }



    Connection conn = null;
    Statement stmt = null;
    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL,USER,PASS);
        stmt = conn.createStatement();
        String sql;
        sql = "SELECT * FROM memo ORDER BY memoId DESC";
        ResultSet rs = stmt.executeQuery(sql);
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
    <li><a href="#1">Memo</a></li>
    <li><a href="#2">Shop</a></li>
    <li><a href="#3">Contact us</a></li>
    <li style="float: right"><a href="Logout.jsp">Log Out</a></li>
</ul>



<div id="indexBkgImg">
    <div style="position: relative;z-index: -1;width: 100%;height: 0;overflow:visible;border: 0;padding: 0;margin: 0;filter: brightness(70%)">
        <div id="bkgImg1" style="opacity: 1;z-index: -1"></div>
        <div id="bkgImg2" style="opacity: 1;z-index: -2"></div>
    </div>
    <div style="position: relative;z-index: 1;width: 100%;height: 100vh;overflow: hidden;border: 0;padding: 0;margin: 0">
        <div style="float: left;width: 15%;height: 100%"></div>
        <div style="float: left;width: 70%;height: 100%">
            <div style="width: 100%;height: 15%"></div>
            <div style="width: 100%;height: 70%;overflow: scroll">
                <%
                    while (rs.next()){
                        String uid = rs.getString("uid");
                        String content = rs.getString("content");
                        %>
                        <div class="memoBlock">
                           <div class="memoUid"><%=uid%></div>
                           <div class="memoContent"><%=content%></div>
                       </div>
                       <%
                   }
                               rs.close();
                               stmt.close();
                               conn.close();
                           }catch(SQLException se){
                               // 处理 JDBC 错误
                               se.printStackTrace();
                           }catch(Exception e){
                               // 处理 Class.forName 错误
                               e.printStackTrace();
                           }finally {
                               // 关闭资源
                               try {
                                   if (stmt != null) stmt.close();
                               } catch (SQLException se2) {
                               }// 什么都不做
                               try {
                                   if (conn != null) conn.close();
                               } catch (SQLException se) {
                                   se.printStackTrace();
                               }
                           }%>
            </div>
            <div style="width: 100%;height: 15%">
                <button class="memoButton" onclick="location.href='MemoEdit.jsp'">Write a New Memo!</button>
            </div>
        </div>
        <div style="float: left;width: 15%;height: 100%"></div>
    </div>
</div>

<div id="pageBand" style="">
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

<%

if (request.getSession().getAttribute("errState") == "memoSubmitSuccess"){ %>
<script>
    window.alert("留言提交成功")
</script>
<%request.getSession().setAttribute("errState",null);}%>