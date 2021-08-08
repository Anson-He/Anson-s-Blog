<%--
  Created by IntelliJ IDEA.
  User: 86134
  Date: 2021/8/6
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sql.GetDBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Iterator" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Anson的控制台</title>
    <link rel="stylesheet" href="../css/category.css"/>
    <script>
        function del(c) {
            var a = window.confirm("确定要删除所有分类为'"+c+"'的文章吗？")
            if (a==true){
                window.location.href="category.jsp?ii="+c;
                <%
                    String cl = request.getParameter("ii");
                    if(cl!=null){
                        String sql22 = "delete from blogs where cla="+"'"+cl+"'";
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
                        String sql33 = "delete from tags where cla="+"'"+cl+"'";
                        count = stsm.executeUpdate(sql33);
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
        function up(e) {
            document.getElementById("oldtag").value = e;
            document.getElementById("update").style.display="block";
        }
        function upd() {
            var newtag = document.getElementById("inp").value;
            var oldtag = document.getElementById("oldtag").value;
            window.location.href="category.jsp?update=t&newtag="+newtag+"&oldtag="+oldtag;
            <%
                String update = request.getParameter("update");
                String newtag = request.getParameter("newtag");
                String oldtag = request.getParameter("oldtag");
                System.out.println(update);
                System.out.println(newtag);
                System.out.println(oldtag);
                if(update!=null){
                    Connection con = null;
                    con = GetDBConnection.getConnection();
                    String sql = "update tags set cla='"+newtag+"' where cla='"+oldtag+"';";
                    Statement statement = null;
                    statement = con.createStatement();
                    int count = statement.executeUpdate(sql);
                    if(count>0){
                        System.out.println("修改成功");
                    }
                    else {
                        System.out.println("修改失败");
                    }
                    statement.close();
                    Statement statement1 = null;
                    String sql2 = "update blogs set cla='"+newtag+"' where cla='"+oldtag+"';";
                    statement1 = con.createStatement();
                    int count2 = statement1.executeUpdate(sql2);
                    if(count2>0){
                        System.out.println("修改成功");
                    }
                    else{
                        System.out.println("修改失败");
                    }
                    statement1.close();
                    con.close();
                }
            %>
            alert("修改成功")
            location.reload();
        }
        function ad() {
            var text = document.getElementById("classes").value;
            if(text!=''){
                window.location.href="category.jsp?text="+text;
                <%
                    String cl2 = request.getParameter("text");
                    if(cl2!=null){
                        String sql222 = "insert into tags value("+"'"+cl2+"')";
                        Connection con22 = null;
                        con22 = GetDBConnection.getConnection();
                        Statement stsm2 = null;
                        stsm2 = con22.createStatement();
                        int count2 = stsm2.executeUpdate(sql222);
                        if(count2 > 0)
                        {
                            System.out.println("添加成功！");
                        }
                        else{
                            System.out.println("添加失败");
                        }
                        stsm2.close();
                        con22.close();
                    }
                %>
                alert("增加成功")
                location.reload();
            }
            else{
                alert("输入为空！")
            }

        }
        function dis() {
            document.getElementById("update").style.display="none"
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
        Connection con = null;
        con = GetDBConnection.getConnection();
        String sql = "select * from tags";
        PreparedStatement preparedStatement = con.prepareStatement(sql);
        ResultSet rs = preparedStatement.executeQuery();
        ArrayList<String> clas = new ArrayList<>();
        while(rs.next()){
            try {
                if(!rs.getString(1).equals("null")) {
                    clas.add(rs.getString(1));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        ArrayList count0 = new ArrayList();
        for(int c = 0;c<clas.size();c++){
            sql = "select count(id) from blogs where cla="+"'"+clas.get(c)+"'";
            preparedStatement = con.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
            while(rs.next()){
                count0.add(rs.getInt(1));
            }
        }
        rs.close();
        con.close();

    %>
<div id="left-nav">
    <div class="author-nav">
        <img src="../img/index.png" alt="个人头像">
    </div>
    <div class="main-nav">
        <ul>
            <a href="postlist.jsp">
                <li>所有文章</li>
            </a>
            <a href="addpost.jsp">
                <li>写文章</li>
            </a>
            <a href="category.jsp">
                <li style="background-color: #eee;">分类管理</li>
            </a>
            <a href="https://changyan.kuaizhan.com/v3/changyan/install/pc">
                <li>评论</li>
            </a>
            <a href="index.html">
                <li>返回首页</li>
            </a>
        </ul>
    </div>
</div>
    <input type="text" id="oldtag" style="display: none">
    <div id="update" style="position: absolute;top: 30%;left: 35%;width: 30%;height: 30%;border: 2px solid red; background-color: #5bc0de;display: none">
        <h3 style="margin-top: 5px;margin-left: 5px">新的分类名为：</h3><br>
        <input type="text" id="inp" style="width: 200px;height: 25px;margin-top: 10%;margin-left: 25%"><br>
        <button style="width: 100px;height: 30px;margin-top: 13%;margin-left: 25%" onclick="upd()">确定</button>
        <button style="width: 100px;height: 30px;margin-left: 2%" onclick="dis()">取消</button>
    </div>
<div id="add">
    <h2 style="margin-left: 2%">添加</h2>
    <hr style="margin-top: 1%; width: 30%;margin-left: 2%"/>
    <h3 style="margin-left: 2%;margin-top: 2%">类别名称：</h3>
    <input type="text" id="classes" style="width: 350px;height: 30px;margin-top: 10px;margin-left: 2%">
    <br>
    <button type="submit" style="margin-top: 1%;width: 100px;height: 30px;margin-left: 22%" onclick="ad()">添加分类</button>
</div>
<div id="manage">
    <h2 style="margin-left: 2%;margin-top: -183px">管理</h2>
    <hr style="margin-top: 1.5%; width: 95%;margin-left: 2%"/>
    <form>
        <table>
            <thead>
            <tr>
                <th>分类名称</th>
                <th>文章数</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                for(int i=0;i<clas.size();i++){
            %>
            <tr>
                <td><%=clas.get(i)%></td>
                <td><%=count0.get(i)%></td>
                <td>
                    <button type="button" class="btn1" onclick="up('<%=clas.get(i)%>')">修改</button>
                    <button type="button" class="btn2" onclick="del('<%=clas.get(i)%>')">删除</button>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </form>
</div>
<footer>
    <p>© <span>2021</span><span><a href="http://anson-he.work/"> • Anson生产BUG的日常</a></span><span></span><span></span><a href="http://beian.miit.gov.cn/"> • 粤ICP备2021021622号-1</a></p>
</footer>
</body>
</html>
