<%--
  Created by IntelliJ IDEA.
  User: 86134
  Date: 2021/8/4
  Time: 23:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sql.GetDBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta charset="utf-8"/>
    <title>Anson's Blog</title>
    <%
        String context = request.getContextPath();
    %>
    <link rel="shortcut icon" href="img/index.ico"/>
    <link rel="stylesheet" href="css/blog.css">
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <script src="js/blog.js"></script>
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
<body style="background: #e2e2e2 url(img/blog.jpg) no-repeat fixed center;
        background-size: cover;">
<%
    String detial0 = null;
    Connection con = null;
    con = GetDBConnection.getConnection();
    String sql = "select * from blogs";
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
<div id="gotop"></div>
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
        <ul>
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
    <div id="top">
        <div class="info">
            <div class="bg-title">
                Anson's Blog
            </div>
            <div class="md-title">
                DEBUG THE WORLD
            </div>
        </div>
    </div>
    <div id="main">
        <form id="postForm">
            <%
                for(int i=0;i<ids.size();i++){
                    if(subs.get(i)!=null){
                        detial0 = subs.get(i);
                    }
                    else{
                        try{
                            detial0 = detials.get(i).substring(0,50);
                        }
                        catch (Exception e){
                            detial0 = detials.get(i);
                        }
                    }

            %>
                <div class="post-info">
                    <br><h2>
                    <a href="article.jsp?id=<%=ids.get(i)%>&title=<%=titles.get(i)%>" target="_blank"><%=titles.get(i)%></a>
                </h2>
                    <div class="post-detial">
                        <span><%=clas.get(i)%></span>
                        <span><%=dates.get(i)%></span>
                    </div>
                </div>
                <p style="width: 50%; margin-left: 25%;margin-top: 5px;text-align: center"><%=detial0%></p>
                <center>
                    <button class="more"><a
                            href="article.jsp?id=<%=ids.get(i)%>&title=<%=titles.get(i)%>" target="_blank"
                            style="color: #000;">Read More</a></button>
                </center><br>
                <hr>
            <%
                }
            %>
        </form>

    </div>
    <footer>
        <p>© <span>2021</span><span><a href="http://anson-he.work/"> • Anson生产BUG的日常</a></span><span></span><span></span><a href="http://beian.miit.gov.cn/"> • 粤ICP备2021021622号-1</a></p>
    </footer>
</div>
</body>

</html>

