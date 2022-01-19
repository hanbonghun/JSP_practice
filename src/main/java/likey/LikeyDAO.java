package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class LikeyDAO {
	
	public void disconnect(Connection conn, ResultSet rs, PreparedStatement pstmt) { //db ���� ���� 
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
		pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
		pstmt.setString(1,userID); // ? ���� ä��� �׸� 1
		pstmt.setString(2, evalutaionID); // ? ���� ä��� �׸� 1
		pstmt.setString(3, userIP); // ? ���� ä��� �׸� 1

		return pstmt.executeUpdate(); // executeUpdate : �����ͺ��̽� ���� ����, �ش� �������� �ϳ��� ������ �߰� �ǹǷ� ���� �� 1 return 
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		disconnect(conn,rs,pstmt);
	}
	return -1; // ȸ�� ���� ���� 
}

}
