package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import dbfile.DBConnectionMgr;
import dto.TestDTO;

public class TestDAO {
	public List<Map<String, String>> list = null;

	public TestDAO() {
		list = new ArrayList<Map<String, String>>();
	}

//	public List<Map<String, String>> loadAll(String startdate, String enddate) {
//
//		String sql = "SELECT * FROM location_data WHERE user_id=33 ORDER BY id ";
//
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		DBConnectionMgr pool = null;
//		
//		String result = new String();
//
//		try {
//			pool = DBConnectionMgr.getInstance();
//			conn = pool.getConnection();
//			pstmt = conn.prepareStatement(sql);
////			pstmt.setString(1, startdate);
////			pstmt.setString(2, enddate);
//			rs = pstmt.executeQuery();
//			list.removeAll(list);
////				
//			
//			int num = 0;
//			while (rs.next()) {
//				Object jsonarray=JSONValue.parse(rs.getString("loc_data"));
//				JSONArray jsonarr=(JSONArray)jsonarray;
//				System.out.println("결과값의 사이즈 : "+jsonarr.size());
//				for(int i=0;i<jsonarr.size();i++){
//					Map<String, String> d = new HashMap<String, String>();
//					num++;
//			        JSONObject jsonobj=(JSONObject)jsonarr.get(i);
//			        d.put("latitude", jsonobj.get("lat").toString());
//			        
//			        d.put("longitude", jsonobj.get("lng").toString());
//			        
//			        String coordinates = jsonobj.get("lng").toString()+","+jsonobj.get("lat").toString();
//			        
//			        d.put("coordinates", coordinates);
//			        
//			        d.put("seq", String.valueOf(num));
//
//			        list.add(d);
//			    }
//			}
//			rs.last();
//			int test = rs.getRow();
//			System.out.println(test);
//		
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
////			pool.freeConnection(conn, pstmt, rs);
//		}
//		return list;
//	}
	
	
	public List<Map<String, String>> loadAll(String startdate, String enddate,String u_id,String u_pw) {

		String pre_sql = "SELECT id FROM users WHERE email='"+u_id+"' AND password="+u_pw;

		
		Connection pre_conn = null;
		PreparedStatement pre_pstmt = null;
		ResultSet pre_rs = null;
		DBConnectionMgr pre_pool = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DBConnectionMgr pool = null;
		String result = new String();

		try {
			pre_pool = DBConnectionMgr.getInstance();
			pre_conn = pre_pool.getConnection();
			pre_pstmt = pre_conn.prepareStatement(pre_sql);
			pre_rs = pre_pstmt.executeQuery();
			pre_rs.last();
			int rowNum = pre_rs.getRow();
			System.out.println(rowNum);
			if(rowNum==1){
				String user_id = pre_rs.getString("id");
				String sql = "SELECT * FROM location_data WHERE user_id="+user_id+" and loc_time>='"+startdate+"' and loc_time<='"+enddate+"' ORDER BY id DESC limit 1";
				pool = DBConnectionMgr.getInstance();
				conn = pool.getConnection();
				pstmt = conn.prepareStatement(sql);
//				pstmt.setString(1, startdate);
//				pstmt.setString(2, enddate);
				rs = pstmt.executeQuery();
				list.removeAll(list);
//					
				
				int num = 0;
				while (rs.next()) {
					Object jsonarray=JSONValue.parse(rs.getString("loc_data"));
					JSONArray jsonarr=(JSONArray)jsonarray;
					System.out.println("결과값의 사이즈 : "+jsonarr.size());
					for(int i=0;i<jsonarr.size();i++){
						Map<String, String> d = new HashMap<String, String>();
						num++;
				        JSONObject jsonobj=(JSONObject)jsonarr.get(i);
				        d.put("latitude", jsonobj.get("lat").toString());
				        
				        d.put("longitude", jsonobj.get("lng").toString());
				        
				        String coordinates = jsonobj.get("lng").toString()+","+jsonobj.get("lat").toString();
				        
				        d.put("coordinates", coordinates);
				        
				        d.put("seq", String.valueOf(num));

				        list.add(d);
				    }
				}
			}else{
				//System.out.println("하나가 아닙니다.");
			}
		

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
//			pool.freeConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	
	
}
