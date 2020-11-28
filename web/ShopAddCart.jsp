<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/28
  Time: 7:50 下午
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
    String goodAmount = request.getParameter("goodAmount");

    Connection conn = null;
    Statement stmt = null;

    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL,USER,PASS);
        stmt = conn.createStatement();
        String sql;

        sql = "SELECT * FROM information_schema.TABLES WHERE TABLE_NAME = '"+uid+"'";
        ResultSet rs = stmt.executeQuery(sql);

        if (!(rs.next())){
            sql = "CREATE TABLE `"+uid+"`(cartGoodId CHAR(10) NULL,cartGoodAmount CHAR(10) NULL) DEFAULT CHARSET=utf8";
            stmt.execute(sql);
        }
        sql = "SELECT * FROM `"+uid+"` WHERE cartGoodId='"+goodId+"'";
        ResultSet gl = stmt.executeQuery(sql);
        if (gl.next()){
            String newCartGoodAmount = String.valueOf(Integer.parseInt(gl.getString("cartGoodAmount")) + Integer.parseInt(goodAmount));
            sql = "UPDATE `"+uid+"` SET cartGoodAmount='"+newCartGoodAmount+"' WHERE cartGoodId='"+goodId+"'";
            stmt.execute(sql);
        } else {
            sql = "INSERT INTO `"+uid+"` (cartGoodId,cartGoodAmount) VALUES ('"+goodId+"','"+goodAmount+"')";
            stmt.execute(sql);
        }

        request.getSession().setAttribute("errState","addCartSuccess");
        gl.close();
        rs.close();
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
