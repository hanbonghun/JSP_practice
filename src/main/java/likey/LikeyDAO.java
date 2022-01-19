package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class LikeyDAO {
	
	public void disconnect(Connection conn, ResultSet rs, PreparedStatement pstmt) { //db 연결 해제 
		try {
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
public int like(String userID, String evalutaionID, String userIP) {
	
	String SQL = "INSERT INTO LIKEY  VALUES(?,?,?)";
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement pstmt =null;
	try {
		conn = DatabaseUtil.getConnection();
		pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
		pstmt.setString(1,userID); // ? 내용 채우는 항목 1
		pstmt.setString(2, evalutaionID); // ? 내용 채우는 항목 1
		pstmt.setString(3, userIP); // ? 내용 채우는 항목 1

		return pstmt.executeUpdate(); // executeUpdate : 데이터베이스 변경 개수, 해당 쿼리문은 하나의 데이터 추가 되므로 성공 시 1 return 
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		disconnect(conn,rs,pstmt);
	}
	return -1; // 회원 가입 실패 
}

}
