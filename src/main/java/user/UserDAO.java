

package user;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DatabaseUtil;

//DAO 는 JSP에서 하나의 데이터 단위를 담기 위한 객체
public class UserDAO { // 데이터 베이스와 1:1 연동 (Database Access Object)
   public int join(String userID, String userPassword) { // 회원 가입 
      String SQL = "INSERT INTO USER VALUES (?, ?)";
      try {
         Connection conn = DatabaseUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(SQL);//sql에서 중복코드 문제 방지
         pstmt.setString(1,  userID); // ? 내용 채우는 항목 1
         pstmt.setString(2, userPassword); // 2
         return pstmt.executeUpdate();  // 위의 insert 된 데이터의 개수 반환 
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
}