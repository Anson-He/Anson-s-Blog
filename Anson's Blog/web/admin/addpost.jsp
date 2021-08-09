<%--
  Created by IntelliJ IDEA.
  User: 86134
  Date: 2021/8/7
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="sql.GetDBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.print.DocFlavor" %>
<%@ page import="java.util.UUID" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Anson的控制台</title>
    <link rel="stylesheet" href="<c:url value='../css/addpost.css'></c:url>">
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <script>
        function post() {
            var myselect = document.getElementById("classes");
            var index = myselect.selectedIndex;
            var cla = myselect.options[index].value;
            var html = ed.txt.html();
            var title = document.getElementById("article-title").value;
            var sub = document.getElementById('subs').value;
            var year = document.getElementById('year').value;
            var month = document.getElementById('month').value;
            var day = document.getElementById('day').value;
            var date = year+"-"+month+"-"+day;
            if(html!='<p><br></p>'&&title!=''&&sub!=''&&year!=''&&month!=''&&day!='') {
                alert("发布成功");
                location.reload()
            }
            else{
                alert("请填写完整")
                return false;
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
    Connection con = null;
    con = GetDBConnection.getConnection();
    ArrayList<String> temp = new ArrayList();
    String sql2 = "select cla from tags";
    PreparedStatement preparedStatement2 = con.prepareStatement(sql2);
    ResultSet rs2 = preparedStatement2.executeQuery();
    while(rs2.next()){
        if(!rs2.getString(1).equals("null")) {
            temp.add(rs2.getString(1));
        }
    }
    rs2.close();
    con.close();
%>
<%
    String id = request.getParameter("id");
    String html = request.getParameter("html");
    String title = request.getParameter("article-title");
    String sub = request.getParameter("subs");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String date = year+"-"+month+"-"+day;
    String cla = request.getParameter("classes");
    String ii = null;
    String tt = "在此处输入标题...";
    String cc = "-";
    String dd = "2021-01-01";
    String ddd = "";
    String ss = "";
    Connection con000 = GetDBConnection.getConnection();
    if(id==null && title!=null){
        String sql = "select id from blogs";
        PreparedStatement p = con000.prepareStatement(sql);
        ResultSet rs = p.executeQuery();
        ArrayList ids = new ArrayList();
        int nums = 0;
        while(rs.next()){
            nums = nums+1;
            ids.add(rs.getString(1));
        }
        while(ids.indexOf(nums)!=-1){
            nums = nums +1;
        }
        UUID uuid = UUID.randomUUID();
        String str = uuid.toString();
        String num=str.replace("-", "");
        String sql0 = "insert into blogs(id,title,cla,date,deatial,sub) values(?,?,?,?,?,?)";
        PreparedStatement ps = null;
        ps = con000.prepareStatement(sql0);
        //'"+num+"','"+title+"','"+cla+"','"+date+"','"+html+"','"+sub+"');
        ps.setString(1,num);
        ps.setString(2,title);
        ps.setString(3,cla);
        ps.setString(4,date);
        ps.setString(5,html);
        ps.setString(6,sub);
        int count2 = ps.executeUpdate();
        if(count2 > 0)
        {
            System.out.println("添加成功！");
        }
        else{
            System.out.println("添加失败");
        }
        p.close();
        ps.close();
        con000.close();
    }
    else if(id!=null&&title!=null){
        String s = "select * from blogs where id='"+id+"'";
        PreparedStatement pp = con000.prepareStatement(s);
        ResultSet rr = pp.executeQuery();
        while(rr.next()){
            ii = rr.getString(1);
            tt = rr.getString(2);
            cc = rr.getString(3);
            dd = rr.getString(4);
            ddd = rr.getString(5);
            ss = rr.getString(6);
        }
        pp.close();
        rr.close();
        con000.close();
    }
    String yy = dd.substring(0,4);
    String mm = dd.substring(5,7);
    String daa = dd.substring(8,10);
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
                <li style="background-color: #eee;">写文章</li>
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

<form action="addpost.jsp" method="post">
    <textarea  id="html" name="html" style="display: none"></textarea>
<div id="write">
    <h2 style="margin-left: 2%">撰写新文章</h2>
    <hr style="margin-top: 1%; width: 95%;margin-left: 2%">
    <input type="text" id="article-title" name="article-title" class="article-title" value="<%=tt%>">
    <div id="editor1" class="editFrame">
    </div>
    <script type="text/javascript" src="<c:url value='../lib/wangEditor-3.1.1/release/wangEditor.min.js'></c:url>"></script>
    <script language="JavaScript">
        var editor=window.wangEditor
        var ed=new editor('#editor1')//这个editor1是上面定义的div框架id
        ed.customConfig.onchange = function(html){
            document.getElementById("html").value = html;
        }
        ed.create()
        ed.txt.html('<%=ddd%>')
    </script>
</div>

<div id="do">
    <h2 style="margin-left: 2%">操作</h2>
    <hr style="margin-top: 1%; width: 80%;margin-left: 2%">
    <span style="display: block;margin-top: 20px;margin-left: 12px">
        <h4>发布时间：</h4><br>
        <input type="text" id="year" name="year" value="<%=yy%>" size="4" maxlength="4" style="margin: 5px 0;">
        - <input type="text" id="month" name="month" value="<%=mm%>" size="2" maxlength="2" style="margin: 5px 0;">
        - <input type="text" id="day" name="day" value="<%=daa%>" size="2" maxlength="2" style="margin: 5px 0;"><br/>
    </span>
    <span style="display: block;margin-top: 20px;margin-left: 12px">
        <h4>摘要：</h4><br>
        <textarea id="subs" name="subs" rows="7" class="form-control" style="width: 300px;height: 200px"><%=ss%></textarea>
    </span>
    <span style="display: block;margin-top: 20px;margin-left: 12px">
        <h4>分类：</h4><br>
        <select id="classes" name="classes" style="margin:5px;">
            <option value="-">-</option>
            <%
                for(int i=0;i<temp.size();i++){
            %>
            <option value="<%=temp.get(i)%>"><%=temp.get(i)%></option>
            <%
                }
            %>
        </select>
        <a href="category.jsp">添加分类</a>
    </span>
    <input type="submit" style="display: block;width: 100px;height: 30px;margin-top: 150px;margin-left: 125px" onclick="post()" value="发布">
</div>
</form>
<footer>
    <p>© <span>2021</span><span><a href="http://anson-he.work/"> • Anson生产BUG的日常</a></span><span></span><span></span><a href="http://beian.miit.gov.cn/"> • 粤ICP备2021021622号-1</a></p>
</footer>
</body>
</html>
