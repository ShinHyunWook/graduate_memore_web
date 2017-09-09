<%@page import="java.util.Calendar"%>
<%@page import="java.net.URL"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH)+1;
int tday = cal.get(Calendar.DATE);
String todaydate = "";
if(tmonth<10){
	if(tday<10){
		todaydate = tyear+"-0"+tmonth+"-0"+tday;
	}else{
		todaydate = tyear+"-0"+tmonth+"-"+tday;
	}
}else{
	if(tday<10){
		todaydate = tyear+"-"+tmonth+"-0"+tday;
	}else{
		todaydate = tyear+"-"+tmonth+"-"+tday;
	}
}


String startDate = request.getParameter("startdate")==null || request.getParameter("startdate").equals("") ? todaydate : request.getParameter("startdate");
String endDate = request.getParameter("enddate")==null || request.getParameter("enddate").equals("") ? todaydate : request.getParameter("enddate");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <style>
    html,
    body {
        height: 100%;
        width: 100%;
    }
    body {
        margin: 0;
    }
    #map {
        width: 100%;
        height: 100%;
    }
    svg {
        position: relative;
    }
    path {
        fill: yellow;
        stroke-width: 2px;
        stroke: red;
        stroke-opacity: 1;
    }
    .travelMarker {
        fill: #006F84;
        opacity: 0.75;
    }
    .waypoints {
        fill: black;
        opacity: 0;
    }
}
.drinks {
    stroke: black;
    fill: red;
}
.lineConnect {
    fill: none;
    stroke: white;
    opacity: 1;
}
.locnames {
    fill: white;
    text-shadow: 1px 1px 1px #FFF, 3px 3px 5px #000;
    font-weight: bold;
    font-size: 30px;
    display: none;
}
#super{
    height: 700px;
    background: url('gra.jpg');
}
#content{
width:100%;
}
#logo{
	padding-top:100px;
}
#logo img{
	margin : 0 auto;
	display: block;
	margin-top:
}
#form_box{
	margin-top:70px;
}
#form_box label{
	color:white;
}
#form_box form{
	margin: 0 auto;
    width: 280px;
}
#left_form{
	width:224px;
	float:left
}
#left_form label{
	width:69px;
}
#left_form input{
	width:144px;
}

    </style>
<!--
    
    <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.3.1/leaflet.css" />
    <script src="http://cdn.leafletjs.com/leaflet-0.3.1/leaflet.js"></script>
    <script src="http://maps.google.com/maps/api/js?key=AIzaSyBlBJFTru5Cp2Ow-HC_w-GiUXbdP_QT3Rk&v=3.2&sensor=false"></script>
    <script src="http://matchingnotes.com/javascripts/leaflet-google.js"></script>
    
-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7/leaflet.css" />
    <script src="http://d3js.org/d3.v3.min.js" type="text/javascript"></script>
    <script src="http://cdn.leafletjs.com/leaflet-0.7/leaflet.js"></script>
    <script src='https://api.tiles.mapbox.com/mapbox.js/v1.6.4/mapbox.js'></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <link href='https://api.tiles.mapbox.com/mapbox.js/v1.6.4/mapbox.css' rel='stylesheet' />    
</head>

<body>
<div id="super">
	<div id="content">
		<div id="logo">
			<img src="m_white.png">
		</div>
		<div id="form_box">
			<form action="visualization.jsp" method="post">
			
			<span id="left_form">		
				<label for="u_id" >ID : </label>
				<input type="text" id="u_id"  name="u_id">
				<label for="u_pw" >PW : </label>
				<input type="password" id="u_pw"  name="u_pw">		
				<label for="startdate" >시작 날짜 : </label>
				<input type="date" id="startdate"  name="startdate" value="<%=startDate%>">
				<label for="startdate" >종료 날짜 : </label>
				<input type="date" id="enddate"  name="enddate" value="<%=endDate%>">
			</span>
			<input type="submit" class="btn btn-default" style="width:53px;height:108px" value="조회"/>
			</form>
		</div>
	</div>
</div>

<!-- 	<table id="myTable">
		<tr>
			<th>ID</th>
			<th>NAME</th>
		</tr>
		<tbody>
		</tbody>
	</table>
	 -->
    <div id="demo"></div>

</body>

</html>