<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/18
  Time: 3:56 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    if (request.getSession().getAttribute("uid") == "0" ||request.getSession().getAttribute("uid") == null){
        request.getSession().setAttribute("errState","unauthenticated");
        response.sendRedirect("index.jsp");
    }

    request.getSession().removeAttribute("uid");
    request.getSession().removeAttribute("errState");
    response.sendRedirect("index.jsp");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
