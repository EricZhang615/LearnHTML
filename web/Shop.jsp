<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/28
  Time: 6:23 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%
    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/shop?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String USER = "root";
    String PASS = "zzy20000615";
    request.setCharacterEncoding("UTF-8");

    if (request.getSession().getAttribute("uid") == "0" ||request.getSession().getAttribute("uid") == null){
        request.getSession().setAttribute("errState","unauthenticated");
        response.sendRedirect("index.jsp");
    }

    String uid = (String) request.getSession().getAttribute("uid");
    float totalPrice = 0.00f;

    Connection conn = null;
    Statement stmt = null;
    Statement stmt2 = null;
    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL,USER,PASS);
        stmt = conn.createStatement();
        stmt2 = conn.createStatement();
        String sql;
        sql = "SELECT * FROM goodList";
        ResultSet rs = stmt.executeQuery(sql);
%>


<html>
<head>
    <meta charset="UTF-8">
    <title>Shop</title>
    <link rel="stylesheet" type="text/css" href="basicStyle.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Kosugi+Maru&family=Montserrat:ital,wght@0,600;1,600&family=Noto+Serif+JP:wght@300&family=Raleway&family=Sawarabi+Mincho&display=swap" rel="stylesheet">
</head>
<body>
<div>
    <%
        while (rs.next()){
            String goodId = rs.getString("goodId");
            String goodName = rs.getString("goodName");
            String goodStock = rs.getString("goodStock");
            String goodPrice = rs.getString("goodPrice");
    %>
    <div class="">
        <div class=""><img src="Image/goodImage/<%=goodId%>.jpeg"></div>
        <div class=""><%=goodName%></div>
        <div class="">¥<%=goodPrice%></div>
        <div class=""><%=goodStock%></div>
        <form action="ShopAddCart.jsp" method="post">
            <input type="hidden" name="goodId" value="<%=goodId%>">
            <input type="number" name="goodAmount" value="1" min="1" max="<%=goodStock%>">
            <input type="submit" value="ADD TO CART">
        </form>
    </div>
    <%
            }
            rs.close();%>
</div>
<div>cart</div>
<div>
    <%
        sql = "SELECT * FROM information_schema.TABLES WHERE TABLE_NAME = '"+uid+"'";
        ResultSet check = stmt.executeQuery(sql);
        if (check.next()){
        check.close();
        sql = "SELECT * FROM `"+uid+"`";
        ResultSet cartSet = stmt.executeQuery(sql);
        while (cartSet.next()){
            String goodId = cartSet.getString("cartGoodId");
            String goodAmount = cartSet.getString("cartGoodAmount");
            String sql2 = "SELECT goodName,goodPrice FROM goodList WHERE goodId='"+goodId+"'";
            ResultSet goodInfo = stmt2.executeQuery(sql2);
            goodInfo.next();
            String goodName = goodInfo.getString("goodName");
            String goodPrice = goodInfo.getString("goodPrice");
            totalPrice += (Float.parseFloat(goodPrice)*Integer.parseInt(goodAmount));
            %>
    <div>
        <div class=""><img src="Image/goodImage/<%=goodId%>.jpeg"></div>
        <div class=""><%=goodName%></div>
        <div class="">¥<%=goodPrice%></div>
        <div class=""><%=goodAmount%></div>
        <form action="ShopDecCart.jsp" method="post">
            <input type="hidden" name="goodId" value="<%=goodId%>">
            <input type="submit" value="Delete">
        </form>
    </div>
            <%goodInfo.close();}
            cartSet.close();}%>
</div>
<div>
    <%
        DecimalFormat df = new DecimalFormat("########.##");
        String tp = df.format(totalPrice);
    %>
    小计：¥<%=tp%>
    <form action="ShopDecCart.jsp" method="post">
        <input type="hidden" name="goodId" value="all">
        <input type="submit" value="DeleteAll">
    </form>
</div>
<%
            check.close();
            stmt.close();
            stmt2.close();
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
                if (stmt2 != null) stmt2.close();
            } catch (SQLException se2) {
            }// 什么都不做
            try {
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }%>


</body>
</html>
<%
    if (request.getSession().getAttribute("errState") == "addCartSuccess"){ %>
<script>
    window.alert("加车成功")
</script>
<%request.getSession().setAttribute("errState",null);}else if (request.getSession().getAttribute("errState") == "decCartSuccess"){%>
<script>
    window.alert("删除成功")
</script>
<%request.getSession().setAttribute("errState",null);}%>