package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

//DTO : JSP���� �ϳ��� ������ ������ ��� ���� ��ü
//DAO : ������ ���̽��� 1:1 ���� (Database Access Object)

public class UserDAO { 
	
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
	
	public int login(String userID, String userPassword) { // ȸ�� ����
		String SQL = "SELECT userPassword FROM USER WHERE userID=?";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setString(1, userID); // ? ���� ä��� �׸� 1
			rs = pstmt.executeQuery();  // executeQuery : �����ͺ��̽� �˻� ��� Ȯ�� 
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) { // getString() �Ķ���Ͱ��� �ش��ϴ� ���� �����͸� string���� ��ȯ
					return 1; // �α��� ����
				} else {
					return 0; // ���̵�� ���������� ��й�ȣ Ʋ��
				}
			}
			return -1; // ���̵� ����
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
			//������ ���̽��� ������ �� �ڿ� ���� 
		}
		return -2; // �����ͺ��̽� ����
	}
	
	public int join(UserDTO user) { // ȸ�� ����
		String SQL = "INSERT INTO USER  VALUES(?,?,?,?,false)";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setString(1, user.getUserID()); // ? ���� ä��� �׸� 1
			pstmt.setString(2, user.getUserPassword()); // ? ���� ä��� �׸� 1
			pstmt.setString(3, user.getUserEmail()); // ? ���� ä��� �׸� 1
			pstmt.setString(4, user.getUserEmailHash()); // ? ���� ä��� �׸� 1

			return pstmt.executeUpdate(); // executeUpdate : �����ͺ��̽� ���� ����, �ش� �������� �ϳ��� ������ �߰� �ǹǷ� ���� �� 1 return 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return -1; // ȸ�� ���� ���� 
	}
	
	
	public boolean getUserEmailChecked(String userID) { // ����� �̸��� ���� ���� Ȯ�� 
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setString(1, userID); // ? ���� ä��� �׸� 1
			rs = pstmt.executeQuery();
			if(rs.next()) { //��� ���� 
				return  rs.getBoolean(1); // userEmailChecked �� �� ��ȯ 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return false; // �����ͺ��̽� ���� 
	}
	
	public boolean setUserEmailChecked(String userID) { // ����� �̸��� ���� Ȯ��
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE  userID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setString(1, userID); // ? ���� ä��� �׸� 1
			pstmt.executeUpdate();
			return true; 

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return false; // �����ͺ��̽� ���� 
	}
	
	
	public String getUserEmail(String userID) { // ����� �̸��� �ּ� ��ȯ 
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setString(1, userID); // ? ���� ä��� �׸� 1
			rs = pstmt.executeQuery();
			if(rs.next()) {
				System.out.println("ã��");
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return null; // �����ͺ��̽� ���� 
	}
}