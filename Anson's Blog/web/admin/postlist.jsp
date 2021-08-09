<%--
  Created by IntelliJ IDEA.
  User: 86134
  Date: 2021/8/5
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sql.GetDBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Iterator" %>

<html>
<head>
    <meta charset="utf-8"/>
    <title>Anson的控制台</title>
    <link rel="stylesheet" href="../css/postlist.css"/>
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <script>
        function clickk() {
            var myselect = document.getElementById("sub_id");
            var index = myselect.selectedIndex;
            var cla = myselect.options[index].value;
            window.location.href="postlist.jsp?sub_id="+cla;
        }
        function del(i) {
            var a = window.confirm("确定要删除该文章吗？")
            if (a==true){
                window.location.href="postlist.jsp?ii="+i;
                <%
                        String d = request.getParameter("ii");
                        if(d!=null){
                        String sql22 = "delete from blogs where id="+"'"+d+"'";
                        Connection con2 = null;
                        con2 = GetDBConnection.getConnection();
                        Statement stsm = null;
                        stsm = con2.createStatement();
                        int count = stsm.executeUpdate(sql22);
                        if(count > 0)
                        {
                            System.out.println("删除成功！");
                        }
                        else{
                            System.out.println("删除失败");
                        }
                        stsm.close();
                        con2.close();
                    }
                %>
                alert("删除成功")
                location.reload();
            }
        }
    </script>

</head>
<body>
<%
    if (session.getAttribute("login")!="yes"){
        response.sendRedirect("../login.jsp");
    }
%>
<%
    request.setCharacterEncoding("utf-8");
    String sql = null;
    String sub_id = request.getParameter("sub_id");
    if(sub_id==null || sub_id.equals("all")){
        sql = "select * from blogs";
    }
    else {
        sql = "select * from blogs where cla="+"'"+sub_id+"'";
    }
    String detial0 = null;
    Connection con = null;
    con = GetDBConnection.getConnection();
    PreparedStatement preparedStatement = con.prepareStatement(sql);
    ResultSet rs = preparedStatement.executeQuery();
    ArrayList<String> ids = new ArrayList<>();
    ArrayList<String> titles = new ArrayList<>();
    ArrayList<String> clas = new ArrayList<>();
    ArrayList<String> dates = new ArrayList<>();
    ArrayList<String> detials = new ArrayList<>();
    ArrayList<String> subs = new ArrayList<>();
    while(rs.next()){
        ids.add(rs.getString(1));
        titles.add(rs.getString(2));
        clas.add(rs.getString(3));
        dates.add(rs.getString(4));
        detials.add(rs.getString(5));
        subs.add(rs.getString(6));
    }

    ArrayList<String> temp = new ArrayList();
    String sql2 = "select cla from tags";
    PreparedStatement preparedStatement2 = con.prepareStatement(sql2);
    ResultSet rs2 = preparedStatement2.executeQuery();
    while(rs2.next()){
        if (!rs2.getString(1).equals("null")) {
            temp.add(rs2.getString(1));
        }
    }
    rs.close();
    rs2.close();
    con.close();
%>
<div id="left-nav">
    <div class="author-nav">
        <img src="../img/index.png" alt="个人头像">
    </div>
    <div class="main-nav">
        <ul>
            <a href="postlist.jsp">
                <li style="background-color: #eee;">所有文章</li>
            </a>
            <a href="addpost.jsp">
                <li>写文章</li>
            </a>
            <a href="category.jsp">
                <li>分类</li>
            </a>
            <a href="https://changyan.kuaizhan.com/v3/changyan/install/pc">
                <li>评论</li>
            </a>
            <a href="<c:url value='../index.html'></c:url>">
                <li>返回首页</li>
            </a>
        </ul>
    </div>
</div>
<div id="manage">
    <h2 style="margin-left: 2%">管理</h2>
    <div class="select">
        <select class="select-class" name="sub_id" id="sub_id">
            <option value="all">全部</option>
            <%
                for(int j=0;j<temp.size();j++){
            %>
            <option value="<%=temp.get(j)%>"><%=temp.get(j)%></option>
            <%
                }
            %>
        </select>
        <button style="width: 3%" onclick="clickk()">过滤</button>

    </div>
    <hr style="margin-top: 1%; width: 95%;margin-left: 2%"/>
    <table>
        <thead>
        <tr>
            <th>标题</th>
            <th>简介</th>
            <th>分类</th>
            <th>日期</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
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
        <tr>
            <td><%=titles.get(i)%></td>
            <td><%=detial0%></td>
            <td><%=clas.get(i)%></td>
            <td><%=dates.get(i)%></td>
            <td>
                <br><button type="button" class="btn1"><a href="change.jsp?id=<%=ids.get(i)%>&article-title=<%=titles.get(i)%>" style="text-decoration: none">修改</a></button><br>
                <br><button type="button" class="btn2" onclick="del('<%=ids.get(i)%>')">删除
                </button><br><br>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <footer>
        <p>© <span>2021</span><span><a href="http://anson-he.work/"> • Anson生产BUG的日常</a></span><span></span><span></span><a href="http://beian.miit.gov.cn/"> • 粤ICP备2021021622号-1</a></p>
    </footer>
</div>


</body>

</html>