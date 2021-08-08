<%@ page import="com.mysql.cj.Session" %><%--
  Created by IntelliJ IDEA.
  User: 86134
  Date: 2021/8/5
  Time: 1:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录到Anson生产BUG的日常</title>
    <link rel="stylesheet" href="css/login.css" />
    <script>
        function li() {
            var name = document.getElementById("name").value
            var password = document.getElementById("password").value
            if(name=="1597893898"&&password=="hyh010710"){
                <%
                    session.setAttribute("login","yes");
                %>
                window.location.href="admin/postlist.jsp"
            }
            else{
                alert("用户名与密码不匹配")
            }
        }
    </script>
</head>
<body class="bg">
<div class="center">
    <h1 style="margin-left: 12%">Login</h1>
        <input type="text" id="name" name="name" value placeholder="用户名"><br>
        <input type="password" id="password" name="password" placeholder="密码"><br>
        <button class="btn" onclick="li()">登录</button>
    <a href="index.html">Back</a>
</div>
</body>
</html>
