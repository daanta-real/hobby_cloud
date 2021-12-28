<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>소모임 등록창</h1>


<form method="post" enctype="multipart/form-data">


회원 idx<input type="text" name="memberIdx" value="99999">
취미분류 이름<input type="text" name="lecCategoryName" value="운동">
<br>
장소 idx<input type="text" name="placeIdx" value="9999">
제목<input type="text" name="gatherName" value="제목">
상세내용<input type="text" name="gatherDetail" value="내용">
<br>
작성일<input type="date" name="gatherRegistered">
인원<input type="text" name="gatherHeadCount" value="1">
지역<input type="text" name="gatherLocRegion" value="지역">
<br>
위도<input type="text" name="gatherLocLatitude" value="123">
경도<input type="text" name="gatherLocLogitude" value="456">
시작시간<input type="date" name="gatherStart" >
<br>
종료시간<input type="date" name="gatherEnd">
최대원인원수<input type="text" name="gatherMax" value="1">
현재오픈여부<input type="text" name="gatherStaus" value="1">
<br>
<input type="file" name="attach" enctype="multipart/form-data" multiple>
<input type="submit" value="전송하기">
</form>