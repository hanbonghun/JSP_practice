package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

//DTO : JSP에서 하나의 데이터 단위를 담기 위한 객체
//DAO : 데이터 베이스와 1:1 연동 (Database Access Object)

public class UserDAO { 
	
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
	
	public int login(String userID, String userPassword) { // 회원 가입
		String SQL = "SELECT userPassword FROM USER WHERE userID=?";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
			pstmt.setString(1, userID); // ? 내용 채우는 항목 1
			rs = pstmt.executeQuery();  // executeQuery : 데이터베이스 검색 결과 확인 
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) { // getString() 파라미터값에 해당하는 열의 데이터를 string으로 반환
					return 1; // 로그인 성공
				} else {
					return 0; // 아이디는 존재하지만 비밀번호 틀림
				}
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
			//데이터 베이스에 접근한 후 자원 해제 
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(UserDTO user) { // 회원 가입
		String SQL = "INSERT INTO USER  VALUES(?,?,?,?,false)";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
			pstmt.setString(1, user.getUserID()); // ? 내용 채우는 항목 1
			pstmt.setString(2, user.getUserPassword()); // ? 내용 채우는 항목 1
			pstmt.setString(3, user.getUserEmail()); // ? 내용 채우는 항목 1
			pstmt.setString(4, user.getUserEmailHash()); // ? 내용 채우는 항목 1

			return pstmt.executeUpdate(); // executeUpdate : 데이터베이스 변경 개수, 해당 쿼리문은 하나의 데이터 추가 되므로 성공 시 1 return 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return -1; // 회원 가입 실패 
	}
	
	
	public boolean getUserEmailChecked(String userID) { // 사용자 이메일 검증 유무 확인 
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
			pstmt.setString(1, userID); // ? 내용 채우는 항목 1
			rs = pstmt.executeQuery();
			if(rs.next()) { //결과 존재 
				return  rs.getBoolean(1); // userEmailChecked 의 값 반환 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return false; // 데이터베이스 오류 
	}
	
	public boolean setUserEmailChecked(String userID) { // 사용자 이메일 검증 확인
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE  userID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
			pstmt.setString(1, userID); // ? 내용 채우는 항목 1
			pstmt.executeUpdate();
			return true; 

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return false; // 데이터베이스 오류 
	}
	
	
	public String getUserEmail(String userID) { // 사용자 이메일 주소 반환 
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
			pstmt.setString(1, userID); // ? 내용 채우는 항목 1
			rs = pstmt.executeQuery();
			if(rs.next()) {
				System.out.println("찾음");
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return null; // 데이터베이스 오류 
	}
}