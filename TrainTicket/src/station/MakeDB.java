package station;

import java.io.IOException;
import java.util.HashMap;
import java.sql.*;
import dbConn.DBConnection;

public class MakeDB {
	public static void main(String[] args) throws IOException, ClassNotFoundException, SQLException {
		HashMap<String, String> stations = BringStations.getStations();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBConnection.getConnection();
			String sql = null;
			for(String key : stations.keySet()) {
				String value = stations.get(key);
				
				sql = "insert into stations values('"+key+"', '"+ value +"')";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
			}
			System.out.println("삽입 성공");
		} catch(SQLException ex) {
			System.out.println("삽입 실패");
			System.out.println("SQLException: " + ex.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
	}
	
	
}
