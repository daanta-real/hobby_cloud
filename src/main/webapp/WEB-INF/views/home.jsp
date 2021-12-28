<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
<a href="${root}/hobbycloud/member/login">login</a>
<a href="${root}/hobbycloud/member/logout">logout</a>
<a href="${root}/hobbycloud/member/join">join</a>
<a href="${root}/hobbycloud/member/password" class="link-btn-block">change pw</a>
<a href="${root}/hobbycloud/member/edit">edit</a>
<a href="${root}/hobbycloud/member/quit">quit</a>
<a href="${root}/hobbycloud/member/mypage">mypage</a>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
