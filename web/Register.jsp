<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/18
  Time: 4:17 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%
    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/userlist?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String USER = "root";
    String PASS = "zzy20000615";

    String usernameInput = request.getParameter("username");
    String passwordInput = request.getParameter("password");

    Connection conn = null;
    Statement stmt = null;
    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL,USER,PASS);
        stmt = conn.createStatement();
        String sql;
        sql = "SELECT * FROM user WHERE BINARY username='"+usernameInput+"'";
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()){
            request.getSession().setAttribute("errState","existUsername");
            response.sendRedirect("RegisterPage.jsp");
        } else {
            sql = "SELECT max(uid) uid FROM user";
            ResultSet maxUid = stmt.executeQuery(sql);
            maxUid.next();
            String newUid = String.valueOf(Integer.parseInt(maxUid.getString("uid")) + 1);
            sql = "INSERT INTO user (username,password,uid) VALUES ('"+usernameInput+"','"+passwordInput+"','"+newUid+"')";
            stmt.execute(sql);
            request.getSession().setAttribute("uid",newUid);
            request.getSession().setAttribute("errState","registerSuccess");
            response.sendRedirect("index.jsp");
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
    }


%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
