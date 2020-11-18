<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/18
  Time: 1:08 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
        String DB_URL = "jdbc:mysql://localhost:3306/userlist?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String USER = "root";
        String PASS = "zzy20000615";

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        Statement stmt = null;
        try{
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL,USER,PASS);
            stmt = conn.createStatement();
            String sql;
            sql = "SELECT * FROM user WHERE BINARY username='"+username+"'";
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()){
                String passwordDb = rs.getString("password");
                String uid = rs.getString("uid");
                if (password.equals(passwordDb)){
                    out.print("<p>"+uid+"</p>");
                }
                else {
                    out.print("<p>err</p>");
                }
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

</body>
</html>
