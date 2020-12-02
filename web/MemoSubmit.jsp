<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/23
  Time: 12:21 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%
    request.setCharacterEncoding("UTF-8");

    if (request.getSession().getAttribute("uid") == "0" ||request.getSession().getAttribute("uid") == null){
        request.getSession().setAttribute("errState","unauthenticated");
        response.sendRedirect("index.jsp");
    }

    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/userlist?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String USER = "root";
    String PASS = "zzy20000615";

    String memoInput = request.getParameter("memo");

    Connection conn = null;
    Statement stmt = null;
    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL,USER,PASS);
        stmt = conn.createStatement();
        String sql;
        sql = "SELECT max(memoId) memoId FROM memo";
        ResultSet rs = stmt.executeQuery(sql);

        rs.next();
        String newMemoId = String.valueOf(Integer.parseInt(rs.getString("memoId")) + 1);
        sql = "INSERT INTO memo (memoId,uid,content,time) VALUES ('"+newMemoId+"','"+
                request.getSession().getAttribute("uid")+"',N'"+memoInput+"',NOW())";
        stmt.execute(sql);
        request.getSession().setAttribute("errState","memoSubmitSuccess");
        response.sendRedirect("Memo.jsp");

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
