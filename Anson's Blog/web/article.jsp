<%--
  Created by IntelliJ IDEA.
  User: 86134
  Date: 2021/8/5
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sql.GetDBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Anson's Blog</title>
    <link rel="stylesheet" href="css/article.css">
    <link rel="shortcut icon" href="img/index.ico"/>
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <script src="js/article.js"></script>
    <style type="text/css">
        a:link {
            text-decoration: none;
        }

        a:visited {
            text-decoration: none;
        }

        a:hover {
            text-decoration: none;
        }

        a:active {
            text-decoration: none;
        }
    </style>
</head>
<body>
<%
    String id = request.getParameter("id");
    Connection con = null;
    con = GetDBConnection.getConnection();
    String sql = "select * from blogs where id="+"'"+id+"'";
    PreparedStatement preparedStatement = con.prepareStatement(sql);
    ResultSet rs = preparedStatement.executeQuery();

    ArrayList<String> ids = new ArrayList<>();
    ArrayList<String> titles = new ArrayList<>();
    ArrayList<String> clas = new ArrayList<>();
    ArrayList<String> dates = new ArrayList<>();
    ArrayList<String> detials = new ArrayList<>();
    ArrayList<String> subs = new ArrayList<>();
    while(rs.next()){

        try {
            ids.add(rs.getString(1));
            titles.add(rs.getString(2));
            clas.add(rs.getString(3));
            dates.add(rs.getString(4));
            detials.add(rs.getString(5));
            subs.add(rs.getString(6));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    rs.close();
    con.close();

%>
<div id="bar" class="scrollbar"></div>
<div id="switch">
    <div id="iconfixed">
        <div class="icon"></div>
    </div>
</div>
<div id="left-nav">
    <div class="author-nav">
        <img src="img/index.png" alt="个人头像">
    </div>
    <div class="main-nav">
        <ul style="list-style: none">
            <a href="index.html">
                <li>返回主页</li>
            </a>
            <a href="blog.jsp">
                <li>博客</li>
            </a>
            <a href="pro.jsp">
                <li>工程</li>
            </a>
            <a href="about.html">
                <li>关于我</li>
            </a>
            <a href="login.jsp">
                <li>控制台</li>
            </a>
        </ul>
    </div>
</div>
<div id="wrap">
    <div id="main">
        <div class="single-title"><h2><%=titles.get(0)%></h2></div>
        <div class="single-info">
            发表于<%=dates.get(0)%> |&nbsp;分类于 <%=clas.get(0)%> </div>
        <div class="single-content"><%=detials.get(0)%></div>
        <br>
        <!--PC版-->
        <div id="SOHUCS" sid="<%=id%>"></div>
        <script charset="utf-8" type="text/javascript" src="https://cy-cdn.kuaizhan.com/upload/changyan.js" ></script>
        <script type="text/javascript">
            window.changyan.api.config({
                appid: 'cyvAwyXdF',
                conf: 'prod_c89c86fa3c1fac410528b76cb6427c98'
            });
        </script>
    </div>
    <footer>
        <p>© <span>2021</span><span><a href="http://anson-he.work/"> • Anson生产BUG的日常</a></span><span></span><span></span><a href="http://beian.miit.gov.cn/"> • 粤ICP备2021021622号-1</a></p>
    </footer>
</div>

</body>
