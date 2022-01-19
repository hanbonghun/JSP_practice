package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {

	public void disconnect(Connection conn, ResultSet rs, PreparedStatement pstmt) { // db ���� ����
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

	public int write(EvaluationDTO evalutionDTO) { // ���� �� ����
		String SQL = "INSERT INTO EVALUATION VALUES(NULL, ?,?,?,?,?,?,?,?,?,?,?,?,0);";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setString(1, evalutionDTO.getUserID().replaceAll("<", "&lt").replaceAll(">","&lt")); // ? ���� ä��� �׸� 1
			pstmt.setString(2, evalutionDTO.getLectureName().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(3, evalutionDTO.getProfessorName().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setInt(4, evalutionDTO.getLectureYear());
			pstmt.setString(5, evalutionDTO.getSemesterDivide().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(6, evalutionDTO.getLectureDivide().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(7, evalutionDTO.getEvaluationTitle().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(8, evalutionDTO.getEvaluationContent().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(9, evalutionDTO.getTotalScore().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(10, evalutionDTO.getAssignment().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(11, evalutionDTO.getGroupMeeting().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(12, evalutionDTO.getAttendance().replaceAll("<", "&lt").replaceAll(">","&lt"));
			//.replaceAll("<", "&lt").replaceAll(">","&lt") : xxs(cross site scripting) ���� ���� 
			
			return pstmt.executeUpdate(); // �����ͺ��̽� ���� �� ���� ��ȯ, ���� -> 1

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn, rs, pstmt);
			// ������ ���̽��� ������ �� �ڿ� ����
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public ArrayList<EvaluationDTO> getList (String lectureDivide, String search, String searchType, int pageNumber){
		if(lectureDivide.equals("��ü")) {
			lectureDivide ="";
		}
		ArrayList<EvaluationDTO> evaluationList = null; //�� �� ��� ��� �迭 
			String SQL = "";
			ResultSet rs = null;
			Connection conn = null;
			PreparedStatement pstmt =null;
			try {
				if (searchType.equals("�ֽż�")) {
					SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY  evaluationID DESC LIMIT " + pageNumber*5+","+ pageNumber*5+6 +";";
				}
				else if(searchType.equals("��õ��")){
					SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY  likeCount DESC LIMIT " + pageNumber*5+","+ pageNumber*5 +6 +";";

					}
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
				pstmt.setString(1, "%" + lectureDivide + "%"); 
				pstmt.setString(2, "%" + search + "%"); 
				rs = pstmt.executeQuery();
				evaluationList = new ArrayList<EvaluationDTO>();
				while(rs.next()) {
					EvaluationDTO evaluation = new EvaluationDTO(
							rs.getInt(1),
							rs.getString(2),
							rs.getString(3),
							rs.getString(4),
							rs.getInt(5),
							rs.getString(6),
							rs.getString(7),
							rs.getString(8),
							rs.getString(9),
							rs.getString(10),
							rs.getString(11),
							rs.getString(12),
							rs.getString(13),
							rs.getInt(14)
							);
					evaluationList.add(evaluation);
					
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				disconnect(conn,rs,pstmt);
				//������ ���̽��� ������ �� �ڿ� ���� 
			}
			return evaluationList; // �����ͺ��̽� ����
		
	}
	
	public int like(String evaluationID) { // ��õ ������ �� 
		
		String SQL = "UPDATE EVALUATION SET likeCount = likeCount+1  WHERE  evaluationID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? ���� ä��� �׸� 1
			return pstmt.executeUpdate();
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return -1; // �����ͺ��̽� ���� 
	}
	
public int delete(String evaluationID) { //  ������ �� ����
		
		String SQL = "DELETE FROM EVALUATION  WHERE  evaluationID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? ���� ä��� �׸� 1
			return pstmt.executeUpdate();
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return -1; // �����ͺ��̽� ���� 
	}


public String getUserID(String evaluationID) { // ������ ���� �ۼ��� ����� ID�� �������� �Լ� 
	
	String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?;";
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement pstmt =null;
	try {
		conn = DatabaseUtil.getConnection();
		pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
		pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? ���� ä��� �׸� 1
		rs = pstmt.executeQuery();
		if(rs.next()) { //��� ���� 
			return  rs.getString(1); // userEmailChecked �� �� ��ȯ 
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		disconnect(conn,rs,pstmt);
	}
	return null; // �����ͺ��̽� ���� 
}
}

