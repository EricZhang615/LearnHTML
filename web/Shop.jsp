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

    Cookie cookie = null;
    Cookie[] cookies = request.getCookies();
    String shopHistory = "null";

    for (int i=0; i<cookies.length;i++){
        cookie = cookies[i];
        if (cookie.getName().equals("KyoaniShopHistory")){
            shopHistory = cookie.getValue();
            break;
        }
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

%>


<html>
<head>
    <meta charset="UTF-8">
    <title>Shop</title>
    <link rel="stylesheet" type="text/css" href="basicStyle.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Kosugi+Maru&family=Montserrat:ital,wght@0,600;1,600&family=Noto+Serif+JP:wght@300&family=Raleway&family=Sawarabi+Mincho&display=swap" rel="stylesheet">
</head>
<body id="main" style="opacity: 0">
<div style="height: 60px" id="top"></div>
<ul class="topnav">
    <li><a href="index.jsp">Home</a></li>
    <li><a href="#1">Memo</a></li>
    <li><a href="#2">Shop</a></li>
    <li><a href="#3">Contact us</a></li>
    <li><span>京都动画非官方FanClub</span></li>
    <li style="float: right"><a href="Logout.jsp">Log Out</a></li>
</ul>

<div class="shopBanner"></div>

<div style="float: left;width: 25vw;height: 1000px"></div>
<div style="float: left;width: 60vw;height: 1500px">
    <%
        if (!shopHistory.equals("null")){%>
        <div style="width: 100%;height: 400px">
            <div>最近购买</div>
        <%
            sql = "SELECT * FROM goodList WHERE goodId='"+shopHistory+"'";
        ResultSet historyGood = stmt.executeQuery(sql);
        while (historyGood.next()){
            String goodId = historyGood.getString("goodId");
            String goodName = historyGood.getString("goodName");
            String goodStock = historyGood.getString("goodStock");
            String goodPrice = historyGood.getString("goodPrice");
            String goodImageUrl = "Image/goodImage/"+goodId+".jpeg";
            %>
            <div class="goodBlock">
                <div class="goodImg" style="background-image: url(<%=goodImageUrl%>)"></div>
                <div class="goodName"><%=goodName%></div>
                <div class="goodPrice"><span>¥ </span><%=goodPrice%></div>
                <div class="goodStock">库存：<%=goodStock%></div>
                <form action="ShopAddCart.jsp" method="post">
                    <input type="hidden" name="goodId" value="<%=goodId%>">
                    <input type="number" name="goodAmount" value="1" min="1" max="<%=goodStock%>">
                    <input type="submit" value="ADD TO CART">
                </form>
            </div>
            <%}
        historyGood.close();%>
        </div>
        <%}%>
    <div style="width: 100%;height: 1500px">
        <%
            sql = "SELECT * FROM goodList";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()){
                String goodId = rs.getString("goodId");
                String goodName = rs.getString("goodName");
                String goodStock = rs.getString("goodStock");
                String goodPrice = rs.getString("goodPrice");
                String goodImageUrl = "Image/goodImage/"+goodId+".jpeg";
        %>
        <div class="goodBlock">
            <div class="goodImg" style="background-image: url(<%=goodImageUrl%>)"></div>
            <div class="goodName"><%=goodName%></div>
            <div class="goodPrice"><span>¥ </span><%=goodPrice%></div>
            <div class="goodStock">库存：<%=goodStock%></div>
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
</div>
<div style="float: left;width: 15vw;height: 1000px"></div>






<%
    sql = "SELECT * FROM information_schema.TABLES WHERE TABLE_NAME = '"+uid+"'";
    ResultSet check = stmt.executeQuery(sql);
    if (check.next()){%>
<div class="cart">
    <div class="cartGood">
        <%
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
                String goodImageUrl = "Image/goodImage/"+goodId+".jpeg";
        %>
        <div class="cartGoodBlock">
            <div class="cartGoodImg" style="background-image: url(<%=goodImageUrl%>)"></div>
            <div class="cartGoodName"><%=goodName%></div>
            <div class="cartGoodPrice"><span>¥</span><%=goodPrice%></div>
            <div class="cartGoodAmount"><%=goodAmount%></div>
            <form action="ShopDecCart.jsp" method="post">
                <input type="hidden" name="goodId" value="<%=goodId%>">
                <input type="submit" value="删除">
            </form>
        </div>
        <%goodInfo.close();}
            cartSet.close();%>
    </div>
    <div class="cartSum">
        <%
            DecimalFormat df = new DecimalFormat("########.##");
            String tp = df.format(totalPrice);
        %>
        <div>小计：</div>
        <div><span>¥ </span><%=tp%></div>
        <%if (!tp.equals("0")){%>
        <form id="settle" action="ShopDecCart.jsp" method="post">
            <input type="hidden" name="goodId" value="all">
            <button onclick="submit()">结算</button>
            <script>
                function submit(){
                    document.getElementById("settle").submit();
                }
            </script>
        </form>
        <%}%>

    </div>
</div>
<%}
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
<script>
    setTimeout(function (){document.getElementById("main").setAttribute('class','opacity2')},500)
</script>
<%
    if (request.getSession().getAttribute("errState") == "addCartSuccess"){ %>
<script>
    window.alert("加车成功")
</script>
<%request.getSession().setAttribute("errState",null);}else if (request.getSession().getAttribute("errState") == "decCartSuccess"){%>
<script>
    window.alert("删除成功")
</script>
<%request.getSession().setAttribute("errState",null);}else if (request.getSession().getAttribute("errState") == "settleSuccess"){%>
<script>
    window.alert("下单成功")
</script>
<%request.getSession().setAttribute("errState",null);}%>