<%--
  Created by IntelliJ IDEA.
  User: eric
  Date: 2020/11/14
  Time: 5:16 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%--<%@include file="homepage.html"%>--%>

<%

    if (request.getSession().getAttribute("uid") == null){
        request.getSession().setAttribute("uid","0");
    }
    String uid = (String) request.getSession().getAttribute("uid");

    Integer hitsCount = (Integer)application.getAttribute("hitCounter");
    if( hitsCount == null || hitsCount == 0 ){
        hitsCount = 1;
    }else{
        hitsCount += 1;
    }
    application.setAttribute("hitCounter", hitsCount);



%>




<html>
<head>
    <meta charset="UTF-8">
    <title>KyotoAnimation Unofficial Fanclub</title>
    <link rel="stylesheet" type="text/css" href="basicStyle.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Kosugi+Maru&family=Montserrat:ital,wght@0,600;1,600&family=Noto+Serif+JP:wght@300&family=Raleway&family=Sawarabi+Mincho&display=swap" rel="stylesheet">
</head>

<body id="main" style="opacity: 0">
<div style="height: 0;box-shadow: 0 60px 120px 50px #281A14;" id="top"></div>
<ul class="clear" id="topbar">
    <li><a href="index.jsp">Home</a></li>
    <li><a href="Memo.jsp">Memo</a></li>
    <li><a href="Shop.jsp">Shop</a></li>
    <li><a href="#3">Contact us</a></li>
    <li><span>京都动画非官方FanClub</span></li>
    <% if (uid.equals("0")) { %>
    <li style="float: right"><a href="RegisterPage.jsp">Sign in</a></li>
    <% } else { %>
    <li style="float: right"><a href="Logout.jsp">Log Out</a></li>
    <% } %>
</ul>


<div class="backToTop">
    <a class="info" href="#top">Top</a>
</div>

<div id="indexBkgImg">
    <div id="bkgImg1" style="opacity: 1;z-index: -1"></div>
    <div id="bkgImg2" style="opacity: 1;z-index: -2"></div>

    <% if (uid.equals("0")) { %>
    <div class="loginWindow">
        <form id="loginForm" action="LoginVerifyPage.jsp" method="post">
            <div>Username:</div>
            <input id="user" type="text" name="username" placeholder="Username...">
            <div>Password:</div>
            <input id="pass" type="password" name="password" placeholder="Password...">
        </form>
        <button onclick="verifyLogin()">Login</button>
        <script>
            function verifyLogin(){
                var receivedUser=document.getElementById("user").value;
                var receivedPass=document.getElementById("pass").value;
                if ( receivedUser.trim().length > 0 && receivedPass.trim().length > 0){
                    document.getElementById("loginForm").submit();
                }
                else {
                    window.alert("用户名和密码不能为空");
                }
            }
        </script>
        <div>还没有账号？<a href="RegisterPage.jsp">注册一个</a></div>
    </div>
    <% } else { %>
    <div class="welcome">歓迎
        <div style="font-size: 30%;font-family: 'Raleway', sans-serif;line-height: 100%">Welcome</div>
    </div>
    <% } %>
</div>

<div id="pageBand">
    <div class="music">
        <audio src="" id="audiosrc"></audio>
        <div class="musicControl">
            <div class="musicControl prev" onclick="prevMusic()"></div>
            <div id="musicPlay" class="musicControl play" onclick="playMusic()"></div>
            <div class="musicControl next" onclick="nextMusic()"></div>
        </div>
        <div class="musicTitle">
            <span id="TrackTitle"></span>
        </div>
    </div>
    <div style="float: right;margin-right: 20vw;margin-top: 20px;font-family: 'Noto Serif JP', serif;font-size: 120%"><%=hitsCount%> views in total</div>
</div>
<div style="float: left;width: 15vw;height: 2240px">
    <div style="width: 100%;height: 1220px"></div>
    <div style="width: 85vw;height: 600px;background: linear-gradient(to right, #feae34 0%, #fe9733 100%)"></div>
</div>
<div style="float: left;width: 70vw;height: 2240px;background-color: rgba(254,151,51,0.05);">
    <div style="width: 100%;height: 80px"></div>
<%--特效banner div--%>
    <div style="width: 100%;height: 400px">
        <div class="stackBanner">
            <div>夢を、育てます</div>
            <div>培育梦想</div>
        </div>
        <div class="stackBanner" style="position: relative;left: -6%">
            <div>夢を、描きます</div>
            <div>描绘梦想</div>
        </div>
        <div class="stackBanner" style="position: relative;left: 8%">
            <div>夢を、届けたい</div>
            <div>想要传递梦想</div>
        </div>
        <div class="stackBanner">
            <div>発想する会社</div>
            <div>实现梦想的公司</div>
        </div>
        <div style="margin-right: 10%;text-align: right;font-size: 150%;font-family: 'Noto Serif JP', serif">
            ——京アニの夢
        </div>
    </div>
    <div style="width: 100%;height: 240px">
        <div class="sceneImg" style="width: 100vw;height: 200px"></div>
    </div>
