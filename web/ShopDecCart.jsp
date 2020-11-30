<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/28
  Time: 10:59 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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
    String goodId = request.getParameter("goodId");
    Cookie cookie = null;
    Cookie[] cookies = request.getCookies();
    String shopHistory = "null";
    int i;
    for (i=0; i<cookies.length;i++){
        cookie = cookies[i];
        if (cookie.getName().equals("KyoaniShopHistory")){
            shopHistory = cookie.getValue();
            break;
        }
    }
    if (i==cookies.length){
        Cookie history = new Cookie("KyoaniShopHistory","null");
        history.setMaxAge(60*60*24*30);
        response.addCookie(history);
    }


    Connection conn = null;
    Statement stmt = null;
//    Statement stmt2 = null;

    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL,USER,PASS);
        stmt = conn.createStatement();
//        stmt2 = conn.createStatement();
                String sql;

        if (goodId.equals("all")){
            sql = "SELECT * FROM `"+uid+"`";
            ResultSet cartGood = stmt.executeQuery(sql);
            while (cartGood.next()){
                shopHistory = cartGood.getString("cartGoodId");
//                String num = cartGood.getString("cartGoodAmount");
//                String sql2 = "SELECT goodStock FROM goodList WHERE goodId='"+shopHistory+"'";
//                ResultSet stock = stmt2.executeQuery(sql2);
//                stock.next();
//                String resStock = stock.getString("goodStock");
//                if ( Integer.parseInt(resStock) < Integer.parseInt(num) ) {
//
//                }
            }
            Cookie history = new Cookie("KyoaniShopHistory",shopHistory);
            history.setMaxAge(60*60*24*30);
            response.addCookie(history);
            cartGood.close();
            sql = "DROP TABLE `"+uid+"`";
            stmt.execute(sql);
            request.getSession().setAttribute("errState","settleSuccess");

        } else {
            sql = "DELETE FROM `"+uid+"` WHERE cartGoodId='"+goodId+"'";
            stmt.execute(sql);
            request.getSession().setAttribute("errState","decCartSuccess");
        }



        stmt.close();
        conn.close();
        response.sendRedirect("Shop.jsp");

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
    }

%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
