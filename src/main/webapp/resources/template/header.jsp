<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<!-- METAS -->
	<META charset="UTF-8"> <!-- 인코딩 -->
	<META http-equiv="X-UA-Compatible" content="IE=edge"> <!-- UA -->
	<META name="viewport" content="width=device-width, initial-scale=1.0"> <!-- VIEWPORT -->
	<!-- LINKS -->
	<!-- Bootstrap Theme -->
	<LINK rel="stylesheet" href="https://bootswatch.com/5/journal/bootstrap.css">
	<!-- Bootstrap -->
	<SCRIPT src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<!-- Google Font -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
	<!-- JQuery 3.6.0 -->
	<SCRIPT src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></SCRIPT>
	<!-- axios -->
	<script src="https://unpkg.com/axios/dist/axios.min.js" crossorigin="anonymous"></script>
	<!-- XE Icon -->
	<LINK rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<!-- HobbyCloud Main CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
	<!-- HobbyCloud Main JS -->    
	<SCRIPT type='text/javascript' src="${pageContext.request.contextPath}/resources/js/main.js"></SCRIPT>
	<!-- CryptoJS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>
	<!-- Kakao Map API -->
	<script
		type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=229c9e937f7dfe922976a86a9a2b723b&libraries=services">
	</script>
	<script type='text/javascript'>
		CONFIG_ROOTPATH = "${pageContext.request.contextPath}";
	</script>
	</HEAD>
</HTML>