<%--introduction--%>
    <div style="width: 100%;height: 500px">
        <div class="stackBanner">
            <div>京都アニメーション</div>
            <div>京都动画</div>
        </div>
        <div class="introduction">
            京都动画全名<span>株式会社京都アニメーション(Kyoto Animation Co.,Ltd.)</span>，昵称为“京アニ”（京阿尼），公司成立于1981年。1985年7月12日成为有限公司，并于1999年成为股份有限公司。2003年开始独立制作动画。
        </div>
        <div class="introduction">
            京都动画的前身为“京都动画工作室”（<span>京都アニメスタジオ</span>）。创办人八田阳子曾在手冢治虫工作室担任动画完稿上色工作，与夫婿八田英明结婚后搬家到京都府宇治市，1981年成立工作室，跟邻近的家庭主妇一起承接龙之子制作公司与日升动画的完稿外包工作。1985年公司法人化，八田英明就任为社长。1986年成立作画部门，逐渐由上色专门公司转向定位为“全关西制”的多部门动画制作公司。现任社长八田英明。现有员工141名。总部设于京都府宇治市，同时拥有<span>Animation Do</span>股份有限公司、3个动画工作室、社员宿舍、动画学校及商品开发部、商品销售店铺等。
        </div>
        <div class="introduction">
            2017年6月，京都动画公布了多个动画电影的企划，并在官网打出<span>“京アニ映画year”</span>（京阿尼电影年）。目前该企划已经宣布最少持续到2020年。
        </div>
    </div>
<%--video--%>
    <div style="width: 100%;height: 300px">
        <div style="width: 50%;height: 300px;float: left">
            <div class="videoTitle" style="font-size: 130%">劇場版 ヴァイオレット・エヴァーガーデン</div>
            <div class="videoDescribe" style="font-size: 130%">2020年9月18日公開</div>
        </div>
        <div class="insertVideo">
            <iframe src="//player.bilibili.com/player.html?aid=49781513&bvid=BV1pb411L7er&cid=87163489&page=1" allowfullscreen="true"></iframe>
        </div>
    </div>
    <div style="width: 100%;height: 300px">
        <div style="width: 50%;height: 300px;float: left">
            <div class="videoTitle" style="font-size: 130%">劇場版 響け！ユーフォニアム ～誓いのフィナーレ～</div>
            <div class="videoDescribe" style="font-size: 130%">2019年4月19日公開</div>
        </div>
        <div class="insertVideo">
            <iframe src="//player.bilibili.com/player.html?aid=47078962&bvid=BV1tb41177ZN&cid=82455006&page=1" allowfullscreen="true"></iframe>
        </div>
    </div>
    <div style="width: 100%;height: 20px"></div>
    <div style="width: 100%;height: 300px">
        <div class="stackBanner">
            <div>スペシャルサンクス</div>
            <div>特别感谢</div>
        </div>
        <div id="indexSponsorTable">
            <table border="0" style="margin: 0 auto">
                <tr>
                    <td><span id="sponsorTitle">Sponsor</span></td>
                    <td><span id="amountsTitle">Amounts</span></td>
                </tr>
                <tr>
                    <td>Eric</td>
                    <td>10$</td>
                </tr>
                <tr>
                    <td>AnotherEric</td>
                    <td>20$</td>
                </tr>
                <tr>
                    <td>AnotherEric</td>
                    <td>20$</td>
                </tr>
                <tr>
                    <td>AnotherEric</td>
                    <td>20$</td>
                </tr>
                <tr>
                    <td>AnotherEric</td>
                    <td>20$</td>
                </tr>
                <tr>
                    <td>AnotherEric</td>
                    <td>20$</td>
                </tr>
                <tr>
                    <td>AnotherEric</td>
                    <td>20$</td>
                </tr>
                <tr>
                    <td>AnotherEric</td>
                    <td>20$</td>
                </tr>
            </table>
        </div>
    </div>
    <div style="width: 100%;height: 100px">
        <div class="linkOfficial" onclick="window.open('http://www.kyotoanimation.co.jp/')">前往官方页面 ></div>
    </div>
</div>
<div style="float: left;width: 15vw;height: 2240px">
    <div style="width: 100%;height: 1220px"></div>
    <div style="width: 15vw;height: 550px;background-image: url('stripe2.png');"></div>
</div>


<div class="footer">
    <div class="footer_left">
        <span class="info">Designed By <a target="_blank" href="https://space.bilibili.com/15261125">Eric</a>.</span>
    </div>
    <div class="footer_right">
    </div>
</div>
</body>
</html>
<script>
    setTimeout(function (){document.getElementById("main").setAttribute('class','opacity2')},500)
</script>
<script src="music.js"></script>
<script src="SwitchBkgImg.js"></script>
<script>
    var x = document.getElementsByClassName("backToTop");
    document.body.onscroll = function () {
        var screenHeight = window.innerHeight;
        var scrollHeight = document.body.scrollTop;
        if (scrollHeight <= screenHeight){
            document.getElementById("topbar").setAttribute("class","clear");
            x[0].style.display = "none";
        } else {
            document.getElementById("topbar").setAttribute("class","topnav");
            x[0].style.display = "block";
        }
    }
</script>

<% if (request.getSession().getAttribute("errState") == "wrongUser"){ %>
<script>
    window.alert("用户名错误")
</script>
<%request.getSession().setAttribute("errState",null);}else if (request.getSession().getAttribute("errState") == "wrongPass"){%>
<script>
    window.alert("密码错误")
</script>
<%request.getSession().setAttribute("errState",null);}else if (request.getSession().getAttribute("errState") == "registerSuccess"){%>
<script>
    window.alert("注册成功 已自动登陆")
</script>
<%request.getSession().setAttribute("errState",null);}else if (request.getSession().getAttribute("errState") == "unauthenticated"){%>
<script>
    window.alert("请先登录")
</script>
<%request.getSession().setAttribute("errState",null);}%>