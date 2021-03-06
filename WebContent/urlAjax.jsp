<%@page import="java.util.Map"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="dto.TestDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.TestDAO"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!//
//%>
<%//
	TestDAO dao = new TestDAO();

	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	String u_id = request.getParameter("u_id");
	String u_pw = request.getParameter("u_pw");	

	
//	List<Map<String, String>> list = dao.loadAll(startdate, enddate);
	List<Map<String, String>> list = dao.loadAll(startdate, enddate,u_id,u_pw);
	
	
	System.out.println("아이디 : " + u_id);
	System.out.println("비밀번호 : " + u_pw);
	System.out.println("시작일 : " + startdate);
	System.out.println("종료일 : " + enddate);

	
	for(int i=0; i<list.size(); i++){
		System.out.println("seq : " + list.get(i).get("seq"));
	}
//%>

<%
	response.setContentType("application/json");
	response.setCharacterEncoding("utf-8");
	//response.getWriter().write(new Gson().toJson(list));
	String strJson="";
	if(list != null && list.size() != 0){
		strJson = "{" +
				"\"type\": \"FeatureCollection\"," +
				"\"crs\": {\"type\": \"name\", \"properties\": { \"name\": \"urn:ogc:def:crs:OGC:1.3:CRS84\" } },"+                                                                                
				"\"features\": [";
				strJson += "{ \"type\": \"Feature\",\"properties\": { \"latitude\": " + list.get(0).get("latitude") +", \"longitude\": " + list.get(0).get("longitude") + ", \"time\": 1, \"id\": \"route1\", \"name\":\"Start\" },\"geometry\": { \"type\": \"Point\",\"coordinates\": [" + list.get(0).get("coordinates") + "] } },";
				for(int i=1; i<list.size()-1; ++i){
					strJson += "{ \"type\": \"Feature\",\"properties\": { \"latitude\": " + list.get(i).get("latitude") +", \"longitude\": " + list.get(i).get("longitude") + ", \"time\": 1, \"id\": \"route1\", \"name\":\"Along route\" },\"geometry\": { \"type\": \"Point\",\"coordinates\": [" + list.get(i).get("coordinates") + "] } },";
				}
				strJson += "{ \"type\": \"Feature\",\"properties\": { \"latitude\": " + list.get(list.size()-1).get("latitude") +", \"longitude\": " + list.get(list.size()-1).get("longitude") + ", \"time\": 1, \"id\": \"route1\", \"name\":\"Goal\" },\"geometry\": { \"type\": \"Point\",\"coordinates\": [" + list.get(list.size()-1).get("coordinates") + "] } }";
				strJson += "]}";
				/* "{ \"type\": \"Feature\",\"properties\": { \"latitude\": 40.722390, \"longitude\": -73.995170, \"time\": 1, \"id\": \"route1\", \"name\":\"Start\" },\"geometry\": { \"type\": \"Point\",\"coordinates\": [126.95400059223175,37.49572025613926] } },			 	"+		 
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.721580, \"longitude\": -73.995480, \"time\": 2, \"id\": \"route1\", \"name\":\"Along route\"  }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95432245731354,37.495669182647205] } },    "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.721280, \"longitude\": -73.994720, \"time\": 3, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95464432239532,37.495635133633115] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.720890, \"longitude\": -73.993760, \"time\": 4, \"id\": \"route1\" , \"name\":\"Along route\"  }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95468723773956,37.495826659135446] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.721580, \"longitude\": -73.993480, \"time\": 5, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.9547301530838,37.49601392804061] } },     "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.722310, \"longitude\": -73.993220, \"time\": 6, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95475697517394,37.49611181841774] } },    "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.722470, \"longitude\": -73.993160, \"time\": 7, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95519149303435,37.49613735501677] } },    "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.723580, \"longitude\": -73.992740, \"time\": 8, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95558845996857,37.4961458672145] } },     "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.725190, \"longitude\": -73.992150, \"time\": 9, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.9560819864273,37.496196940380536] } },    "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.725590, \"longitude\": -73.992020, \"time\": 10, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\":  [126.95653527975084,37.4961671477046] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.725390, \"longitude\": -73.991510, \"time\": 11, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.956747174263,37.49615012331301] } },     "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.724180, \"longitude\": -73.988650, \"time\": 12, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\":  [126.95697247982024,37.496133098917554] } }, "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.723900, \"longitude\": -73.987980, \"time\": 13, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\":  [126.95729434490202,37.49609905011496] } },  "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.724550, \"longitude\": -73.987510, \"time\": 14, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95751965045929,37.496086281809994] } },  "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.726370, \"longitude\": -73.986180, \"time\": 15, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\":  [126.95782005786894,37.49604372077767] } },  "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.726960, \"longitude\": -73.985750, \"time\": 16, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95799171924591,37.49598839139936] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727570, \"longitude\": -73.985310, \"time\": 17, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\":  [126.95824921131134,37.49586070806223] } },  "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 18, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95856034755707,37.49580112243021] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 19, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95887148380281,37.49573728062884] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 20, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95894926786421,37.495709615831274] } },  "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 21, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95888757705688,37.49536699710466] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 22, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95887416601181,37.49523292847942] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 23, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.9588580727577,37.49508821921698] } },    "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 24, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95884197950363,37.495041401454415] } },  "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 25, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.959088742733,37.495003095990455] } },    "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 26, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95907801389694,37.494932869255535] } },  "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 27, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95920675992966,37.49492222883539] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 28, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.9594132900238,37.494898819905735] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 29, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95950984954833,37.4948711547976] } },    "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 30, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95950180292128,37.494743469550336] } },  "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 31, \"id\": \"route1\", \"name\":\"Along route\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.9594320654869,37.494632808826104] } },   "+
				"{ \"type\": \"Feature\", \"properties\": { \"latitude\": 40.727250, \"longitude\": -73.984550, \"time\": 32, \"id\": \"route1\", \"name\":\"Goal\"   }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [126.95952862501144,37.49458599077802] } }           "+
				"]"+
				"}"; */
			}
			response.getWriter().write(strJson);
%>
                       